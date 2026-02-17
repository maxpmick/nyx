---
name: sprayingtoolkit
description: A suite of Python scripts designed to perform efficient password spraying attacks against Microsoft Lync/Skype for Business (S4B), Outlook Web Access (OWA), and Office 365 (O365). Use this toolkit during the exploitation or post-exploitation phases to gain initial access or escalate privileges by testing common passwords against a list of discovered usernames across web-based mail and communication portals.
---

# sprayingtoolkit

## Overview
SprayingToolkit is a collection of utilities (atomizer, spindrift, aerosol, vaporizer) specifically tailored for password spraying Microsoft infrastructure. It automates the process of validating credentials against OWA, Lync, and IMAP endpoints while managing timing intervals to avoid account lockouts. Category: Exploitation / Password Attacks.

## Installation (if not already installed)
The toolkit is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update
sudo apt install sprayingtoolkit
```

## Common Workflows

### Discover Internal Domain via OWA
Before spraying, use `spindrift` to attempt to leak the internal domain name from an OWA target.
```bash
spindrift --target https://mail.example.com/owa
```

### Password Spraying OWA with a Single Password
Spray a single password against a list of users to minimize lockout risks.
```bash
atomizer owa mail.example.com "Winter2023!" users.txt --threads 5
```

### Interval-based Spraying (Slow and Stealthy)
Spray multiple passwords from a file with a specific time delay between attempts to bypass lockout policies.
```bash
atomizer lync lyncdiscover.example.com passwords.txt users.txt --interval "00:30:00"
```

### Generate Usernames from Full Names
Convert a list of names into a specific username format (e.g., first initial + last name).
```bash
cat names.txt | spindrift --domain example.com --format "{f}{last}" > users.txt
```

## Complete Command Reference

### atomizer
The primary execution script for performing the spray.

**Usage Patterns:**
- `atomizer (lync|owa|imap) <target> <password> <userfile> [options]`
- `atomizer (lync|owa|imap) <target> <passwordfile> <userfile> --interval <TIME> [options]`
- `atomizer (lync|owa|imap) <target> --csvfile CSVFILE [options]`
- `atomizer (lync|owa|imap) <target> --user-as-pass USERFILE [options]`
- `atomizer (lync|owa|imap) <target> --recon [options]`

**Arguments:**
- `target`: Target domain or URL.
- `password`: Single password to spray.
- `userfile`: File containing usernames (one per line).
- `passwordfile`: File containing passwords (one per line).

**Options:**
- `-h, --help`: Show help screen.
- `-v, --version`: Show version.
- `-c, --csvfile CSVFILE`: CSV file containing usernames and passwords.
- `-i, --interval TIME`: Spray at specified interval [format: "H:M:S"].
- `-t, --threads THREADS`: Number of concurrent threads [default: 3].
- `-d, --debug`: Enable debug output.
- `-p, --targetPort PORT`: Target port for IMAP server [default: 993].
- `--recon`: Only collect info, do not perform the spray.
- `--gchat URL`: GChat webhook URL for notifications.
- `--slack URL`: Slack webhook URL for notifications.
- `--user-row-name NAME`: Username row title in CSV [default: Email Address].
- `--pass-row-name NAME`: Password row title in CSV [default: Password].
- `--user-as-pass USERFILE`: Use the usernames in the specified file as the password.

---

### spindrift
Used for username generation and infrastructure reconnaissance.

**Usage:**
`spindrift [<file>] [--target TARGET | --domain DOMAIN] [--format FORMAT]`

**Arguments:**
- `file`: File containing names (can also read from stdin).

**Options:**
- `--target TARGET`: Optional domain or URL to retrieve the internal domain name from OWA.
- `--domain DOMAIN`: Manually specify the domain to append to each username.
- `--format FORMAT`: Username format [default: {f}{last}]. Common variables: `{first}`, `{last}`, `{f}`, `{l}`.

---

### sprayingtoolkit (Wrapper/Info)
The main package entry point lists the available scripts located in `/usr/share/sprayingtoolkit`:
- `aerosol.py`
- `atomizer.py`
- `core/`
- `spindrift.py`
- `vaporizer.py`

## Notes
- **Lockout Policy**: Always verify the target's account lockout policy before spraying. Use the `--interval` flag in `atomizer` to stay below the threshold.
- **Lync/S4B**: When targeting Lync, use the `lyncdiscover` or `autodiscover` subdomains as the target.
- **IMAP**: The IMAP module defaults to port 993 (SSL/TLS). If the target uses a different port, specify it with `-p`.