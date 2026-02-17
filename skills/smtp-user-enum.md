---
name: smtp-user-enum
description: Enumerate valid users on an SMTP server by leveraging the EXPN, VRFY, or RCPT TO commands. Use during the reconnaissance or vulnerability analysis phases of a penetration test to discover valid usernames or email addresses for further attacks like password spraying or phishing.
---

# smtp-user-enum

## Overview
`smtp-user-enum` is a username guessing tool primarily designed for use against SMTP services (originally targeting Solaris, but effective against many others). It identifies valid users by checking how the server responds to specific SMTP commands. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing, install it via:

```bash
sudo apt update && sudo apt install smtp-user-enum
```

## Common Workflows

### Single User Verification
Check if a specific user exists on a target server using the default VRFY method:
```bash
smtp-user-enum -u admin -t 192.168.1.25
```

### Bulk Enumeration via Wordlist
Scan a target for multiple usernames using a list and the RCPT TO method:
```bash
smtp-user-enum -M RCPT -U /usr/share/wordlists/metasploit/unix_users.txt -t 10.0.0.1
```

### Email Address Discovery
Append a domain to usernames to guess valid email addresses instead of just local system accounts:
```bash
smtp-user-enum -D example.com -U users.txt -t 10.0.0.1
```

### Multi-Target Scanning
Scan multiple mail servers for a specific administrative account:
```bash
smtp-user-enum -u root -T mail-servers.txt
```

## Complete Command Reference

```
smtp-user-enum [options] ( -u username | -U file-of-usernames ) ( -t host | -T file-of-targets )
```

### Required Arguments (Must choose one user and one target option)

| Flag | Description |
|------|-------------|
| `-u <user>` | Check if a single specific username exists on the remote system |
| `-U <file>` | File containing a list of usernames to check |
| `-t <host>` | Server hostname or IP address running the SMTP service |
| `-T <file>` | File containing a list of hostnames/IPs running the SMTP service |

### Options

| Flag | Description |
|------|-------------|
| `-m <n>` | Maximum number of processes to run in parallel (default: 5) |
| `-M <mode>` | Method to use for username guessing: `EXPN`, `VRFY`, or `RCPT` (default: VRFY) |
| `-f <addr>` | MAIL FROM email address. Used only in "RCPT TO" mode (default: user@example.com) |
| `-D <dom>` | Domain to append to supplied usernames to create email addresses (e.g., `-D example.com` turns `foo` into `foo@example.com`) |
| `-p <port>` | TCP port on which the SMTP service runs (default: 25) |
| `-d` | Enable debugging output |
| `-w <n>` | Wait a maximum of `n` seconds for a reply from the server (default: 5) |
| `-v` | Verbose output |
| `-h` | Display the help message |

## Notes
- **Method Selection**: Many modern SMTP servers disable `VRFY` and `EXPN` for security. If these fail, try `-M RCPT`, which mimics the start of an email delivery process and is often more successful.
- **Rate Limiting**: High values for `-m` (processes) may trigger rate-limiting or security alerts on the target server.
- **False Positives**: Some servers are configured to "Catch-All" or always return a positive response regardless of whether the user exists. Always verify results manually if every name in a list returns as "exists."