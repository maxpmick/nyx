---
name: offsec-courses
description: Install and manage metapackages containing all necessary tools and dependencies for Offensive Security (OffSec) certification courses. Use when preparing a Kali Linux environment for OSCP (PEN-200), OSEP (PEN-300), OSWE (WEB-300), OSED (EXP-301), or EXP-100. These packages ensure all required scripts, binaries, and libraries for specific course labs and exams are present.
---

# offsec-courses

## Overview
The `offsec-courses` collection consists of metapackages designed to streamline the setup of Kali Linux for students enrolled in Offensive Security training. Each package maps to a specific certification path, installing the exact toolset required for that curriculum. Category: Information Gathering / Exploitation / Web Application Testing.

## Installation
These packages are metapackages. To install the environment for a specific course, run the corresponding command:

```bash
# For PEN-200 / OSCP (PWK)
sudo apt update && sudo apt install offsec-pwk

# For PEN-300 / OSEP (ETBD)
sudo apt update && sudo apt install offsec-pen300

# For WEB-300 / OSWE (AWAE)
sudo apt update && sudo apt install offsec-awae

# For EXP-301 / OSED (WUMED)
sudo apt update && sudo apt install offsec-exp301

# For EXP-100
sudo apt update && sudo apt install offsec-exp100
```

## Common Workflows

### Preparing for the OSCP (PEN-200)
Install the full suite of tools including enumeration (nmap, dnsrecon), exploitation (metasploit, sqlmap), and post-exploitation (mimikatz, peass) resources.
```bash
sudo apt install offsec-pwk
```

### Setting up for Advanced Web Attacks (WEB-300)
Install web-specific tools and the necessary Python 2 legacy environment required for certain course exploits.
```bash
sudo apt install offsec-awae
```

### Configuring an Evasion and Breaching Environment (PEN-300)
Install tools focused on bypasses, lateral movement, and tunneling like Chisel, Responder, and PowerShell.
```bash
sudo apt install offsec-pen300
```

## Complete Package Reference

### offsec-pwk (PEN-200 / OSCP)
The most comprehensive metapackage for general penetration testing.
*   **Key Tools:** nmap, burpsuite, metasploit-framework, sqlmap, john, hashcat, bloodhound, responder, impacket-scripts, seclists, exploitdb, mimikatz, evil-winrm, and more.
*   **Services:** apache2, pure-ftpd, snmp, postgresql-client.

### offsec-pen300 (PEN-300 / OSEP)
Focused on advanced evasion techniques and breach operations.
*   **Key Tools:** chisel, dnscat2, gobuster, impacket-scripts, powershell, proxychains4, responder, wireshark.
*   **Development:** gcc, golang.

### offsec-awae (WEB-300 / OSWE)
Focused on white-box web application auditing.
*   **Key Tools:** burpsuite, firefox-esr, freerdp3-x11, impacket-scripts, netcat-traditional.
*   **Runtimes:** openjdk-11-jdk-headless, offsec-awae-python2.

### offsec-awae-python2
Provides legacy Python 2 support specifically for WEB-300 resources.
*   **Dependencies:** python2, python-cffi, ca-certificates.

### offsec-exp301 (EXP-301 / OSED)
Focused on Windows user-mode exploit development.
*   **Key Tools:** impacket-scripts, metasploit-framework, python3, rdesktop.

### offsec-exp100 (EXP-100)
Introductory exploit development path.
*   **Key Tools:** gdb-multiarch, qemu-user, binutils-aarch64-linux-gnu, binutils-arm-linux-gnueabihf.

## Notes
- These packages do not contain the course materials (PDFs/Videos) themselves, only the software tools required to perform the labs.
- Installing `offsec-pwk` is highly recommended for any general-purpose penetration testing VM due to its exhaustive list of dependencies.
- Some packages may install legacy services (like `apache2` or `samba`); ensure you manage these services securely.