#!/usr/bin/env python3
"""Nyx setup — single-script installer for the Nyx pentesting VM."""

import getpass
import hashlib
import os
import shutil
import subprocess
import sys
import tempfile
import textwrap
import time

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
    "arch": ["qemu-full", "libvirt", "dnsmasq", "virt-install", "guestfs-tools", "p7zip", "curl", "git", "gnupg"],
    "debian": ["qemu-kvm", "libvirt-daemon-system", "dnsmasq-base", "virtinst", "libguestfs-tools", "p7zip-full", "curl", "git", "gpg"],
    "fedora": ["qemu-kvm", "libvirt", "dnsmasq", "virt-install", "guestfs-tools", "p7zip", "curl", "git", "gnupg2"],
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

def detect_distro():
    info("Detecting distribution...")
    try:
        with open("/etc/os-release") as f:
            os_release = f.read().lower()
    except FileNotFoundError:
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

def configure():
    print()
    print(f"  {BOLD}Configuration{RESET}")
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

    # Web search
    exa_input = input("  Enable Exa web search? [Y/n]: ").strip().lower()
    enable_exa = exa_input != "n"
    print()

    return {
        "provider": provider["id"],
        "provider_name": provider["name"],
        "env_var": provider["env"],
        "model": model,
        "small_model": small_model,
        "api_key": api_key,
        "vm_name": vm_name,
        "vm_ram": vm_ram,
        "vm_cpus": vm_cpus,
        "vm_user": "kali",
        "workspace": "/home/kali/pentest",
        "enable_exa": "true" if enable_exa else "false",
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

    # Poll for SSH (up to 90s)
    ssh_base = ssh_cmd(cfg["vm_user"], vm_ip, cfg["ssh_key"])
    for i in range(45):
        if run_quiet(ssh_base + ["true"]):
            ok(f"VM ready at {vm_ip}")
            return vm_ip
        time.sleep(2)

    die(f"SSH not reachable at {vm_ip} after 90s.")


# ── 14. Provision VM ─────────────────────────────────────────────────────────

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

    # Build staging directory
    staging = tempfile.mkdtemp()
    try:
        # Copy lib/ (guest.sh lives here)
        shutil.copytree(os.path.join(SCRIPT_DIR, "lib"), os.path.join(staging, "lib"))
        # Copy templates/
        shutil.copytree(os.path.join(SCRIPT_DIR, "templates"), os.path.join(staging, "templates"))
        # Copy optional dirs
        for d in ["prompts", "skills", "commands"]:
            src = os.path.join(SCRIPT_DIR, d)
            if os.path.isdir(src):
                shutil.copytree(src, os.path.join(staging, d))

        # Write config env file (single-quote values to prevent shell interpretation)
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

        # Upload to VM
        run(ssh_base + ["mkdir -p /tmp/nyx-setup"])
        run(scp_base + [f"{staging}/.", f"{target}:/tmp/nyx-setup/"])
        run(ssh_base + ["chmod 700 /tmp/nyx-setup && chmod 600 /tmp/nyx-setup/nyx-setup.env"])

        # Run guest.sh
        run(ssh_base + ["bash /tmp/nyx-setup/lib/guest.sh --config-file /tmp/nyx-setup/nyx-setup.env"])
    finally:
        shutil.rmtree(staging, ignore_errors=True)

    ok("VM provisioned")


# ── 15. Install launcher ─────────────────────────────────────────────────────

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
