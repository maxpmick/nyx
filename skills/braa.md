---
name: braa
description: Mass SNMP scanner capable of querying dozens or hundreds of hosts simultaneously in a single process. Use when performing rapid SNMP reconnaissance, bulk OID enumeration, or mass SNMP SET operations across large network ranges during the information gathering phase.
---

# braa

## Overview
Braa is a high-speed, mass SNMP scanner that implements its own SNMP stack rather than relying on traditional libraries like net-snmp. It is designed for extreme performance and low resource consumption, allowing for simultaneous queries across large IP ranges. Note that it requires numerical OIDs as it does not include an ASN.1 parser. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume braa is already installed. If the command is missing:

```bash
sudo apt install braa
```

## Common Workflows

### SNMP Walk on a single host
Perform a walk starting from the `.1.3.6` OID using the `public` community string:
```bash
braa public@192.168.1.215:.1.3.6.*
```

### Mass SNMP GET across an IP range
Query the system description (`.1.3.6.1.2.1.1.1.0`) for an entire subnet:
```bash
braa public@192.168.1.1-192.168.1.255:.1.3.6.1.2.1.1.1.0
```

### Multiple queries and custom ID tags
Perform a SET and a WALK simultaneously, tagging the output for easier parsing:
```bash
braa public@10.253.101.1:.1.3.6.1.2.1.1.4.0=sadmin/contact,.1.3.6.*/tree
```

### Loading queries from a file
Execute bulk queries defined in a text file (one query per line):
```bash
braa -f queries.txt -t 2 -v
```

## Complete Command Reference

### Usage
```
braa [options] [query1] [query2] ...
```

### Options
| Flag | Description |
|------|-------------|
| `-h` | Show help message |
| `-2` | Claim to be a SNMP2C agent |
| `-v` | Show short summary after doing all queries |
| `-x` | Hexdump octet-strings |
| `-t <s>` | Wait `<s>` seconds for responses |
| `-d <s>` | Wait `<s>` microseconds after sending each packet |
| `-p <s>` | Wait `<s>` milliseconds between subsequent passes |
| `-f <file>` | Load queries from file `<file>` (one per line) |
| `-a <time>` | Quit after `<time>` seconds, independent of progress |
| `-r <rc>` | Retry count (default: 3) |

### Query Format
Queries follow the structure: `[community@]iprange[:port]:oid[=value][/id]`

*   **GET**: `[community@]iprange[:port]:oid[/id]`
*   **WALK**: `[community@]iprange[:port]:oid.*[/id]`
*   **SET**: `[community@]iprange[:port]:oid=value[/id]`

### SET Value Types
When performing a SET query, values must be prepended with a type specifier:
*   `i`: INTEGER
*   `a`: IPADDRESS
*   `s`: OCTET STRING
*   `o`: OBJECT IDENTIFIER

*If the type specifier is missing, braa will attempt to auto-detect the value type.*

## Notes
- **Numerical OIDs Only**: Braa does not resolve MIB names (e.g., use `.1.3.6.1.2.1.1.5.0` instead of `sysName.0`).
- **Speed**: The tool is extremely fast; use the `-d` (delay) flag if you are overwhelming the target network or devices.
- **IP Ranges**: Supports ranges in the format `10.0.0.1-10.0.0.254`.
- **Custom IDs**: The `/id` suffix in queries is useful for labeling output when running multiple different queries at once.