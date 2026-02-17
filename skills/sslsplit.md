---
name: sslsplit
description: Transparent and scalable SSL/TLS interception tool for man-in-the-middle attacks. It intercepts connections via NAT, terminates SSL/TLS, and initiates new connections to the destination while logging all transmitted data. Use for network forensics, penetration testing, and intercepting encrypted traffic (HTTPS, STARTTLS, etc.) when you have control over the network routing or gateway.
---

# sslsplit

## Overview
SSLsplit is a tool for man-in-the-middle (MITM) attacks against SSL/TLS encrypted network connections. It transparently intercepts connections through a NAT engine, terminates the encryption, and re-encrypts the traffic to the original destination. It is capable of forging certificates on the fly using a provided CA key/cert. Category: Sniffing & Spoofing / Web Application Testing.

## Installation (if not already installed)
Assume sslsplit is already installed. If not:
```bash
sudo apt install sslsplit
```

## Common Workflows

### Basic HTTPS Interception
Intercept HTTPS traffic using a CA certificate and key, logging connection summaries to a file.
```bash
sslsplit -k ca.key -c ca.crt -l connections.log https 0.0.0.0 8443
```

### Full Content Logging with SNI
Intercept SSL traffic and log full request/response data to separate files in a directory, using SNI to determine the destination.
```bash
sslsplit -D -S /tmp/output -k ca.key -c ca.crt https 127.0.0.1 9443 sni 443
```

### Transparent Interception (NAT)
Interception using the default NAT engine (e.g., netfilter/iptables) for all incoming TCP/SSL traffic.
```bash
sslsplit -k ca.key -c ca.crt -P tcp 127.0.0.1 10025 ssl 127.0.0.1 10443
```

### STARTTLS Interception
Interception of protocols that upgrade to SSL/TLS (like SMTP or IMAP) using `autossl`.
```bash
sslsplit -k ca.key -c ca.crt autossl 0.0.0.0 10025
```

## Complete Command Reference

```
sslsplit [-D] [-f conffile] [-o opt=val] [options...] [proxyspecs...]
```

### Configuration Options
| Flag | Description |
|------|-------------|
| `-f conffile` | Use `conffile` to load configuration from |
| `-o opt=val` | Override `conffile` option `opt` with value `val` |

### Certificate and Key Options
| Flag | Description |
|------|-------------|
| `-c pemfile` | Use CA cert (and key) from `pemfile` to sign forged certs |
| `-k pemfile` | Use CA key (and cert) from `pemfile` to sign forged certs |
| `-C pemfile` | Use CA chain from `pemfile` (intermediate and root CA certs) |
| `-K pemfile` | Use key from `pemfile` for leaf certs (default: generate) |
| `-q crlurl` | Use URL as CRL distribution point for all forged certs |
| `-t certdir` | Use cert+chain+key PEM files from `certdir` to target sites matching CNs |
| `-A pemfile` | Use cert+chain+key PEM as fallback leaf cert when `-t` doesn't match |
| `-w gendir` | Write leaf key and only generated certificates to `gendir` |
| `-W gendir` | Write leaf key and all certificates to `gendir` |

### Connection Handling Options
| Flag | Description |
|------|-------------|
| `-O` | Deny all OCSP requests on all proxyspecs |
| `-P` | Passthrough SSL if splitting fails (client cert auth/no CA) (default: drop) |
| `-a pemfile` | Use cert from `pemfile` when destination requests client certs |
| `-b pemfile` | Use key from `pemfile` when destination requests client certs |
| `-g pemfile` | Use DH group params from `pemfile` (default: keyfiles or auto) |
| `-G curve` | Use ECDH named curve (default: prime256v1) |
| `-Z` | Disable SSL/TLS compression on all connections |
| `-r proto` | Only support one protocol: `tls10`, `tls11`, `tls12` (default: all) |
| `-R proto` | Disable one protocol: `tls10`, `tls11`, `tls12` (default: none) |
| `-s ciphers` | Use the given OpenSSL cipher suite spec (default: ALL:-aNULL) |

### System and Engine Options
| Flag | Description |
|------|-------------|
| `-x engine` | Load OpenSSL engine with the given identifier |
| `-e engine` | Specify default NAT engine to use (default: netfilter) |
| `-E` | List available NAT engines and exit |
| `-u user` | Drop privileges to `user` (default if root: nobody) |
| `-m group` | Override group when using `-u` (default: primary group of user) |
| `-j jaildir` | `chroot()` to `jaildir` |
| `-p pidfile` | Write pid to `pidfile` |

### Logging Options
| Flag | Description |
|------|-------------|
| `-l logfile` | Connect log: log one line summary per connection to `logfile` |
| `-L logfile` | Content log: full data to file or named pipe (excludes `-S`/`-F`) |
| `-S logdir` | Content log: full data to separate files in `logdir` (excludes `-L`/`-F`) |
| `-F pathspec` | Content log: full data to sep files with `%` substitution |
| `-X pcapfile` | pcap log: packets to `pcapfile` (excludes `-Y`/`-y`) |
| `-Y pcapdir` | pcap log: packets to separate files in `pcapdir` (excludes `-X`/`-y`) |
| `-y pathspec` | pcap log: packets to sep files with `%` substitution |
| `-I if` | Mirror packets to interface `if` |
| `-T addr` | Mirror packets to target address `addr` (used with `-I`) |
| `-M logfile` | Log master keys to `logfile` in SSLKEYLOGFILE format |

#### Pathspec Substitutions (`-F`, `-y`)
- `%T`: Initial connection time (ISO 8601 UTC)
- `%d`: Destination host and port
- `%D`: Destination host
- `%p`: Destination port
- `%s`: Source host and port
- `%S`: Source host
- `%q`: Source port
- `%%`: Literal '%'

### Generic Options
| Flag | Description |
|------|-------------|
| `-d` | Daemon mode: run in background, log errors to syslog |
| `-D` | Debug mode: run in foreground, log debug messages on stderr |
| `-V` | Print version information and exit |
| `-h` | Print usage information and exit |

### Proxyspec Format
`type listenaddr+port [natengine|targetaddr+port|"sni"+port]`

**Examples:**
- `http 0.0.0.0 8080 www.example.com 80` (Static hostname)
- `https ::1 8443 2001:db8::1 443` (Static IPv6 address)
- `https 127.0.0.1 9443 sni 443` (SNI DNS lookups)
- `tcp 127.0.0.1 10025` (Default NAT engine)
- `ssl 2001:db8::2 9999 pf` (Specific NAT engine 'pf')
- `autossl ::1 10025` (STARTTLS detection)

## Notes
- To intercept traffic, you must redirect traffic to the sslsplit listening port using `iptables` or `nftables` (e.g., `PREROUTING` chain with `REDIRECT` or `DNAT`).
- Forged certificates will trigger browser warnings unless the CA certificate used by sslsplit is installed in the victim's trusted root store.
- Use `-M` to log master keys for later decryption of PCAP files in Wireshark.