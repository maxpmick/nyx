---
name: dnswalk
description: Debug DNS zone information by performing zone transfers and checking for internal consistency and accuracy. Use when performing DNS reconnaissance, verifying zone file integrity, identifying misconfigured nameservers, or checking for lame delegations during information gathering.
---

# dnswalk

## Overview
dnswalk is a DNS debugger that performs zone transfers of specified domains and checks the database for internal consistency and accuracy. It identifies common errors such as lame delegations, missing PTR records, and inconsistent CNAME records. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume dnswalk is already installed. If you get a "command not found" error:

```bash
sudo apt install dnswalk
```

Dependencies: libnet-dns-perl, perl.

## Common Workflows

### Basic Zone Check
Perform a standard check on a domain. The domain name must end with a dot.
```bash
dnswalk example.com.
```

### Recursive Domain Debugging
Recursively check subdomains and print debugging information to stderr.
```bash
dnswalk -r -d example.com.
```

### Forward and Reverse Consistency Check
Check for missing PTR records and ensure forward/reverse lookups match.
```bash
dnswalk -f -i example.com.
```

## Complete Command Reference

```bash
dnswalk [-r -f -i -a -d -m -F -l] [-D <level>] domain.
```

**Note:** The domain argument **must** end with a trailing dot (`.`).

### Options

| Flag | Type | Description |
|------|------|-------------|
| `-r` | Boolean | Recursively descend sub-domains of the specified domain. |
| `-f` | Boolean | Perform "forward" checks. Check that A records have corresponding PTR records. |
| `-i` | Boolean | Check for invalid characters in domain names. |
| `-a` | Boolean | Check for duplicate A records. |
| `-d` | Boolean | Print debugging information to stderr. |
| `-m` | Boolean | Check if the MX record points to a host that has an A record (not a CNAME). |
| `-F` | Boolean | Perform "fancy" checks. Includes checking for consistent TTLs and other advanced validation. |
| `-l` | Boolean | Check for "lame delegations" (nameservers listed in the zone that do not answer authoritatively). |
| `-D <level>` | Argument | Set debugging level to the specified value. |
| `--` | Special | Stop processing options. Useful if the domain name starts with a hyphen. |

## Notes
- **Trailing Dot**: dnswalk strictly requires the domain name to end with a dot (e.g., `example.com.` instead of `example.com`).
- **Zone Transfers**: This tool relies on the ability to perform AXFR (zone transfers). If the target nameserver restricts zone transfers, dnswalk will be unable to retrieve the records for analysis.
- **Perl Warnings**: You may see "Old package separator" warnings on modern Kali installations; these are typically non-fatal and related to the tool's age.