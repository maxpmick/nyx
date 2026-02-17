---
name: routersploit
description: Exploitation framework dedicated to embedded devices and routers. It includes modules for exploits, credential testing, scanners, and payload generation. Use when performing penetration testing on IoT devices, routers, or embedded systems to identify vulnerabilities, perform brute-force attacks, or execute remote code.
---

# routersploit

## Overview
RouterSploit (rsf) is an open-source exploitation framework for embedded devices. It mirrors the Metasploit workflow, providing specialized modules for routers and IoT hardware. Category: Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
Assume routersploit is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install routersploit
```

## Common Workflows

### Automated Vulnerability Scanning
Use the `autopwn` module to scan a target against all available exploit modules.
```bash
rsf.py
rsf > use scanners/autopwn
rsf (AutoPwn) > set target 192.168.1.1
rsf (AutoPwn) > run
```

### Exploiting a Specific Vulnerability
Identify a module, check vulnerability status, and execute.
```bash
rsf > use exploits/multi/misfortune_cookie
rsf (Misfortune Cookie) > set target 192.168.1.1
rsf (Misfortune Cookie) > check
rsf (Misfortune Cookie) > run
```

### Credential Brute Forcing
Test common or custom credentials against a router's web interface.
```bash
rsf > use creds/http_basic_bruteforce
rsf (HTTP Basic Bruteforce) > set target 192.168.1.1
rsf (HTTP Basic Bruteforce) > set passwords file:///usr/share/wordlists/rockyou.txt
rsf (HTTP Basic Bruteforce) > run
```

### Command Line Execution
Run a specific module directly from the terminal without entering the interactive shell.
```bash
routersploit -m exploits/dlink/dir_300_600_rce -s "target 192.168.1.1"
```

## Complete Command Reference

### CLI Arguments
Both `routersploit` and `rsf.py` support the following arguments:

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-m <module>` | Select a specific module to run |
| `-s "<option> <value>"` | Set a module option (used with `-m`) |

### Interactive Shell Commands

| Command | Description |
|---------|-------------|
| `use <module>` | Select a module for use |
| `set <option> <value>` | Set a value for a specific module option |
| `setg <option> <value>` | Set a global value for an option |
| `show options` | Display options for the current module |
| `show info` | Display detailed information about the current module |
| `show devices` | List devices supported by the current module |
| `check` | Check if the target is vulnerable to the selected exploit |
| `run` / `exploit` | Execute the current module |
| `back` | Return to the previous context |
| `exit` / `quit` | Exit the RouterSploit framework |
| `search <query>` | Search for modules (e.g., `search dlink`) |

### Module Categories

| Category | Description |
|----------|-------------|
| `exploits` | Modules that take advantage of identified vulnerabilities |
| `creds` | Modules designed to test credentials against network services (HTTP, SSH, Telnet, etc.) |
| `scanners` | Modules that check if a target is vulnerable to specific exploits |
| `payloads` | Modules for generating payloads for various architectures and injection points |
| `generic` | Modules that perform generic attacks |

## Notes
- **Target Format**: Most modules accept IP addresses, but some credential modules allow files using the `file://` prefix (e.g., `file:///path/to/targets.txt`).
- **Wordlists**: RouterSploit includes internal wordlists located at `/usr/share/routersploit/routersploit/wordlists/`.
- **Check Feature**: Always use the `check` command before `run` to avoid crashing services or unnecessary noise on the network.