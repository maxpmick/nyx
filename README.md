<p align="center">
  <strong>Nyx <br><br>
  <strong>Agentic pentester and OSINT machine.</strong><br>
  One command to build a Kali Linux VM with an AI-powered terminal agent.
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>&nbsp;
  <a href="#quickstart"><img src="https://img.shields.io/badge/Arch-1793D1?logo=archlinux&logoColor=white" alt="Arch"></a>&nbsp;
  <a href="#quickstart"><img src="https://img.shields.io/badge/Ubuntu-E95420?logo=ubuntu&logoColor=white" alt="Ubuntu"></a>&nbsp;
  <a href="#quickstart"><img src="https://img.shields.io/badge/Fedora-51A2DA?logo=fedora&logoColor=white" alt="Fedora"></a>
</p>

---

## What It Does

- Provisions a Kali Linux VM (QEMU/KVM) with a static IP and SSH key auth
- Runs a full `kali-linux-default` install inside the guest
- Installs [OpenCode](https://opencode.ai) as the AI agent interface
- Installs [nyx-memory](https://github.com/maxpmick/nyx-memory) for structured pentest documentation
- Deploys 790+ tool reference docs and workflow playbooks into the VM
- Installs a `nyx` launcher on the host that starts the VM and connects
- If run inside an existing Kali VM, it skips host/libvirt provisioning and applies OpenCode + Nyx customizations only

## Prerequisites

- Linux host with KVM support (Intel VT-x / AMD-V enabled in BIOS)
- 25+ GB free disk space
- `sudo` access on the host
- Python 3
- API key for a supported AI provider

## Quickstart

```bash
git clone https://github.com/maxpmick/nyx.git
cd nyx
sudo python3 setup.py
```

The installer is interactive and handles everything:

1. Host package installation (qemu, libvirt, etc.)
2. libvirt network setup + iptables rules for hosts running UFW/Tailscale/Docker
3. Kali QEMU image download (~3.5 GB) with checksum verification
4. Interactive config (provider/model/API key, VM sizing, optional persistent USB passthrough)
5. Image customization — SSH key injection, static IP (`192.168.122.50`), DNS
6. VM creation and guest provisioning:
   - Full system update + `kali-linux-default` toolset
   - OpenCode + nyx-memory installed
   - API key stored in OpenCode's auth store
   - Tool reference docs and playbooks deployed
7. Host launcher installation at `~/.local/bin/nyx`

When running `setup.py` inside an already-running Kali VM, setup auto-detects guest mode and only runs the OpenCode/Nyx customization flow.

Once complete:

```bash
nyx
```

If `nyx` isn't found, add `~/.local/bin` to your `PATH`.

## Supported Providers

| Provider      | Env Variable         | Default Model                |
| :------------ | :------------------- | :--------------------------- |
| Anthropic     | `ANTHROPIC_API_KEY`  | `claude-sonnet-4-5-20250929` |
| OpenAI        | `OPENAI_API_KEY`     | `gpt-4o`                     |
| Google Gemini | `GEMINI_API_KEY`     | `gemini-2.5-flash`           |
| Groq          | `GROQ_API_KEY`       | `llama-3.3-70b`              |
| OpenRouter    | `OPENROUTER_API_KEY` | user-chosen                  |

## Architecture

Single-agent design. Compact system prompt + on-demand reference docs keep context lean. Tool docs and playbooks are read only when needed — not pre-loaded.

| Component        | Location (inside VM)             | Role                                                       |
| :--------------- | :------------------------------- | :--------------------------------------------------------- |
| System prompt    | `~/pentest/SYSTEM_PROMPT.md`     | Agent identity, rules, methodology (~2KB)                  |
| Tool reference   | `~/pentest/tool-docs/<tool>.md`  | Per-tool docs, read on demand: `cat ./tool-docs/nmap.md`   |
| Playbooks        | `~/pentest/playbooks/<phase>.md` | Phase workflows, read on demand: `cat ./playbooks/recon.md`|
| Auth             | `~/.local/share/opencode/auth.json` | API key stored by OpenCode's auth system                |
| nyx-memory (MCP) | npm global                       | Structured notes: findings, hosts, credentials, evidence   |
| nyx-log          | npm global                       | CLI wrapper that captures raw tool output as evidence      |
| opencode.json    | `~/pentest/opencode.json`        | OpenCode config (model, permissions, MCP)                  |

## Repository Structure

```text
nyx/
├── setup.py                    # Host installer — runs once
├── lib/
│   └── guest.sh                # Guest-side provisioning (runs inside Kali)
├── templates/
│   └── opencode.json.template  # OpenCode config template
├── prompts/
│   └── SYSTEM_PROMPT.md        # Agent system prompt
├── commands/                   # Playbooks deployed to ~/pentest/playbooks/
├── skills/                     # Tool docs deployed to ~/pentest/tool-docs/
└── assets/
    └── banner.txt
```

## Manual Host Prep (Optional)

Pre-install dependencies before running setup:

**Arch Linux**
```bash
sudo pacman -S --needed qemu-full libvirt dnsmasq virt-install guestfs-tools p7zip curl git gnupg usbutils
```

**Debian / Ubuntu**
```bash
sudo apt-get update && sudo apt-get install -y qemu-kvm libvirt-daemon-system \
  libvirt-daemon-config-network dnsmasq-base virtinst libguestfs-tools p7zip-full curl git gpg usbutils
```

**Fedora**
```bash
sudo dnf install -y qemu-kvm libvirt dnsmasq virt-install guestfs-tools p7zip curl git gnupg2 usbutils
```

## Troubleshooting

### UFW / Tailscale / Docker blocking VM internet

If the VM has no internet access, the host firewall is dropping forwarded packets. Setup detects and fixes this automatically, but if you re-enable UFW afterwards:

```bash
sudo iptables -I FORWARD -i virbr0 -j ACCEPT
sudo iptables -I FORWARD -o virbr0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
```

### VM stuck at "Waiting for VM to boot"

The NM connection file uses no `interface-name`, so it applies to whatever ethernet interface the VM has. If SSH isn't reachable after 90s, check the VM's network state via console or `virsh domifaddr`. The static IP is always `192.168.122.50`.

### Raw socket permissions (`arp-scan`, `tcpdump`, etc.)

OpenCode runs as `kali` (non-root). Tools requiring raw sockets need:

```bash
sudo arp-scan --localnet
# or grant capability permanently:
sudo setcap cap_net_raw,cap_net_admin=eip "$(command -v arp-scan)"
```

### Nuke and rebuild

```bash
virsh -c qemu:///system destroy nyx-kali
virsh -c qemu:///system undefine nyx-kali --remove-all-storage
sudo python3 setup.py
```

The image download is cached in `.cache/` and reused. Only the VM disk and configuration are wiped.

## Disclaimer

> This tool is intended for authorized security testing, CTF competitions, security research, and educational use only. Always obtain proper authorization before testing systems you do not own.

## License

[MIT](LICENSE)
