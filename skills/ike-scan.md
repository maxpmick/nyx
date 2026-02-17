---
name: ike-scan
description: Discover and fingerprint IKE hosts (IPsec VPN servers) by analyzing responses and retransmission backoff patterns. Use when performing network reconnaissance to identify VPN gateways, determining IKE implementations, or capturing Aggressive Mode handshakes for offline PSK cracking during penetration testing.
---

# ike-scan

## Overview
`ike-scan` is a command-line tool that discovers and fingerprints IKE (Internet Key Exchange) hosts. It functions by sending IKE packets to target hosts and analyzing the responses. It can identify the presence of VPN servers and determine the specific IKE implementation by comparing retransmission timing against a database of known patterns. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install ike-scan
```

## Common Workflows

### Basic Discovery
Scan a local network to find IKE-responsive hosts:
```bash
ike-scan 192.168.1.0/24
```

### Fingerprinting VPN Implementation
Determine the vendor/software of a specific VPN gateway using backoff analysis:
```bash
ike-scan --showbackoff 10.0.0.1
```

### Aggressive Mode PSK Capture
Attempt to initiate Aggressive Mode and save the handshake for offline cracking:
```bash
ike-scan --aggressive --id=vpnclient --pskcrack=handshake.txt 10.0.0.1
```

### Offline PSK Cracking
Use the companion tool `psk-crack` to brute-force a captured PSK:
```bash
psk-crack --bruteforce=8 --charset="0123456789" handshake.txt
```

## Complete Command Reference

### ike-scan Options

| Flag | Description |
|------|-------------|
| `--help`, `-h` | Display usage message and exit |
| `--file=<fn>`, `-f <fn>` | Read hostnames or addresses from file (one per line, "-" for stdin) |
| `--sport=<p>`, `-s <p>` | Set UDP source port (default: 500, 0: random). Requires root for < 1024 |
| `--dport=<p>`, `-d <p>` | Set UDP destination port (default: 500) |
| `--retry=<n>`, `-r <n>` | Total number of attempts per host (default: 3) |
| `--timeout=<n>`, `-t <n>` | Initial per-host timeout in ms (default: 500) |
| `--bandwidth=<n>`, `-B <n>` | Set outbound bandwidth (e.g., 56000, 64K, 1M) |
| `--interval=<n>`, `-i <n>` | Minimum packet interval (ms, 'u' for μs, 's' for seconds) |
| `--backoff=<b>`, `-b <b>` | Timeout backoff factor (default: 1.50) |
| `--verbose`, `-v` | Verbose progress (use multiple times for more detail) |
| `--quiet`, `-q` | Don't decode returned packet (shorter output) |
| `--multiline`, `-M` | Split payload decode across multiple lines |
| `--lifetime=<s>`, `-l <s>` | Set IKE lifetime in seconds (default: 28800) or hex (e.g., 0xFF) |
| `--lifesize=<s>`, `-z <s>` | Set IKE lifesize in Kilobytes (default: 0) |
| `--auth=<n>`, `-m <n>` | Set auth method (1: PSK, 64221: Checkpoint, 65001: GSS) |
| `--version`, `-V` | Display version and exit |
| `--vendor=<v>`, `-e <v>` | Set vendor ID string to hex value |
| `--trans=<t>`, `-a <t>` | Use custom transform (e.g., `(1=1,2=2,3=3,4=4)` or `5,2,1,2`) |
| `--showbackoff[=<n>]`, `-o[<n>]` | Display backoff fingerprint table (optional wait time, default: 60s) |
| `--fuzz=<n>`, `-u <n>` | Pattern matching fuzz in ms (default: 500) |
| `--patterns=<f>`, `-p <f>` | Use specific IKE backoff patterns file |
| `--vidpatterns=<f>`, `-I <f>` | Use specific Vendor ID patterns file |
| `--aggressive`, `-A` | Use IKE Aggressive Mode (default is Main Mode) |
| `--id=<id>`, `-n <id>` | Identification value for Aggressive Mode (string or 0xhex) |
| `--idtype=<n>`, `-y <n>` | Identification type (default: 3 - ID_USER_FQDN) |
| `--dhgroup=<n>`, `-g <n>` | Diffie Hellman Group (1, 2, 5, 14-21. Default: 2) |
| `--gssid=<n>`, `-G <n>` | Use GSS ID (hex string) |
| `--random`, `-R` | Randomize the host list order |
| `--tcp[=<n>]`, `-T[<n>]` | Use TCP (1: RAW/Checkpoint, 2: Encapsulated/Cisco) |
| `--tcptimeout=<n>`, `-O <n>` | TCP connect timeout in seconds (default: 10) |
| `--pskcrack[=<f>]`, `-P[<f>]` | Output Aggressive Mode PSK parameters for offline cracking |
| `--nodns`, `-N` | Do not use DNS to resolve names |
| `--noncelen=<n>`, `-c <n>` | Set nonce length in bytes (default: 20) |
| `--headerlen=<n>`, `-L <n>` | Set ISAKMP header length manually (+n, -n, or n) |
| `--mbz=<n>`, `-Z <n>` | Use value for reserved (MBZ) fields (0-255) |
| `--headerver=<n>`, `-E <n>` | Specify ISAKMP header version (default: 0x10) |
| `--certreq=<c>`, `-C <c>` | Add CertificateRequest payload (hex) |
| `--doi=<d>`, `-D <d>` | Set SA DOI (default: 1 - IPsec) |
| `--situation=<s>`, `-S <s>` | Set SA Situation (default: 1) |
| `--protocol=<p>`, `-j <p>` | Set Proposal protocol ID (default: 1 - PROTO_ISAKMP) |
| `--transid=<t>`, `-k <t>` | Set Transform ID (default: 1 - KEY_IKE) |
| `--spisize=<n>` | Set proposal SPI size (default: 0) |
| `--hdrflags=<n>` | Set ISAKMP header flags (default: 0) |
| `--hdrmsgid=<n>` | Set ISAKMP header message ID (default: 0) |
| `--cookie=<n>` | Set ISAKMP initiator cookie (hex) |
| `--exchange=<n>` | Set exchange type (2: Main, 4: Aggressive) |
| `--nextpayload=<n>` | Set next payload in ISAKMP header |
| `--randomseed=<n>` | Seed the PRNG for repeatable packet data |
| `--timestamp` | Display timestamps for received packets |
| `--sourceip=<s>` | Set source IP (dotted quad or "random"). Requires root |
| `--bindip=<s>` | Set the IP address to bind to |
| `--shownum` | Display host number for received packets |
| `--nat-t` | Use RFC 3947 NAT-Traversal (ports 4500) |
| `--rcookie=<n>` | Set ISAKMP responder cookie (hex) |
| `--ikev2`, `-2` | Use IKE version 2 (Experimental) |

### psk-crack Options

| Flag | Description |
|------|-------------|
| `--help`, `-h` | Display help and exit |
| `--version`, `-V` | Display version and exit |
| `--verbose`, `-v` | Increase verbosity |
| `--dictionary=<f>`, `-d <f>` | Set dictionary file (default: `/usr/share/ike-scan/psk-crack-dictionary`) |
| `--norteluser=<u>`, `-u <u>` | Specify username for Nortel Contivity PSK cracking |
| `--bruteforce=<n>`, `-B <n>` | Select brute-force cracking up to `<n>` characters |
| `--charset=<s>`, `-c <s>` | Set brute-force character set |

## Notes
- **NAT-T**: Using `--nat-t` changes the default ports to 4500. If you need different ports with NAT-T, specify `--sport` and `--dport` *after* the `--nat-t` flag.
- **Aggressive Mode**: This is often required to capture PSK hashes. Many modern servers disable this for security.
- **Root Privileges**: Required for using source ports below 1024 or using the `--sourceip` raw socket feature.
- **Target Specification**: Supports IP addresses, hostnames, CIDR (192.168.1.0/24), and ranges (192.168.1.1-192.168.1.10).