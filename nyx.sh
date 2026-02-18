#!/usr/bin/env bash
# nyx — Start Nyx VM and launch OpenCode
set -euo pipefail

VM_NAME="${NYX_VM_NAME:-nyx-kali}"
VM_USER="${NYX_VM_USER:-kali}"
VM_IP="${NYX_VM_IP:-192.168.122.50}"
WORKSPACE="${NYX_WORKSPACE:-/home/kali/pentest}"
SSH_KEY="${NYX_SSH_KEY:-$HOME/.ssh/nyx_kali}"

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

virsh_q()  { virsh -c qemu:///system "$@" >/dev/null 2>&1 || sudo virsh -c qemu:///system "$@" >/dev/null 2>&1; }
virsh_o()  { virsh -c qemu:///system "$@" 2>/dev/null || sudo virsh -c qemu:///system "$@" 2>/dev/null; }

# Check VM exists
virsh_q dominfo "$VM_NAME" || { printf "${RED}Nyx VM not found. Run setup.py first.${RESET}\n"; exit 1; }

# Start if not running
state=$(virsh_o domstate "$VM_NAME" | tr -d '\r')
if [[ "$state" != "running" ]]; then
    printf "${CYAN}Starting VM...${RESET}\n"
    virsh_q start "$VM_NAME"
fi

# Wait for SSH (up to 60s)
printf "${CYAN}Connecting...${RESET}\n"
for i in $(seq 1 30); do
    ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
        -o LogLevel=ERROR -o BatchMode=yes -i "$SSH_KEY" "$VM_USER@$VM_IP" true 2>/dev/null && break
    sleep 2
done

# Launch OpenCode
printf "${GREEN}${BOLD}Launching Nyx...${RESET}\n"
exec ssh -t -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR \
    -i "$SSH_KEY" "$VM_USER@$VM_IP" \
    "cd \"$WORKSPACE\" && source .env && if command -v opencode >/dev/null; then exec opencode; else exec \$HOME/.local/bin/opencode; fi"
