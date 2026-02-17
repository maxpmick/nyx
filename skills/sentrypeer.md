---
name: sentrypeer
description: Detect and collect bad IP addresses and phone numbers using a distributed SIP honeypot. Use when setting up fraud detection for VoIP infrastructure, gathering intelligence on SIP-based attacks, or sharing threat data via Peer-to-Peer (P2P) networks.
---

# sentrypeer

## Overview
SentryPeer is a fraud detection tool and distributed SIP honeypot. It identifies bad actors attempting to make unauthorized phone calls, logging their IP addresses and the numbers they dial. Unlike centralized services, SentryPeer emphasizes data ownership and Peer-to-Peer (P2P) sharing of threat intelligence. Category: Reconnaissance / Information Gathering / Detection.

## Installation (if not already installed)
Assume sentrypeer is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install sentrypeer
```

## Common Workflows

### Basic Honeypot Mode
Run a simple SIP honeypot with verbose logging to capture incoming SIP probes:
```bash
sentrypeer -v
```

### P2P Threat Sharing
Join the distributed network to share and receive bad actor data using a bootstrap node:
```bash
sentrypeer -p -b bootstrap.sentrypeer.org
```

### API and WebHook Integration
Run in API mode and forward captured "bad actor" data to a custom WebHook for automated blocking:
```bash
sentrypeer -a -w https://your-api.internal/alerts -i <CLIENT_ID> -c <CLIENT_SECRET>
```

### Stealth/Silent Mode
Disable SIP responses (don't talk back to the scanner) and log everything to a specific JSON file:
```bash
sentrypeer -l /var/log/sentrypeer_hits.json -j
```

## Complete Command Reference

```
sentrypeer [OPTIONS]
```

### Options

| Flag | Environment Variable | Description |
|------|----------------------|-------------|
| `-f <DB_FILE>` | `SENTRYPEER_DB_FILE` | Set 'sentrypeer.db' location |
| `-j` | `SENTRYPEER_JSON_LOG` | Enable JSON logging |
| `-p` | `SENTRYPEER_PEER_TO_PEER` | Enable Peer to Peer mode |
| `-b <BOOTSTRAP_NODE>` | `SENTRYPEER_BOOTSTRAP_NODE` | Set Peer to Peer bootstrap node |
| `-i <CLIENT_ID>` | `SENTRYPEER_OAUTH2_CLIENT_ID` | Set OAuth 2 client ID for WebHook Bearer token |
| `-c <CLIENT_SECRET>` | `SENTRYPEER_OAUTH2_CLIENT_SECRET` | Set OAuth 2 client secret for WebHook Bearer token |
| `-a` | `SENTRYPEER_API` | Enable RESTful API mode |
| `-w <WEBHOOK_URL>` | `SENTRYPEER_WEBHOOK_URL` | Set WebHook URL for bad actor JSON POSTs |
| `-r` | `SENTRYPEER_SIP_RESPONSIVE` | Enable SIP responsive mode (respond to SIP requests) |
| `-R` | `SENTRYPEER_SIP_DISABLE` | Disable SIP mode completely |
| `-l <JSON_LOG_FILE>` | `SENTRYPEER_JSON_LOG_FILE` | Set JSON logfile location (default: `./sentrypeer_json.log`) |
| `-N` | `SENTRYPEER_TLS_DISABLE` | Disable Rust powered TCP, UDP, and TLS |
| `-t <TLS_CERT_FILE>` | `SENTRYPEER_CERT` | Set TLS cert location (default: `./cert.pem`) |
| `-k <TLS_KEY_FILE>` | `SENTRYPEER_KEY` | Set TLS key location (default: `./key.pem`) |
| `-z <TLS_LISTEN_ADDR>` | `SENTRYPEER_TLS_LISTEN_ADDRESS` | Set TLS listen address (default: `0.0.0.0:5061`) |
| `-s` | `SENTRYPEER_SYSLOG` | Enable syslog logging |
| `-v` | `SENTRYPEER_VERBOSE` | Enable verbose logging |
| `-d` | `SENTRYPEER_DEBUG` | Enable debug mode |
| `-h, --help` | N/A | Print help message |
| `-V, --version` | N/A | Print version information |

## Notes
- **Default Database**: If not specified, the tool creates/uses `sentrypeer.db` in the current directory.
- **Security**: When using the WebHook feature, ensure you provide the OAuth2 credentials if the endpoint requires authentication.
- **SIP Ports**: By default, SIP typically uses 5060 (UDP/TCP) and 5061 (TLS). Ensure these ports are accessible if you want to capture traffic.