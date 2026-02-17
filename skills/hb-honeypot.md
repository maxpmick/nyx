---
name: hb-honeypot
description: Deploy a honeypot to detect and deceive attackers attempting to exploit the Heartbleed vulnerability (CVE-2014-0160). It listens on port 443 and responds with bogus SSL heartbeat data, specifically identifying scanners using known exploit patterns and providing a "Rickroll" in the hex dump. Use during defensive operations, threat intelligence gathering, or to identify malicious actors scanning for SSL vulnerabilities.
---

# hb-honeypot

## Overview
hb-honeypot is a Perl-based honeypot script designed to detect and mislead attackers scanning for the Heartbleed vulnerability (CVE-2014-0160). It mimics a vulnerable SSL service on TCP port 443. When it detects the specific byte pattern used by Heartbleed exploit scripts (like the one by Jared Stafford), it logs the attacker's IP and returns a fake memory dump containing a "Rickroll" message. Category: Reconnaissance / Information Gathering (Identification).

## Installation (if not already installed)
Assume hb-honeypot is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install hb-honeypot
```

## Common Workflows

### Standard Honeypot Deployment
Run the honeypot on the default SSL port. This requires root privileges to bind to port 443.
```bash
sudo hb-honeypot
```

### Running via Perl Script
If the binary alias is not in the path, run the script directly:
```bash
sudo perl /usr/bin/hb_honeypot.pl
```

### Monitoring for Scanners
Once running, the tool will output the IP addresses of any host attempting to perform a Heartbleed heartbeat request to the console:
```text
Heartbleed scan detected from: 192.168.1.50
```

## Complete Command Reference

The tool is a simple script with no complex command-line arguments or subcommands. It is invoked directly.

```bash
hb-honeypot
```

**Execution Details:**
- **Default Port:** 443 (TCP)
- **Protocol:** SSL/TLS Heartbeat (Simulated)
- **Detection Trigger:** Matches the byte pattern used in the original `hb-test.py` / `jspenguin` exploit demo.
- **Response:** Returns a bogus SSL heartbeat response containing a hex-encoded "Rickroll" (lyrics to "Never Gonna Give You Up").

## Notes
- **Privileges:** You must run this tool as `root` (or via `sudo`) because it binds to privileged port 443.
- **Conflict:** Ensure no other service (like Apache, Nginx, or another SSL listener) is already bound to port 443 on the interface you wish to use.
- **Scope:** This is a low-interaction honeypot. It does not provide a full SSL handshake or a real web server; it only responds to the heartbeat request specifically.