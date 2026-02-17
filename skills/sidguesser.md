---
name: sidguesser
description: Guess Oracle database SIDs (System Identifiers) and instances using a dictionary-based attack. Use when performing database reconnaissance, identifying Oracle instances for further exploitation, or during web application testing where an Oracle backend is suspected.
---

# sidguesser

## Overview
A dictionary-based tool for guessing Oracle SIDs/instances. It operates at a speed of approximately 80-100 guesses per second and is used to identify valid database instances on a target server. Category: Web Application Testing / Database Assessment.

## Installation (if not already installed)
Assume sidguesser is already installed. If the `sidguess` command is not found:

```bash
sudo apt update && sudo apt install sidguesser
```

## Common Workflows

### Basic SID Brute Force
Identify valid SIDs on an Oracle server using a standard wordlist:
```bash
sidguess -i 192.168.1.205 -d /usr/share/wordlists/metasploit/oracle_sids.txt
```

### Stop After First Match
Find a single valid SID and stop the attack immediately:
```bash
sidguess -i 192.168.1.205 -d /usr/share/wordlists/metasploit/oracle_sids.txt -m findfirst
```

### Targeted Port with Logging
Scan a non-standard Oracle port and save the results to a file:
```bash
sidguess -i 10.0.0.50 -p 1522 -d /usr/share/wordlists/rockyou.txt -r oracle_results.txt
```

## Complete Command Reference

```bash
sidguess -i <ip> -d <dictionary> [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-i <ip>` | Target IP address of the Oracle server |
| `-d <dictionary>` | Path to the dictionary file containing potential SIDs |
| `-p <portnr>` | Use specific port (default: 1521) |
| `-r <report>` | Report results to the specified file |
| `-m <mode>` | Execution mode: `findfirst` (stop after first match) or `findall` (default, test entire list) |

### Interactive Commands
While the tool is running, the following keys can be used:
- `<space>`: Display current statistics
- `Q`: Quit the attack

## Notes
- The tool is relatively slow (80-100 guesses per second) compared to modern multi-threaded brute-forcers, but effective for Oracle TNS listener interactions.
- Ensure you have a high-quality Oracle-specific SID wordlist for best results; generic user wordlists may not contain common Oracle SIDs like `ORCL`, `XE`, or `PROD`.