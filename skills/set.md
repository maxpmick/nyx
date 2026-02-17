---
name: setoolkit
description: Perform advanced social engineering attacks including spear-phishing, website cloning, infectious media generation, and credential harvesting. Use when conducting social engineering assessments, phishing simulations, or testing human-centric security controls during a penetration test.
---

# Social-Engineer Toolkit (SET)

## Overview
The Social-Engineer Toolkit (SET) is an open-source Python-driven framework designed for penetration testing centered around Social Engineering. It automates the creation of sophisticated attacks such as credential harvesters, web-based exploits, and malicious payloads. Category: Exploitation / Social Engineering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update
sudo apt install set
```

## Common Workflows

### Launching the Toolkit
SET is menu-driven. Start the main interface with:
```bash
sudo setoolkit
```
*Note: You must accept the Terms of Service on the first run.*

### Credential Harvester (Website Cloning)
1. Select `1) Social-Engineering Attacks`
2. Select `2) Website Attack Vectors`
3. Select `3) Credential Harvester Attack Method`
4. Select `2) Site Cloner`
5. Enter the IP address to report back to (usually your local IP).
6. Enter the URL to clone (e.g., `https://gmail.com`).

### Spear-Phishing Attack
1. Select `1) Social-Engineering Attacks`
2. Select `1) Spear-Phishing Attack Vectors`
3. Select `1) Perform a Mass Email Attack`
4. Choose a payload (e.g., a malicious Word doc or PDF).
5. Configure the mailer (SMTP or Sendmail) to deliver the payload to targets.

### Infectious Media Generator
1. Select `1) Social-Engineering Attacks`
2. Select `3) Infectious Media Generator`
3. Choose `1) File-Format Exploits` or `2) Standard Metasploit Executable`.
4. SET will create an `autorun.inf` and a payload to be placed on a USB drive.

## Complete Command Reference

The primary command is `setoolkit`. The legacy command `se-toolkit` is deprecated.

### Main Menu Options

| Option | Description |
|--------|-------------|
| `1` | **Social-Engineering Attacks**: Access phishing, web attacks, infectious media, and payload generators. |
| `2` | **Penetration Testing (Fast-Track)**: Access automated exploitation tools and MSSQL attacks. |
| `3` | **Third Party Modules**: Load community-contributed modules. |
| `4` | **Update the Social-Engineer Toolkit**: Check for newer versions via Git. |
| `5` | **Update SET configuration**: Reload the `set.config` file settings. |
| `6` | **Help, Credits, and About**: View documentation and author information. |
| `99` | **Exit**: Close the toolkit. |

### Social-Engineering Attack Sub-Menu (Option 1)

| Sub-Option | Description |
|------------|-------------|
| `1` | **Spear-Phishing Attack Vectors**: Create malicious attachments and email them to targets. |
| `2` | **Website Attack Vectors**: Clone sites for credential harvesting, Java applet attacks, or Metasploit browser exploits. |
| `3` | **Infectious Media Generator**: Create USB/CD/DVD autorun payloads. |
| `4` | **Create a Payload and Listener**: Generate a standalone `.exe` and start a Metasploit handler. |
| `5` | **Mass Mailer Attack**: Send plain text or HTML emails to multiple targets. |
| `6` | **Arduino-Based Attack Vector**: Create payloads for Teensy/Arduino HID devices. |
| `7` | **Wireless Access Point Attack Vector**: Create a rogue AP to redirect traffic. |
| `8` | **QRCode Generator Attack Vector**: Generate a QR code that redirects to a malicious URL. |
| `9` | **Powershell Attack Vectors**: Use PowerShell-specific exploits (e.g., alphanumeric shellcode, injection). |
| `10` | **SMS Spoofing Attack Vector**: Craft and send spoofed SMS messages. |

## Notes
- **Configuration**: Advanced settings (like enabling Apache instead of the built-in server) are located in `/etc/setoolkit/set.config`.
- **Dependencies**: SET relies heavily on the `metasploit-framework` for payload generation and listeners. Ensure Metasploit is functional.
- **Permissions**: Must be run as `root` or with `sudo` to bind to privileged ports (80, 443) and manage network interfaces.
- **Legal**: Only use this tool on systems and networks you have explicit, written permission to test.