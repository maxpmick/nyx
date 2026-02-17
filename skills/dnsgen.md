---
name: dnsgen
description: Generate a combination of domain names from provided input for DNS reconnaissance and subdomain discovery. It creates permutations based on a wordlist and extracts custom words from the input domains. Use when performing subdomain enumeration, expanding a list of known hosts, or generating potential targets for DNS brute-forcing during information gathering.
---

# dnsgen

## Overview
dnsgen is a Python-based tool that generates potential domain names by combining provided input with a wordlist. It extracts custom words from the input domains themselves and applies permutations to discover hidden subdomains. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume dnsgen is already installed. If you get a "command not found" error:

```bash
sudo apt install dnsgen
```

Dependencies: python3, python3-click, python3-tldextract.

## Common Workflows

### Basic generation from a file
```bash
dnsgen domains.txt
```
Reads domains from `domains.txt` and outputs generated permutations to stdout.

### Piping from other tools
```bash
subfinder -d example.com -silent | dnsgen - > generated_subs.txt
```
Takes discovered subdomains and generates additional candidates for further resolution.

### Using a custom wordlist and length filter
```bash
dnsgen -w /usr/share/wordlists/dnsmap.txt -l 3 domains.txt
```
Uses a specific wordlist and only extracts custom words from the input domains that are at least 3 characters long.

### Fast generation for large datasets
```bash
dnsgen --fast domains.txt
```
Optimizes the generation process for speed when dealing with large input files.

## Complete Command Reference

```
Usage: dnsgen [OPTIONS] FILENAME
```

### Options

| Flag | Description |
|------|-------------|
| `-l, --wordlen INTEGER RANGE` | Min length of custom words extracted from domains. [1<=x<=100] |
| `-w, --wordlist PATH` | Path to custom wordlist. |
| `-f, --fast` | Fast generation mode. |
| `--help` | Show the help message and exit. |

## Notes
- If `FILENAME` is set to `-`, dnsgen will read from standard input (stdin).
- The tool is highly effective when paired with a DNS resolver like `massdns` or `puredns` to verify which of the generated domains actually exist.
- Custom words are extracted per execution from the domains provided in the input, allowing the tool to adapt to the naming conventions of the target organization.