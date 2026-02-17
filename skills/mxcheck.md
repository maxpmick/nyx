---
name: mxcheck
description: Perform information gathering and security scanning on e-mail servers. It checks DNS records (A, MX, PTR, SPF, MTA-STS, DKIM, DMARC), identifies AS information, scans for open SMTP ports, tests for open relays, checks blacklists, and probes for information leaks via server strings or the VRFY command. Use this tool during the reconnaissance or vulnerability analysis phase when auditing mail server configurations and security posture.
---

# mxcheck

## Overview
mxcheck is an info and security scanner for e-mail servers. It automates the verification of DNS-based mail security records, checks for common misconfigurations like open relays, and identifies potential information leaks. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume mxcheck is already installed. If the command is not found, install it using:

```bash
sudo apt install mxcheck
```

## Common Workflows

### Basic scan of a mail domain
```bash
mxcheck -s example.com
```

### Comprehensive scan including blacklist checks and DKIM verification
```bash
mxcheck -s example.com -b --dkim-selector google
```

### Automated scan with custom DNS and no prompts
```bash
mxcheck -s example.com -d 1.1.1.1 -n --write-tsv
```

### Testing for Open Relay with custom addresses
```bash
mxcheck -s mail.example.com -f sender@attacker.com -t victim@internal.corp
```

## Complete Command Reference

```
mxcheck [options]
```

| Flag | Description |
|------|-------------|
| `-b, --blacklist` | Check if the service/IP is listed on common blacklists |
| `-p, --disable-port-scan` | Disable the SMTP port scan (ports 25, 465, 587) |
| `-S, --dkim-selector <string>` | The DKIM selector. If set, a DKIM check is performed on the provided service domain |
| `-d, --dnsserver <string>` | The DNS server to be requested for lookups (default "8.8.8.8") |
| `-f, --mailfrom <string>` | Set the `MAIL FROM` address for relay/VRFY testing (default "info@foo.wtf") |
| `-t, --mailto <string>` | Set the `RCPT TO` address for relay testing (default "info@baz.wtf") |
| `-n, --no-prompt` | Answer yes to all questions (non-interactive mode) |
| `-s, --service <string>` | The service host or domain to check |
| `-u, --updatecheck` | Check for a new version of mxcheck |
| `-v, --version` | Display version and license information |
| `-w, --write-tsv` | Write a TSV (Tab-Separated Values) formatted report to a file |

## Notes
- The tool checks for several DNS records critical to mail security: A, MX, PTR, SPF, MTA-STS, DKIM, and DMARC.
- It attempts to identify the Autonomous System (AS) Number and Country of the target.
- It probes for StartTLS support and validates the presented SSL/TLS certificate.
- Security tests include checking for the `VRFY` command (user enumeration) and testing if the server acts as an **Open Relay**.