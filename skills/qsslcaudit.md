---
name: qsslcaudit
description: Test SSL/TLS clients to determine if they securely validate certificates and support weak protocols or ciphers. Use this tool when auditing mobile applications, thick clients, or IoT devices to identify vulnerabilities like lack of certificate pinning, acceptance of self-signed certificates, or support for deprecated protocols (SSLv2/v3) and weak ciphers.
---

# qsslcaudit

## Overview
qsslcaudit is a tool designed to test the security of SSL/TLS clients. It acts as a server that performs various tests to see if a client correctly validates certificates and which protocols/ciphers it accepts. Category: Reconnaissance / Information Gathering, Web Application Testing.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install qsslcaudit
```

## Common Workflows

### Basic Audit of a Web Client
Start the listener on a specific port and suggest a common name to the client:
```bash
qsslcaudit -p 8443 --user-cn target-app.com
```

### Testing for Specific Vulnerabilities
Run only tests for SSLv3 and TLS 1.0 support (IDs 9 and 13):
```bash
qsslcaudit --selected-tests 9,13 -p 443
```

### Testing Certificate Trust with Custom CA
Provide a custom CA certificate and key to test if the client accepts certificates signed by an untrusted authority:
```bash
qsslcaudit --user-ca-cert myCA.crt --user-ca-key myCA.key --selected-tests 6,7
```

### Auditing STARTTLS (e.g., SMTP)
Test a mail client's security by initiating a STARTTLS handshake:
```bash
qsslcaudit --starttls smtp -p 25
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Displays help on commandline options |
| `--help-all` | Displays help including Qt specific options |
| `-v`, `--version` | Displays version information |
| `-l`, `--listen-address <addr>` | Listen on specific address (default: 0.0.0.0) |
| `-p`, `--listen-port <port>` | Bind to specific port (default: 8443) |
| `--user-cn <domain>` | Common Name (CN) to suggest to client (default: example.com) |
| `--server <url>` | Grab certificate information from an existing server |
| `--user-cert <path>` | Path to file containing custom certificate or chain |
| `--user-key <path>` | Path to file containing custom private key |
| `--user-ca-cert <path>` | Path to file containing custom certificate usable as CA |
| `--user-ca-key <path>` | Path to file containing custom private key for CA |
| `--selected-tests <ids>` | Comma-separated list of test IDs to execute |
| `--forward <addr:port>` | Forward connection to upstream proxy |
| `--show-ciphers` | Show ciphers provided by loaded OpenSSL library |
| `--starttls <type>` | Exchange STARTTLS messages (`ftp`, `smtp`, `xmpp`) before TLS |
| `--loop-tests` | Infinitely repeat selected tests (use Ctrl-C to stop) |
| `-w`, `--wait-data-timeout <ms>` | Wait for incoming data in milliseconds (default: 5000) |
| `--output-xml <file>` | Save results in XML format |
| `--pid-file <path>` | Create a pidfile once initialized |
| `--dtls` | Use DTLS protocol over UDP |
| `--double-first-test` | Execute the first test twice and ignore its client fingerprint |

### SSL Client Test IDs
| ID | Category | Description |
|----|----------|-------------|
| 1 | certs | Custom certificate trust (user-supplied cert) |
| 2 | certs | Self-signed certificate for target domain trust |
| 3 | certs | Self-signed certificate for invalid domain trust (www.example.com) |
| 4 | certs | Custom certificate for target domain trust (signed by user-supplied cert) |
| 5 | certs | Custom certificate for invalid domain trust (signed by user-supplied cert) |
| 6 | certs | Certificate for target domain signed by custom CA trust |
| 7 | certs | Certificate for invalid domain signed by custom CA trust |
| 8 | protos | SSLv2 protocol support |
| 9 | protos | SSLv3 protocol support |
| 10 | ciphers | SSLv3 protocol and EXPORT grade ciphers support |
| 11 | ciphers | SSLv3 protocol and LOW grade ciphers support |
| 12 | ciphers | SSLv3 protocol and MEDIUM grade ciphers support |
| 13 | protos | TLS 1.0 protocol support |
| 14 | ciphers | TLS 1.0 protocol and EXPORT grade ciphers support |
| 15 | ciphers | TLS 1.0 protocol and LOW grade ciphers support |
| 16 | ciphers | TLS 1.0 protocol and MEDIUM grade ciphers support |
| 17 | ciphers | TLS 1.1 protocol and EXPORT grade ciphers support |
| 18 | ciphers | TLS 1.1 protocol and LOW grade ciphers support |
| 19 | ciphers | TLS 1.1 protocol and MEDIUM grade ciphers support |
| 20 | ciphers | TLS 1.2 protocol and EXPORT grade ciphers support |
| 21 | ciphers | TLS 1.2 protocol and LOW grade ciphers support |
| 22 | ciphers | TLS 1.2 protocol and MEDIUM grade ciphers support |
| 23 | ciphers | DTLS 1.0 protocol and EXPORT grade ciphers support |
| 24 | ciphers | DTLS 1.0 protocol and LOW grade ciphers support |
| 25 | ciphers | DTLS 1.0 protocol and MEDIUM grade ciphers support |
| 26 | ciphers | DTLS 1.2 protocol and EXPORT grade ciphers support |
| 27 | ciphers | DTLS 1.2 protocol and LOW grade ciphers support |
| 28 | ciphers | DTLS 1.2 protocol and MEDIUM grade ciphers support |
| 29 | certs | CVE-2020-0601 ECC cert trust (Windows CryptoAPI spoofing) |

## Notes
- To test a client, you must point the client (via proxy settings or DNS redirection) to the IP and port where `qsslcaudit` is listening.
- Use `--show-ciphers` to verify what your local environment supports before running cipher-specific tests.
- Test 29 is specifically for the "CurveBall" vulnerability (CVE-2020-0601).