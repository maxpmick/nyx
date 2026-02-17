---
name: testssl.sh
description: Check TLS/SSL ciphers, protocols, and cryptographic flaws on any port. Use when performing web application security testing, infrastructure auditing, or vulnerability scanning to identify weak encryption, expired certificates, and vulnerabilities like Heartbleed, POODLE, or ROBOT.
---

# testssl.sh

## Overview
testssl.sh is a free command-line tool that checks a server's service on any port for support of TLS/SSL ciphers, protocols, and recent cryptographic flaws. It works with any SSL/TLS enabled and STARTTLS service (HTTPS, SMTPS, POP3S, IMAPS, etc.). Category: Vulnerability Analysis / Web Application Testing.

## Installation (if not already installed)
Assume the tool is already installed. If missing:
```bash
sudo apt install testssl.sh
```
Dependencies: `bind9-dnsutils`, `bsdextrautils`, `openssl`, `procps`.

## Common Workflows

### Basic full scan against a website
```bash
testssl.sh example.com
```

### Check for specific vulnerabilities (e.g., Heartbleed and ROBOT)
```bash
testssl.sh -H --BB example.com:443
```

### Mass testing from a file with parallel execution
```bash
testssl.sh --file targets.txt --parallel --jsonfile-pretty ./results/
```

### Test a STARTTLS enabled mail server
```bash
testssl.sh -t smtp mail.example.com:25
```

## Complete Command Reference

### Usage
`testssl [options] <URI>` or `testssl <options>`

`<URI>` can be `host`, `host:port`, `URL`, or `URL:port`. Port 443 is default.

### Standalone Options
| Flag | Description |
|------|-------------|
| `--help` | Display help message |
| `-b, --banner` | Display banner and version |
| `-v, --version` | Display banner and version |
| `-V, --local [pattern]` | Pretty print all local OpenSSL ciphers. Optional pattern filters by hexcode, name, kx, or bits |

### General Options
| Flag | Description |
|------|-------------|
| `-t, --starttls <proto>` | Run against STARTTLS service: `ftp, smtp, lmtp, pop3, imap, xmpp, xmpp-server, telnet, ldap, nntp, sieve, postgres, mysql` |
| `--xmpphost <domain>` | Supply domainname (like SNI) for STARTTLS xmpp/xmpp-server checks |
| `--mx <domain/host>` | Tests MX records from high to low priority (STARTTLS, port 25) |
| `--file, -iL <fname>` | Mass testing: Read commands from file (supports # comments or nmap -oG format) |
| `--mode <serial\|parallel>`| Mass testing mode (default: serial). `--parallel` is a shortcut |
| `--warnings <batch\|off>` | `batch`: stop on error; `off`: skip warnings and continue |
| `--connect-timeout <s>` | Max seconds to wait for TCP socket connect |
| `--openssl-timeout <s>` | Max seconds to wait for openssl connect |

### Single Check Options
| Flag | Description |
|------|-------------|
| `-e, --each-cipher` | Checks each local cipher remotely |
| `-E, --cipher-per-proto`| Checks ciphers per protocol |
| `-s, --std, --categories`| Tests standard cipher categories by strength |
| `-f, --fs, --forward-secrecy`| Checks forward secrecy settings |
| `-p, --protocols` | Checks TLS/SSL protocols (including ALPN/HTTP2 and SPDY) |
| `-g, --grease` | Tests server implementation bugs like GREASE |
| `-S, --server-defaults` | Displays server's default picks and certificate info |
| `-P, --server-preference`| Displays server's picks: protocol+cipher |
| `-x, --single-cipher <pat>`| Tests matched pattern of ciphers |
| `-c, --client-simulation`| Test which clients negotiate with which cipher/protocol |
| `-h, --header, --headers`| Tests HSTS, HPKP, banners, security headers, cookies, etc. |

### Vulnerability Checks
| Flag | Description |
|------|-------------|
| `-U, --vulnerable` | Tests ALL vulnerabilities listed below |
| `-H, --heartbleed` | Heartbleed vulnerability |
| `-I, --ccs, --ccs-injection`| CCS injection vulnerability |
| `-T, --ticketbleed` | Ticketbleed (BigIP loadbalancers) |
| `--BB, --robot` | Return of Bleichenbacher's Oracle Threat (ROBOT) |
| `--SI, --starttls-injection`| STARTTLS injection issues |
| `-R, --renegotiation` | Renegotiation vulnerabilities |
| `-C, --compression, --crime`| CRIME (TLS compression) |
| `-B, --breach` | BREACH (HTTP compression) |
| `-O, --poodle` | POODLE (SSL) |
| `-Z, --tls-fallback` | TLS_FALLBACK_SCSV mitigation |
| `-W, --sweet32` | SWEET32 (64-bit block ciphers: 3DES, RC2, IDEA) |
| `-A, --beast` | BEAST vulnerability |
| `-L, --lucky13` | LUCKY13 vulnerability |
| `-WS, --winshock` | Winshock vulnerability |
| `-F, --freak` | FREAK vulnerability |
| `-J, --logjam` | LOGJAM vulnerability |
| `-D, --drown` | DROWN vulnerability |
| `-4, --rc4, --appelbaum` | Check for RC4 ciphers |

### Tuning / Connect Options
| Flag | Description |
|------|-------------|
| `-9, --full` | Includes implementation bugs and cipher-per-protocol tests |
| `--bugs` | Enables OpenSSL `-bugs` option for buggy F5s, etc. |
| `--assume-http` | Enforce HTTP checks if protocol check fails |
| `--ssl-native` | Use OpenSSL instead of sockets (Faster but less accurate) |
| `--openssl <PATH>` | Use specific openssl binary |
| `--proxy <host:port\|auto>`| Connect via proxy |
| `-6` | Enable IPv6 support |
| `--ip <ip>` | Test specific IP; "one" for first DNS result; "proxy" for proxy DNS |
| `-n, --nodns <min\|none>` | `none`: no DNS; `min`: A, AAAA, MX only |
| `--sneaky` | Less traces: custom user agent and referer |
| `--user-agent <ua>` | Set custom User-Agent |
| `--ids-friendly` | Skip checks that trigger IDS blocks |
| `--phone-out` | Allow external contact for CRL/OCSP |
| `--add-ca <files\|dir>` | Path to CA certs for trust check |
| `--mtls <file>` | Path to client certificate (PEM) |
| `--basicauth <u:p>` | Provide HTTP basic auth |
| `--reqheader <header>` | Add custom HTTP request header |

### Output Options
| Flag | Description |
|------|-------------|
| `--quiet` | Suppress banner |
| `--wide` | Wide output (hexcode, kx, strength, RFC names) |
| `--show-each` | Display all tested ciphers, not just successful ones |
| `--mapping <type>` | `openssl` (default), `iana`, `rfc`, `no-openssl`, `no-iana` |
| `--color <0-3>` | 0: None, 1: B/W, 2: Color (default), 3: Extra color |
| `--colorblind` | Swap green and blue |
| `--debug <0-6>` | Debug levels |
| `--disable-rating` | Disable the rating output |

### File Output Options
| Flag | Description |
|------|-------------|
| `--log, --logging` | Log stdout to file (default naming) |
| `--logfile, -oL <file>` | Log stdout to specific file or directory |
| `--json` | Flat JSON output |
| `--jsonfile, -oj <file>` | Flat JSON to specific file/dir |
| `--json-pretty` | Structured JSON output |
| `--jsonfile-pretty, -oJ <file>`| Structured JSON to specific file/dir |
| `--csv` | CSV output |
| `--csvfile, -oC <file>` | CSV to specific file/dir |
| `--html` | HTML output |
| `--htmlfile, -oH <file>` | HTML to specific file/dir |
| `--out(f,F)ile, -oa/-oA <file>`| Log to LOG, JSON, CSV, and HTML (like nmap) |
| `--hints` | Additional hints for findings |
| `--severity <level>` | Filter CSV/JSON by `LOW`, `MEDIUM`, `HIGH`, or `CRITICAL` |
| `--append` | Append to existing output files |
| `--overwrite` | Overwrite existing output files |
| `--outprefix <prefix>` | Prepend prefix to output filenames |

## Notes
- Values can be assigned with `=` (e.g., `--color=0`).
- The `<URI>` must always be the last parameter.
- Parallel mode (`--parallel`) significantly speeds up mass testing from files.
- Use `--sneaky` and `--ids-friendly` when scanning environments with active monitoring.