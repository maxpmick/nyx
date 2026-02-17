---
name: dnschef
description: Highly configurable DNS proxy for penetration testers and malware analysts. It intercepts DNS queries and returns fake responses for specific domains while proxying others to real DNS servers. Use during traffic analysis, malware analysis, or exploitation to redirect application traffic to controlled infrastructure.
---

# dnschef

## Overview
DNSChef is a "Fake DNS" proxy used for application network traffic analysis. It allows a tester to intercept DNS requests and redirect them to arbitrary IP addresses. It is essential for forcing applications or malware to communicate with a local or controlled server instead of their intended production destinations. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume dnschef is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install dnschef
```

## Common Workflows

### Spoof all A records to a single IP
Redirect every DNS lookup to a local listener for broad traffic interception.
```bash
sudo dnschef --fakeip 192.168.1.100
```

### Spoof specific domains only
Only intercept traffic for specific targets while allowing other DNS requests to resolve normally.
```bash
sudo dnschef --fakedomains target.com,api.target.com --fakeip 10.0.0.5
```

### Use a configuration file for multiple records
Manage complex redirection rules using a file containing `domain=ip` pairs.
```bash
sudo dnschef --file hosts.txt --interface 0.0.0.0
```

### Reverse logic: Spoof everything EXCEPT specific domains
Redirect all traffic except for critical infrastructure domains.
```bash
sudo dnschef --truedomains google.com,microsoft.com --fakeip 192.168.1.100
```

## Complete Command Reference

```
dnschef [options]
```

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--fakedomains <list>` | Comma separated list of domains to resolve to FAKE values. All others resolve to TRUE values. |
| `--truedomains <list>` | Comma separated list of domains to resolve to TRUE values. All others resolve to FAKE values. |

### Fake DNS Records
| Flag | Description |
|------|-------------|
| `--fakeip <IP>` | IPv4 address to use for matching 'A' queries. |
| `--fakeipv6 <IPv6>` | IPv6 address to use for matching 'AAAA' queries. |
| `--fakemail <name>` | MX name to use for matching 'MX' queries. |
| `--fakealias <name>` | CNAME name to use for matching 'CNAME' queries. |
| `--fakens <name>` | NS name to use for matching 'NS' queries. |
| `--file <FILE>` | Specify a file containing `DOMAIN=IP` pairs (one per line). Takes precedence over other arguments. |

### Runtime Parameters
| Flag | Description |
|------|-------------|
| `--logfile <FILE>` | Specify a log file to record all activity. |
| `--nameservers <list>` | Comma separated list of upstream DNS servers (e.g., `8.8.8.8#53` or `4.2.2.1#53#tcp`). Default: 8.8.8.8 (IPv4) or 2001:4860:4860::8888 (IPv6). |
| `-i`, `--interface <IP>` | Interface to listen on. Default: 127.0.0.1 (IPv4) or ::1 (IPv6). |
| `-t`, `--tcp` | Use TCP DNS proxy instead of the default UDP. |
| `-6`, `--ipv6` | Run in IPv6 mode. |
| `-p`, `--port <port>` | Port number to listen for DNS requests. Default: 53. |
| `-q`, `--quiet` | Don't show headers/banners. |

## Notes
- **Root Privileges**: Running on the default DNS port (53) requires `sudo`.
- **Client Configuration**: You must manually configure the target device's DNS settings or use a technique like ARP spoofing to point the target's DNS traffic to the machine running DNSChef.
- **Precedence**: Data obtained from the `--file` argument takes precedence over command-line flags like `--fakeip`.