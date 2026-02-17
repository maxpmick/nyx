---
name: dmitry
description: Perform deep information gathering on a host including WHOIS lookups (IP and domain), Netcraft info retrieval, subdomain discovery, email address harvesting, and TCP port scanning. Use when performing initial reconnaissance, footprinting, or external infrastructure auditing during the information gathering phase of a penetration test.
---

# dmitry

## Overview
DMitry (Deepmagic Information Gathering Tool) is a command-line application written in C for gathering as much information as possible about a host. It consolidates multiple lookup functions into a single tool, including subdomain discovery and port scanning. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume dmitry is already installed. If you get a "command not found" error:

```bash
sudo apt install dmitry
```

## Common Workflows

### Comprehensive Reconnaissance
Perform all lookups (WHOIS, Netcraft, subdomains, emails) and a port scan, saving results to a file:
```bash
dmitry -winsep -o results.txt example.com
```

### Quick Subdomain and Email Harvest
Search for subdomains and email addresses associated with a target domain:
```bash
dmitry -se example.com
```

### Port Scan with Banner Grabbing
Perform a TCP port scan on a host, reporting filtered ports and grabbing service banners with a 5-second TTL:
```bash
dmitry -pfb -t 5 example.com
```

## Complete Command Reference

```
Usage: dmitry [-winsepfb] [-t 0-9] [-o %host.txt] host
```

### Options

| Flag | Description |
|------|-------------|
| `-o` | Save output to `%host.txt` or to a file specified by `-o file` |
| `-i` | Perform a whois lookup on the IP address of a host |
| `-w` | Perform a whois lookup on the domain name of a host |
| `-n` | Retrieve Netcraft.com information on a host |
| `-s` | Perform a search for possible subdomains |
| `-e` | Perform a search for possible email addresses |
| `-p` | Perform a TCP port scan on a host |
| `-f` | Perform a TCP port scan on a host showing output reporting filtered ports (Requires `-p`) |
| `-b` | Read in the banner received from the scanned port (Requires `-p`) |
| `-t 0-9` | Set the TTL in seconds when scanning a TCP port (Default: 2) |

## Notes
- The `-f` and `-b` flags are modifiers for the port scan and will not function unless the `-p` flag is also provided.
- DMitry relies on external sources (like Netcraft and WHOIS servers) for much of its data; connectivity to these services is required for full functionality.
- Subdomain and email searches are performed via search engine scraping and public records.