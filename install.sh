#!/usr/bin/env bash
# install.sh — Nyx bootstrap installer
#
# One command to install Nyx and all its dependencies:
#   curl -fsSL https://raw.githubusercontent.com/maxpmick/nyx/main/install.sh | bash
#
# Supports: Arch Linux, Ubuntu/Debian, Fedora
# Override defaults with env vars:
#   NYX_INSTALL_DIR  — where to clone the repo  (default: ~/.nyx)
#   NYX_REPO_URL     — git remote URL            (default: github.com/maxpmick/nyx)

set -euo pipefail

# ── Configuration ────────────────────────────────────────────────────────────
NYX_INSTALL_DIR_EXPLICIT=false
if [[ -n "${NYX_INSTALL_DIR+x}" ]]; then
    NYX_INSTALL_DIR_EXPLICIT=true
fi
NYX_INSTALL_DIR="${NYX_INSTALL_DIR:-$HOME/.nyx}"
NYX_REPO_URL="${NYX_REPO_URL:-https://github.com/maxpmick/nyx.git}"
USE_LOCAL_CLONE=false
INSTALL_USER="${SUDO_USER:-$USER}"

# ── ANSI Colors ──────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# ── Logging (Phase 0 — before gum is available) ─────────────────────────────
info()    { printf "  ${BLUE}[*]${RESET} %s\n" "$*"; }
warn()    { printf "  ${YELLOW}[!]${RESET} %s\n" "$*"; }
error()   { printf "  ${RED}[✗]${RESET} %s\n" "$*" >&2; }
success() { printf "  ${GREEN}[✓]${RESET} %s\n" "$*"; }
die()     { echo; for _m in "$@"; do error "$_m"; done; exit 1; }

have_command() {
    local cmd="$1"
    command -v "$cmd" &>/dev/null \
        || [[ -x "/usr/sbin/$cmd" ]] \
        || [[ -x "/usr/local/sbin/$cmd" ]] \
        || [[ -x "/sbin/$cmd" ]]
}

# ── Banner ───────────────────────────────────────────────────────────────────
show_banner() {
    printf "\n${MAGENTA}"
    cat <<'EOF'
    ███╗   ██╗██╗   ██╗██╗  ██╗
    ████╗  ██║╚██╗ ██╔╝╚██╗██╔╝
    ██╔██╗ ██║ ╚████╔╝  ╚███╔╝
    ██║╚██╗██║  ╚██╔╝   ██╔██╗
    ██║ ╚████║   ██║   ██╔╝ ██╗
    ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝
EOF
    printf "${RESET}"
    printf "    ${DIM}Agentic Pentester & OSINT Machine${RESET}\n"
    printf "    ${DIM}─────────────────────────────────${RESET}\n\n"
}

# ── Distro Detection ────────────────────────────────────────────────────────
DISTRO=""

detect_distro() {
    if [[ -f /etc/arch-release ]]; then
        DISTRO="arch"
    elif [[ -f /etc/debian_version ]]; then
        DISTRO="debian"
    elif [[ -f /etc/fedora-release ]] || [[ -f /etc/redhat-release ]]; then
        DISTRO="fedora"
    else
        die "Unsupported distribution. Nyx requires Arch Linux, Ubuntu/Debian, or Fedora."
    fi
}

distro_label() {
    case "$DISTRO" in
        arch)   printf "Arch Linux" ;;
        debian) printf "Ubuntu/Debian" ;;
        fedora) printf "Fedora" ;;
    esac
}

# ── KVM Check ────────────────────────────────────────────────────────────────
check_kvm() {
    if [[ ! -e /dev/kvm ]]; then
        die "KVM not available (/dev/kvm not found). Enable Intel VT-x or AMD-V in your BIOS/UEFI settings."
    fi
    if ! grep -cqE '(vmx|svm)' /proc/cpuinfo 2>/dev/null; then
        die "CPU does not support hardware virtualization. Enable VT-x/AMD-V in BIOS/UEFI."
    fi
}

# ── Disk Space Check ────────────────────────────────────────────────────────
check_disk_space() {
    local available_kb available_gb
    available_kb=$(df --output=avail "$HOME" 2>/dev/null | tail -1 | tr -d ' ')
    available_gb=$(( available_kb / 1048576 ))
    if (( available_gb < 25 )); then
        die "Insufficient disk space. At least 25 GB required (${available_gb} GB available)."
    fi
}

# ── Package Mapping ──────────────────────────────────────────────────────────
# Maps a command name to the package that provides it, per distro.
REQUIRED_CMDS=(qemu-system-x86_64 virsh dnsmasq virt-install virt-customize 7z curl git gpg)

pkg_for_cmd() {
    local cmd="$1"
    case "${DISTRO}:${cmd}" in
        arch:qemu-system-x86_64)    printf "qemu-full" ;;
        arch:virsh)                 printf "libvirt" ;;
        arch:dnsmasq)               printf "dnsmasq" ;;
        arch:virt-install)          printf "virt-install" ;;
        arch:virt-customize)        printf "guestfs-tools" ;;
        arch:7z)                    printf "p7zip" ;;
        arch:curl)                  printf "curl" ;;
        arch:git)                   printf "git" ;;
        arch:gpg)                   printf "gnupg" ;;

        debian:qemu-system-x86_64) printf "qemu-kvm" ;;
        debian:virsh)               printf "libvirt-daemon-system" ;;
        debian:dnsmasq)             printf "dnsmasq-base" ;;
        debian:virt-install)        printf "virtinst" ;;
        debian:virt-customize)      printf "libguestfs-tools" ;;
        debian:7z)                  printf "p7zip-full" ;;
        debian:curl)                printf "curl" ;;
        debian:git)                 printf "git" ;;
        debian:gpg)                 printf "gpg" ;;

        fedora:qemu-system-x86_64) printf "qemu-kvm" ;;
        fedora:virsh)               printf "libvirt" ;;
        fedora:dnsmasq)             printf "dnsmasq" ;;
        fedora:virt-install)        printf "virt-install" ;;
        fedora:virt-customize)      printf "guestfs-tools" ;;
        fedora:7z)                  printf "p7zip" ;;
        fedora:curl)                printf "curl" ;;
        fedora:git)                 printf "git" ;;
        fedora:gpg)                 printf "gnupg2" ;;
    esac
}

# ── Scan Dependencies ───────────────────────────────────────────────────────
MISSING_PKGS=()
MISSING_CMDS=()

add_missing_pkg() {
    local pkg="$1" existing
    for existing in "${MISSING_PKGS[@]+"${MISSING_PKGS[@]}"}"; do
        [[ "$existing" == "$pkg" ]] && return 0
    done
    MISSING_PKGS+=("$pkg")
}

scan_deps() {
    MISSING_PKGS=()
    MISSING_CMDS=()

    for cmd in "${REQUIRED_CMDS[@]}"; do
        if ! have_command "$cmd"; then
            MISSING_CMDS+=("$cmd")
            local pkg
            pkg=$(pkg_for_cmd "$cmd")
            add_missing_pkg "$pkg"
        fi
    done

    # On Debian/Ubuntu, default NAT network XML may be packaged separately.
    if [[ "$DISTRO" == "debian" ]] && [[ ! -f /usr/share/libvirt/networks/default.xml ]]; then
        add_missing_pkg "libvirt-daemon-config-network"
    fi
}

# ── Install gum ─────────────────────────────────────────────────────────────
install_gum() {
    if command -v gum &>/dev/null; then
        success "gum is installed"
        return 0
    fi

    info "Installing gum (interactive TUI toolkit)..."
    echo

    case "$DISTRO" in
        arch)
            sudo pacman -S --noconfirm --needed gum </dev/null 2>&1 | tail -5
            ;;
        debian)
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://repo.charm.sh/apt/gpg.key \
                | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg 2>/dev/null
            echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
                | sudo tee /etc/apt/sources.list.d/charm.list >/dev/null
            sudo apt-get update -qq </dev/null 2>&1 | tail -3
            sudo apt-get install -y -qq gum </dev/null 2>&1 | tail -3
            ;;
        fedora)
            sudo tee /etc/yum.repos.d/charm.repo >/dev/null <<'REPO'
[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key
REPO
            sudo dnf install -y gum </dev/null 2>&1 | tail -5
            ;;
    esac

    if command -v gum &>/dev/null; then
        echo
        success "gum installed successfully"
    else
        die "Failed to install gum. Please install it manually: https://github.com/charmbracelet/gum#installation"
    fi
}

# ── Show Dependency Status (gum-powered) ────────────────────────────────────
show_dep_status() {
    echo
    gum style --bold --foreground 212 "  Dependencies"
    echo

    for cmd in "${REQUIRED_CMDS[@]}"; do
        local pkg
        pkg=$(pkg_for_cmd "$cmd")
        if have_command "$cmd"; then
            printf "  ${GREEN}✓${RESET}  ${DIM}%-22s %s${RESET}\n" "$cmd" "$pkg"
        else
            printf "  ${RED}✗${RESET}  ${BOLD}%-22s${RESET} ${YELLOW}%s${RESET}\n" "$cmd" "$pkg"
        fi
    done

    echo

    # Service status
    gum style --bold --foreground 212 "  Services"
    echo

    if libvirt_daemon_active; then
        printf "  ${GREEN}✓${RESET}  ${DIM}%-22s running${RESET}\n" "libvirtd"
    else
        printf "  ${RED}✗${RESET}  ${BOLD}%-22s${RESET} ${YELLOW}not running${RESET}\n" "libvirtd"
    fi

    if id -nG "$USER" 2>/dev/null | grep -qw libvirt; then
        printf "  ${GREEN}✓${RESET}  ${DIM}%-22s member${RESET}\n" "libvirt group"
    else
        printf "  ${RED}✗${RESET}  ${BOLD}%-22s${RESET} ${YELLOW}not a member${RESET}\n" "libvirt group"
    fi

    if virsh net-info default 2>/dev/null | grep -q "Active:.*yes"; then
        printf "  ${GREEN}✓${RESET}  ${DIM}%-22s active${RESET}\n" "default network"
    else
        printf "  ${RED}✗${RESET}  ${BOLD}%-22s${RESET} ${YELLOW}inactive${RESET}\n" "default network"
    fi

    echo
}

# ── Install Packages (gum-powered) ──────────────────────────────────────────
install_packages() {
    (( ${#MISSING_PKGS[@]} == 0 )) && return 0

    gum style --foreground 214 "  The following packages will be installed:"
    echo
    for pkg in "${MISSING_PKGS[@]}"; do
        printf "    ${CYAN}•${RESET}  %s\n" "$pkg"
    done
    echo

    if ! gum confirm "Install ${#MISSING_PKGS[@]} package(s)?"; then
        die "Installation cancelled."
    fi

    echo

    case "$DISTRO" in
        arch)
            gum spin --spinner dot --title "  Installing packages via pacman..." -- \
                sudo pacman -S --noconfirm --needed "${MISSING_PKGS[@]}" </dev/null
            ;;
        debian)
            gum spin --spinner dot --title "  Updating package lists..." -- \
                sudo apt-get update -qq </dev/null
            gum spin --spinner dot --title "  Installing packages via apt..." -- \
                sudo apt-get install -y -qq "${MISSING_PKGS[@]}" </dev/null
            ;;
        fedora)
            gum spin --spinner dot --title "  Installing packages via dnf..." -- \
                sudo dnf install -y "${MISSING_PKGS[@]}" </dev/null
            ;;
    esac

    success "All packages installed"
}

# ── Setup Services (gum-powered) ────────────────────────────────────────────
NEEDS_GROUP_ACTIVATE=false

default_network_active() {
    sudo virsh net-info default 2>/dev/null | grep -q "Active:.*yes"
}

libvirt_daemon_active() {
    systemctl is-active --quiet libvirtd 2>/dev/null \
        || systemctl is-active --quiet virtqemud.socket 2>/dev/null \
        || systemctl is-active --quiet virtqemud.service 2>/dev/null
}

USE_MODULAR_DAEMONS=false

start_libvirt_daemons() {
    # libvirt supports two mutually exclusive daemon layouts:
    #   monolithic  — single libvirtd handles everything
    #   modular     — separate virtqemud, virtnetworkd, virtstoraged, …
    # They CONFLICT: only one set can own the sockets at a time.
    # Detect which layout to use, then cleanly start it.

    local modular_units=(
        virtqemud virtnetworkd virtstoraged
        virtinterfaced virtnodedevd virtsecretd virtnwfilterd
    )

    # Use modular only if libvirtd.service doesn't exist on this system
    if ! systemctl cat libvirtd.service >/dev/null 2>&1; then
        USE_MODULAR_DAEMONS=true
    fi

    if $USE_MODULAR_DAEMONS; then
        # ── Modular mode ─────────────────────────────────────────────
        # Stop monolithic daemon to avoid conflicts
        sudo systemctl disable --now libvirtd.socket  >/dev/null 2>&1 || true
        sudo systemctl disable --now libvirtd-ro.socket >/dev/null 2>&1 || true
        sudo systemctl disable --now libvirtd-admin.socket >/dev/null 2>&1 || true
        sudo systemctl stop libvirtd.service >/dev/null 2>&1 || true

        for u in "${modular_units[@]}"; do
            sudo systemctl enable --now "${u}.socket" >/dev/null 2>&1 || true
        done
    else
        # ── Monolithic mode (default, broadest compat) ───────────────
        # Stop modular sockets/services that conflict with libvirtd
        for u in "${modular_units[@]}"; do
            sudo systemctl disable --now "${u}.socket"  >/dev/null 2>&1 || true
            sudo systemctl stop "${u}.service" >/dev/null 2>&1 || true
        done

        # Start sockets FIRST — libvirtd relies on socket activation and
        # won't create listener sockets itself when started with --timeout
        sudo systemctl enable --now libvirtd.socket      >/dev/null 2>&1 || true
        sudo systemctl enable --now libvirtd-ro.socket   >/dev/null 2>&1 || true
        sudo systemctl enable --now libvirtd-admin.socket >/dev/null 2>&1 || true

        # Now (re)start the service so it picks up the activated sockets
        sudo systemctl restart libvirtd.service >/dev/null 2>&1 || true
    fi
}

wait_for_virsh() {
    local i
    for ((i=0; i<20; i++)); do
        sudo virsh uri >/dev/null 2>&1 && return 0
        sleep 1
    done
    return 1
}

ensure_default_network() {
    local xml_candidate tmp_xml

    # In modular mode, virtnetworkd must be running to manage networks.
    # In monolithic mode libvirtd handles everything — don't start
    # modular daemons or they'll conflict.
    if $USE_MODULAR_DAEMONS; then
        sudo systemctl start virtnetworkd.socket  >/dev/null 2>&1 || true
        sudo systemctl start virtnetworkd.service >/dev/null 2>&1 || true
    fi

    # Define default network from packaged XML when available.
    if ! sudo virsh net-info default >/dev/null 2>&1; then
        for xml_candidate in /usr/share/libvirt/networks/default.xml /etc/libvirt/qemu/networks/default.xml; do
            [[ -f "$xml_candidate" ]] || continue
            sudo virsh net-define "$xml_candidate" >/dev/null 2>&1 && break
        done
    fi

    # Last resort: define a standard libvirt NAT network.
    if ! sudo virsh net-info default >/dev/null 2>&1; then
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
        sudo virsh net-define "$tmp_xml" >/dev/null 2>&1 || true
        rm -f "$tmp_xml"
    fi

    sudo virsh net-start default >/dev/null 2>&1 || true
    sudo virsh net-autostart default >/dev/null 2>&1 || true
    default_network_active
}

setup_services() {
    gum style --bold --foreground 212 "  System Configuration"
    echo

    # ── libvirt daemons ──────────────────────────────────────────────
    # Always run start_libvirt_daemons: it detects the correct mode,
    # cleans up conflicting units from previous runs, and ensures
    # sockets are active before the service starts.
    start_libvirt_daemons

    # Wait for virsh to actually connect before running any virsh commands
    if ! wait_for_virsh; then
        die "libvirt daemons started but virsh cannot connect after 20 s." \
            "Debug: systemctl status libvirtd virtqemud.socket virtnetworkd.socket"
    fi
    success "libvirt daemons are running"

    # ── libvirt group ────────────────────────────────────────────────
    if ! id -nG "$INSTALL_USER" 2>/dev/null | grep -qw libvirt; then
        gum spin --spinner dot --title "  Adding $INSTALL_USER to libvirt group..." -- \
            sudo usermod -aG libvirt "$INSTALL_USER"
        NEEDS_GROUP_ACTIVATE=true
        success "Added $INSTALL_USER to libvirt group"
    else
        success "$INSTALL_USER already in libvirt group"
    fi

    # ── Default virtual network ──────────────────────────────────────
    if ! default_network_active; then
        info "Starting default virtual network..."
        if ensure_default_network; then
            success "Default network activated"
        else
            die "Could not activate the libvirt default network." \
                "Debug: sudo virsh net-list --all && journalctl -u virtnetworkd -u libvirtd --no-pager -n 30"
        fi
    else
        success "Default network already active"
    fi

    echo
}

# ── Clone Repository (gum-powered) ──────────────────────────────────────────
clone_repo() {
    gum style --bold --foreground 212 "  Repository"
    echo

    if $USE_LOCAL_CLONE; then
        success "Using existing Nyx clone at $NYX_INSTALL_DIR"
        echo
        return 0
    fi

    if [[ -d "$NYX_INSTALL_DIR/.git" ]]; then
        gum spin --spinner dot --title "  Updating existing installation..." -- \
            git -C "$NYX_INSTALL_DIR" pull --ff-only 2>/dev/null
        success "Updated $NYX_INSTALL_DIR"
    else
        if [[ -d "$NYX_INSTALL_DIR" ]] && [[ -n "$(ls -A "$NYX_INSTALL_DIR" 2>/dev/null)" ]]; then
            local backup="${NYX_INSTALL_DIR}.bak.$(date +%s)"
            warn "$NYX_INSTALL_DIR exists — backing up to $backup"
            mv "$NYX_INSTALL_DIR" "$backup"
        fi
        gum spin --spinner dot --title "  Cloning Nyx repository..." -- \
            git clone --depth 1 "$NYX_REPO_URL" "$NYX_INSTALL_DIR"
        success "Cloned to $NYX_INSTALL_DIR"
    fi

    echo
}

# ── Completion ───────────────────────────────────────────────────────────────
show_completion() {
    gum style \
        --border double \
        --border-foreground 212 \
        --padding "1 3" \
        --bold \
        "  ✓ Nyx dependencies are installed!" \
        "" \
        "  Installation directory: $NYX_INSTALL_DIR" \
        "  Next step: VM setup wizard (provider, model, API key)"
    echo
}

# ─────────────────────────────────────────────────────────────────────────────
#  Main
# ─────────────────────────────────────────────────────────────────────────────
main() {
    show_banner

    # ── Phase 0: Bare shell checks ───────────────────────────────────────
    if ! $NYX_INSTALL_DIR_EXPLICIT && [[ "$(basename "$PWD")" == "nyx" ]] && [[ -d "$PWD/.git" ]]; then
        NYX_INSTALL_DIR="$PWD"
        USE_LOCAL_CLONE=true
        info "Detected existing Nyx clone in current directory: $NYX_INSTALL_DIR"
    fi

    info "Detecting system..."
    detect_distro
    success "Detected $(distro_label)"

    info "Checking KVM support..."
    check_kvm
    success "KVM is available"

    info "Checking disk space..."
    check_disk_space
    success "Sufficient disk space (25 GB+ required)"

    echo
    info "This installer requires sudo privileges to install packages."
    sudo -v
    echo

    # ── Install gum for interactive TUI ──────────────────────────────────
    install_gum

    # Keep sudo credential alive in background for the rest of the install
    (while true; do sudo -n true 2>/dev/null; sleep 50; done) &
    SUDO_KEEPALIVE_PID=$!
    trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT

    # ── Phase 1: gum-powered interactive experience ──────────────────────

    # Scan and display dependency status
    scan_deps
    show_dep_status

    # Install missing packages
    if (( ${#MISSING_PKGS[@]} > 0 )); then
        install_packages
        echo
    else
        gum style --foreground 76 "  All packages already installed"
        echo
    fi

    # Configure services
    setup_services

    # Clone repository
    clone_repo

    # Done
    show_completion

    # Hand off to setup wizard
    local setup_script setup_cmd
    setup_script="$NYX_INSTALL_DIR/setup.sh"
    if [[ ! -f "$setup_script" ]]; then
        die "Setup wizard not found at $setup_script. Re-run installer and check repository clone."
    fi
    printf -v setup_cmd 'bash %q' "$setup_script"

    if gum confirm "  Launch setup wizard now?"; then
        echo
        if $NEEDS_GROUP_ACTIVATE; then
            info "Activating libvirt group for this session..."
            exec sg libvirt -c "$setup_cmd"
        else
            exec bash "$setup_script"
        fi
    else
        echo
        if $NEEDS_GROUP_ACTIVATE; then
            warn "You were added to the libvirt group."
            warn "Log out and back in, then run:"
        else
            info "Run the setup wizard later:"
        fi
        printf "\n    ${CYAN}${BOLD}bash %q${RESET}\n\n" "$setup_script"
    fi
}

main "$@"
