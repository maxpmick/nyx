---
name: freerdp2
description: A suite of free Remote Desktop Protocol (RDP) tools including clients (xfreerdp, wlfreerdp) and a shadowing server. Use for remote desktop access, credential testing, NTLM hashing, and sharing X11 displays during penetration testing or remote administration.
---

# freerdp2

## Overview
FreeRDP is a libre client/server implementation of the Remote Desktop Protocol (RDP). It includes high-performance clients for X11 and Wayland, a shadowing server to share existing displays, and utilities for NTLM hashing and certificate generation. Category: Password Attacks / Remote Access.

## Installation (if not already installed)
Assume the tools are installed. If missing, use:
```bash
sudo apt install freerdp2-x11 freerdp2-wayland freerdp2-shadow-x11 winpr-utils
```

## Common Workflows

### Connect to Windows with Credentials
```bash
xfreerdp /u:Administrator /p:Password123 /v:192.168.1.100
```

### Connect using Pass-the-Hash
```bash
xfreerdp /u:Admin /pth:aad3b435b51404eeaad3b435b51404ee:32196B5646D97B8F60972B851249D219 /v:10.0.0.5
```

### Share current X11 display (Shadowing)
```bash
freerdp-shadow-cli /port:3389 -auth
```

### Generate NTLM Hash for a user
```bash
winpr-hash -u Administrator -p Password123
```

## Complete Command Reference

### xfreerdp (X11 Client)
`xfreerdp [file] [options] [/v:server[:port]]`

| Flag | Description |
|------|-------------|
| `/u:[[domain\]user\|user[@domain]]` | Username |
| `/p:password` | Password |
| `/v:server[:port]` | Server hostname or IP |
| `/d:domain` | Domain |
| `/pth:hash`, `/pass-the-hash:hash` | Pass the hash (restricted admin mode) |
| `/admin`, `/console` | Admin (or console) session |
| `/f` | Fullscreen mode |
| `/size:W[x]H` or `percent%[wh]` | Screen size (e.g., `/size:800x600` or `/size:50%h`) |
| `/w:width` | Width (default: 1024) |
| `/h:height` | Height (default: 768) |
| `/workarea` | Use available work area |
| `/t:title` | Window title |
| `+clipboard` | Activate clipboard redirection |
| `/drive:name,path` | Redirect directory as named share |
| `+drives` | Redirect all mount points as shares |
| `/smartcard[:str]` | Redirect smartcard devices |
| `/printer[:name[,driver]]` | Redirect printer device |
| `/sound[:options]` | Audio output (sound) |
| `/mic[:options]` | Audio input (microphone) |
| `/usb:id,dev:vid:pid` | USB device redirection |
| `/cert:[deny,ignore,tofu,fingerprint]` | Certificate accept options |
| `/sec:[rdp\|tls\|nla\|ext]` | Force specific protocol security |
| `-nego` | Disable protocol security negotiation |
| `/restricted-admin` | Restricted admin mode |
| `/vmconnect[:vmid]` | Hyper-V console (port 2179) |
| `/proxy:[proto://][user:pass@]host:port` | Proxy settings |
| `/from-stdin[:force]` | Read credentials from stdin |
| `/load-balance-info:string` | Load balance info |
| `/g:gateway[:port]` | Gateway Hostname |
| `/gu:user`, `/gp:pass`, `/gd:domain` | Gateway credentials |
| `+aero` | Desktop composition |
| `-wallpaper` | Disable wallpaper |
| `-themes` | Disable themes |
| `-fonts` | Disable smooth fonts |
| `/dynamic-resolution` | Send resolution updates on resize |
| `/smart-sizing[:W[x]H]` | Scale remote desktop to window size |
| `/version` | Print version |
| `/help` | Print help |

### freerdp-shadow-cli (Shadowing Server)
`freerdp-shadow-cli [options]`

| Flag | Description |
|------|-------------|
| `/port:<number>` | Server port |
| `/ipc-socket:<name>` | Server IPC socket |
| `/bind-address:<addr>` | Address to bind to (e.g., `[::1]` for IPv6) |
| `/monitors:<0,1...>` | Select monitors to share |
| `/rect:<x,y,w,h>` | Select rectangle within monitor to share |
| `+auth` | Clients must authenticate (default: off) |
| `-may-view` | Clients may view without prompt (default: on) |
| `-may-interact` | Clients may interact without prompt (default: on) |
| `/sec:<rdp\|tls\|nla\|ext>` | Force specific protocol security |
| `/sam-file:<file>` | NTLM SAM file for NLA authentication |
| `/version` | Print version |

### winpr-hash (NTLM Hashing)
`winpr-hash -u <username> -p <password> [-d <domain>] [-f <default,sam>] [-v <1,2>]`

### winpr-makecert (Certificate Tool)
`winpr-makecert [options] [output file]`

| Flag | Description |
|------|-------------|
| `-rdp` | Generate certificate for RDP usage |
| `-silent` | Silent generation |
| `-format <crt\|pem\|pfx>` | File format |
| `-path <path>` | Output path |
| `-p <password>` | Export password |
| `-n <name>` | Subject name (e.g., `-n "CN=Host"`) |
| `-a <algorithm>` | Signature algorithm (md5, sha1, sha256, sha384, sha512) |
| `-len <number>` | Key length in bits |
| `-m <number>` | Validity in months |
| `-y <number>` | Validity in years |

## Notes
- **Security**: Use `/cert:ignore` only in trusted labs as it bypasses MITM protection.
- **Performance**: Use `/network:auto` or specific types like `/network:wan` to optimize RDP traffic.
- **Wayland**: Use `wlfreerdp` for Wayland-native environments; it supports the same core options as `xfreerdp`.
- **Keyboard**: If keys are mapped incorrectly, use `/kbd-list` to find your layout and `/kbd:0xID` to set it.