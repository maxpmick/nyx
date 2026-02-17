---
name: kali-tweaks
description: Adjust advanced configuration settings for Kali Linux including shell customization, APT mirror selection, metapackage management, system hardening, and virtualization optimizations. Use when needing to optimize system performance, change the default shell/prompt, switch to a faster repository mirror, or install specific toolsets via metapackages.
---

# kali-tweaks

## Overview
A TUI (Text User Interface) based configuration tool designed to simplify common administrative tasks in Kali Linux. It centralizes settings for system hardening, repository management, and environment customization. Category: System Administration / Configuration.

## Installation (if not already installed)
Assume kali-tweaks is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install kali-tweaks
```

## Common Workflows

### Launching the Interface
Simply run the command to open the interactive menu:
```bash
kali-tweaks
```

### Changing APT Mirrors
If `apt update` is slow, launch `kali-tweaks`, navigate to **Network Repositories**, and select a closer or faster mirror to update `/etc/apt/sources.list`.

### Customizing the Shell
To switch between Bash and ZSH or enable/disable the two-line prompt, use the **Shell & Prompt** section.

### Optimizing Virtual Machines
When running Kali in VirtualBox or VMware, use the **Virtualization** menu to install guest tools or optimize shared folders and clipboard integration.

## Complete Command Reference

The tool is primarily interactive. While it does not feature a complex CLI flag system for individual tweaks, the following options are available:

### Execution Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display the help message and exit. |

### Interactive Menu Sections

| Section | Description |
|---------|-------------|
| **Hardening** | Configure the system for extra security (e.g., disabling services, kernel hardening). |
| **Metapackages** | Install or remove specific subsets of tools (e.g., `kali-linux-default`, `kali-tools-top10`, `kali-linux-everything`). |
| **Network Repositories** | Configure APT sources, switch between official mirrors, or enable/disable experimental branches. |
| **Shell & Prompt** | Configure the default shell (Bash/ZSH) and the appearance of the command prompt. |
| **Virtualization** | Apply specific configurations and drivers for virtualized environments (VirtualBox, VMware, QEMU/KVM). |

### Navigation Controls

| Key | Action |
|-----|--------|
| `<Tab>` / `<Alt-Tab>` | Move focus between buttons and menu elements. |
| `<Space>` | Select or toggle a highlighted option. |
| `<Enter>` | Confirm selection or enter a submenu. |
| `<F12>` | Proceed to the next screen or apply changes. |
| `<Esc>` | Go back or exit. |

## Notes
- **Root Privileges**: This tool requires root privileges to modify system configurations. If run as a standard user, it will prompt for `sudo`.
- **Metapackages**: Installing "Everything" via the Metapackages menu requires significant disk space and a stable internet connection.
- **Non-Interactive Use**: `kali-tweaks` is designed for interactive use; for automation, use standard Debian tools like `apt` or `dpkg-reconfigure`.