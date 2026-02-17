#!/usr/bin/env bash
# setup.sh — Nyx setup wizard
# Usage: bash setup.sh

set -euo pipefail

# ── Load modules ──
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/tui.sh"
source "$SCRIPT_DIR/lib/configure.sh"
source "$SCRIPT_DIR/lib/host.sh"
source "$SCRIPT_DIR/lib/verify.sh"

# ── Install nyx launcher to ~/.local/bin ──
install_nyx_command() {
    local bin_dir="$HOME/.local/bin"
    mkdir -p "$bin_dir"

    # Generate launcher with current config baked in
    cat > "$bin_dir/nyx" <<'LAUNCHER'
#!/usr/bin/env bash
set -euo pipefail
LAUNCHER

    # Inject config values
    cat >> "$bin_dir/nyx" <<LAUNCHER
VM_NAME="${NYX_VM_NAME}"
VM_USER="${NYX_VM_USER}"
WORKSPACE="${NYX_WORKSPACE}"
SSH_KEY="${NYX_SSH_KEY}"
LAUNCHER

    # Append the rest of the launcher logic
    cat >> "$bin_dir/nyx" <<'LAUNCHER'

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

get_vm_ip() {
    local ip mac
    ip=$(virsh domifaddr "$VM_NAME" 2>/dev/null | awk '/ipv4/ {print $4}' | cut -d/ -f1 | head -1)
    if [[ -n "$ip" ]]; then
        printf '%s' "$ip"
        return 0
    fi

    mac=$(virsh domiflist "$VM_NAME" 2>/dev/null | awk '$3 == "default" {print $5; exit}')
    if [[ -n "$mac" ]]; then
        ip=$(virsh net-dhcp-leases default 2>/dev/null \
            | awk -v mac="$mac" 'tolower($2) == tolower(mac) {print $5; exit}' \
            | cut -d/ -f1)
        if [[ -n "$ip" ]]; then
            printf '%s' "$ip"
            return 0
        fi
    fi

    return 1
}

if ! virsh dominfo "$VM_NAME" &>/dev/null; then
    printf "${RED}Nyx VM not found. Run setup.sh first.${RESET}\n"
    exit 1
fi

if [[ "$(virsh domstate "$VM_NAME" 2>/dev/null)" != "running" ]]; then
    printf "${CYAN}Starting VM...${RESET}\n"
    virsh start "$VM_NAME"
fi

VM_IP=""
for i in $(seq 1 30); do
    VM_IP=$(get_vm_ip || true)
    [[ -n "$VM_IP" ]] && break
    sleep 2
done

if [[ -z "$VM_IP" ]]; then
    printf "${RED}Could not get VM IP address.${RESET}\n"
    exit 1
fi

printf "${CYAN}Connecting...${RESET}\n"
for i in $(seq 1 15); do
    if ssh -o ConnectTimeout=2 \
           -o StrictHostKeyChecking=no \
           -o UserKnownHostsFile=/dev/null \
           -o LogLevel=ERROR \
           -o BatchMode=yes \
           -i "$SSH_KEY" \
           "$VM_USER@$VM_IP" true 2>/dev/null; then
        break
    fi
    sleep 2
done

printf "${GREEN}${BOLD}Launching Nyx...${RESET}\n"
exec ssh -t \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -o LogLevel=ERROR \
    -i "$SSH_KEY" \
    "$VM_USER@$VM_IP" \
    "cd \"$WORKSPACE\" && source .env && if command -v opencode >/dev/null; then exec opencode; else exec \$HOME/.local/bin/opencode; fi"
LAUNCHER

    chmod +x "$bin_dir/nyx"

    # Check if ~/.local/bin is in PATH
    if [[ ":$PATH:" != *":$bin_dir:"* ]]; then
        log_warn "$bin_dir is not in your PATH"
        log_info "Add to your shell profile: export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi

    log_success "Installed 'nyx' command to $bin_dir/nyx"
}

# ── Completion message ──
show_completion() {
    echo
    printf "${GREEN}${BOLD}  ✓ Nyx is ready!${RESET}\n"
    echo
    printf "  To start:  ${CYAN}${BOLD}nyx${RESET}\n"
    echo
    printf "  VM:        ${DIM}%s (%s MB RAM, %s CPUs)${RESET}\n" "$NYX_VM_NAME" "$NYX_VM_RAM" "$NYX_VM_CPUS"
    printf "  IP:        ${DIM}%s${RESET}\n" "$NYX_VM_IP"
    printf "  Provider:  ${DIM}%s/%s${RESET}\n" "$NYX_PROVIDER" "$NYX_MODEL"
    printf "  Workspace: ${DIM}%s${RESET}\n" "$NYX_WORKSPACE"
    echo
}

# ── Main ──
main() {
    tui_banner

    # ── Phase 1: Questions (interactive) ──
    check_host_prerequisites
    echo
    configure_vm
    echo
    configure_provider
    echo
    configure_model
    echo
    configure_search
    echo

    # ── Confirm before proceeding ──
    log_info "Configuration complete. Ready to provision."
    if ! tui_confirm "Proceed with setup?"; then
        log_warn "Setup cancelled."
        exit 0
    fi
    echo

    # ── Phase 2: Provisioning (spinners, no interaction) ──
    tui_spin "Downloading Kali Linux image (3.5 GB)..."  download_kali_image
    tui_spin "Verifying image integrity..."               verify_kali_image
    tui_spin "Extracting image..."                        extract_kali_image
    tui_spin "Configuring VM image..."                    customize_kali_image
    tui_spin "Creating virtual machine..."                create_vm
    tui_spin "Waiting for VM to boot..."                  wait_for_vm
    tui_spin "Provisioning VM..."                         provision_vm
    tui_spin "Running verification..."                    verify_setup

    # ── Install launcher ──
    install_nyx_command

    # ── Done ──
    show_completion
}

main "$@"
