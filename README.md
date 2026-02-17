<p align="center">
  <pre align="center">
  ███╗   ██╗██╗   ██╗██╗  ██╗
  ████╗  ██║╚██╗ ██╔╝╚██╗██╔╝
  ██╔██╗ ██║ ╚████╔╝  ╚███╔╝
  ██║╚██╗██║  ╚██╔╝   ██╔██╗
  ██║ ╚████║   ██║   ██╔╝ ██╗
  ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝</pre>
</p>

<p align="center">
  <strong>Agentic pentester &amp; OSINT machine.</strong><br>
  One command to set up a Kali Linux VM with an AI-powered terminal agent.
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>&nbsp;
  <a href="#quickstart"><img src="https://img.shields.io/badge/Arch-1793D1?logo=archlinux&logoColor=white" alt="Arch"></a>&nbsp;
  <a href="#quickstart"><img src="https://img.shields.io/badge/Ubuntu-E95420?logo=ubuntu&logoColor=white" alt="Ubuntu"></a>&nbsp;
  <a href="#quickstart"><img src="https://img.shields.io/badge/Fedora-51A2DA?logo=fedora&logoColor=white" alt="Fedora"></a>
</p>

---

## What It Does

- Provisions a **Kali Linux VM** (QEMU/KVM) with SSH access
- Installs [OpenCode](https://opencode.ai) as the AI agent interface
- Installs [nyx-memory](https://github.com/maxpmick/nyx-memory) for structured pentest documentation
- Deploys **790+ tool skills**, system prompts, and configuration
- Provides a single `nyx` command to launch everything

## Prerequisites

- Linux with KVM support (Intel VT-x / AMD-V enabled)
- ~25 GB free disk space
- An API key from a supported AI provider

## Quickstart

```bash
curl -fsSL https://raw.githubusercontent.com/maxpmick/nyx/main/install.sh | bash
```

That's it. The interactive installer handles everything:

| Step | What happens                                                  |
| :--: | :------------------------------------------------------------ |
|  1   | Detects your distro (Arch, Ubuntu/Debian, Fedora)             |
|  2   | Installs all required packages (QEMU, libvirt, guestfs-tools) |
|  3   | Configures libvirtd, networking, and user groups               |
|  4   | Clones the repository                                         |
|  5   | Launches the setup wizard                                     |

The setup wizard then walks you through:

> VM resources &rarr; AI provider &rarr; API key &rarr; Model selection &rarr; Web search toggle

Then it downloads Kali, creates the VM, and provisions everything automatically. When done:

```bash
nyx
```

This starts the VM, connects via SSH, and drops you into OpenCode with the Nyx agent.

<details>
<summary><strong>Manual installation</strong></summary>
<br>

If you prefer to install dependencies yourself (`setup.sh` expects `gum` for the full TUI):

**Arch Linux:**
```bash
sudo pacman -S qemu-full libvirt dnsmasq virt-install guestfs-tools p7zip curl git gnupg gum
```

**Debian / Ubuntu:**
```bash
sudo apt install qemu-kvm libvirt-daemon-system libvirt-daemon-config-network dnsmasq-base virtinst libguestfs-tools p7zip-full curl git gpg
# Install gum from Charm's repo: https://github.com/charmbracelet/gum#installation
```

**Fedora:**
```bash
sudo dnf install qemu-kvm libvirt dnsmasq virt-install guestfs-tools p7zip curl git gnupg2
# Install gum from Charm's repo: https://github.com/charmbracelet/gum#installation
```

Then enable libvirt and add yourself to the group:
```bash
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER
# Log out and back in
virsh net-start default && virsh net-autostart default
```

Then clone and run:
```bash
git clone https://github.com/maxpmick/nyx.git ~/.nyx
cd ~/.nyx
bash setup.sh
```

</details>

## Supported Providers

| Provider      | Env Variable          | Default Model                |
| :------------ | :-------------------- | :--------------------------- |
| Anthropic     | `ANTHROPIC_API_KEY`   | `claude-sonnet-4-5-20250929` |
| OpenAI        | `OPENAI_API_KEY`      | `gpt-4o`                     |
| Google Gemini | `GEMINI_API_KEY`      | `gemini-2.5-flash`           |
| Groq          | `GROQ_API_KEY`        | `llama-3.3-70b`              |
| OpenRouter    | `OPENROUTER_API_KEY`  | user-chosen                  |

## Architecture

Nyx uses a **single-agent architecture**. One primary agent with a comprehensive system prompt self-selects behavioral modes (recon, exploit, OSINT, reporting, etc.) based on the task at hand.

| Component       | Role                                                                                         |
| :-------------- | :------------------------------------------------------------------------------------------- |
| `prompts/*.md`  | System prompts defining identity and methodology                                             |
| `skills/`       | 790+ tool-specific knowledge files loaded on demand                                          |
| **nyx-memory**  | MCP server for structured note-taking (`finding_add`, `host_discover`, `credential_add`, ..) |
| **nyx-log**     | CLI wrapper that captures raw tool output as evidence                                        |

## Repository Structure

```
nyx/
├── install.sh                  # Auto-installer (curl | bash)
├── setup.sh                    # Setup wizard
├── nyx.sh                      # Launcher (reference)
├── lib/
│   ├── common.sh               # Shared utilities
│   ├── tui.sh                  # TUI abstraction (gum/whiptail/basic)
│   ├── host.sh                 # Host-side VM provisioning
│   ├── guest.sh                # Guest-side installation
│   ├── configure.sh            # Config gathering
│   └── verify.sh               # Post-setup verification
├── templates/
│   └── opencode.json.template  # OpenCode config template
├── assets/
│   └── banner.txt              # ASCII art
├── prompts/                    # System prompt markdown files
├── skills/                     # Kali tool skills (790+)
└── commands/                   # Slash commands
```

## Disclaimer

> **This tool is intended for authorized security testing, CTF competitions, security research, and educational purposes only.** Always obtain proper authorization before testing systems you do not own. The authors are not responsible for misuse.

## License

[MIT](LICENSE)
