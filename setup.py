#!/usr/bin/env python3
"""Nyx setup — single-script installer for the Nyx pentesting VM."""

import getpass
import hashlib
import os
import re
import shutil
import subprocess
import sys
import tempfile
import textwrap
import time
import xml.etree.ElementTree as ET

# ── Defaults ──────────────────────────────────────────────────────────────────

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
CACHE_DIR = os.path.join(SCRIPT_DIR, ".cache")

KALI_IMAGE_URL = "https://cdimage.kali.org/kali-2025.4/kali-linux-2025.4-qemu-amd64.7z"
KALI_SHA256_URL = "https://cdimage.kali.org/kali-2025.4/SHA256SUMS"
KALI_7Z_FILE = "kali-linux-2025.4-qemu-amd64.7z"
KALI_QCOW2_GLOB = "kali-linux-*-qemu-amd64.qcow2"

VM_DISK_DIR = "/var/lib/libvirt/images"
VM_STATIC_IP = "192.168.122.50"
VM_GATEWAY = "192.168.122.1"

PROVIDERS = {
    "1": {
        "name": "Anthropic",
        "id": "anthropic",
        "env": "ANTHROPIC_API_KEY",
        "models": ["claude-sonnet-4-5-20250929", "claude-opus-4-6", "claude-haiku-4-5-20251001"],
        "small": "claude-haiku-4-5-20251001",
    },
    "2": {
        "name": "OpenAI",
        "id": "openai",
        "env": "OPENAI_API_KEY",
        "models": ["gpt-4o", "gpt-4o-mini", "o3-mini"],
        "small": "gpt-4o-mini",
    },
    "3": {
        "name": "Google Gemini",
        "id": "google",
        "env": "GEMINI_API_KEY",
        "models": ["gemini-2.5-flash", "gemini-2.5-pro"],
        "small": "gemini-2.5-flash",
    },
    "4": {
        "name": "Groq",
        "id": "groq",
        "env": "GROQ_API_KEY",
        "models": ["llama-3.3-70b", "llama-3.1-8b", "mixtral-8x7b-32768"],
        "small": "llama-3.3-70b",
    },
    "5": {
        "name": "OpenRouter",
        "id": "openrouter",
        "env": "OPENROUTER_API_KEY",
        "models": [],
        "small": "",
    },
}

PACKAGES = {
    "arch": ["qemu-full", "libvirt", "dnsmasq", "virt-install", "guestfs-tools", "p7zip", "curl", "git", "gnupg", "usbutils"],
    "debian": ["qemu-kvm", "libvirt-daemon-system", "dnsmasq-base", "virtinst", "libguestfs-tools", "p7zip-full", "curl", "git", "gpg", "usbutils"],
    "fedora": ["qemu-kvm", "libvirt", "dnsmasq", "virt-install", "guestfs-tools", "p7zip", "curl", "git", "gnupg2", "usbutils"],
}

DEFAULT_NETWORK_XML = """\
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
"""

# ── Colors ────────────────────────────────────────────────────────────────────

RED = "\033[0;31m"
GREEN = "\033[0;32m"
YELLOW = "\033[0;33m"
BLUE = "\033[0;34m"
MAGENTA = "\033[0;35m"
CYAN = "\033[0;36m"
BOLD = "\033[1m"
RESET = "\033[0m"


def info(msg):
    print(f"  {BLUE}[*]{RESET} {msg}")


def ok(msg):
    print(f"  {GREEN}[+]{RESET} {msg}")


def warn(msg):
    print(f"  {YELLOW}[!]{RESET} {msg}")


def err(msg):
    print(f"  {RED}[!]{RESET} {msg}", file=sys.stderr)


def die(*msgs):
    print()
    for m in msgs:
        err(m)
    sys.exit(1)


def run(cmd, **kwargs):
    """Run a command, returning CompletedProcess. Raises on failure."""
    return subprocess.run(cmd, check=True, **kwargs)


def run_quiet(cmd, **kwargs):
    """Run a command silently, return True on success."""
    try:
        subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, **kwargs)
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        return False


def virsh(*args):
    """Run virsh against qemu:///system, trying without sudo first."""
    cmd = ["virsh", "-c", "qemu:///system"] + list(args)
    if run_quiet(cmd):
        return True
    return run_quiet(["sudo"] + cmd)


def virsh_output(*args):
    """Run virsh and return stdout."""
    cmd = ["virsh", "-c", "qemu:///system"] + list(args)
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, check=True)
        return r.stdout
    except (subprocess.CalledProcessError, FileNotFoundError):
        pass
    try:
        r = subprocess.run(["sudo"] + cmd, capture_output=True, text=True, check=True)
        return r.stdout
    except (subprocess.CalledProcessError, FileNotFoundError):
        return ""


def ssh_cmd(user, ip, key):
    """Build base SSH command list."""
    return [
        "ssh",
        "-o", "StrictHostKeyChecking=no",
        "-o", "UserKnownHostsFile=/dev/null",
        "-o", "LogLevel=ERROR",
        "-o", "BatchMode=yes",
        "-o", "ConnectTimeout=10",
        "-o", "ServerAliveInterval=30",
        "-o", "ServerAliveCountMax=10",
        "-i", key,
        f"{user}@{ip}",
    ]


# ── USB passthrough helpers ───────────────────────────────────────────────────

def list_connected_usb_devices():
    """Return connected USB devices, grouped by vendor/product ID."""
    try:
        result = subprocess.run(["lsusb"], capture_output=True, text=True, check=True)
    except FileNotFoundError:
        warn("lsusb not found; USB passthrough selection is unavailable.")
        return []
    except subprocess.CalledProcessError:
        warn("Could not enumerate USB devices; USB passthrough selection is unavailable.")
        return []

    pattern = re.compile(
        r"^Bus\s+\d+\s+Device\s+\d+:\s+ID\s+([0-9a-fA-F]{4}):([0-9a-fA-F]{4})\s*(.*)$"
    )
    grouped = {}

    for line in result.stdout.splitlines():
        match = pattern.match(line.strip())
        if not match:
            continue

        vendor_id, product_id, description = match.groups()
        key = (vendor_id.lower(), product_id.lower())
        desc = description.strip() or "Unknown USB device"

        if key not in grouped:
            grouped[key] = {
                "vendor_id": key[0],
                "product_id": key[1],
                "description": desc,
                "count": 1,
            }
        else:
            grouped[key]["count"] += 1
            if grouped[key]["description"] == "Unknown USB device" and description.strip():
                grouped[key]["description"] = description.strip()

    return sorted(
        grouped.values(),
        key=lambda d: (d["vendor_id"], d["product_id"], d["description"]),
    )


def select_usb_passthrough_devices():
    """Prompt user to choose USB devices for persistent passthrough."""
    while True:
        devices = list_connected_usb_devices()
        if not devices:
            print("  USB passthrough devices: none detected (or lsusb unavailable).")
            raw = input("  Press 'r' to refresh, or Enter to skip: ").strip().lower()
            print()
            if raw == "r":
                continue
            return []

        print("  USB passthrough devices (persistent):")
        for i, dev in enumerate(devices, 1):
            qty = f" x{dev['count']}" if dev["count"] > 1 else ""
            print(f"    {i}) {dev['vendor_id']}:{dev['product_id']}  {dev['description']}{qty}")

        raw = input("\n  Select USB device numbers (comma-separated), 'r' to refresh, Enter to skip: ").strip()
        if not raw:
            print()
            return []
        if raw.lower() == "r":
            print()
            continue

        selected = []
        seen = set()
        for token in raw.split(","):
            token = token.strip()
            if not token:
                continue
            if not token.isdigit():
                die(f"Invalid USB selection: {token}")

            idx = int(token)
            if idx < 1 or idx > len(devices):
                die(f"Invalid USB selection index: {idx}")

            dev = devices[idx - 1]
            key = (dev["vendor_id"], dev["product_id"])
            if key in seen:
                continue
            seen.add(key)
            selected.append({
                "vendor_id": dev["vendor_id"],
                "product_id": dev["product_id"],
                "description": dev["description"],
            })

        print()
        return selected


def usb_passthrough_exists(vm_xml, vendor_id, product_id):
    """Check whether USB passthrough VID:PID already exists in domain XML."""
    try:
        root = ET.fromstring(vm_xml)
    except ET.ParseError:
        return False

    want_vendor = f"0x{vendor_id.lower()}"
    want_product = f"0x{product_id.lower()}"

    for hostdev in root.findall("./devices/hostdev"):
        if hostdev.get("type") != "usb":
            continue

        source = hostdev.find("source")
        if source is None:
            continue

        vendor = source.find("vendor")
        product = source.find("product")
        if vendor is None or product is None:
            continue

        have_vendor = vendor.get("id", "").lower()
        have_product = product.get("id", "").lower()
        if have_vendor == want_vendor and have_product == want_product:
            return True

    return False


def find_host_usb_devices(vendor_id, product_id):
    """Return matching host USB device nodes for a VID:PID."""
    sys_usb_root = "/sys/bus/usb/devices"
    devices = []
    if not os.path.isdir(sys_usb_root):
        return devices

    for entry in os.listdir(sys_usb_root):
        # Top-level USB devices are names like 1-4, 3-7.1, etc.
        # Interface entries include ":" and are handled separately.
        if ":" in entry:
            continue
        dev_path = os.path.join(sys_usb_root, entry)
        vendor_path = os.path.join(dev_path, "idVendor")
        product_path = os.path.join(dev_path, "idProduct")
        if not os.path.isfile(vendor_path) or not os.path.isfile(product_path):
            continue
        try:
            with open(vendor_path) as f:
                have_vendor = f.read().strip().lower()
            with open(product_path) as f:
                have_product = f.read().strip().lower()
        except OSError:
            continue
        if have_vendor == vendor_id and have_product == product_id:
            devices.append({"name": entry, "path": dev_path})

    return sorted(devices, key=lambda d: d["name"])


def install_usb_autosuspend_udev_rule(vendor_id, product_id):
    """Persistently disable USB autosuspend for a passthrough VID:PID."""
    rule_path = "/etc/udev/rules.d/99-nyx-usb-passthrough.rules"
    rule = (
        'ACTION=="add", SUBSYSTEM=="usb", '
        f'ATTR{{idVendor}}=="{vendor_id}", ATTR{{idProduct}}=="{product_id}", '
        'TEST=="power/control", ATTR{power/control}="on", '
        'TEST=="power/autosuspend_delay_ms", ATTR{power/autosuspend_delay_ms}="-1"'
    )

    existing = ""
    if os.path.isfile(rule_path):
        try:
            with open(rule_path) as f:
                existing = f.read()
        except OSError as e:
            warn(f"Could not read {rule_path}: {e}")
            return

    if rule in existing:
        return

    try:
        with open(rule_path, "a") as f:
            if existing and not existing.endswith("\n"):
                f.write("\n")
            if not existing:
                f.write("# Managed by nyx setup.py for USB passthrough stability\n")
            f.write(f"{rule}\n")
        ok(f"Installed persistent USB autosuspend override for {vendor_id}:{product_id}")
    except OSError as e:
        warn(f"Failed to write {rule_path}: {e}")
        return

    run_quiet(["udevadm", "control", "--reload-rules"])
    run_quiet([
        "udevadm", "trigger",
        "--subsystem-match=usb",
        f"--attr-match=idVendor={vendor_id}",
        f"--attr-match=idProduct={product_id}",
    ])


def disable_host_usb_autosuspend(vendor_id, product_id):
    """Disable autosuspend immediately for matching host USB devices."""
    devices = find_host_usb_devices(vendor_id, product_id)
    if not devices:
        warn(f"USB device not found on host for autosuspend tuning: {vendor_id}:{product_id}")
        return

    any_applied = False
    for dev in devices:
        device_applied = False
        power_dir = os.path.join(dev["path"], "power")
        control_path = os.path.join(power_dir, "control")
        delay_path = os.path.join(power_dir, "autosuspend_delay_ms")

        if os.path.isfile(control_path):
            try:
                with open(control_path, "w") as f:
                    f.write("on")
                device_applied = True
            except OSError as e:
                warn(f"Failed to set power/control for {dev['name']}: {e}")

        if os.path.isfile(delay_path):
            try:
                with open(delay_path, "w") as f:
                    f.write("-1")
                device_applied = True
            except OSError as e:
                warn(f"Failed to set autosuspend_delay_ms for {dev['name']}: {e}")

        if device_applied:
            ok(f"Disabled USB autosuspend for {vendor_id}:{product_id} ({dev['name']})")
            any_applied = True

    if not any_applied:
        info(f"No writable autosuspend controls found for {vendor_id}:{product_id}")


def unbind_host_usb_drivers(vendor_id, product_id):
    """Unbind host kernel drivers for matching USB VID:PID interfaces."""
    sys_usb_root = "/sys/bus/usb/devices"
    if not os.path.isdir(sys_usb_root):
        warn("Cannot inspect /sys/bus/usb/devices; skipping host USB driver unbind.")
        return

    matches = [d["name"] for d in find_host_usb_devices(vendor_id, product_id)]

    if not matches:
        warn(f"USB device not found on host for driver unbind: {vendor_id}:{product_id}")
        return

    unbound_any = False
    entries = sorted(os.listdir(sys_usb_root))
    for device in matches:
        iface_prefix = f"{device}:"
        for iface in entries:
            if not iface.startswith(iface_prefix):
                continue

            iface_path = os.path.join(sys_usb_root, iface)
            driver_link = os.path.join(iface_path, "driver")
            if not os.path.islink(driver_link):
                continue

            driver_name = os.path.basename(os.path.realpath(driver_link))
            unbind_path = os.path.join(driver_link, "unbind")
            try:
                with open(unbind_path, "w") as f:
                    f.write(iface)
                ok(f"Unbound host driver {driver_name} from {vendor_id}:{product_id} ({iface})")
                unbound_any = True
            except OSError as e:
                warn(f"Failed to unbind host driver for {vendor_id}:{product_id} ({iface}): {e}")

    if not unbound_any:
        info(f"No host USB interface drivers needed unbinding for {vendor_id}:{product_id}")


def apply_usb_passthrough(cfg):
    """Attach selected USB devices to VM persistently."""
    devices = cfg.get("usb_passthrough", [])
    if not devices:
        return

    vm_name = cfg["vm_name"]
    if not virsh("dominfo", vm_name):
        warn(f"Cannot configure USB passthrough: VM '{vm_name}' not found.")
        return

    info("Applying persistent USB passthrough configuration...")
    vm_xml = virsh_output("dumpxml", vm_name)
    if not vm_xml:
        warn("Could not read VM XML; skipping USB passthrough.")
        return
    vm_running = virsh_output("domstate", vm_name).strip().lower() == "running"

    for dev in devices:
        vendor_id = dev["vendor_id"].lower()
        product_id = dev["product_id"].lower()
        label = dev.get("description", "USB device")
        install_usb_autosuspend_udev_rule(vendor_id, product_id)
        disable_host_usb_autosuspend(vendor_id, product_id)
        unbind_host_usb_drivers(vendor_id, product_id)

        hostdev_xml = textwrap.dedent(f"""\
            <hostdev mode='subsystem' type='usb' managed='yes'>
              <source>
                <vendor id='0x{vendor_id}'/>
                <product id='0x{product_id}'/>
              </source>
            </hostdev>
        """)

        if usb_passthrough_exists(vm_xml, vendor_id, product_id):
            ok(f"USB passthrough already configured: {vendor_id}:{product_id} ({label})")
            if vm_running:
                with tempfile.NamedTemporaryFile(mode="w", suffix=".xml", delete=False) as f:
                    f.write(hostdev_xml)
                    temp_xml = f.name
                try:
                    # Reset stale runtime state first, then reattach live.
                    detach_cmd = ["virsh", "-c", "qemu:///system", "detach-device", vm_name, temp_xml, "--live"]
                    run_quiet(detach_cmd) or run_quiet(["sudo"] + detach_cmd)

                    attach_cmd = ["virsh", "-c", "qemu:///system", "attach-device", vm_name, temp_xml, "--live"]
                    if run_quiet(attach_cmd) or run_quiet(["sudo"] + attach_cmd):
                        ok(f"USB passthrough live reset applied: {vendor_id}:{product_id} ({label})")
                    else:
                        warn(f"USB passthrough live reset failed: {vendor_id}:{product_id} ({label})")
                finally:
                    os.unlink(temp_xml)
            continue

        with tempfile.NamedTemporaryFile(mode="w", suffix=".xml", delete=False) as f:
            f.write(hostdev_xml)
            temp_xml = f.name

        try:
            cmd = ["virsh", "-c", "qemu:///system", "attach-device", vm_name, temp_xml, "--config"]
            if vm_running:
                cmd.append("--live")
            if run_quiet(cmd) or run_quiet(["sudo"] + cmd):
                ok(f"USB passthrough configured: {vendor_id}:{product_id} ({label})")
                vm_xml = virsh_output("dumpxml", vm_name)
            else:
                warn(f"Failed to configure USB passthrough: {vendor_id}:{product_id} ({label})")
        finally:
            os.unlink(temp_xml)


# ── 1. Banner ─────────────────────────────────────────────────────────────────

def print_banner():
    banner_path = os.path.join(SCRIPT_DIR, "assets", "banner.txt")
    if os.path.isfile(banner_path):
        with open(banner_path) as f:
            print(f"{MAGENTA}{f.read()}{RESET}")
    print()


# ── 2. Check prerequisites ───────────────────────────────────────────────────

def check_prerequisites():
    info("Checking prerequisites...")

    if os.geteuid() != 0:
        die("This script must be run as root: sudo python3 setup.py")

    if not os.path.exists("/dev/kvm"):
        with open("/proc/cpuinfo") as f:
            cpuinfo = f.read()
        if "vmx" not in cpuinfo and "svm" not in cpuinfo:
            die(
                "/dev/kvm not found and CPU has no virtualization flags.",
                "Enable Intel VT-x or AMD-V in your BIOS.",
            )
        die(
            "/dev/kvm not found but CPU supports virtualization.",
            "Load the kvm module: sudo modprobe kvm-intel (or kvm-amd)",
        )

    # Disk space check (25 GB)
    stat = os.statvfs(SCRIPT_DIR)
    avail_gb = (stat.f_bavail * stat.f_frsize) // (1024 ** 3)
    if avail_gb < 25:
        die(f"Need at least 25 GB free disk space, only {avail_gb} GB available.")

    ok("Prerequisites OK")


# ── 3. Detect distro ─────────────────────────────────────────────────────────

def read_os_release():
    """Read /etc/os-release as lowercase text, or return empty string."""
    try:
        with open("/etc/os-release") as f:
            return f.read().lower()
    except FileNotFoundError:
        return ""


def is_running_inside_kali_vm():
    """Return True if this script is running inside a Kali virtual machine."""
    os_release = read_os_release()
    if "kali" not in os_release:
        return False

    if run_quiet(["systemd-detect-virt", "--vm", "--quiet"]):
        return True

    vm_markers = ("kvm", "qemu", "vmware", "virtualbox", "xen", "hyper-v", "parallels")
    for path in ["/sys/class/dmi/id/product_name", "/sys/class/dmi/id/sys_vendor"]:
        try:
            with open(path) as f:
                data = f.read().strip().lower()
        except (FileNotFoundError, PermissionError, OSError):
            continue
        if any(marker in data for marker in vm_markers):
            return True

    return False


def detect_distro():
    info("Detecting distribution...")
    os_release = read_os_release()
    if not os_release:
        die("Cannot detect distribution: /etc/os-release not found.")

    if "arch" in os_release:
        distro = "arch"
    elif "debian" in os_release or "ubuntu" in os_release:
        distro = "debian"
    elif "fedora" in os_release:
        distro = "fedora"
    else:
        die("Unsupported distribution. Supported: Arch, Debian/Ubuntu, Fedora.")

    ok(f"Detected: {distro}")
    return distro


# ── 4. Install packages ──────────────────────────────────────────────────────

def install_packages(distro):
    info("Installing packages...")
    pkgs = PACKAGES[distro]

    if distro == "arch":
        run(["pacman", "-S", "--needed", "--noconfirm"] + pkgs)
    elif distro == "debian":
        run(["apt-get", "update", "-qq"])
        # Ensure default network config is available
        if not os.path.exists("/usr/share/libvirt/networks/default.xml"):
            pkgs = pkgs + ["libvirt-daemon-config-network"]
        run(["apt-get", "install", "-y", "-qq"] + pkgs)
    elif distro == "fedora":
        run(["dnf", "install", "-y"] + pkgs)

    ok("Packages installed")


# ── 5. Start libvirt ──────────────────────────────────────────────────────────

def start_libvirt():
    info("Configuring libvirt...")

    # Detect monolithic vs modular
    use_modular = not run_quiet(["systemctl", "cat", "libvirtd.service"])

    if not use_modular:
        # Check if modular is active without libvirtd
        modular_active = (
            run_quiet(["systemctl", "is-active", "--quiet", "virtqemud.socket"])
            or run_quiet(["systemctl", "is-active", "--quiet", "virtqemud.service"])
        )
        monolithic_active = (
            run_quiet(["systemctl", "is-active", "--quiet", "libvirtd.socket"])
            or run_quiet(["systemctl", "is-active", "--quiet", "libvirtd.service"])
        )
        if modular_active and not monolithic_active:
            use_modular = True

    modular_units = [
        "virtqemud", "virtnetworkd", "virtstoraged",
        "virtinterfaced", "virtnodedevd", "virtsecretd", "virtnwfilterd",
    ]

    if use_modular:
        for sock in ["libvirtd.socket", "libvirtd-ro.socket", "libvirtd-admin.socket"]:
            run_quiet(["systemctl", "disable", "--now", sock])
        run_quiet(["systemctl", "stop", "libvirtd.service"])
        for u in modular_units:
            run_quiet(["systemctl", "enable", "--now", f"{u}.socket"])
    else:
        for u in modular_units:
            run_quiet(["systemctl", "disable", "--now", f"{u}.socket"])
            run_quiet(["systemctl", "stop", f"{u}.service"])
        for sock in ["libvirtd.socket", "libvirtd-ro.socket", "libvirtd-admin.socket"]:
            run_quiet(["systemctl", "enable", "--now", sock])
        run_quiet(["systemctl", "restart", "libvirtd.service"])

    # Wait for virsh to respond
    for _ in range(20):
        if run_quiet(["sudo", "virsh", "-c", "qemu:///system", "uri"]):
            break
        time.sleep(1)

    # Add user to libvirt group
    real_user = os.environ.get("SUDO_USER", "")
    if real_user:
        run_quiet(["usermod", "-aG", "libvirt", real_user])

    ok("Libvirt running")


# ── 6. Ensure default network ────────────────────────────────────────────────

def ensure_default_network():
    info("Ensuring default network...")

    # Check if network is defined
    if not virsh("net-info", "default"):
        # Define it
        with tempfile.NamedTemporaryFile(mode="w", suffix=".xml", delete=False) as f:
            f.write(DEFAULT_NETWORK_XML)
            tmp = f.name
        try:
            run(["sudo", "virsh", "-c", "qemu:///system", "net-define", tmp])
        finally:
            os.unlink(tmp)

    # Start the network
    output = virsh_output("net-info", "default")
    if "active:           yes" not in output.lower().replace(" ", ""):
        # Check active status more carefully
        active = False
        for line in output.splitlines():
            if "active" in line.lower() and "yes" in line.lower():
                active = True
                break

        if not active:
            virsh("net-start", "default")

    virsh("net-autostart", "default")

    # If iptables FORWARD policy is DROP (e.g. UFW, Tailscale, Docker),
    # libvirt's nftables rules alone aren't enough — add iptables rules
    # so the VM can reach the internet.
    try:
        r = subprocess.run(
            ["iptables", "-S", "FORWARD"],
            capture_output=True, text=True, check=True,
        )
        if "-P FORWARD DROP" in r.stdout:
            warn("iptables FORWARD policy is DROP — adding virbr0 exceptions")
            run_quiet(["iptables", "-C", "FORWARD", "-i", "virbr0", "-j", "ACCEPT"]) or \
                run(["iptables", "-I", "FORWARD", "-i", "virbr0", "-j", "ACCEPT"])
            run_quiet(["iptables", "-C", "FORWARD", "-o", "virbr0", "-m", "conntrack",
                        "--ctstate", "RELATED,ESTABLISHED", "-j", "ACCEPT"]) or \
                run(["iptables", "-I", "FORWARD", "-o", "virbr0", "-m", "conntrack",
                     "--ctstate", "RELATED,ESTABLISHED", "-j", "ACCEPT"])
    except (subprocess.CalledProcessError, FileNotFoundError):
        pass

    ok("Default network active")


# ── 7. Interactive config ─────────────────────────────────────────────────────

def configure(guest_only=False):
    print()
    title = "Configuration (Kali guest mode)" if guest_only else "Configuration"
    print(f"  {BOLD}{title}{RESET}")
    print()

    # Provider
    print("  AI Provider:")
    for k, v in PROVIDERS.items():
        default_tag = " (default)" if k == "1" else ""
        print(f"    {k}) {v['name']}{default_tag}")
    provider_choice = input(f"\n  Choice [1]: ").strip() or "1"
    if provider_choice not in PROVIDERS:
        die(f"Invalid provider choice: {provider_choice}")
    provider = PROVIDERS[provider_choice]
    print()

    # Model
    if provider["models"]:
        print(f"  Model for {provider['name']}:")
        for i, m in enumerate(provider["models"], 1):
            default_tag = " (default)" if i == 1 else ""
            print(f"    {i}) {m}{default_tag}")
        model_choice = input(f"\n  Choice [1]: ").strip() or "1"
        try:
            model = provider["models"][int(model_choice) - 1]
        except (ValueError, IndexError):
            die(f"Invalid model choice: {model_choice}")
        small_model = provider["small"]
    else:
        model = input("  Model name: ").strip()
        if not model:
            die("Model name is required.")
        small_model = input(f"  Small model name [{model}]: ").strip() or model
    print()

    # API key
    api_key = getpass.getpass(f"  {provider['env']}: ")
    if not api_key:
        die("API key is required.")
    print()

    workspace = input("  Workspace [/home/kali/pentest]: ").strip() or "/home/kali/pentest"
    print()

    # Web search
    exa_input = input("  Enable Exa web search? [Y/n]: ").strip().lower()
    enable_exa = exa_input != "n"
    print()

    base_cfg = {
        "provider": provider["id"],
        "provider_name": provider["name"],
        "env_var": provider["env"],
        "model": model,
        "small_model": small_model,
        "api_key": api_key,
        "workspace": workspace,
        "enable_exa": "true" if enable_exa else "false",
    }

    if guest_only:
        return base_cfg

    # VM resources
    vm_name = input("  VM name [nyx-kali]: ").strip() or "nyx-kali"

    ram_input = input("  VM RAM in MB [4096]: ").strip() or "4096"
    try:
        vm_ram = int(ram_input)
    except ValueError:
        die(f"Invalid RAM value: {ram_input}")

    cpus_input = input("  VM CPUs [2]: ").strip() or "2"
    try:
        vm_cpus = int(cpus_input)
    except ValueError:
        die(f"Invalid CPU value: {cpus_input}")
    print()

    usb_passthrough = select_usb_passthrough_devices()

    return {
        **base_cfg,
        "vm_name": vm_name,
        "vm_ram": vm_ram,
        "vm_cpus": vm_cpus,
        "vm_user": "kali",
        "usb_passthrough": usb_passthrough,
        "ssh_key": os.path.join(
            os.path.expanduser(f"~{os.environ.get('SUDO_USER', 'root')}"),
            ".ssh", "nyx_kali"
        ),
    }


# ── 8. Download Kali image ───────────────────────────────────────────────────

def download_image():
    os.makedirs(CACHE_DIR, exist_ok=True)
    dest = os.path.join(CACHE_DIR, KALI_7Z_FILE)

    if os.path.isfile(dest):
        # Check if download is complete
        try:
            r = subprocess.run(
                ["curl", "-sIL", KALI_IMAGE_URL],
                capture_output=True, text=True, check=True,
            )
            remote_size = 0
            for line in r.stdout.splitlines():
                if line.lower().startswith("content-length:"):
                    remote_size = int(line.split(":", 1)[1].strip())
            local_size = os.path.getsize(dest)
            if remote_size and local_size >= remote_size:
                ok("Kali image already downloaded")
                return
            info(f"Resuming download ({local_size // 1048576}MB / {remote_size // 1048576}MB)...")
        except Exception:
            info("Resuming download...")
    else:
        info("Downloading Kali Linux image (~3.5 GB)...")

    run(["curl", "-L", "-C", "-", "--progress-bar", "-o", dest, KALI_IMAGE_URL])
    ok("Download complete")


# ── 9. Verify checksum ───────────────────────────────────────────────────────

def verify_checksum():
    info("Verifying image checksum...")
    dest = os.path.join(CACHE_DIR, KALI_7Z_FILE)
    sums_file = os.path.join(CACHE_DIR, "SHA256SUMS")

    run(["curl", "-sL", "-o", sums_file, KALI_SHA256_URL])

    # Parse expected hash
    expected = None
    with open(sums_file) as f:
        for line in f:
            parts = line.strip().split()
            if len(parts) >= 2 and parts[1] == KALI_7Z_FILE:
                candidate = parts[0].lower().strip()
                if len(candidate) == 64:
                    expected = candidate
                    break

    if not expected:
        warn("Could not find checksum in SHA256SUMS, skipping verification")
        return

    # Compute actual
    sha = hashlib.sha256()
    with open(dest, "rb") as f:
        while True:
            chunk = f.read(1 << 20)
            if not chunk:
                break
            sha.update(chunk)
    actual = sha.hexdigest()

    if expected != actual:
        die(
            "SHA256 mismatch!",
            f"Expected: {expected}",
            f"Actual:   {actual}",
        )

    ok("Checksum verified")


# ── 10. Extract image ────────────────────────────────────────────────────────

def extract_image(cfg):
    vm_qcow2 = os.path.join(VM_DISK_DIR, f"{cfg['vm_name']}.qcow2")

    # Already deployed to final location?
    if run_quiet(["sudo", "test", "-f", vm_qcow2]):
        ok("VM disk already exists, skipping extraction")
        return

    # Check if QCOW2 already extracted in cache
    import glob
    existing = glob.glob(os.path.join(CACHE_DIR, "**", KALI_QCOW2_GLOB), recursive=True)
    if existing:
        ok("QCOW2 already extracted")
        return

    info("Extracting image...")
    archive = os.path.join(CACHE_DIR, KALI_7Z_FILE)
    run(["7z", "x", f"-o{CACHE_DIR}", archive, "-y"])
    ok("Extraction complete")


# ── 11. Customize image ──────────────────────────────────────────────────────

def customize_image(cfg):
    vm_qcow2 = os.path.join(VM_DISK_DIR, f"{cfg['vm_name']}.qcow2")

    # If already deployed to libvirt images, skip (VM was already created)
    if run_quiet(["sudo", "test", "-f", vm_qcow2]):
        ok("VM disk already customized")
        return

    # Find the extracted QCOW2 in cache (user-owned, so virt-customize works
    # without permission issues — libguestfs launches QEMU as current user)
    import glob
    sources = glob.glob(os.path.join(CACHE_DIR, "**", KALI_QCOW2_GLOB), recursive=True)
    if not sources:
        die("No QCOW2 found in cache. Extraction may have failed.")
    cache_qcow2 = sources[0]

    # Generate SSH key if needed
    ssh_key = cfg["ssh_key"]
    if not os.path.isfile(ssh_key):
        info("Generating SSH keypair...")
        real_user = os.environ.get("SUDO_USER", "root")
        real_home = os.path.expanduser(f"~{real_user}")
        run([
            "ssh-keygen", "-t", "ed25519",
            "-f", ssh_key, "-N", "", "-C", "nyx-kali", "-q",
        ], env={**os.environ, "HOME": real_home})
        # Fix ownership if running as sudo
        if real_user != "root":
            run(["chown", real_user, ssh_key, f"{ssh_key}.pub"])

    # Build a NetworkManager connection file for static IP
    # Do NOT set interface-name — the NIC name varies by machine type
    # (eth0 on i440fx, enp1s0 on Q35+virtio). Omitting it lets NM apply
    # this profile to whichever wired interface appears first.
    nm_conn = textwrap.dedent(f"""\
        [connection]
        id=nyx-static
        type=ethernet
        autoconnect=true
        autoconnect-priority=100

        [ipv4]
        method=manual
        addresses={VM_STATIC_IP}/24
        gateway={VM_GATEWAY}
        dns=1.1.1.1;8.8.8.8;

        [ipv6]
        method=ignore
    """)
    nm_conn_path = os.path.join(CACHE_DIR, "nyx-static.nmconnection")
    with open(nm_conn_path, "w") as f:
        f.write(nm_conn)

    # Customize the user-owned cache copy (no sudo needed)
    info("Customizing image...")
    run([
        "virt-customize", "-a", cache_qcow2,
        "--run-command", "systemctl enable ssh",
        "--run-command", "echo 'kali ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/90-nyx-kali && chmod 440 /etc/sudoers.d/90-nyx-kali",
        "--ssh-inject", f"kali:file:{ssh_key}.pub",
        "--hostname", cfg["vm_name"],
        "--mkdir", "/etc/NetworkManager/system-connections",
        "--upload", f"{nm_conn_path}:/etc/NetworkManager/system-connections/nyx-static.nmconnection",
        "--run-command", "chmod 600 /etc/NetworkManager/system-connections/nyx-static.nmconnection",
        "--run-command", "rm -f /etc/NetworkManager/system-connections/default.nmconnection",
    ])
    os.unlink(nm_conn_path)

    # Deploy customized image to libvirt images directory
    info("Deploying disk image...")
    run(["sudo", "mkdir", "-p", VM_DISK_DIR])
    run(["sudo", "cp", cache_qcow2, vm_qcow2])

    ok("Image customized and deployed")


# ── 12. Create VM ─────────────────────────────────────────────────────────────

def create_vm(cfg):
    # Check if VM already exists
    if virsh("dominfo", cfg["vm_name"]):
        ok(f"VM '{cfg['vm_name']}' already exists, skipping creation")
        return

    info("Creating VM...")
    vm_qcow2 = os.path.join(VM_DISK_DIR, f"{cfg['vm_name']}.qcow2")

    run([
        "virt-install",
        "--connect", "qemu:///system",
        "--name", cfg["vm_name"],
        "--memory", str(cfg["vm_ram"]),
        "--vcpus", str(cfg["vm_cpus"]),
        "--cpu", "host-model",
        "--disk", f"{vm_qcow2},format=qcow2,bus=virtio",
        "--import",
        "--osinfo", "debian12",
        "--network", "network=default,model=virtio",
        "--graphics", "spice",
        "--noautoconsole",
    ])

    ok("VM created")


# ── 13. Wait for VM ──────────────────────────────────────────────────────────

def wait_for_vm(cfg):
    info("Waiting for VM to boot...")
    vm_name = cfg["vm_name"]
    vm_ip = VM_STATIC_IP

    # Ensure it's running
    state = virsh_output("domstate", vm_name).strip()
    if state != "running":
        virsh("start", vm_name)

    # Poll for SSH (up to 5 minutes), with a live timer.
    timeout_seconds = 300
    poll_interval = 2
    start_time = time.monotonic()
    timer_printed = False

    ssh_probe = ssh_cmd(cfg["vm_user"], vm_ip, cfg["ssh_key"])
    for i, token in enumerate(ssh_probe):
        if token == "ConnectTimeout=10":
            ssh_probe[i] = "ConnectTimeout=2"
            break

    while True:
        if run_quiet(ssh_probe + ["true"]):
            if timer_printed:
                print()
            ok(f"VM ready at {vm_ip}")
            return vm_ip

        elapsed = int(time.monotonic() - start_time)
        if elapsed >= timeout_seconds:
            if timer_printed:
                print()
            die(f"SSH not reachable at {vm_ip} after {timeout_seconds} seconds.")

        remaining = timeout_seconds - elapsed
        elapsed_m, elapsed_s = divmod(elapsed, 60)
        remaining_m, remaining_s = divmod(remaining, 60)
        max_m, max_s = divmod(timeout_seconds, 60)
        print(
            f"\r  SSH wait timer: {elapsed_m:02d}:{elapsed_s:02d} elapsed, "
            f"{remaining_m:02d}:{remaining_s:02d} remaining (max {max_m:02d}:{max_s:02d})",
            end="",
            flush=True,
        )
        timer_printed = True
        time.sleep(min(poll_interval, remaining))


# ── 14. Provision VM ─────────────────────────────────────────────────────────

def build_guest_staging_bundle(cfg):
    """Create temp staging directory with guest provisioning payload."""
    staging = tempfile.mkdtemp(prefix="nyx-setup-")

    shutil.copytree(os.path.join(SCRIPT_DIR, "lib"), os.path.join(staging, "lib"))
    shutil.copytree(os.path.join(SCRIPT_DIR, "templates"), os.path.join(staging, "templates"))

    for d in ["prompts", "skills", "commands"]:
        src = os.path.join(SCRIPT_DIR, d)
        if os.path.isdir(src):
            shutil.copytree(src, os.path.join(staging, d))

    # Single-quote values to prevent shell interpretation.
    env_path = os.path.join(staging, "nyx-setup.env")
    with open(env_path, "w") as f:
        for key, val in [
            ("PROVIDER", cfg["provider"]),
            ("MODEL", cfg["model"]),
            ("SMALL_MODEL", cfg["small_model"]),
            ("API_KEY_ENV", cfg["env_var"]),
            ("API_KEY", cfg["api_key"]),
            ("WORKSPACE", cfg["workspace"]),
            ("ENABLE_EXA", cfg["enable_exa"]),
        ]:
            safe_val = val.replace("'", "'\\''")
            f.write(f"{key}='{safe_val}'\n")
    os.chmod(env_path, 0o600)

    return staging


def provision_vm(cfg, vm_ip):
    info("Provisioning VM...")

    ssh_base = ssh_cmd(cfg["vm_user"], vm_ip, cfg["ssh_key"])
    scp_base = [
        "scp",
        "-o", "StrictHostKeyChecking=no",
        "-o", "UserKnownHostsFile=/dev/null",
        "-o", "LogLevel=ERROR",
        "-o", "BatchMode=yes",
        "-i", cfg["ssh_key"],
        "-r",
    ]
    target = f"{cfg['vm_user']}@{vm_ip}"

    staging = build_guest_staging_bundle(cfg)
    try:
        # Upload to VM
        run(ssh_base + ["rm -rf /tmp/nyx-setup && mkdir -p /tmp/nyx-setup"])
        run(scp_base + [f"{staging}/.", f"{target}:/tmp/nyx-setup/"])
        run(ssh_base + ["chmod 700 /tmp/nyx-setup && chmod 600 /tmp/nyx-setup/nyx-setup.env"])

        # Run guest.sh
        run(ssh_base + ["bash /tmp/nyx-setup/lib/guest.sh --config-file /tmp/nyx-setup/nyx-setup.env"])
    finally:
        shutil.rmtree(staging, ignore_errors=True)

    ok("VM provisioned")


# ── 15. Provision existing Kali VM ───────────────────────────────────────────

def provision_existing_kali_vm(cfg):
    """Run guest provisioning locally when setup.py executes inside a Kali VM."""
    info("Provisioning existing Kali VM (OpenCode + Nyx customizations)...")

    staging = build_guest_staging_bundle(cfg)
    guest_script = os.path.join(staging, "lib", "guest.sh")
    env_path = os.path.join(staging, "nyx-setup.env")

    try:
        cmd = ["bash", guest_script, "--config-file", env_path, "--setup-dir", staging]
        real_user = os.environ.get("SUDO_USER", "")
        if os.geteuid() == 0 and real_user and real_user != "root":
            run(["sudo", "-u", real_user, "-H"] + cmd)
        else:
            if os.geteuid() == 0:
                warn("Running guest setup as root; OpenCode files will be written under /root.")
            run(cmd)
    finally:
        shutil.rmtree(staging, ignore_errors=True)

    ok("Existing Kali VM provisioned")


# ── 16. Install launcher ─────────────────────────────────────────────────────

def install_launcher(cfg):
    info("Installing nyx launcher...")

    real_user = os.environ.get("SUDO_USER", "root")
    real_home = os.path.expanduser(f"~{real_user}")
    bin_dir = os.path.join(real_home, ".local", "bin")
    os.makedirs(bin_dir, exist_ok=True)

    launcher_path = os.path.join(bin_dir, "nyx")
    launcher = textwrap.dedent(f"""\
        #!/usr/bin/env bash
        # nyx — Start Nyx VM and launch OpenCode
        set -euo pipefail

        VM_NAME="{cfg['vm_name']}"
        VM_USER="{cfg['vm_user']}"
        VM_IP="{VM_STATIC_IP}"
        WORKSPACE="{cfg['workspace']}"
        SSH_KEY="{cfg['ssh_key']}"

        CYAN='\\033[0;36m'
        GREEN='\\033[0;32m'
        RED='\\033[0;31m'
        BOLD='\\033[1m'
        RESET='\\033[0m'

        virsh_q()  {{ virsh -c qemu:///system "$@" >/dev/null 2>&1 || sudo virsh -c qemu:///system "$@" >/dev/null 2>&1; }}
        virsh_o()  {{ virsh -c qemu:///system "$@" 2>/dev/null || sudo virsh -c qemu:///system "$@" 2>/dev/null; }}

        # Check VM exists
        virsh_q dominfo "$VM_NAME" || {{ printf "${{RED}}Nyx VM not found. Run setup.py first.${{RESET}}\\n"; exit 1; }}

        # Start if not running
        state=$(virsh_o domstate "$VM_NAME" | tr -d '\\r')
        if [[ "$state" != "running" ]]; then
            printf "${{CYAN}}Starting VM...${{RESET}}\\n"
            virsh_q start "$VM_NAME"
        fi

        # Wait for SSH (up to 60s)
        printf "${{CYAN}}Connecting...${{RESET}}\\n"
        for i in $(seq 1 30); do
            ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \\
                -o LogLevel=ERROR -o BatchMode=yes -i "$SSH_KEY" "$VM_USER@$VM_IP" true 2>/dev/null && break
            sleep 2
        done

        # Launch OpenCode
        printf "${{GREEN}}${{BOLD}}Launching Nyx...${{RESET}}\\n"
        exec ssh -t -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR \\
            -i "$SSH_KEY" "$VM_USER@$VM_IP" \\
            "export PATH=\\$HOME/.local/bin:\\$HOME/.opencode/bin:\\$PATH && cd \\"$WORKSPACE\\" && source .env && exec opencode"
    """)

    with open(launcher_path, "w") as f:
        f.write(launcher)
    os.chmod(launcher_path, 0o755)

    # Fix ownership
    if real_user != "root":
        run_quiet(["chown", "-R", real_user, bin_dir])

    ok(f"Launcher installed: {launcher_path}")


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    print_banner()

    if is_running_inside_kali_vm():
        info("Detected existing Kali VM. Running guest-only setup path.")
        cfg = configure(guest_only=True)
        provision_existing_kali_vm(cfg)
        print()
        print(f"  {GREEN}{BOLD}Setup complete!{RESET}")
        print()
        print(f"  Run {CYAN}cd {cfg['workspace']} && source .env && opencode{RESET}")
        print()
        return

    check_prerequisites()
    distro = detect_distro()
    install_packages(distro)
    start_libvirt()
    ensure_default_network()

    cfg = configure()

    download_image()
    verify_checksum()
    extract_image(cfg)
    customize_image(cfg)
    create_vm(cfg)
    apply_usb_passthrough(cfg)
    vm_ip = wait_for_vm(cfg)
    provision_vm(cfg, vm_ip)
    install_launcher(cfg)

    print()
    print(f"  {GREEN}{BOLD}Setup complete!{RESET}")
    print()
    print(f"  Run {CYAN}nyx{RESET} to start.")
    print(f"  (You may need to log out and back in for the libvirt group to take effect.)")
    print()


if __name__ == "__main__":
    main()
