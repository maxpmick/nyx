---
name: zonedb
description: Access and manage a comprehensive database of public DNS zones, including TLDs and subdomains with associated metadata like RDAP URLs, WHOIS servers, and geographic locations. Use when performing DNS reconnaissance, identifying valid domain extensions, verifying name servers, or updating local databases of top-level domains and public suffixes during information gathering.
---

# zonedb

## Overview
A free, open-source database and tool containing a list and associated metadata of public DNS zones (domain name extensions). It includes current, retired, and withdrawn TLDs and subdomains. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt install zonedb
```

## Common Workflows

### List all Top-Level Domains (TLDs)
```bash
zonedb -tlds -list
```

### Filter zones by specific tags and export
```bash
zonedb -tags "generic,infrastructure" -list
```

### Update the local root zone and IANA metadata
```bash
zonedb -update-root -update-iana -w
```

### Search for zones using a regular expression
```bash
zonedb -x "^co\." -list
```

## Complete Command Reference

```bash
zonedb [arguments] <command>
```

### Arguments

| Flag | Description |
|------|-------------|
| `-add-languages string` | Add BCP 47 language tags to zones (comma-delimited) |
| `-add-locations string` | Add locations to zones (comma-delimited) |
| `-add-rdap-url string` | Add RDAP URL to zones |
| `-add-tags string` | Add tags to zones (comma-delimited) |
| `-c int` | Number of concurrent connections (default 32) |
| `-dir string` | Data directory (location of zones.txt and metadata dir) (default "/var/lib/zonedb") |
| `-exclude-tags string` | Exclude working zones with tags (comma-delimited) |
| `-generate-go` | Generate Go source code to specified directory |
| `-grep string` | Filter working zones by regular expression across all metadata |
| `-guess-languages` | Guess BCP 47 languages for zones |
| `-list` | List working zones |
| `-list-locations` | List locations in working zones |
| `-list-tags` | List tags in working zones |
| `-list-wildcards` | List zones with wildcarded DNS |
| `-ps` | Check against Public Suffix List |
| `-remove-locations string` | Remove locations from zones (comma-delimited) |
| `-remove-tags string` | Remove tags from zones (comma-delimited) |
| `-set-info-url string` | Set zone(s) info URLs |
| `-tags string` | Filter working zones by tags (comma-delimited) |
| `-tlds` | Work on top-level domains only |
| `-update` | Update all (root zone, whois, IANA data, IDN tables) |
| `-update-iana` | Query IANA for metadata |
| `-update-idn` | Query IANA for IDN tables |
| `-update-info-url` | Update zone(s) info URLs |
| `-update-ns` | Update name servers |
| `-update-rdap` | Query IANA for RDAP URLs |
| `-update-root` | Retrieve updates to the root zone file |
| `-update-ruby-whois` | Query Ruby Whois for whois servers |
| `-update-whois` | Query whois-servers.net for whois servers |
| `-update-wildcards` | Update wildcard IPs |
| `-v` | Enable verbose logging |
| `-verify-ns` | Verify name servers |
| `-verify-whois` | Verify whois servers |
| `-w` | Write zones.txt and metadata |
| `-x string` | Filter working zones by regular expression |
| `-zones string` | Select specific working zones (comma-delimited) |

## Notes
- The default data directory is `/var/lib/zonedb`. Ensure you have appropriate permissions if using the `-w` (write) flag.
- The `-update` flags require an active internet connection to fetch data from IANA and other sources.
- This tool is highly useful for generating custom wordlists for subdomain enumeration based on valid TLDs/suffixes.