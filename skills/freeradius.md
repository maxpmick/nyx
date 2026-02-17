---
name: freeradius
description: A high-performance, highly configurable RADIUS server for authentication, authorization, and accounting (AAA). Use to manage network access control, test RADIUS server responses, sniff RADIUS traffic, and perform security audits on EAP/RADIUS implementations.
---

# freeradius

## Overview
FreeRADIUS is the industry-standard open-source RADIUS server. It supports various authentication backends (SQL, LDAP, PAM, Active Directory), multiple EAP types (TLS, PEAP, TTLS), and includes a suite of client utilities for testing and debugging. Category: Sniffing & Spoofing / Network Services.

## Installation (if not already installed)
The server and utilities are often split into multiple packages.
```bash
sudo apt install freeradius freeradius-utils
```

## Common Workflows

### Debugging the Server
Run the server in the foreground with full debug output to troubleshoot configuration or authentication issues.
```bash
freeradius -X
```

### Testing Authentication
Verify if a user can authenticate against a RADIUS server using PAP.
```bash
radtest username password localhost 0 testing123
```

### Sniffing RADIUS Traffic
Monitor RADIUS packets on a specific interface to capture attributes and credentials.
```bash
radsniff -i eth0 -s testing123
```

### Checking Active Sessions
View currently logged-in users tracked by the RADIUS server.
```bash
radwho -i -u john_doe
```

## Complete Command Reference

### freeradius (Server)
```
freeradius [options]
```
| Flag | Description |
|------|-------------|
| `-C` | Check configuration and exit |
| `-f` | Run as a foreground process, not a daemon |
| `-h` | Print help message |
| `-i <ipaddr>` | Listen on ipaddr ONLY |
| `-l <log_file>` | Logging output written to this file |
| `-m` | Clean up all memory on SIGINT/SIGQUIT |
| `-n <name>` | Read raddb/name.conf instead of radiusd.conf |
| `-p <port>` | Listen on port ONLY |
| `-P` | Always write out PID, even with -f |
| `-s` | Do not spawn child processes (single-threaded) |
| `-t` | Disable threads |
| `-v` | Print server version |
| `-X` | Full debugging mode (equivalent to -tfxxl stdout) |
| `-x` | Additional debugging (-xx for more) |

### radtest (Client Test)
```
radtest [OPTIONS] user passwd radius-server[:port] nas-port-number secret [ppphint] [nasname]
```
| Flag | Description |
|------|-------------|
| `-d <dir>` | Set radius directory |
| `-t <type>` | Auth method: pap, chap, mschap, or eap-md5 |
| `-P <proto>` | Select udp (default) or tcp |
| `-x` | Enable debug output |
| `-4` | Use IPv4 for NAS address (default) |
| `-6` | Use IPv6 for NAS address |
| `-b` | Mandate checks for Blast RADIUS issue |

### radclient (Packet Generator)
```
radclient [options] server[:port] <command> [<secret>]
```
| Flag | Description |
|------|-------------|
| `<command>` | auth, acct, status, coa, disconnect, or auto |
| `-4 / -6` | Force IPv4 or IPv6 |
| `-b` | Mandate checks for Blast RADIUS |
| `-c <count>` | Send each packet 'count' times |
| `-d <raddb>` | Set user dictionary directory |
| `-D <dir>` | Set main dictionary directory |
| `-f <file>` | Read packets from file (use :file to verify responses) |
| `-F` | Print file name, packet number, and reply code |
| `-n <num>` | Send N requests/s |
| `-p <num>` | Send 'num' packets from a file in parallel |
| `-q` | Quiet mode |
| `-r <retries>`| Retry sending 'retries' times on timeout |
| `-s` | Print summary of auth results |
| `-S <file>` | Read secret from file |
| `-t <timeout>`| Wait 'timeout' seconds before retrying |
| `-x` | Debugging mode |
| `-P <proto>` | Use tcp or udp |

### radsniff (RADIUS Sniffer)
```
radsniff [options][stats options] -- [pcap files]
```
| Flag | Description |
|------|-------------|
| `-a` | List all available interfaces |
| `-c <count>` | Number of packets to capture |
| `-C` | Enable UDP checksum validation |
| `-d <dir>` | Set config or dictionary directory |
| `-e <events>`| Log specific events: received, norsp, rtx, noreq, reused, error |
| `-f <filter>`| PCAP filter (default: RADIUS ports) |
| `-i <iface>` | Capture from interface |
| `-I <file>` | Read packets from PCAP file |
| `-l <attrs>` | Output packet sig and list of attributes |
| `-L <attrs>` | Detect retransmissions using these attributes |
| `-m` | Disable promiscuous mode |
| `-p <port>` | Filter by port (default 1812) |
| `-P <file>` | Daemonize and write PID file |
| `-r / -R` | Request/Response attribute filters |
| `-s <secret>`| RADIUS secret for packet decryption |
| `-S` | Write PCAP data to stdout |
| `-t <timeout>`| Stop after N seconds |
| `-W <int>` | Write stats every N seconds |

### radwho (Session Monitor)
| Flag | Description |
|------|-------------|
| `-c` | Show caller ID |
| `-d <dir>` | Set raddb directory |
| `-F <file>` | Use specific radutmp file |
| `-i` | Show session ID |
| `-n` | No full name |
| `-N <ip>` | Filter by NAS IP |
| `-p` | Show port type |
| `-P <port>` | Filter by NAS port |
| `-r` | Raw comma-delimited output |
| `-R` | Output as RADIUS attributes |
| `-s` | Show full name |
| `-u / -U` | Filter by user (case-insensitive / case-sensitive) |
| `-Z` | Include accounting stop info (requires -R) |

### radlast (Login History)
| Flag | Description |
|------|-------------|
| `-a` | Display hostnames as last entry |
| `-d` | Translate IP to hostname |
| `-f <file>` | Use specific wtmpdb database |
| `-F` | Display full times and dates |
| `-j` | JSON output |
| `-n <N>` | Display only first N entries |
| `-s / -t` | Filter by "since" or "until" TIME |

### Utility Commands
- **checkrad**: `checkrad nas_type nas_ip nas_port login session_id` (Check if user is logged in).
- **radcrypt**: `radcrypt [--des|--md5|--check] plaintext [crypted]` (Hash/verify passwords).
- **raddebug**: `raddebug [-c condition] [-t timeout] [-u user]` (Debug running server).
- **radmin**: Administration tool for managing a running server instance.
- **radzap**: `radzap [-N nas_ip] [-P port] [-u user]` (Remove rogue session entries).
- **smbencrypt**: Produce LM & NT hashes from cleartext.

## Notes
- The default configuration directory is usually `/etc/freeradius/3.0/`.
- **Blast RADIUS**: Use the `-b` flag in client tools to ensure protection against CVE-2024-3596.
- For EAP testing, use `radeapclient` which supports the same flags as `radclient` but handles EAP state machines.