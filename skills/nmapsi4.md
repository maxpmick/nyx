---
name: nmapsi4
description: A graphical user interface (GUI) based on Qt for the Nmap network scanner. Use when a visual representation of network scans, host discovery, and port mapping is preferred over the command line, or to manage complex Nmap options through a structured interface during reconnaissance and vulnerability analysis.
---

# nmapsi4

## Overview
NmapSI4 is a complete Qt-based graphical interface for Nmap. It is designed to provide a user-friendly way to manage the extensive options of the Nmap security scanner, facilitating network discovery and security auditing. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)

Assume nmapsi4 is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install nmapsi4
```

**Dependencies:** nmap, bind9-dnsutils, libqt5core5t64, libqt5gui5t64, libqt5widgets5t64, libqt5network5t64, libqt5webenginewidgets5.

## Common Workflows

### Launching the GUI
Simply run the application from the terminal or application menu to start the interface:
```bash
nmapsi4
```

### Opening a Saved Scan Result
To open a specific Nmap XML output file or NmapSI4 project file directly into the GUI:
```bash
nmapsi4 /path/to/scan_results.xml
```

### Viewing Version and Help
To check the current version or view basic command-line arguments:
```bash
nmapsi4 --version
nmapsi4 --help
```

## Complete Command Reference

```
nmapsi4 [Qt-options] [KDE-options] [File]
```

### Arguments

| Argument | Description |
|----------|-------------|
| `File(s)` | Path to file(s) to open within the application (e.g., previous scan results) |

### General Options

| Flag | Description |
|------|-------------|
| `--help` | Show help about options |
| `--help-qt` | Show Qt specific options |
| `--help-kde` | Show KDE specific options |
| `--help-all` | Show all options |
| `--author` | Show author information |
| `-v`, `--version` | Show version information |
| `--license` | Show license information |
| `--` | End of options |

## Notes
- NmapSI4 acts as a wrapper; **Nmap** must be installed on the system for the tool to perform any scanning functions.
- While the tool provides a GUI, it may require root privileges (via `sudo` or internal prompts) to perform certain types of scans like SYN Stealth scans (`-sS`) or OS fingerprinting (`-O`).
- The interface allows for the management of multiple scan profiles and provides a visual representation of the network topology.