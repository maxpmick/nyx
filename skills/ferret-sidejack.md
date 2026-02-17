---
name: ferret-sidejack
description: Extract session cookies and other interesting data from network traffic to facilitate sidejacking attacks. Use when performing session hijacking, sniffing unencrypted web traffic, or feeding data into Hamster for automated session cloning during penetration testing or web application security assessments.
---

# ferret-sidejack

## Overview
Ferret-sidejack is a network sniffing tool designed to extract "interesting" bits from network traffic, specifically session cookies, authentication tokens, and other metadata. It is primarily used to perform sidejacking (session hijacking) by capturing cookies that can be used to impersonate a user. It is often used in conjunction with the "hamster" tool. Category: Sniffing & Spoofing / Web Application Testing.

## Installation (if not already installed)
Assume ferret-sidejack is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install ferret-sidejack
```

## Common Workflows

### Live Sniffing for Session Cookies
Monitor a specific network interface to capture session data in real-time.
```bash
sudo ferret-sidejack -i eth0
```

### Offline Analysis of PCAP Files
Process existing capture files to extract session information. This supports wildcards for batch processing.
```bash
ferret-sidejack -r *.pcap
```

### Feeding Hamster for Sidejacking
Typically, you run ferret to generate a `hamster.txt` file (or similar output) which the Hamster tool then uses to proxy your browser sessions.
```bash
sudo ferret-sidejack -i wlan0
```
*Note: After running this, you would typically launch `hamster` in another terminal to utilize the captured sessions.*

## Complete Command Reference

```
ferret-sidejack [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-i <adapter>` | Sniffs the wire(less) attached to that network adapter. Requires libpcap/winpcap and usually root privileges. |
| `-r <files>` | Read files in off-line mode. Supports wildcards (e.g., `ferret-sidejack -r *.pcap`). Does not require libpcap. |
| `-c <file>` | Reads in more advanced parameters from a configuration file. |
| `-h` | Display the help menu and version information. |

## Notes
- **Sidejacking**: This tool is most effective against unencrypted HTTP traffic. It cannot extract cookies from encrypted HTTPS traffic unless the SSL/TLS layer has been stripped (e.g., using sslstrip).
- **Output**: By default, the tool often creates a file named `hamster.txt` in the current directory containing the captured session information.
- **Permissions**: Capturing live traffic with the `-i` flag requires root or sudo privileges.