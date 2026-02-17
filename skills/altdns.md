---
name: altdns
description: Discover subdomains through alterations and permutations by taking a list of known subdomains and mutating them using a wordlist. Use when performing DNS reconnaissance, subdomain discovery, or expanding the attack surface during penetration testing by identifying non-obvious subdomains like dev, staging, or test variations.
---

# altdns

## Overview
Altdns is a DNS reconnaissance tool that generates potential subdomain names by applying alterations and permutations to a known list of subdomains. It uses a wordlist of common patterns (e.g., "dev", "test", "staging") to create a massive list of mutated subdomains which can then be resolved to find hidden infrastructure. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume altdns is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install altdns
```

## Common Workflows

### Generate mutated subdomains
```bash
altdns -i known_subdomains.txt -o mutated_list.txt -w words.txt
```
Takes a list of known subdomains and a wordlist to generate a list of potential subdomains without resolving them.

### Generate and resolve subdomains
```bash
altdns -i known_subdomains.txt -o mutated.txt -w words.txt -r -s resolved_subdomains.txt
```
Generates the mutations and immediately attempts to resolve them, saving only the valid ones to `resolved_subdomains.txt`.

### Use with numeric permutations and custom DNS
```bash
altdns -i subdomains.txt -o output.txt -w words.txt -n -d 8.8.8.8 -r -s results.txt
```
Adds numeric suffixes (0-9) to the mutations and uses Google's DNS server for resolution.

## Complete Command Reference

```
altdns [-h] -i INPUT -o OUTPUT [-w WORDLIST] [-r] [-n] [-e] [-d DNSSERVER] [-s SAVE] [-t THREADS]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-i`, `--input INPUT` | **Required.** File containing the list of known subdomains |
| `-o`, `--output OUTPUT` | **Required.** Output location for the generated altered subdomains |
| `-w`, `--wordlist WORDLIST` | List of words to use for altering/mutating the subdomains |
| `-r`, `--resolve` | Resolve all altered subdomains to check if they exist |
| `-n`, `--add-number-suffix` | Add a number suffix (0-9) to every generated domain |
| `-e`, `--ignore-existing` | Ignore existing domains found in the input file |
| `-d`, `--dnsserver DNSSERVER` | IP address of the DNS resolver to use (overrides system default) |
| `-s`, `--save SAVE` | File to save the successfully resolved altered subdomains to |
| `-t`, `--threads THREADS` | Number of threads to run simultaneously for resolution |

## Notes
- The tool is highly effective at finding development or staging environments that follow predictable naming conventions (e.g., `api-dev.example.com` vs `api-test.example.com`).
- When using the `-r` (resolve) flag, it is recommended to increase the number of threads (`-t`) for faster performance, but be mindful of the load on the DNS resolver.
- The output file specified by `-o` can become very large depending on the size of the input list and wordlist.