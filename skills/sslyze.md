---
name: sslyze
description: Fast and comprehensive SSL/TLS scanner to analyze server configurations and identify misconfigurations. Use when performing reconnaissance, vulnerability analysis, or web application testing to check for expired certificates, weak protocols (SSLv2/v3), insecure renegotiation, Heartbleed, ROBOT, and compliance with Mozilla's TLS recommendations.
---

# sslyze

## Overview
SSLyze is a Python-based tool designed to analyze the SSL/TLS configuration of a server. It helps security testers identify misconfigurations, insecure protocols, and vulnerabilities like Heartbleed or CCS Injection. Category: Reconnaissance / Vulnerability Analysis / Web Application Testing.

## Installation (if not already installed)
Assume sslyze is already installed. If the command is missing:

```bash
sudo apt install sslyze
```

## Common Workflows

### Basic Scan against a single host
```bash
sslyze www.google.com
```

### Comprehensive scan with JSON output
```bash
sslyze --certinfo --sslv2 --sslv3 --tlsv1 --tlsv1_1 --tlsv1_2 --tlsv1_3 --reneg --resum --heartbleed --json_out results.json www.example.com:443
```

### Scan multiple targets from a file
```bash
sslyze --targets_in targets.txt --quiet --json_out results.json
```

### Check compliance against Mozilla's "Modern" configuration
```bash
sslyze --mozilla_config modern www.example.com
```

## Complete Command Reference

```bash
sslyze [options] [target ...]
```

### Positional Arguments
| Argument | Description |
|----------|-------------|
| `target` | The list of servers to scan (e.g., `google.com`, `192.168.1.1:443`). |

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit. |
| `--custom_tls_config <FILE>` | Path to JSON file containing specific TLS config to check against (Mozilla format). |
| `--mozilla_config <type>` | Check against Mozilla's recommended TLS configs: `modern`, `intermediate` (default), `old`, or `disable`. |
| `--update_trust_stores` | Update default trust stores from GitHub. Run separately; silences other options. |

### Client Certificate Options
| Flag | Description |
|------|-------------|
| `--cert <FILE>` | Client certificate chain filename (PEM format). |
| `--key <FILE>` | Client private key filename. |
| `--keyform <FORMAT>` | Client private key format: `DER` or `PEM` (default). |
| `--pass <PASSPHRASE>` | Client private key passphrase. |

### Input and Output Options
| Flag | Description |
|------|-------------|
| `--json_out <FILE>` | Write results to JSON file. Use `-` for stdout. |
| `--targets_in <FILE>` | Read list of targets (one host:port per line) from file. |
| `--quiet` | Do not output to stdout; useful with `--json_out`. |

### Connectivity Options
| Flag | Description |
|------|-------------|
| `--slow_connection` | Reduce concurrent connections for slow/unstable links. |
| `--https_tunnel <URL>` | Tunnel traffic through HTTP CONNECT proxy: `http://USER:PW@HOST:PORT/`. |
| `--starttls <PROTOCOL>` | Perform StartTLS handshake. Protocols: `auto`, `smtp`, `xmpp`, `xmpp_server`, `pop3`, `imap`, `ftp`, `ldap`, `rdp`, `postgres`. |
| `--xmpp_to <HOSTNAME>` | Hostname for the 'to' attribute in XMPP stream. |
| `--sni <SERVER_NAME>` | Use Server Name Indication for TLS 1.0+ connections. |

### Scan Commands
| Flag | Description |
|------|-------------|
| `--ems` | Test for TLS Extended Master Secret extension support. |
| `--compression` | Test for TLS compression (CRIME attack vector). |
| `--reneg` | Test for insecure and client-initiated renegotiation. |
| `--sslv2` | Test for SSL 2.0 support. |
| `--sslv3` | Test for SSL 3.0 support. |
| `--tlsv1` | Test for TLS 1.0 support. |
| `--tlsv1_1` | Test for TLS 1.1 support. |
| `--tlsv1_2` | Test for TLS 1.2 support. |
| `--tlsv1_3` | Test for TLS 1.3 support. |
| `--certinfo` | Retrieve and analyze certificate validity. |
| `--certinfo_ca_file <FILE>` | Path to root certificates (PEM) for `--certinfo` validation. |
| `--resum` | Test TLS 1.2 session resumption (Session IDs and Tickets). |
| `--resum_attempts <N>` | Number of resumption attempts (default: 5). |
| `--early_data` | Test for TLS 1.3 early data support. |
| `--fallback` | Test for TLS_FALLBACK_SCSV mechanism. |
| `--heartbleed` | Test for OpenSSL Heartbleed vulnerability. |
| `--openssl_ccs` | Test for OpenSSL CCS Injection (CVE-2014-0224). |
| `--robot` | Test for the ROBOT vulnerability. |
| `--http_headers` | Test for security-related HTTP headers. |
| `--elliptic_curves` | Test for supported elliptic curves. |

## Notes
- If no scan commands are provided, SSLyze will run a default set of plugins.
- Use `--slow_connection` if you encounter frequent timeouts or "Connection reset" errors.
- The `--json_out` format is compatible with the SSLyze Python API for automated processing.