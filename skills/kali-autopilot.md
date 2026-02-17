---
name: kali-autopilot
description: Create and execute automated attack scripts for red teaming, purple teaming, and penetration testing. Use when automating exploitation workflows, simulating adversary behavior for detection training (Kali Purple), or orchestrating multi-step attack sequences involving Metasploit and system commands.
---

# kali-autopilot

## Overview
Kali Autopilot is a framework designed to develop and execute automated attack scripts. It is primarily used in red and purple teaming exercises to simulate attacks against vulnerable machines for detection and response training, but it is equally effective for standard penetration testing automation. Category: Reconnaissance / Information Gathering (Identify).

## Installation (if not already installed)
Assume kali-autopilot is already installed. If you receive a "command not found" error:

```bash
sudo apt install kali-autopilot
```

Dependencies: python3, python3-easygui, python3-pymetasploit3, python3-sarge, python3-wxgtk4.0.

## Common Workflows

### Launching the GUI
The primary way to interact with Kali Autopilot for script creation and management is through its graphical interface.
```bash
kali-autopilot
```

### Automated Attack Simulation
1. Launch the tool and define a new attack plan.
2. Configure connections to Metasploit (msfrpcd) if using exploit modules.
3. Sequence commands and modules to run against target IPs.
4. Execute the script to simulate a live adversary.

### Purple Teaming / Detection Training
Use Kali Autopilot to run a consistent, repeatable set of attacks against a target while monitoring defensive tools (SIEM/EDR) to verify if the specific techniques are correctly logged and alerted upon.

## Complete Command Reference

Kali Autopilot is primarily a GUI-driven application for building and running attack scripts.

```bash
kali-autopilot [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `--help` | Show help message and exit |
| `--version` | Show program's version number and exit |

### Functional Capabilities
While the command-line interface is minimal, the tool provides the following capabilities within its environment:

*   **Metasploit Integration**: Connects to `msfrpcd` to automate the execution of Metasploit modules (exploits, scanners, post-modules).
*   **System Command Execution**: Ability to run arbitrary shell commands as part of an attack sequence.
*   **Script Logic**: Define delays, loops, and conditional sequences for complex attack chains.
*   **GUI Builder**: A visual interface to drag-and-drop attack components without manual coding.

## Notes
*   **Metasploit Requirement**: To use Metasploit features, ensure the Metasploit RPC daemon is running (`msfrpcd -P <password> -S`).
*   **Kali Purple**: This tool is a core component of the Kali Purple architecture for SOC (Security Operations Center) analysis and defensive posture testing.
*   **Safety**: Automated scripts can be destructive. Always verify the target IP and the impact of the modules being automated before execution.