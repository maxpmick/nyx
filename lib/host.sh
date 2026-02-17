#!/usr/bin/env bash
# host.sh — Host-side VM provisioning

# Try virsh first as the current user, then via sudo.
run_virsh() {
    if virsh "$@" >/dev/null 2>&1; then
        return 0
    fi
    sudo virsh "$@" >/dev/null 2>&1
}

# ── Libvirt daemon helpers ──
# Monolithic (libvirtd) and modular (virtqemud, virtnetworkd, …) daemons are
# mutually exclusive.  These helpers detect which layout is present, ensure the
# correct one is running, and clean up the other.

_NYX_USE_MODULAR=false

_libvirt_daemon_active() {
    systemctl is-active --quiet libvirtd.service 2>/dev/null \
        || systemctl is-active --quiet libvirtd.socket 2>/dev/null \
        || systemctl is-active --quiet virtqemud.socket 2>/dev/null \
        || systemctl is-active --quiet virtqemud.service 2>/dev/null
}

_start_libvirt_daemons() {
    local modular_units=(
        virtqemud virtnetworkd virtstoraged
        virtinterfaced virtnodedevd virtsecretd virtnwfilterd
    )

    # Use modular only if libvirtd.service doesn't exist at all
    if ! systemctl cat libvirtd.service >/dev/null 2>&1; then
        _NYX_USE_MODULAR=true
    fi

    if $_NYX_USE_MODULAR; then
        sudo systemctl disable --now libvirtd.socket      >/dev/null 2>&1 || true
        sudo systemctl disable --now libvirtd-ro.socket    >/dev/null 2>&1 || true
        sudo systemctl disable --now libvirtd-admin.socket >/dev/null 2>&1 || true
        sudo systemctl stop libvirtd.service               >/dev/null 2>&1 || true

        for u in "${modular_units[@]}"; do
            sudo systemctl enable --now "${u}.socket" >/dev/null 2>&1 || true
        done
    else
        for u in "${modular_units[@]}"; do
            sudo systemctl disable --now "${u}.socket"  >/dev/null 2>&1 || true
            sudo systemctl stop "${u}.service"          >/dev/null 2>&1 || true
        done

        sudo systemctl enable --now libvirtd.socket       >/dev/null 2>&1 || true
        sudo systemctl enable --now libvirtd-ro.socket    >/dev/null 2>&1 || true
        sudo systemctl enable --now libvirtd-admin.socket >/dev/null 2>&1 || true
        sudo systemctl restart libvirtd.service           >/dev/null 2>&1 || true
    fi
}

_wait_for_virsh() {
    local i
    for ((i=0; i<20; i++)); do
        sudo virsh uri >/dev/null 2>&1 && return 0
        sleep 1
    done
    return 1
}

default_network_active() {
    virsh net-info default 2>/dev/null | grep -q "Active:.*yes" \
        || sudo virsh net-info default 2>/dev/null | grep -q "Active:.*yes"
}

ensure_default_network() {
    local xml_candidate tmp_xml

    # In modular mode, virtnetworkd must be running.
    # In monolithic mode libvirtd handles everything — don't start
    # modular daemons or they'll conflict.
    if $_NYX_USE_MODULAR; then
        sudo systemctl start virtnetworkd.socket  >/dev/null 2>&1 || true
        sudo systemctl start virtnetworkd.service >/dev/null 2>&1 || true
    fi

    # Define default network from packaged XML when available.
    if ! run_virsh net-info default; then
        for xml_candidate in /usr/share/libvirt/networks/default.xml /etc/libvirt/qemu/networks/default.xml; do
            [[ -f "$xml_candidate" ]] || continue
            run_virsh net-define "$xml_candidate" && break
        done
    fi

    # Last resort: define a standard libvirt NAT network.
    if ! run_virsh net-info default; then
        tmp_xml="$(mktemp /tmp/nyx-default-net.XXXXXX.xml)"
        cat >"$tmp_xml" <<'EOF'
<network>
  <name>default</name>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
EOF
        run_virsh net-define "$tmp_xml" || true
        rm -f "$tmp_xml"
    fi

    run_virsh net-start default || true
    run_virsh net-autostart default || true
    default_network_active
}

# ── Prerequisite Checks ──
check_host_prerequisites() {
    local missing=() host_user
    host_user="${SUDO_USER:-$USER}"

    # KVM support
    if [[ ! -e /dev/kvm ]]; then
        log_error "KVM not available (/dev/kvm missing)."
        log_error "Enable hardware virtualization (VT-x/AMD-V) in BIOS."
        exit 1
    fi

    if ! grep -cqE '(vmx|svm)' /proc/cpuinfo 2>/dev/null; then
        log_error "CPU does not support hardware virtualization."
        exit 1
    fi

    # Required commands
    for cmd in virsh dnsmasq virt-install virt-customize 7z curl gum; do
        if ! check_command "$cmd"; then
            missing+=("$cmd")
        fi
    done

    if (( ${#missing[@]} > 0 )); then
        log_error "Missing required tools: ${missing[*]}"
        echo
        log_info "Run the auto-installer to set up all dependencies:"
        echo "  bash install.sh"
        echo
        log_info "Or install manually:"
        if [[ -f /etc/arch-release ]]; then
            echo "  sudo pacman -S qemu-full libvirt dnsmasq virt-install guestfs-tools p7zip curl gum"
        elif [[ -f /etc/debian_version ]]; then
            echo "  sudo apt install qemu-kvm libvirt-daemon-system libvirt-daemon-config-network dnsmasq-base virtinst libguestfs-tools p7zip-full curl"
            echo "  # then install gum: https://github.com/charmbracelet/gum#installation"
        elif [[ -f /etc/fedora-release ]] || [[ -f /etc/redhat-release ]]; then
            echo "  sudo dnf install qemu-kvm libvirt dnsmasq virt-install guestfs-tools p7zip curl"
            echo "  # then install gum: https://github.com/charmbracelet/gum#installation"
        fi
        exit 1
    fi

    # libvirt daemons — start if needed (handles monolithic vs modular)
    if ! _libvirt_daemon_active; then
        log_info "libvirt daemons not running, starting..."
        _start_libvirt_daemons
    else
        # Even if a daemon is active, ensure sockets are clean
        # (fixes leftover conflicts from earlier broken runs)
        _start_libvirt_daemons
    fi

    if ! _wait_for_virsh; then
        log_error "libvirt daemons started but virsh cannot connect after 20 s."
        log_info "Debug: systemctl status libvirtd virtqemud.socket virtnetworkd.socket"
        exit 1
    fi

    # User in libvirt group
    if ! id -nG "$host_user" | grep -qw libvirt; then
        log_warn "User '$host_user' is not in the 'libvirt' group."
        log_info "Run 'bash install.sh' to configure automatically, or add manually:"
        echo "  sudo usermod -aG libvirt $host_user"
        log_info "Then log out and back in."
        exit 1
    fi

    # Default network active
    if ! default_network_active; then
        log_warn "Default NAT network is not active. Attempting to activate..."
        if ! ensure_default_network; then
            log_error "Could not activate the libvirt default network."
            log_info "Debug: sudo virsh net-list --all && journalctl -u virtnetworkd -u libvirtd --no-pager -n 30"
            exit 1
        fi

        log_success "Default NAT network activated"
    fi

    # Disk space
    if ! check_disk_space 25; then
        log_error "Insufficient disk space. At least 25 GB required."
        exit 1
    fi

    # Network
    if ! check_network; then
        log_error "Cannot reach cdimage.kali.org. Check network connectivity."
        exit 1
    fi

    log_success "All prerequisites met"
}

# ── Download Kali Image ──
download_kali_image() {
    mkdir -p "$NYX_CACHE_DIR"
    local dest="$NYX_CACHE_DIR/$KALI_7Z_FILE"

    if [[ -f "$dest" ]]; then
        log_info "Kali image already downloaded, skipping"
        return 0
    fi

    curl -L -C - --progress-bar -o "$dest" "$KALI_IMAGE_URL"
}

# ── Verify Image ──
verify_kali_image() {
    local dest="$NYX_CACHE_DIR/$KALI_7Z_FILE"

    # Download checksums (and signature when available)
    curl -sL -o "$NYX_CACHE_DIR/SHA256SUMS" "$KALI_IMAGE_SHA256_URL"
    curl -sL -o "$NYX_CACHE_DIR/SHA256SUMS.gpg" "$KALI_IMAGE_GPG_URL" || true

    # Signature verification is best-effort; checksum verification remains mandatory.
    if [[ -f "$NYX_CACHE_DIR/SHA256SUMS.gpg" ]] && command -v gpg &>/dev/null; then
        if gpg --verify "$NYX_CACHE_DIR/SHA256SUMS.gpg" "$NYX_CACHE_DIR/SHA256SUMS" &>/dev/null; then
            log_success "Checksum signature verified"
        else
            log_warn "Could not verify checksum signature (Kali signing key may be missing). Continuing with SHA256 check."
        fi
    fi

    # Check hash
    local expected
    expected=$(grep "$KALI_7Z_FILE" "$NYX_CACHE_DIR/SHA256SUMS" | awk '{print $1}')
    if [[ -z "$expected" ]]; then
        log_warn "Could not find checksum for $KALI_7Z_FILE, skipping verification"
        return 0
    fi

    local actual
    actual=$(sha256sum "$dest" | awk '{print $1}')

    if [[ "$expected" != "$actual" ]]; then
        log_error "SHA256 mismatch!"
        log_error "Expected: $expected"
        log_error "Actual:   $actual"
        rm -f "$dest"
        exit 1
    fi

    log_success "Image checksum verified"
}

# ── Extract Image ──
extract_kali_image() {
    local archive="$NYX_CACHE_DIR/$KALI_7Z_FILE"

    # Check if already extracted
    local existing
    existing=$(find "$NYX_CACHE_DIR" -maxdepth 1 -name "$KALI_QCOW2_GLOB" -print -quit 2>/dev/null)
    if [[ -n "$existing" ]]; then
        log_info "QCOW2 already extracted, skipping"
        return 0
    fi

    7z x -o"$NYX_CACHE_DIR" "$archive" -y
}

# ── Customize Image ──
customize_kali_image() {
    # Find the extracted QCOW2
    local source_qcow2
    source_qcow2=$(find "$NYX_CACHE_DIR" -maxdepth 1 -name "$KALI_QCOW2_GLOB" -print -quit)
    if [[ -z "$source_qcow2" ]]; then
        log_error "No QCOW2 found in cache. Extraction may have failed."
        exit 1
    fi

    # Copy to working image
    NYX_QCOW2="$NYX_CACHE_DIR/${NYX_VM_NAME}.qcow2"
    export NYX_QCOW2

    if [[ ! -f "$NYX_QCOW2" ]]; then
        cp "$source_qcow2" "$NYX_QCOW2"
    fi

    # Generate SSH key if needed
    if [[ ! -f "$NYX_SSH_KEY" ]]; then
        ssh-keygen -t ed25519 -f "$NYX_SSH_KEY" -N "" -C "nyx-kali" -q
    fi

    # Customize the image
    sudo virt-customize -a "$NYX_QCOW2" \
        --run-command 'systemctl enable ssh' \
        --run-command "echo 'kali ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/90-nyx-kali && chmod 440 /etc/sudoers.d/90-nyx-kali" \
        --ssh-inject "kali:file:${NYX_SSH_KEY}.pub" \
        --hostname "$NYX_VM_NAME"
}

# ── Create VM ──
create_vm() {
    # Remove existing VM if present
    if virsh dominfo "$NYX_VM_NAME" &>/dev/null; then
        virsh destroy "$NYX_VM_NAME" 2>/dev/null || true
        virsh undefine "$NYX_VM_NAME" --remove-all-storage 2>/dev/null || true
    fi

    virt-install \
        --name "$NYX_VM_NAME" \
        --memory "$NYX_VM_RAM" \
        --vcpus "$NYX_VM_CPUS" \
        --cpu host \
        --disk "$NYX_QCOW2,format=qcow2,bus=virtio" \
        --import \
        --osinfo debian12 \
        --network network=default,model=virtio \
        --graphics spice \
        --noautoconsole
}

# ── Wait for VM ──
get_vm_ip() {
    local ip mac

    # Primary source: guest agent (domifaddr)
    ip=$(virsh domifaddr "$NYX_VM_NAME" 2>/dev/null \
        | awk '/ipv4/ {print $4}' | cut -d/ -f1 | head -1)
    if [[ -n "$ip" ]]; then
        printf '%s' "$ip"
        return 0
    fi

    # Fallback: default network DHCP leases
    mac=$(virsh domiflist "$NYX_VM_NAME" 2>/dev/null | awk '$3 == "default" {print $5; exit}')
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

wait_for_vm() {
    local timeout=120
    local elapsed=0

    # Poll for IP
    NYX_VM_IP=""
    export NYX_VM_IP
    while (( elapsed < timeout )); do
        NYX_VM_IP=$(get_vm_ip || true)
        [[ -n "$NYX_VM_IP" ]] && break
        sleep 3
        elapsed=$((elapsed + 3))
    done

    if [[ -z "$NYX_VM_IP" ]]; then
        log_error "Timed out waiting for VM IP address."
        exit 1
    fi

    # Poll for SSH
    while (( elapsed < timeout )); do
        if ssh_vm true 2>/dev/null; then
            log_success "VM is ready at $NYX_VM_IP"
            return 0
        fi
        sleep 3
        elapsed=$((elapsed + 3))
    done

    log_error "Timed out waiting for SSH."
    exit 1
}

# ── Provision VM ──
# SCP repo into VM and run guest.sh
provision_vm() {
    # Create staging directory
    local staging
    staging=$(mktemp -d)
    cp -r "$NYX_DIR/lib" "$staging/"
    cp -r "$NYX_DIR/templates" "$staging/"
    [[ -d "$NYX_DIR/prompts" ]] && cp -r "$NYX_DIR/prompts" "$staging/"
    [[ -d "$NYX_DIR/skills" ]] && cp -r "$NYX_DIR/skills" "$staging/"
    [[ -d "$NYX_DIR/commands" ]] && cp -r "$NYX_DIR/commands" "$staging/"

    # Also copy pre-generated skills from output/ if skills/ is empty
    if [[ -d "$NYX_DIR/output/skills" ]] && [[ ! "$(ls -A "$staging/skills/" 2>/dev/null)" ]]; then
        mkdir -p "$staging/skills"
        cp -r "$NYX_DIR/output/skills/"* "$staging/skills/" 2>/dev/null || true
    fi

    # Write setup config to file (avoids exposing secrets in process args)
    {
        printf 'PROVIDER=%q\n' "$NYX_PROVIDER"
        printf 'MODEL=%q\n' "$NYX_MODEL"
        printf 'SMALL_MODEL=%q\n' "$NYX_SMALL_MODEL"
        printf 'API_KEY_ENV=%q\n' "$NYX_API_KEY_ENV_VAR"
        printf 'API_KEY=%q\n' "$NYX_API_KEY"
        printf 'WORKSPACE=%q\n' "$NYX_WORKSPACE"
        printf 'ENABLE_EXA=%q\n' "$NYX_ENABLE_EXA"
    } > "$staging/nyx-setup.env"
    chmod 600 "$staging/nyx-setup.env"

    # Upload to VM
    ssh_vm "mkdir -p /tmp/nyx-setup"
    scp_to_vm "$staging/." "/tmp/nyx-setup/"
    rm -rf "$staging"
    ssh_vm "chmod 700 /tmp/nyx-setup && chmod 600 /tmp/nyx-setup/nyx-setup.env"

    # Run guest.sh
    ssh_vm "bash /tmp/nyx-setup/lib/guest.sh --config-file /tmp/nyx-setup/nyx-setup.env"
}
