---
name: freerdp3
description: A comprehensive suite of Remote Desktop Protocol (RDP) tools including clients (X11, Wayland, SDL), a MITM proxy, and a shadowing server. Use for remote administration, RDP vulnerability research, credential testing, and session interception. It supports modern RDP features like NLA, RemoteFX, and multimedia redirection.
---

# freerdp3

## Overview
FreeRDP is a libre client/server implementation of the Remote Desktop Protocol (RDP). The suite includes multiple clients (`xfreerdp3`, `wlfreerdp3`, `sdl-freerdp3`), a proxy server for MITM operations (`freerdp-proxy3`), and tools for shadowing existing X11 sessions (`freerdp-shadow-cli3`). Category: Reconnaissance / Information Gathering, Vulnerability Analysis, Password Attacks.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. To install specific components:
```bash
sudo apt install freerdp3-x11 freerdp3-wayland freerdp3-sdl freerdp3-proxy freerdp3-shadow-x11 winpr3-utils
```

## Common Workflows

### Standard Connection with NLA
```bash
xfreerdp3 /u:Administrator /p:Password123 /v:192.168.1.10
```

### Connection with Drive and Clipboard Redirection
```bash
xfreerdp3 /u:user /v:10.0.0.5 /drive:shared,/tmp +clipboard
```

### MITM Proxy Setup
Create a template configuration, edit it, and start the proxy:
```bash
freerdp-proxy3 --dump-config proxy.ini
freerdp-proxy3 proxy.ini
```

### Generate NTLM Hash for Pass-the-Hash
```bash
winpr-hash3 -u Administrator -p Password123
```

## Complete Command Reference

### xfreerdp3 / sdl-freerdp3 Options
Both clients share the same core syntax: `[client] [file] [options] /v:<server>[:port]`

#### General Options
| Flag | Description |
|------|-------------|
| `/v:<server>[:port]` | Server hostname, URL, IPv4, IPv6, or path to pipe |
| `/u:[[domain\]user]` | Username for authentication |
| `/p:<password>` | Password for authentication |
| `/d:<domain>` | Domain for authentication |
| `/port:<number>` | Server port (default 3389) |
| `+admin` | Connect to admin/console session |
| `/t:<title>` | Set window title |
| `+f` | Fullscreen mode |
| `/size:<w>x<h>` | Screen size (e.g., 1024x768 or 90%) |
| `/w:<width>` | Width |
| `/h:<height>` | Height |
| `/kbd:layout:<id>` | Set keyboard layout |
| `+version` | Print version |

#### Security & Authentication
| Flag | Description |
|------|-------------|
| `/sec:<type>` | Force security: `rdp`, `tls`, `nla`, `ext`, `aad` |
| `+auth-only` | Authenticate only, do not start session |
| `-authentication` | Disable authentication (experimental) |
| `/cert:<options>` | Certificate handling: `deny`, `ignore`, `tofu`, `fingerprint:<hash>` |
| `/pth:<hash>` | Pass-the-hash (restricted admin mode) |
| `+restricted-admin` | Enable restricted admin mode |
| `/from-stdin[:force]` | Read credentials from stdin |
| `/auth-pkg-list:<list>` | Filter authentication packages (e.g., `!ntlm`) |

#### Redirection Options
| Flag | Description |
|------|-------------|
| `+clipboard` | Enable clipboard redirection |
| `/drive:<name>,<path>` | Redirect local directory as a share |
| `+drives` | Redirect all mount points |
| `/smartcard:<name>` | Redirect smartcard devices |
| `/printer:<name>` | Redirect printer device |
| `/serial:<name>,<path>` | Redirect serial port |
| `/parallel:<name>,<path>` | Redirect parallel port |
| `/usb:<options>` | Redirect USB devices by ID or address |
| `/sound:<options>` | Audio output redirection |
| `/microphone:<options>` | Audio input redirection |

#### Performance & Graphics
| Flag | Description |
|------|-------------|
| `/network:<type>` | Connection type: `modem`, `broadband`, `wan`, `lan`, `auto` |
| `+rfx` | Enable RemoteFX |
| `/gfx:<options>` | RDP8 graphics pipeline options |
| `+aero` | Enable desktop composition |
| `-fonts` | Disable smooth fonts |
| `-themes` | Disable themes |
| `-wallpaper` | Disable wallpaper |
| `/compression-level:<n>` | Set compression level (0, 1, 2) |

### freerdp-proxy3 Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display help text |
| `--buildconfig` | Print build configuration |
| `<config.ini>` | Start proxy with specified config file |
| `--dump-config <file>` | Create a template config file |
| `-v`, `--version` | Print version |

### freerdp-shadow-cli3 Options
| Flag | Description |
|------|-------------|
| `/bind-address:<addr>` | Address to bind the shadow server to |
| `/port:<number>` | Server port |
| `/sam-file:<file>` | NTLM SAM file for NLA authentication |
| `/sec:<type>` | Force security: `rdp`, `tls`, `nla`, `ext` |
| `-auth` | Require client authentication (default: on) |
| `-may-interact` | Allow clients to interact without prompt |
| `/monitors:<ids>` | Select monitors to share |
| `/rect:<x,y,w,h>` | Select specific screen rectangle to share |

### winpr-hash3 Options
`winpr-hash3 -u <username> -p <password> [options]`
| Flag | Description |
|------|-------------|
| `-u <user>` | Username |
| `-p <pass>` | Password |
| `-d <domain>` | Domain |
| `-f <format>` | Output format: `default`, `sam` |
| `-v <version>` | NTLM version: `1`, `2` |

### winpr-makecert3 Options
| Flag | Description |
|------|-------------|
| `-rdp` | Generate certificate for RDP usage |
| `-format <fmt>` | File format: `crt`, `pem`, `pfx` |
| `-path <path>` | Output path |
| `-p <password>` | Export password |
| `-n <name>` | Subject name (e.g., "CN=Host") |
| `-a <algo>` | Algorithm: `md5`, `sha1`, `sha256`, `sha384`, `sha512` |
| `-len <bits>` | Key length |
| `-m <months>` | Validity in months |
| `-y <years>` | Validity in years |

## Notes
- **Keyboard Release**: Use `Right CTRL` to release keyboard/mouse grab in X11/SDL clients.
- **Fullscreen Toggle**: `CTRL+ALT+Enter`.
- **NLA Security**: The shadow server requires a SAM file for NLA by default. Use `/sam-file` or start with `-sec-nla` for PAM (if supported).
- **Wayland**: `wlfreerdp3` is optimized for Wayland compositors but supports most `xfreerdp3` options.