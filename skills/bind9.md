---
name: bind9
description: A comprehensive suite of DNS (Domain Name System) tools including the named server, administration utilities, and diagnostic clients like dig and nslookup. Use for configuring DNS servers, performing advanced DNS queries, validating DNSSEC signatures, managing zone files, and troubleshooting domain resolution issues.
---

# bind9

## Overview
BIND (Berkeley Internet Name Domain) is the most widely used DNS software. This skill covers the server (`named`), administration tools (`rndc`, `dnssec-*`), and client utilities (`dig`, `host`, `nslookup`, `delv`). Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume BIND9 is installed. If commands are missing:
```bash
sudo apt install bind9 bind9utils bind9-dnsutils
```

## Common Workflows

### Advanced DNS Query with dig
```bash
dig @8.8.8.8 example.com A +dnssec +multiline
```
Queries Google DNS for the A record of example.com, requesting DNSSEC records and displaying them in a readable format.

### Zone File Syntax Check
```bash
named-checkzone example.com /etc/bind/db.example.com
```
Validates the syntax and integrity of a DNS zone file before loading it into the server.

### Remote Server Management
```bash
rndc status
rndc reload example.com
```
Checks the status of the local `named` daemon and reloads a specific zone.

### DNSSEC Key Generation
```bash
dnssec-keygen -a RSASHA256 -b 2048 -n ZONE example.com
```
Generates a ZSK (Zone Signing Key) for the specified domain.

## Complete Command Reference

### Client Utilities

#### dig (Domain Information Groper)
`dig [@server] [domain] [q-type] [q-class] {q-opt} {d-opt}`

**Query Options (q-opt):**
- `-4`, `-6`: Use IPv4 or IPv6 only.
- `-b address[#port]`: Bind to source address/port.
- `-c class`: Specify query class (IN, CH, HS).
- `-f filename`: Batch mode from file.
- `-k keyfile`: TSIG key file.
- `-p port`: Specify port number.
- `-q name`: Specify query name.
- `-r`: Do not read `~/.digrc`.
- `-t type`: Specify query type (A, MX, SOA, etc.).
- `-u`: Display times in microseconds.
- `-x addr`: Reverse lookup shortcut.
- `-y [hmac:]name:key`: Named base64 TSIG key.

**Display Options (d-opt) `+[no]keyword`:**
- `all`, `answer`, `authority`, `additional`, `comments`, `stats`: Control section display.
- `dnssec`: Request DNSSEC records.
- `multiline`: Expanded format.
- `short`: Answer only.
- `trace`: Trace delegation from root.
- `yaml`: Output as YAML.
- `tcp`: Use TCP mode.

#### host
`host [-aCdilrTvVw] [-c class] [-t type] hostname [server]`
- `-a`: Equivalent to `-v -t ANY`.
- `-l`: List all hosts in a domain (AXFR).
- `-r`: Disable recursion.
- `-T`: Use TCP.

#### nslookup
`nslookup [-option] [name | -] [server]`
- `set type=X`: Set query type (A, MX, etc.).
- `set debug`: Enable debugging.
- `set recurse`: Enable recursion.

#### delv (DNS Look-up and Validation)
`delv [@server] [domain] [q-type] [-a anchor-file] [-i]`
- `-a`: Specify root trust anchor.
- `-i`: Disable DNSSEC validation.

### Server & Admin Tools

#### named (The Daemon)
`named [-4|-6] [-c conffile] [-d debuglevel] [-f|-g] [-p port] [-t chrootdir] [-u user]`
- `-f`: Run in foreground.
- `-g`: Run in foreground and log to stderr.
- `-c`: Path to configuration file.

#### rndc (Name Server Control)
`rndc [-s server] [-p port] [-y key] command`
- `status`: Display server status.
- `reload [zone]`: Reload config/zone.
- `freeze/thaw [zone]`: Suspend/Resume updates.
- `flush [view]`: Flush cache.
- `addzone/delzone`: Dynamic zone management.

#### dnssec-keygen
`dnssec-keygen [options] name`
- `-a <alg>`: Algorithm (RSASHA256, ECDSAP256SHA256, ED25519, etc.).
- `-b <bits>`: Key size.
- `-n <type>`: ZONE, HOST, ENTITY, USER, or OTHER.
- `-f <flag>`: KSK, ZSK, or REVOKE.
- `-K <dir>`: Output directory.

#### dnssec-signzone
`dnssec-signzone [options] zonefile [keys]`
- `-S`: Smart signing (auto-find keys).
- `-o <origin>`: Zone origin name.
- `-e <time>`: RRSIG end time.
- `-3 <salt>`: NSEC3 salt.

#### named-checkconf / named-checkzone
- `named-checkconf [-z] [filename]`: Check `named.conf` syntax. `-z` attempts to load all master zones.
- `named-checkzone <zonename> <filename>`: Check zone file validity.

### Helper Utilities

| Tool | Description |
|------|-------------|
| `arpaname` | Translate IP to `.arpa` name. |
| `ddns-confgen` | Generate keys for DDNS. |
| `dnssec-dsfromkey` | Generate DS records from a keyset. |
| `dnssec-importkey` | Import external DNSKEYs. |
| `dnssec-settime` | Set key timing metadata. |
| `named-journalprint` | Print zone journal files. |
| `named-rrchecker` | Check individual RR syntax. |
| `nsec3hash` | Generate NSEC3 hashes. |
| `tsig-keygen` | Generate TSIG keys for server auth. |

## Notes
- **Security**: Always run `named-checkconf` before restarting the BIND service to prevent downtime.
- **Permissions**: Ensure the user running `named` (usually `bind`) has read access to config files and write access to directories for dynamic zones or journals.
- **DNSSEC**: When signing zones, keep track of key expiration dates to avoid validation failures.