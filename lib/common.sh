#!/usr/bin/env bash
# common.sh — Shared utilities for Nyx
set -euo pipefail

# ── Resolve repo root ──
NYX_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export NYX_DIR

# ── ANSI Colors ──
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# ── Logging ──
log_info()    { printf "${BLUE}[*]${RESET} %s\n" "$*"; }
log_warn()    { printf "${YELLOW}[!]${RESET} %s\n" "$*"; }
log_error()   { printf "${RED}[✗]${RESET} %s\n" "$*" >&2; }
log_success() { printf "${GREEN}[✓]${RESET} %s\n" "$*"; }

# ── Checks ──
check_command() {
    local cmd="$1"
    command -v "$cmd" &>/dev/null \
        || [[ -x "/usr/sbin/$cmd" ]] \
        || [[ -x "/usr/local/sbin/$cmd" ]] \
        || [[ -x "/sbin/$cmd" ]]
}

check_network() {
    curl -sI --connect-timeout 5 "https://cdimage.kali.org" &>/dev/null
}

check_disk_space() {
    local required_gb="${1:-25}"
    local target_dir="${2:-$NYX_DIR}"
    local available_kb
    available_kb=$(df --output=avail "$target_dir" 2>/dev/null | tail -1 | tr -d ' ')
    local available_gb=$(( available_kb / 1048576 ))
    (( available_gb >= required_gb ))
}

# ── Defaults ──
NYX_VM_NAME="${NYX_VM_NAME:-nyx-kali}"
NYX_VM_USER="${NYX_VM_USER:-kali}"
NYX_WORKSPACE="${NYX_WORKSPACE:-/home/kali/pentest}"
NYX_SSH_KEY="${NYX_SSH_KEY:-$HOME/.ssh/nyx_kali}"
NYX_CACHE_DIR="${NYX_CACHE_DIR:-$NYX_DIR/.cache}"

KALI_IMAGE_URL="https://cdimage.kali.org/kali-2025.4/kali-linux-2025.4-qemu-amd64.7z"
KALI_IMAGE_SHA256_URL="https://cdimage.kali.org/kali-2025.4/SHA256SUMS"
KALI_IMAGE_GPG_URL="https://cdimage.kali.org/kali-2025.4/SHA256SUMS.gpg"
KALI_7Z_FILE="kali-linux-2025.4-qemu-amd64.7z"
KALI_QCOW2_GLOB="kali-linux-*-qemu-amd64.qcow2"

# ── SSH helper ──
ssh_vm() {
    ssh -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -o LogLevel=ERROR \
        -o BatchMode=yes \
        -i "$NYX_SSH_KEY" \
        "${NYX_VM_USER}@${NYX_VM_IP}" "$@"
}

scp_to_vm() {
    scp -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -o LogLevel=ERROR \
        -o BatchMode=yes \
        -i "$NYX_SSH_KEY" \
        -r "$1" "${NYX_VM_USER}@${NYX_VM_IP}:$2"
}
