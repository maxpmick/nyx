---
name: wifipumpkin3
description: A powerful framework for rogue access point attacks and man-in-the-middle (MITM) operations. Use to create fake Wi-Fi hotspots, capture credentials via captive portals, perform SSL stripping, and intercept wireless traffic. Ideal for red teaming, wireless security auditing, and social engineering during penetration tests.
---

# wifipumpkin3

## Overview
wifipumpkin3 is a comprehensive framework written in Python for mounting rogue access point attacks. It allows security researchers to simulate wireless MITM environments, intercept traffic, and deploy various plugins like captive portals and DNS spoofing. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install wifipumpkin3
```

## Common Workflows

### Start the Interactive Framework
```bash
sudo wifipumpkin3 -i wlan0 -iNet eth0
```
Sets `wlan0` as the AP interface and `eth0` as the internet source.

### Run a Scripted Session
```bash
sudo wifipumpkin3 -p attack_script.pulp
```

### Launch a Captive Portal (Subtool)
```bash
captiveflask -t /path/to/template -p 8080 -rU http://google.com
```

### SSL Stripping for MITM
```bash
sslstrip3 -l 10000 -w log.txt -a
```

## Complete Command Reference

### wifipumpkin3 / wp3
The main framework entry point. Both commands share the same options.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `-i INTERFACE` | Set interface for creating the Access Point |
| `-iNet INTERFACE_NET` | Set interface for sharing internet to the AP |
| `-s SESSION` | Set session for continuing a previous attack |
| `-p, --pulp PULP` | Script interactive sessions with a `.pulp` file |
| `-x, --xpulp XPULP` | Execute commands from a string using `;` as separator |
| `-m, --wireless-mode MODE` | Set wireless mode settings |
| `--no-colors` | Disable terminal colors and effects |
| `--rest` | Run the Wp3 RESTful API |
| `--restport PORT` | Port for RESTful API (default: 1337) |
| `--username USERNAME` | Specify RESTful API username |
| `--password PASSWORD` | Specify RESTful API password |
| `-iNM, --ignore-from-networkmanager` | Set interface to be ignored by Network-Manager |
| `-rNM, --remove-from-networkmanager` | Remove interface from Network-Manager control |
| `-v, --version` | Show program's version number |

### captiveflask
Subtool for creating Flask-based captive portals.

| Flag | Description |
|------|-------------|
| `-t, --tamplate TEMPLATE` | Path to the theme login captive portal template |
| `-s, --static STATIC` | Path of the static files for the webpage |
| `-r, --redirect IP` | IP address of the gateway captive portal |
| `-p, --port PORT` | Port for the captive portal |
| `-rU, --redirect-url URL` | URL to redirect to after user submits credentials |
| `-f, --force-login_successful-template` | Force redirect to `login_successful.html` template |
| `-v, --version` | Show version |

### evilqr3
Subtool for QR code-based phishing/attacks.

| Flag | Description |
|------|-------------|
| `-t, --tamplate TEMPLATE` | Path to the theme login captive portal |
| `-s, --static STATIC` | Path of the static files |
| `-p, --port PORT` | Port for the captive portal |
| `-rU, --redirect-url URL` | URL to redirect to after credential entry |
| `-sa, --server-address IP` | IP address of the gateway captive portal |
| `-mu, --match-useragent UA` | Match specific user agent |
| `-tp, --token-api TOKEN` | Token API for secure requests |
| `-d, --debug` | Enable debug mode |

### phishkin3
Subtool for captive portals using external phishing pages.

| Flag | Description |
|------|-------------|
| `-r, --redirect IP` | IP address of the gateway captive portal |
| `-p, --port PORT` | Port for the captive portal |
| `-cU, --cloud-url-phishing URL` | Cloud URL of the phishing domain page |
| `-rU, --redirect-url URL` | URL to redirect to after credentials are inserted |

### sslstrip3
Fork of sslstrip for transparently hijacking HTTP traffic.

| Flag | Description |
|------|-------------|
| `-w <file>, --write=<file>` | Specify file to log to |
| `-p, --post` | Log only SSL POSTs (default) |
| `-s, --ssl` | Log all SSL traffic to and from server |
| `-a, --all` | Log all SSL and HTTP traffic |
| `-l <port>, --listen=<port>` | Port to listen on (default: 10000) |
| `-f, --favicon` | Substitute a lock favicon on secure requests |
| `-k, --killsessions` | Kill sessions in progress |
| `-t <config>, --tamper <config>`| Enable response tampering with settings from config |
| `-i, --inject` | Inject code into HTML pages using a text file |

## Notes
- **Hardware**: Requires a wireless adapter that supports AP (Master) mode.
- **NetworkManager**: Use the `-iNM` flag to prevent NetworkManager from interfering with the wireless interface during the attack.
- **Permissions**: Must be run with `sudo` or as root to manage network interfaces and iptables.