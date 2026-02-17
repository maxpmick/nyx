---
name: stunnel4
description: Universal TLS/SSL encryption wrapper that provides secure tunneling for non-TLS aware network daemons. Use when you need to secure cleartext protocols (like POP3, IMAP, SMTP, or HTTP), establish encrypted tunnels between remote clients and local servers, or perform TLS offloading and load-balancing during post-exploitation or web application testing.
---

# stunnel4

## Overview
stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code. It functions as a TLS offloading and load-balancing proxy, belonging to the Post-Exploitation and Web Application Testing domains.

## Installation (if not already installed)
Assume stunnel4 is already installed. If you get a "command not found" error:

```bash
sudo apt install stunnel4
```

## Common Workflows

### Encapsulate a local cleartext service (Server Mode)
To provide TLS for a local IMAP service running on port 143:
```bash
# Create stunnel.conf
[imapd]
accept = 993
connect = 127.0.0.1:143
cert = /etc/stunnel/stunnel.pem
```
Then run: `stunnel4 stunnel.conf`

### Connect a cleartext client to a TLS server (Client Mode)
To let a local email client connect to a remote TLS-enabled IMAP server:
```bash
[imap-client]
client = yes
accept = 127.0.0.1:143
connect = imap.example.com:993
```

### SOCKS VPN Tunneling
Client side:
```bash
[socks_client]
client = yes
accept = 127.0.0.1:1080
connect = vpn_server:9080
```
Server side:
```bash
[socks_server]
protocol = socks
accept = 9080
cert = stunnel.pem
```

## Complete Command Reference

### CLI Arguments
```
stunnel [FILE] | -fd N | -help | -version | -sockets | -options
```

| Flag | Description |
|------|-------------|
| `FILE` | Use specified configuration file |
| `-fd N` | Read the config file from specified file descriptor (Unix only) |
| `-help` | Print help menu |
| `-version` | Print version and compile-time defaults |
| `-sockets` | Print default socket options |
| `-options` | Print supported TLS options |

### Global Configuration Options
| Option | Description |
|--------|-------------|
| `chroot = DIR` | Directory to chroot stunnel process (Unix only) |
| `compression = deflate\|zlib` | Select data compression algorithm |
| `debug = [FACILITY.]LEVEL` | Debugging level (0-7). Default is 5 (notice) |
| `EGD = PATH` | Path to Entropy Gathering Daemon socket (Unix only) |
| `engine = auto\|ID` | Select hardware/software cryptographic engine |
| `engineCtrl = CMD[:PARM]` | Control hardware engine |
| `engineDefault = LIST` | Set OpenSSL tasks delegated to engine (RSA, DSA, etc.) |
| `fips = yes\|no` | Enable/disable FIPS 140-2 mode |
| `foreground = yes\|quiet\|no` | Stay in foreground; 'yes' also logs to stderr |
| `log = append\|overwrite` | Log file handling |
| `output = FILE` | Append log messages to a file (use /dev/stdout for stdout) |
| `pid = FILE` | PID file location (Unix only) |
| `provider = ID` | Cryptographic provider ID (OpenSSL 3.0+) |
| `providerParameter = ID:P=V` | Set specific parameter for a provider (OpenSSL 3.5+) |
| `RNDbytes = BYTES` | Bytes to read from random seed files |
| `RNDfile = FILE` | Path to file with random seed data |
| `RNDoverwrite = yes\|no` | Overwrite random seed files with new data |
| `service = NAME` | stunnel service name for syslog/TCP Wrappers |
| `setEnv = VAR=VAL` | Set environment variable for child processes |
| `syslog = yes\|no` | Enable logging via syslog (Unix only) |

### Service-Level Options
| Option | Description |
|--------|-------------|
| `accept = [HOST:]PORT` | Address to accept connections on |
| `CAengine = ID` | Load trusted CA from an engine (pkcs11, cng) |
| `CApath = DIR` | Load trusted CAs from a directory |
| `CAfile = FILE` | Load trusted CAs from a file |
| `CAstore = URI` | Load trusted CAs from OSSL_STORE URI (OpenSSL 3.0+) |
| `cert = FILE\|URI` | Certificate chain file (PEM or P12) |
| `checkEmail = EMAIL` | Verify email in peer certificate |
| `checkHost = HOST` | Verify host in peer certificate |
| `checkIP = IP` | Verify IP in peer certificate |
| `ciphers = LIST` | Permitted TLS ciphers (TLSv1.2 and below) |
| `ciphersuites = LIST` | Permitted TLSv1.3 ciphersuites |
| `client = yes\|no` | Enable client mode (remote service uses TLS) |
| `config = CMD[:PARM]` | OpenSSL configuration command |
| `connect = [HOST:]PORT` | Remote address to connect to (supports multiple for RR) |
| `CRLpath = DIR` | Certificate Revocation Lists directory |
| `CRLfile = FILE` | Certificate Revocation Lists file |
| `curves = LIST` | ECDH curves separated with ':' |
| `delay = yes\|no` | Delay DNS lookup for the connect option |
| `engineId = ID` | Select engine ID for the service |
| `exec = PATH` | Execute a local inetd-type program |
| `execArgs = ARGS` | Arguments for exec including $0 |
| `failover = rr\|prio` | Strategy for multiple connect targets |
| `ident = USERNAME` | Use IDENT (RFC 1413) username checking |
| `include = DIR` | Include all config parts in directory |
| `key = FILE\|URI` | Private key for the certificate |
| `libwrap = yes\|no` | Enable/disable /etc/hosts.allow and /etc/hosts.deny |
| `local = HOST` | Bind to a static local IP for outgoing connections |
| `OCSP = URL` | Select OCSP responder |
| `OCSPaia = yes\|no` | Validate certs with AIA OCSP responders |
| `OCSPflag = FLAG` | Specify OCSP responder flag |
| `OCSPnonce = yes\|no` | Send/verify OCSP nonce extension |
| `OCSPrequire = yes\|no` | Require conclusive OCSP response |
| `options = OPTIONS` | OpenSSL library options (e.g., NO_SSLv3) |
| `protocol = PROTO` | Protocol negotiation (smtp, pop3, imap, ldap, socks, proxy, etc.) |
| `protocolAuthentication = TYPE` | Auth type for protocol (basic, ntlm, plain, login) |
| `protocolHost = ADDR` | Host address for protocol negotiations |
| `PSKidentity = ID` | PSK identity for client |
| `PSKsecrets = FILE` | File with IDENTITY:KEY pairs |
| `pty = yes\|no` | Allocate a pseudoterminal for 'exec' |
| `redirect = [HOST:]PORT` | Redirect on cert auth failure (Server mode only) |
| `renegotiation = yes\|no` | Support TLS renegotiation |
| `reset = yes\|no` | Use TCP RST to indicate error |
| `retry = yes\|no\|MS` | Reconnect after disconnect (delay in milliseconds) |
| `securityLevel = 0-5` | Set OpenSSL security level (Default: 2) |
| `requireCert = yes\|no` | Require client certificate |
| `setgid = GROUP` | Unix group ID for process or Unix socket |
| `setuid = USER` | Unix user ID for process or Unix socket |
| `sessionCacheSize = NUM` | Max internal session cache entries |
| `sessionResume = yes\|no` | Allow session resumption |
| `sni = SERV:PAT` | Server Name Indication (Server mode) |
| `sni = NAME` | Server Name Indication (Client mode) |
| `socket = a\|l\|r:OPT=VAL` | Set socket options (accept/local/remote) |
| `sslVersion = VER` | Select TLS version (all, SSLv3, TLSv1.2, etc.) |
| `sslVersionMax = VER` | Maximum supported protocol version |
| `sslVersionMin = VER` | Minimum supported protocol version |
| `stack = BYTES` | CPU stack size of created threads |
| `ticketKeySecret = HEX` | Key for session ticket confidentiality |
| `ticketMacSecret = HEX` | Key for session ticket integrity |
| `TIMEOUTbusy = SEC` | Time to wait for expected data |
| `TIMEOUTidle = SEC` | Time to keep an idle connection |
| `transparent = TYPE` | Transparent proxy (none, source, destination, both) |
| `verify = 0-4` | Peer certificate verification level (Obsolete) |
| `verifyChain = yes\|no` | Verify peer certificate chain from root CA |
| `verifyPeer = yes\|no` | Verify end-entity peer certificate |

## Notes
- **Signals**: Use `SIGHUP` to reload config, `SIGUSR1` for log rotation, and `SIGUSR2` to list active connections.
- **FTP Restriction**: stunnel cannot be used for FTP due to the protocol's multi-port nature.
- **Security**: Default security level is 2 (112-bit security). Level 0 permits everything.
- **DH Parameters**: stunnel automatically generates temporary 2048-bit DH parameters every 24 hours.
- **Permissions**: Private keys should be chmod 600.
- **Inetd Mode**: If running via inetd/xinetd, do not use the `accept` option; place service options in the global section.