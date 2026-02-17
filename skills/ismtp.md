---
name: ismtp
description: Test SMTP servers for user enumeration (RCPT TO and VRFY), internal spoofing, and mail relay vulnerabilities. Use during the reconnaissance or vulnerability analysis phases when encountering SMTP services to identify valid usernames or test for misconfigured mail security.
---

# ismtp

## Overview
iSMTP is a tool designed to test SMTP servers for common vulnerabilities and information disclosure. It can perform user enumeration using VRFY and RCPT TO commands, test for internal spoofing capabilities, and check for open relay configurations. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume ismtp is already installed. If the command is not found:

```bash
sudo apt update && sudo apt install ismtp
```

## Common Workflows

### User Enumeration
Enumerate users on a specific host using a wordlist and both VRFY/RCPT TO methods:
```bash
ismtp -h 192.168.1.25:25 -e /usr/share/wordlists/metasploit/unix_users.txt -l 3
```

### Testing for Open Relay
Test if a mail server allows external relaying by providing a consultant email for the test report:
```bash
ismtp -h 192.168.1.25:25 -x -i consultant@example.com
```

### Testing Internal Spoofing
Attempt to send a spoofed email to test internal filtering, including a text attachment:
```bash
ismtp -h 192.168.1.25:25 -m -s "ceo@target.com" -r "employee@target.com" -S "CEO Name" -R "Employee Name" -a
```

### Bulk Testing from File
Run enumeration against a list of SMTP servers and save results to a directory:
```bash
ismtp -f smtp_servers.txt -e users.txt -o
```

## Complete Command Reference

```bash
ismtp <OPTIONS>
```

### Required Options (Must choose one)
| Flag | Description |
|------|-------------|
| `-f <import file>` | Imports a list of SMTP servers for testing. (Cannot use with `-h`) |
| `-h <host>` | The target IP and port (format: `IP:port`). (Cannot use with `-f`) |

### Spoofing Options
| Flag | Description |
|------|-------------|
| `-i <email>` | The consultant's email address (used for relay/spoof reports) |
| `-s <email>` | The sender's email address |
| `-r <email>` | The recipient's email address |
| `--sr <email>` | Specifies both the sender's and recipient's email address as the same value |
| `-S <name>` | The sender's first and last name |
| `-R <name>` | The recipient's first and last name |
| `--SR <name>` | Specifies both the sender's and recipient's first and last name as the same value |
| `-m` | Enables SMTP spoof testing |
| `-a` | Includes a `.txt` attachment with the spoofed email |

### SMTP Enumeration Options
| Flag | Description |
|------|-------------|
| `-e <file>` | Enable SMTP user enumeration testing and imports email/username list |
| `-l <1\|2\|3>` | Specifies enumeration type: `1` = VRFY, `2` = RCPT TO, `3` = All (Default: 3) |

### SMTP Relay Options
| Flag | Description |
|------|-------------|
| `-i <email>` | The consultant's email address |
| `-x` | Enables SMTP external relay testing |

### Miscellaneous Options
| Flag | Description |
|------|-------------|
| `-t <secs>` | The timeout value in seconds (Default: 10) |
| `-o` | Creates "ismtp-results" directory and writes output to `ismtp-results/smtp_<service>_<ip>(port).txt` |

## Notes
- Any combination of options is supported (e.g., you can run enumeration and relay tests simultaneously).
- When using `-h`, ensure the port is specified (e.g., `10.0.0.1:25`).
- Results generated with the `-o` flag are organized by IP and port for easy reference during reporting.