---
name: sipvicious
description: Audit SIP-based VoIP systems by scanning for SIP devices, identifying extensions, and cracking passwords. Use when performing security assessments on VoIP infrastructure, discovering SIP PBX servers, enumerating valid extensions, or testing the strength of SIP digest authentication.
---

# sipvicious

## Overview
SIPVicious is a suite of tools for auditing Session Initiation Protocol (Protocol) based VoIP systems. It consists of five main tools: `svmap` (scanner), `svwar` (extension enumerator), `svcrack` (password cracker), `svreport` (session manager/exporter), and `svcrash` (anti-scanner). Category: Vulnerability Analysis / Password Attacks / VoIP.

## Installation (if not already installed)
Assume the tool is already installed. If missing:
```bash
sudo apt install sipvicious
```

## Common Workflows

### Scan a network for SIP servers
```bash
svmap 192.168.1.0/24 -v
```

### Enumerate extensions on a specific PBX
```bash
svwar -e 100-999 192.168.1.202
```

### Crack a password for a known extension
```bash
svcrack -u 100 -d /usr/share/wordlists/rockyou.txt 192.168.1.202
```

### Export a previous session to PDF
```bash
svreport export -f pdf -o results.pdf -s session_name
```

## Complete Command Reference

### svmap (SIP Scanner)
Scans for SIP devices on a given network.

| Flag | Description |
|------|-------------|
| `-p, --port` | Destination port or ranges (e.g., `-p5060,5061,8000-8100`) |
| `-v, --verbose` | Increase verbosity |
| `-q, --quiet` | Quiet mode |
| `-P, --localport` | Source port for packets |
| `-x, --externalip` | IP Address to use as external IP (NAT/Multi-interface) |
| `-b, --bindingip` | Bind to a specific local IP address |
| `-t, --timeout` | Throttle speed (e.g., 0.5) to prevent packet loss |
| `-R, --reportback` | Send exception traceback to author |
| `-A, --autogetip` | Automatically resolve local IP address |
| `-s, --save` | Save the session name |
| `--resume` | Resume a previous session |
| `-c, --enablecompact` | Enable compact mode for smaller packets |
| `--randomscan` | Scan random IP addresses |
| `-i, --input` | Scan IPs found in a previous session |
| `-I, --inputtext` | Scan IPs from a text file |
| `-m, --method` | Request method (default: OPTIONS) |
| `-d, --debug` | Print SIP messages received |
| `--first` | Only send the first X number of messages |
| `-e, --extension` | Specify a specific extension |
| `--randomize` | Randomize scanning order |
| `--srv` | Scan SRV records for SIP on destination domains |
| `--fromname` | Specify a name for the From header |
| `-6, --ipv6` | Scan an IPv6 address |

### svwar (Extension Scanner)
Identifies working extension lines on a PBX.

| Flag | Description |
|------|-------------|
| `-p, --port` | Destination port (default 5060) |
| `-v, --verbose` | Increase verbosity |
| `-q, --quiet` | Quiet mode |
| `-P, --localport` | Source port for packets |
| `-x, --externalip` | IP Address to use as external IP |
| `-b, --bindingip` | Bind to a specific local IP address |
| `-t, --timeout` | Throttle speed |
| `-R, --reportback` | Send exception traceback to author |
| `-A, --autogetip` | Automatically resolve local IP address |
| `-s, --save` | Save the session name |
| `--resume` | Resume a previous session |
| `-c, --enablecompact` | Enable compact mode |
| `-d, --dictionary` | Dictionary file for extension names (or `-` for stdin) |
| `-m, --method` | Request method: REGISTER (default), OPTIONS, or INVITE |
| `-e, --extensions` | Extension range (e.g., `-e 100-999,1000-1500`) |
| `-z, --zeropadding` | Number of zeros for padding (e.g., `-z 4` for 0001) |
| `--force` | Force scan, ignoring initial sanity checks |
| `-T, --template` | Format string template (e.g., `--template="123%#04i999"`) |
| `-D, --enabledefaults` | Scan for default/typical extensions (1000, 2000, etc.) |
| `--maximumtime` | Max seconds to wait for response before skipping |
| `--domain` | Force a specific domain name in SIP message |
| `--debug` | Print SIP messages received |
| `-6` | Scan an IPv6 address |

### svcrack (Password Cracker)
Online password guessing tool using digest authentication.

| Flag | Description |
|------|-------------|
| `-u, --username` | Username to crack |
| `-d, --dictionary` | Dictionary file (or `-` for stdin) |
| `-r, --range` | Range of numbers to try as passwords |
| `-e, --extension` | Extension to crack (if different from username) |
| `-z, --zeropadding` | Number of zeros for padding numerical passwords |
| `-n, --reusenonce` | Reuse nonce to speed up cracking (if supported by target) |
| `-p, --port` | Destination port |
| `-v, --verbose` | Increase verbosity |
| `-q, --quiet` | Quiet mode |
| `-P, --localport` | Source port |
| `-x, --externalip` | External IP address |
| `-b, --bindingip` | Binding IP address |
| `-t, --timeout` | Throttle speed |
| `-A, --autogetip` | Automatically get local IP |
| `-s, --save` | Save session |
| `--resume` | Resume session |
| `-c, --enablecompact` | Enable compact mode |
| `-T, --template` | Template for extensions |
| `--maximumtime` | Max time to wait for response |
| `-D, --enabledefaults` | Try default passwords |
| `--domain` | Force specific domain |
| `--requesturi` | Force the first line URI (e.g., `sip:999@example.org`) |
| `-m, --method` | Specify SIP method |
| `-6` | Scan IPv6 |

### svreport (Report Engine)
Manages and exports sessions.

| Command | Description |
|---------|-------------|
| `list` | Lists all saved scans |
| `export` | Exports scan to a format |
| `delete` | Deletes a scan |
| `stats` | Prints statistics |
| `search` | Search for string in User Agent (svmap sessions) |

| Options | Description |
|---------|-------------|
| `-v, --verbose` | Increase verbosity |
| `-q, --quiet` | Quiet mode |
| `-t, --type` | Session type (svmap, svwar, svcrack) |
| `-s, --session` | Name of the session |
| `-f, --format` | Format: stdout, pdf, xml, csv, txt |
| `-o, --output` | Output filename |
| `-n` | Do not resolve IP addresses |
| `-c, --count` | Count entries (used with `list`) |

### svcrash (Anti-Scanner)
Responds to `svwar` and `svcrack` messages to crash older versions of the tools.

| Flag | Description |
|------|-------------|
| `--auto` | Automatically send responses to attacks |
| `--astlog` | Path for the Asterisk full logfile |
| `-d` | Specify attacker's IP address |
| `-p` | Specify attacker's port |
| `-b` | Bruteforce the attacker's port |

## Notes
- SIP typically runs on UDP port 5060.
- Use `-t` (timeout) if you suspect packet loss is causing missed results.
- The `--externalip` and `-A` flags are critical when scanning from behind NAT.