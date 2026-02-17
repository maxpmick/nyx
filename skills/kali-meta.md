---
name: kali-meta
description: Manage and install Kali Linux metapackages to quickly set up specific security environments, toolsets, or desktop interfaces. Use when preparing a new Kali installation, adding entire categories of tools (e.g., wireless, forensics, web apps), or ensuring all default tools for a specific security domain are present.
---

# kali-meta

## Overview
Metapackages in Kali Linux are used to install groups of related packages. Instead of installing tools individually, these packages allow users to install entire security domains (e.g., `kali-tools-wireless`) or environment configurations (e.g., `kali-linux-headless`) with a single command. Category: System Administration / Package Management.

## Installation (if not already installed)
Metapackages are managed via the standard `apt` package manager.

```bash
sudo apt update
sudo apt install <metapackage-name>
```

## Common Workflows

### Install the Top 10 most popular tools
```bash
sudo apt install kali-tools-top10
```

### Prepare a system for Wireless Auditing
```bash
sudo apt install kali-tools-wireless
```

### Install every single tool available in Kali
```bash
sudo apt install kali-linux-everything
```

### Set up a lightweight headless environment
```bash
sudo apt install kali-linux-headless
```

## Complete Command Reference

### System & Environment Metapackages

| Package Name | Description |
|--------------|-------------|
| `kali-linux-core` | Core security packages installed by default on any offensive system. |
| `kali-linux-default` | Applications included in the default official Kali Linux images. |
| `kali-linux-large` | Extended default tool selection (default + many more). |
| `kali-linux-everything` | Every tool available in the Kali repository. |
| `kali-linux-headless` | Default tools that do not require X11/GUI. |
| `kali-linux-arm` | Metapackage for ARM-based architectures. |
| `kali-linux-wsl` | Tools optimized for Kali on Windows Subsystem for Linux. |
| `kali-linux-labs` | Vulnerable environments (DVWA, Juice Shop) for practice. |
| `kali-linux-firmware` | Curated list of firmware for hardware support. |
| `kali-system-cli` | Essential system CLI tools (curl, wget, vim). |
| `kali-system-core` | Base system packages (sudo, zsh, tmux, openssh). |
| `kali-system-gui` | System GUI tools (gparted, rdesktop, cherrytree). |

### Desktop Environment Metapackages

| Package Name | Description |
|--------------|-------------|
| `kali-desktop-core` | Dependencies common to all Kali desktops. |
| `kali-desktop-xfce` | Minimalistic Xfce desktop (Kali default). |
| `kali-desktop-gnome` | Minimalistic GNOME desktop. |
| `kali-desktop-kde` | Minimalistic KDE Plasma desktop. |
| `kali-desktop-i3` | Minimalistic i3 tiling window manager. |
| `kali-desktop-mate` | Minimalistic MATE desktop. |
| `kali-desktop-lxde` | Minimalistic LXDE desktop. |
| `kali-desktop-e17` | Minimalistic Enlightenment E17 desktop. |
| `kali-desktop-live` | Environment for official Kali live images. |

### Security Domain Metapackages (Tools)

| Package Name | Security Domain / Category |
|--------------|----------------------------|
| `kali-tools-information-gathering` | Reconnaissance / OSINT / DNS / Scanning. |
| `kali-tools-vulnerability` | Vulnerability Analysis / Stress Testing. |
| `kali-tools-exploitation` | Exploitation / Metasploit / BeEF. |
| `kali-tools-post-exploitation` | Post-Exploitation / Tunneling / OS Backdoors. |
| `kali-tools-forensics` | Digital Forensics / Carving / Analysis. |
| `kali-tools-reverse-engineering` | Reverse Engineering / Debugging. |
| `kali-tools-wireless` | Wireless Attacks (802.11, Bluetooth, RFID, SDR). |
| `kali-tools-802-11` | WiFi specific attack tools. |
| `kali-tools-bluetooth` | Bluetooth specific attack tools. |
| `kali-tools-rfid` | RFID/NFC attack tools. |
| `kali-tools-sdr` | Software Defined Radio tools. |
| `kali-tools-web` | Web Application Testing / Burp / SQLmap. |
| `kali-tools-database` | Database Assessment / SQL Injection. |
| `kali-tools-passwords` | Password Attacks / Cracking / Wordlists. |
| `kali-tools-sniffing-spoofing` | Network Sniffing & Spoofing / MitM. |
| `kali-tools-social-engineering` | Social Engineering / Phishing. |
| `kali-tools-crypto-stego` | Cryptography & Steganography. |
| `kali-tools-fuzzing` | Fuzzing / Protocol Analysis. |
| `kali-tools-hardware` | Hardware Hacking / Firmware / JTAG. |
| `kali-tools-gpu` | GPU-accelerated cracking tools. |
| `kali-tools-voip` | Voice over IP security tools. |
| `kali-tools-top10` | The 10 most essential Kali tools. |
| `kali-tools-windows-resources` | Windows-specific binaries and scripts. |
| `kali-tools-reporting` | Reporting / Evidence Gathering / Documentation. |

### NIST CSF Domain Metapackages

| Package Name | NIST CSF Domain |
|--------------|-----------------|
| `kali-tools-identify` | IDENTIFY: Asset management and risk assessment. |
| `kali-tools-protect` | PROTECT: ClamAV, encryption, firewalls. |
| `kali-tools-detect` | DETECT: Detection and monitoring tools. |
| `kali-tools-respond` | RESPOND: Incident response and forensics. |
| `kali-tools-recover` | RECOVER: Data recovery and restoration. |

### NetHunter Metapackages

| Package Name | Description |
|--------------|-------------|
| `kali-nethunter-core` | Core packages for any NetHunter system. |
| `kali-nethunter-full` | Full toolset for mobile devices (Android). |
| `kali-nethunter-nano` | Minimal toolset for tiny devices (Smart watches). |

## Notes
- **Storage**: Installing `kali-linux-everything` requires significant disk space (often 20GB+).
- **Conflicts**: Installing multiple desktop environments is possible but may lead to bloated menus and conflicting display managers.
- **Dependencies**: Metapackages use "Depends" or "Recommends". Removing a tool that is a dependency of a metapackage may trigger the removal of the metapackage itself (though the other tools will remain as "orphans").