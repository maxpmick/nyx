---
name: teamsploit
description: Automate common penetration testing tasks and facilitate real-time collaboration within a team using the Metasploit Framework. Use when performing group-based penetration testing, automated exploitation, post-exploitation, or session sharing across multiple team members.
---

# teamsploit

## Overview
TeamSploit is a suite of tools designed for the Metasploit Framework (MSF) to enable group-based penetration testing. It provides automation for exploitation and post-exploitation, information gathering, and session sharing. It is compatible with MSF OpenSource, Express, and Pro. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume TeamSploit is already installed. If you encounter errors, ensure dependencies are met:

```bash
sudo apt update
sudo apt install teamsploit gnome-terminal metasploit-framework ruby
```

**Configuration Requirement:**
Before running, you must configure the tool by editing the configuration file:
```bash
sudo nano /usr/share/teamsploit/teamsploit.conf
```

## Common Workflows

### Initial Setup
Before launching, ensure the Metasploit database is started and the TeamSploit configuration is populated with the correct database credentials and team settings.

### Launching TeamSploit
```bash
sudo teamsploit
```
This launches the main interface. Note that administrative rights are typically required to interact with the Metasploit Framework.

### Automated Post-Exploitation
Once sessions are established in the shared MSF environment, TeamSploit can be used to automate the collection of evidence, credentials, and system information across all active sessions.

## Complete Command Reference

### Main Executable
```bash
teamsploit [options]
```

| Flag | Description |
|------|-------------|
| `-h` | Display the help menu and version information |

### Features and Capabilities
TeamSploit operates as a wrapper and extension for Metasploit, providing the following functional areas:

*   **Exploitation Automation**: Scripts to automate the launching of exploits against identified targets.
*   **Automated Post-Exploitation**: Automated gathering of hashes, tokens, and sensitive files once a shell is gained.
*   **Information and Data Gathering**: Tools to aggregate data from multiple team members into a central view.
*   **Session Sharing**: Allows multiple testers to interact with the same Metasploit sessions.
*   **Trojans and Trollware**: Includes modules for deploying persistence and "troll" payloads for training or engagement purposes.

## Notes
*   **Configuration**: The tool will fail with an error ("Error, No Config...Wait...WHAT ARE YOU DOING?") if `/usr/share/teamsploit/teamsploit.conf` has not been modified.
*   **Permissions**: Must be run with `sudo` or as the `root` user to ensure proper integration with Metasploit services.
*   **Environment**: Requires `gnome-terminal` to be installed as it often spawns new terminal windows for different tasks or sessions.