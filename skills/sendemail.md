---
name: sendemail
description: Send emails from the command line via SMTP. Use when automating email notifications in scripts, testing SMTP relay configurations, performing social engineering simulations (phishing tests), or exfiltrating small amounts of data via email during penetration testing.
---

# sendemail

## Overview
sendEmail is a lightweight, completely command line based SMTP email agent written in Perl. It is designed to be easily integrated into bash scripts and programs to send emails without requiring a complex local mail server setup. Category: Social Engineering / Information Gathering.

## Installation (if not already installed)
Assume sendemail is already installed. If you get a "command not found" error:

```bash
sudo apt install sendemail
```

## Common Workflows

### Send a simple email via a remote SMTP server
```bash
sendemail -f sender@example.com -t victim@target.com -u "Security Alert" -m "Please review your account activity." -s smtp.example.com:587 -xu username -xp password
```

### Send an email with an attachment
```bash
sendemail -f admin@company.com -t user@company.com -u "Report" -m "See attached file." -a /path/to/report.pdf -s localhost:25
```

### Send an HTML email from a file
```bash
sendemail -f news@site.com -t subscriber@site.com -u "Weekly Update" -o message-file=newsletter.html -o message-content-type=html -s smtp.site.com
```

### Send to multiple recipients (To, CC, BCC)
```bash
sendemail -f dev@project.com -t lead@project.com dev-list@project.com -cc manager@project.com -bcc archive@project.com -u "Build Success" -m "The latest build passed all tests."
```

## Complete Command Reference

### Required Arguments
| Flag | Description |
|------|-------------|
| `-f ADDRESS` | From (sender) email address |
| `-t ADDRESS [ADDR ...]` | To email address(es). At least one recipient required via `-t`, `-cc`, or `-bcc` |
| `-m MESSAGE` | Message body. Required via `-m`, STDIN, or `-o message-file=FILE` |

### Common Options
| Flag | Description |
|------|-------------|
| `-u SUBJECT` | Message subject |
| `-s SERVER[:PORT]` | SMTP mail relay, default is `localhost:25` |
| `-S [SENDMAIL_PATH]` | Use local sendmail utility (default: `/usr/bin/sendmail`) instead of network MTA |

### Optional Arguments
| Flag | Description |
|------|-------------|
| `-a FILE [FILE ...]` | File attachment(s) |
| `-cc ADDRESS [ADDR ...]` | Cc email address(es) |
| `-bcc ADDRESS [ADDR ...]` | Bcc email address(es) |
| `-xu USERNAME` | Username for SMTP authentication |
| `-xp PASSWORD` | Password for SMTP authentication |

### Advanced ("Paranormal") Options
| Flag | Description |
|------|-------------|
| `-b BINDADDR[:PORT]` | Local host bind address |
| `-l LOGFILE` | Log to the specified file |
| `-v` | Verbosity, use multiple times for greater effect |
| `-q` | Be quiet (no STDOUT output) |
| `-o NAME=VALUE` | Advanced options (see below) |

#### Advanced `-o` Options
| Option | Description |
|--------|-------------|
| `message-content-type=<auto\|text\|html>` | Set the content type of the message |
| `message-file=FILE` | Read message body from a file |
| `message-format=raw` | Send message in raw format |
| `message-header=HEADER` | Add a custom header to the email |
| `message-charset=CHARSET` | Set the character set (e.g., UTF-8) |
| `reply-to=ADDRESS` | Set a Reply-To address |
| `timeout=SECONDS` | Set the network timeout |
| `username=USERNAME` | SMTP authentication username (alternative to `-xu`) |
| `password=PASSWORD` | SMTP authentication password (alternative to `-xp`) |
| `tls=<auto\|yes\|no>` | Enable/disable TLS support |
| `fqdn=FQDN` | Set the Fully Qualified Domain Name for the HELO/EHLO |

### Help Commands
| Flag | Description |
|------|-------------|
| `--help` | General overview |
| `--help addressing` | Explain addressing and related options |
| `--help message` | Explain message body input and related options |
| `--help networking` | Explain `-s`, `-b`, and networking options |
| `--help output` | Explain logging and other output options |
| `--help misc` | Explain `-o` options, TLS, SMTP auth, and more |

## Notes
- If using Gmail or similar services, you may need to enable "App Passwords" or "Less Secure Apps" (if still supported) to authenticate.
- Use `-o tls=yes` if the SMTP server requires encryption.
- The tool can accept the message body from STDIN by omitting `-m` and `-o message-file`.