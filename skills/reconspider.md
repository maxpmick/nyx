---
name: reconspider
description: Advanced OSINT framework for scanning IP addresses, emails, websites, and organizations. It aggregates raw data from multiple sources (including Wave, Photon, and Recon Dog) to visualize attack surfaces. Use when performing comprehensive information gathering, digital footprinting, or OSINT investigations during the reconnaissance phase of a penetration test.
---

# reconspider

## Overview
ReconSpider is a comprehensive OSINT framework designed for Infosec Researchers and Penetration Testers. It automates the collection of data regarding IP addresses, emails, websites, and organizations, combining multiple tools to provide a deep look into a target's digital presence. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume reconspider is already installed. If you encounter errors, install it and its dependencies:

```bash
sudo apt update
sudo apt install reconspider
```

**Configuration:**
To unlock full functionality (like Shodan or IPStack lookups), you must add your API keys to the configuration file:
`/etc/reconspider/reconspider.conf`

## Common Workflows

### Start the Interactive Framework
ReconSpider is primarily an interactive tool. Launch it to access the main menu:
```bash
reconspider
```

### IP Address Enumeration
Within the tool, select the IP address scanning option to retrieve geolocation, ISP information, and proxy/VPN detection (using IP2Proxy LITE data).

### Website Reconnaissance
Use the website module to perform automated crawling, header analysis, and DNS enumeration by providing a target URL.

### Email OSINT
Input an email address to check for breaches (via h8mail integration) and associated social media profiles or domain registrations.

## Complete Command Reference

ReconSpider uses a menu-driven interface. Below are the primary modules available within the framework:

### Main Menu Options

| Option | Description |
|--------|-------------|
| **IP Address** | Gathers information about a specific IP, including geolocation, ASN, and proxy status. |
| **Email Address** | Performs OSINT on email addresses, checking for leaks and associated data. |
| **Website** | Comprehensive web reconnaissance including crawling, tech stack detection, and DNS info. |
| **Organization** | Scans for information related to a specific company or organization name. |

### Global Flags

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |

### Dependencies
The tool relies on the following packages for its various modules:
- `h8mail`: Email breach hunting.
- `python3-shodan`: Shodan search engine integration.
- `python3-whois`: Domain ownership information.
- `python3-ip2proxy`: Proxy/VPN detection.
- `python3-nmap`: Port scanning capabilities.
- `python3-gmplot`: Generating Google Maps plots for coordinates.

## Notes
- **API Keys**: Many features will fail or return limited data if Shodan and IPStack API keys are not configured in `/etc/reconspider/reconspider.conf`.
- **Data Volume**: The tool installs over 370MB of data, including local GeoIP and Proxy databases for offline lookups.
- **Integration**: It effectively wrappers the functionality of `Wave`, `Photon`, and `Recon Dog` into a single interface.