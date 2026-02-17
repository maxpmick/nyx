---
name: evil-ssdp
description: Spoof SSDP replies to phish for NTLM hashes or credentials on a local network. It responds to SSDP multicast discovery requests to make a fake UPnP device appear in Windows Explorer, tempting users to visit a malicious web page or connect to an SMB share. Use during internal penetration testing for lateral movement, credential harvesting, or NTLM relay attacks.
---

# evil-ssdp

## Overview
evil-ssdp is a tool designed to spoof SSDP (Simple Service Discovery Protocol) replies. It poses as a generic UPnP device on a local network, causing a fake device to appear in the "Network" section of Windows Explorer on target machines. When a user interacts with the device, they are directed to a configurable phishing page or prompted for authentication. Category: Sniffing & Spoofing / Exploitation.

## Installation (if not already installed)
Assume evil-ssdp is already installed. If the command is missing:

```bash
sudo apt install evil-ssdp
```

## Common Workflows

### Basic NTLM Hash Harvesting
Start the tool on a specific interface using the default Office365 template. This will point targets back to your machine's IP for SMB authentication.
```bash
sudo evil-ssdp eth0
```

### Phishing with Basic Authentication
Force a Basic Auth login prompt with a custom realm to capture cleartext credentials (base64 encoded in logs).
```bash
sudo evil-ssdp eth0 -b -r "Corporate Infrastructure Login"
```

### Custom Template and Redirect
Use a specific template and redirect the user to a legitimate site after they interact with the fake device.
```bash
sudo evil-ssdp eth0 -t scanner -u https://google.com
```

### Analyze Mode
Monitor SSDP traffic on the network and test the web server without actually sending spoofed replies.
```bash
sudo evil-ssdp eth0 -a
```

## Complete Command Reference

```bash
evil_ssdp.py [-h] [-p PORT] [-t TEMPLATE] [-s SMB] [-b] [-r REALM] [-u URL] [-a] interface
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `interface` | Network interface to listen on (e.g., eth0, wlan0). |

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-p`, `--port PORT` | Port for the internal HTTP server. Defaults to `8888`. |
| `-t`, `--template TEMPLATE` | Name of a folder in the templates directory. Defaults to `office365`. This determines the XML and phishing pages used. |
| `-s`, `--smb SMB` | IP address of your SMB server (e.g., Responder or Metasploit). Defaults to the primary address of the provided `interface`. |
| `-b`, `--basic` | Enable base64 Basic Authentication for templates and write captured credentials to the log file. |
| `-r`, `--realm REALM` | The realm string displayed when prompting the target for authentication via Basic Auth. |
| `-u`, `--url URL` | Redirect to this URL. Works with templates that perform a POST for logon forms or include custom redirect JavaScript. |
| `-a`, `--analyze` | Run in analyze mode. The tool will NOT respond to SSDP queries but will run the web server for testing purposes. |

## Notes
- This tool is highly effective in environments where users frequently browse the "Network" neighborhood in Windows.
- It is often used in conjunction with **Responder** to capture NTLM hashes when the victim attempts to access the spoofed SMB share.
- Templates are stored in the tool's installation directory; you can create custom templates to mimic local printers, scanners, or storage devices.
- Ensure your firewall allows inbound traffic on the specified HTTP port (default 8888) and UDP port 1900.