---
name: enumiax
description: Enumerate usernames on systems using the Inter-Asterisk Exchange (IAX) protocol. Supports both sequential brute-force guessing and dictionary-based attacks. Use when performing VoIP security assessments, vulnerability analysis of Asterisk PBX systems, or identifying valid user accounts for further exploitation.
---

# enumiax

## Overview
enumIAX is an Inter-Asterisk Exchange (IAX) protocol username brute-force enumerator. It helps security professionals identify valid usernames on VoIP systems by operating in two distinct modes: Sequential Username Guessing or Dictionary Attack. Category: Vulnerability Analysis / VoIP.

## Installation (if not already installed)
Assume enumiax is already installed. If the command is not found, install it using:

```bash
sudo apt install enumiax
```

## Common Workflows

### Dictionary Attack
Perform a dictionary-based enumeration against a target VoIP server using a specific wordlist:
```bash
enumiax -d /usr/share/wordlists/metasploit/unix_users.txt 192.168.1.1
```

### Sequential Brute-Force
Attempt to guess usernames sequentially by specifying a minimum and maximum character length:
```bash
enumiax -m 4 -M 6 192.168.1.1
```

### Rate-Limited Attack with Verbosity
Perform an attack while limiting the speed of calls (in microseconds) to avoid detection or service disruption, with increased output detail:
```bash
enumiax -d /usr/share/wordlists/rockyou.txt -r 500000 -vv 192.168.1.1
```

### Resume a Session
Read the session state from a previously saved state file to resume an interrupted enumeration:
```bash
enumiax -s session.state 192.168.1.1
```

## Complete Command Reference

```bash
enumiax [options] target
```

### Options

| Flag | Description |
|------|-------------|
| `-d <dict>` | Dictionary attack using the specified `<dict>` file |
| `-i <count>` | Interval for auto-save (number of operations, default: 1000) |
| `-m #` | Minimum username length (in characters) |
| `-M #` | Maximum username length (in characters) |
| `-r #` | Rate-limit calls (in microseconds) |
| `-s <file>` | Read session state from the specified state file |
| `-v` | Increase verbosity (repeat for additional verbosity, e.g., `-vv`) |
| `-V` | Print version information and exit |
| `-h` | Print help/usage information and exit |

## Notes
- If no dictionary file (`-d`) is provided, the tool defaults to sequential guessing based on the length parameters.
- Rate-limiting (`-r`) is highly recommended when testing production VoIP infrastructure to prevent Denial of Service (DoS) conditions on the IAX service.
- The tool is specifically designed for the IAX protocol, commonly used by Asterisk PBX systems.