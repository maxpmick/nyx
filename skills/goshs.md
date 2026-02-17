---
name: goshs
description: A high-performance, feature-rich SimpleHTTPServer written in Go. Use it to quickly serve files over HTTP/HTTPS, WebDAV, or SFTP during penetration testing, data exfiltration, or lateral movement. It supports advanced features like basic/certificate authentication, TLS (including Let's Encrypt), IP whitelisting, and webhooks for monitoring file access.
---

# goshs

## Overview
`goshs` is an enhanced alternative to Python's `SimpleHTTPServer`. It provides a web-based file manager with support for uploads, downloads, and directory listings, while adding security layers like TLS, authentication, and connection restrictions. Category: Reconnaissance / Information Gathering, Exploitation, Post-Exploitation.

## Installation (if not already installed)
Assume `goshs` is already installed. If not:
```bash
sudo apt update && sudo apt install goshs
```

## Common Workflows

### Quick File Sharing (Read-Only)
Serve the current directory on port 8080 without allowing uploads or deletions:
```bash
goshs -p 8080 -ro -nd
```

### Secure Exfiltration Server
Start a server with a self-signed certificate and basic authentication for secure file uploads:
```bash
goshs -s -ss -b 'admin:P@ssw0rd123!'
```

### WebDAV and SFTP Co-existence
Serve files using HTTP (port 8000), WebDAV (port 8001), and SFTP (port 2022) simultaneously:
```bash
goshs -w -sftp
```

### Restricted Access with Whitelisting
Only allow specific IP addresses to access the hosted files:
```bash
goshs --ip-whitelist 192.168.1.10,10.0.0.5
```

## Complete Command Reference

### Web Server Options
| Flag | Description | Default |
|------|-------------|---------|
| `-i, --ip` | IP or Interface to listen on | `0.0.0.0` |
| `-p, --port` | The port to listen on | `8000` |
| `-d, --dir` | The web root directory | Current path |
| `-w, --webdav` | Also serve using webdav protocol | `false` |
| `-wp, --webdav-port` | The port to listen on for webdav | `8001` |
| `-ro, --read-only` | Read only mode, no upload possible | `false` |
| `-uo, --upload-only` | Upload only mode, no download possible | `false` |
| `-uf, --upload-folder` | Specify a different upload folder | Current path |
| `-nc, --no-clipboard` | Disable the clipboard sharing | `false` |
| `-nd, --no-delete` | Disable the delete option | `false` |
| `-si, --silent` | Running without dir listing | `false` |
| `-c, --cli` | Enable cli (only with auth and tls) | `false` |
| `-e, --embedded` | Show embedded files in UI | `false` |
| `-o, --output` | Write output to logfile | `false` |

### TLS Options
| Flag | Description |
|------|-------------|
| `-s, --ssl` | Use TLS |
| `-ss, --self-signed` | Use a self-signed certificate |
| `-sk, --server-key` | Path to server key |
| `-sc, --server-cert` | Path to server certificate |
| `-p12, --pkcs12` | Path to server p12 |
| `-p12np, --p12-no-pass` | Server p12 has empty password |
| `-sl, --lets-encrypt` | Use Let's Encrypt as certification service |
| `-sld, --le-domains` | Domain(s) to request from Let's Encrypt (comma separated) |
| `-sle, --le-email` | Email to use with Let's Encrypt |
| `-slh, --le-http` | Port to use for Let's Encrypt HTTP Challenge (default: 80) |
| `-slt, --le-tls` | Port to use for Let's Encrypt TLS ALPN Challenge (default: 443) |

### SFTP Server Options
| Flag | Description | Default |
|------|-------------|---------|
| `-sftp` | Activate SFTP server capabilities | `false` |
| `-sp, --sftp-port` | The port SFTP listens on | `2022` |
| `-skf, --sftp-keyfile` | Authorized_keys file for pubkey auth | |
| `-shk, --sftp-host-keyfile`| SSH Host key file for identification | |

### Authentication Options
| Flag | Description |
|------|-------------|
| `-b, --basic-auth` | Use basic authentication (`user:pass` - user can be empty) |
| `-ca, --cert-auth` | Use certificate based authentication - provide CA certificate |
| `-H, --hash` | Hash a password for file based ACLs |

### Connection Restriction
| Flag | Description |
|------|-------------|
| `-ipw, --ip-whitelist` | Comma separated list of IPs to whitelist |
| `-tpw, --trusted-proxy-whitelist` | Comma separated list of trusted proxies |

### Webhook Options
| Flag | Description | Default |
|------|-------------|---------|
| `-W, --webhook` | Enable webhook support | `false` |
| `-Wu, --webhook-url` | URL to send webhook requests to | |
| `-We, --webhook-events` | Events to notify: `all, upload, delete, download, view, webdav, sftp, verbose` | `all` |
| `-Wp, --webhook-provider` | Webhook provider: `Discord, Mattermost, Slack` | `Discord` |

### Misc Options
| Flag | Description | Default |
|------|-------------|---------|
| `-C, --config` | Provide config file path | `false` |
| `-P, --print-config` | Print sample config to STDOUT | `false` |
| `-u, --user` | Drop privs to user (unix only) | Current user |
| `--update` | Update goshs to most recent version | |
| `-nm, --no-mdns` | Disable zeroconf mDNS registration | `false` |
| `-V, --verbose` | Activate verbose log output | `false` |
| `-v` | Print the current goshs version | |

## Notes
- **Security**: When using `-b` (basic auth), passwords can be provided as plaintext or as bcrypt hashes.
- **CLI Mode**: The `-c` flag enables a command-line interface within the web UI, but it requires both authentication (`-b` or `-ca`) and TLS (`-s`) to be active for security.
- **mDNS**: By default, `goshs` registers itself via mDNS (Zeroconf), making it discoverable on the local network. Use `-nm` to disable this behavior.