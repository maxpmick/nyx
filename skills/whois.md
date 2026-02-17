---
name: whois
description: Query online servers for domain registration details, IP address assignments, and contact information using the WHOIS protocol. Use when performing reconnaissance, identifying domain ownership, investigating IP netblocks, or gathering administrative/technical contact data during information gathering.
---

# whois

## Overview
An intelligent WHOIS client that automatically selects the appropriate server to query for domain and network resource information. It also includes `mkpasswd`, a front-end for the `crypt(3)` password encryption function. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install whois
```

## Common Workflows

### Standard Domain Lookup
```bash
whois example.com
```
Automatically identifies the correct registrar or registry server and fetches the record.

### Query a Specific Host or IP
```bash
whois 1.1.1.1
```
Retrieves ASN and network range information from regional internet registries (RIRs) like ARIN, RIPE, or APNIC.

### Force a Specific WHOIS Server
```bash
whois -h whois.nic.it google.it
```

### Generate a Password Hash (mkpasswd)
```bash
mkpasswd -m sha-512 -s MySalt123
```
Prompts for a password and returns a SHA-512 hashed string using the provided salt.

## Complete Command Reference

### whois
Client for the WHOIS directory service.

```
whois [OPTION]... OBJECT...
```

| Flag | Description |
|------|-------------|
| `-h HOST`, `--host HOST` | Connect to server HOST |
| `-p PORT`, `--port PORT` | Connect to specified PORT |
| `-I` | Query `whois.iana.org` and follow its referral |
| `-H` | Hide legal disclaimers |
| `--verbose` | Explain what is being done (useful for debugging server selection) |
| `--no-recursion` | Disable recursion from registry to registrar servers |
| `--help` | Display help and exit |
| `--version` | Output version information and exit |

**RIPE-specific Flags** (Supported by `whois.ripe.net` and similar servers):

| Flag | Description |
|------|-------------|
| `-l` | Find the one level less specific match |
| `-L` | Find all levels less specific matches |
| `-m` | Find all one level more specific matches |
| `-M` | Find all levels of more specific matches |
| `-c` | Find the smallest match containing a `mnt-irt` attribute |
| `-x` | Exact match |
| `-b` | Return brief IP address ranges with abuse contact |
| `-B` | Turn off object filtering (show email addresses) |
| `-G` | Turn off grouping of associated objects |
| `-d` | Return DNS reverse delegation objects too |
| `-i ATTR[,ATTR]...` | Do an inverse look-up for specified ATTRibutes |
| `-T TYPE[,TYPE]...` | Only look for objects of TYPE |
| `-K` | Only primary keys are returned |
| `-r` | Turn off recursive look-ups for contact information |
| `-R` | Force to show local copy of the domain object even if it contains referral |
| `-a` | Also search all the mirrored databases |
| `-s SOURCE[,SOURCE]...` | Search the database mirrored from SOURCE |
| `-g SOURCE:FIRST-LAST` | Find updates from SOURCE from serial FIRST to LAST |
| `-t TYPE` | Request template for object of TYPE |
| `-v TYPE` | Request verbose template for object of TYPE |
| `-q [version\|sources\|types]` | Query specified server info |

### mkpasswd
Front-end to the `crypt(3)` password encryption function.

```
mkpasswd [OPTIONS]... [PASSWORD [SALT]]
```

| Flag | Description |
|------|-------------|
| `-m`, `--method=TYPE` | Select encryption method TYPE (e.g., md5, sha-256, sha-512) |
| `-5` | Shortcut for `--method=md5crypt` |
| `-S`, `--salt=SALT` | Use the specified SALT |
| `-R`, `--rounds=NUMBER` | Use the specified NUMBER of rounds |
| `-P`, `--password-fd=NUM` | Read password from file descriptor NUM instead of `/dev/tty` |
| `-s`, `--stdin` | Read password from stdin (equivalent to `--password-fd=0`) |
| `-h`, `--help` | Display help and exit |
| `-V`, `--version` | Output version information and exit |

## Notes
- If `PASSWORD` is missing for `mkpasswd`, it is requested interactively.
- If no `SALT` is specified for `mkpasswd`, a random one is generated.
- Use `mkpasswd -m help` to see all available encryption methods on the current system.
- Many WHOIS servers implement rate limiting; excessive queries may result in temporary IP bans.