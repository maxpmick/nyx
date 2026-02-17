#!/usr/bin/env bash
# nyx — Start Nyx VM and launch OpenCode
set -euo pipefail

VM_NAME="nyx-kali"
VM_USER="kali"
WORKSPACE="/home/kali/pentest"
SSH_KEY="$HOME/.ssh/nyx_kali"

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

# Check VM exists
if ! virsh dominfo "$VM_NAME" &>/dev/null; then
    printf "${RED}Nyx VM not found. Run setup.sh first.${RESET}\n"
    exit 1
fi

# Start if not running
if [[ "$(virsh domstate "$VM_NAME" 2>/dev/null)" != "running" ]]; then
    printf "${CYAN}Starting VM...${RESET}\n"
    virsh start "$VM_NAME"
fi

# Get IP (poll up to 60s)
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

# Wait for SSH (poll up to 30s)
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

# Hand off to OpenCode
printf "${GREEN}${BOLD}Launching Nyx...${RESET}\n"
exec ssh -t \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -o LogLevel=ERROR \
    -i "$SSH_KEY" \
    "$VM_USER@$VM_IP" \
    "cd \"$WORKSPACE\" && source .env && if command -v opencode >/dev/null; then exec opencode; else exec \$HOME/.local/bin/opencode; fi"
