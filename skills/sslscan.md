---
name: sslscan
description: Query SSL/TLS services to discover supported protocol versions, cipher suites, key exchanges, signature algorithms, and certificate details. Use when performing vulnerability analysis, web application testing, or information gathering to identify weak encryption parameters, expired certificates, or vulnerabilities like Heartbleed and CRIME.
---

# sslscan

## Overview
sslscan is a fast SSL/TLS scanner that reports on the security configuration of encrypted services. It identifies supported protocols (SSLv2 to TLS 1.3), cipher suites, certificate chains, and common vulnerabilities. Category: Reconnaissance / Information Gathering, Vulnerability Analysis, Web Application Testing.

## Installation (if not already installed)
Assume sslscan is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install sslscan
```

## Common Workflows

### Basic scan of a web server
```bash
sslscan example.com:443
```

### Scan multiple targets from a file and save to XML
```bash
sslscan --targets=hosts.txt --xml=results.xml
```

### Check for weak protocols and Heartbleed on a mail server
```bash
sslscan --starttls-smtp --no-colour mail.example.com:25
```

### Detailed certificate analysis with SNI
```bash
sslscan --show-certificate --sni-name=example.com example.com
```

## Complete Command Reference

```
sslscan [options] [host:port | host]
```

### Target Options

| Flag | Description |
|------|-------------|
| `--targets=<file>` | A file containing a list of hosts to check (host:port or host) |
| `--sni-name=<name>` | Hostname for Server Name Indication (SNI) |
| `--ipv4`, `-4` | Only use IPv4 |
| `--ipv6`, `-6` | Only use IPv6 |

### Certificate and Authentication Options

| Flag | Description |
|------|-------------|
| `--show-certificate` | Show full certificate information |
| `--show-certificates` | Show full certificate chain information |
| `--show-client-cas` | Show trusted CAs for TLS client authentication |
| `--no-check-certificate` | Don't warn about weak certificate algorithms or keys |
| `--ocsp` | Request OCSP response from server |
| `--pk=<file>` | Private key file or PKCS#12 file (key/cert pair) |
| `--pkpass=<password>` | Password for the private key or PKCS#12 file |
| `--certs=<file>` | PEM/ASN1 formatted client certificates |

### Protocol and Cipher Options

| Flag | Description |
|------|-------------|
| `--ssl2` | Only check if SSLv2 is enabled |
| `--ssl3` | Only check if SSLv3 is enabled |
| `--tls10` | Only check TLSv1.0 ciphers |
| `--tls11` | Only check TLSv1.1 ciphers |
| `--tls12` | Only check TLSv1.2 ciphers |
| `--tls13` | Only check TLSv1.3 ciphers |
| `--tlsall` | Only check TLS ciphers (all versions) |
| `--show-ciphers` | Show supported client ciphers |
| `--show-cipher-ids` | Show cipher IDs |
| `--iana-names` | Use IANA/RFC cipher names rather than OpenSSL ones |
| `--show-times` | Show handshake times in milliseconds |

### Vulnerability and Detail Options

| Flag | Description |
|------|-------------|
| `--no-cipher-details` | Disable EC curve names and EDH/RSA key lengths output |
| `--no-ciphersuites` | Do not check for supported ciphersuites |
| `--no-compression` | Do not check for TLS compression (CRIME) |
| `--no-fallback` | Do not check for TLS Fallback SCSV |
| `--no-groups` | Do not enumerate key exchange groups |
| `--no-heartbleed` | Do not check for OpenSSL Heartbleed (CVE-2014-0160) |
| `--no-renegotiation` | Do not check for TLS renegotiation |
| `--show-sigs` | Enumerate signature algorithms |

### Protocol-Specific (STARTTLS/RDP) Options

| Flag | Description |
|------|-------------|
| `--starttls-ftp` | STARTTLS setup for FTP |
| `--starttls-imap` | STARTTLS setup for IMAP |
| `--starttls-irc` | STARTTLS setup for IRC |
| `--starttls-ldap` | STARTTLS setup for LDAP |
| `--starttls-mysql` | STARTTLS setup for MYSQL |
| `--starttls-pop3` | STARTTLS setup for POP3 |
| `--starttls-psql` | STARTTLS setup for PostgreSQL |
| `--starttls-smtp` | STARTTLS setup for SMTP |
| `--starttls-xmpp` | STARTTLS setup for XMPP |
| `--xmpp-server` | Use a server-to-server XMPP handshake |
| `--rdp` | Send RDP preamble before starting scan |

### General Options

| Flag | Description |
|------|-------------|
| `--bugs` | Enable SSL implementation bug work-arounds |
| `--no-colour` | Disable coloured output |
| `--sleep=<msec>` | Pause between connection requests (Default: disabled) |
| `--timeout=<sec>` | Set socket timeout (Default: 3s) |
| `--connect-timeout=<sec>` | Set connect timeout (Default: 75s) |
| `--verbose` | Display verbose output |
| `--version` | Display the program version |
| `--xml=<file>` | Output results to an XML file. Use `-` for STDOUT |
| `--help` | Display help text |

## Notes
- When scanning modern web servers behind CDNs or load balancers, always use `--sni-name` to ensure you are hitting the correct virtual host.
- The `--xml` output is highly recommended for automated reporting or post-processing.
- For IPv6 addresses in the command line, use brackets: `sslscan [::1]`.