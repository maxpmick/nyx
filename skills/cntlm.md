---
name: cntlm
description: Fast NTLM authentication proxy with tunneling capabilities. Use when a local application or tool does not support NTLM authentication natively and needs to connect through a corporate proxy, or when performing security testing that requires NTLM-to-Basic credential conversion, SOCKS5 proxying, or TCP/IP tunneling through an authenticating gateway.
---

# cntlm

## Overview
Cntlm is a fast and efficient NTLM proxy with support for TCP/IP tunneling, authenticated connection caching, and ACLs. It acts as a middleman between local applications and an NTLM-authenticating upstream proxy, providing a local listener that handles the complex NTLM handshake. Category: Sniffing & Spoofing / Information Gathering.

## Installation (if not already installed)
Assume `cntlm` is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install cntlm
```

## Common Workflows

### Generate NTLM Hashes for Configuration
To avoid storing passwords in plaintext, generate hashes to use in `/etc/cntlm.conf`.
```bash
cntlm -u myuser -d mydomain -H
```

### Run in Foreground for Debugging
Test a connection to a proxy at `10.0.0.1:8080` while watching the debug output.
```bash
cntlm -v -f -u myuser -d mydomain -l 3128 10.0.0.1:8080
```

### Create an SSH-like Tunnel
Forward local port 8022 through the NTLM proxy to a remote SSH server at `example.com:22`.
```bash
cntlm -u myuser -d mydomain -L 8022:example.com:22 10.0.0.1:8080
```

### SOCKS5 Proxy with NTLM Authentication
Start a SOCKS5 proxy on port 1080 that authenticates via the upstream NTLM proxy.
```bash
cntlm -u myuser -d mydomain -O 1080 10.0.0.1:8080
```

## Complete Command Reference

```
cntlm [-AaBcDdFfGgHhILlMNOPpqRrSsTUuvwXx] <proxy_host>[:]<proxy_port> ...
```

### Options

| Flag | Description |
|------|-------------|
| `-A <addr>[/<net>]` | ACL allow rule. IP or hostname, net must be a number (CIDR notation) |
| `-a ntlm\|nt\|lm` | Authentication type - combined NTLM, just LM, or just NT. Default: NTLM |
| `-B` | Enable NTLM-to-basic authentication |
| `-c <config_file>` | Use specific configuration file (overrides defaults) |
| `-D <addr>[/<net>]` | ACL deny rule. Syntax same as -A |
| `-d <domain>` | Set Domain/workgroup separately |
| `-F <flags>` | Specify NTLM authentication flags |
| `-f` | Run in foreground; do not fork into daemon mode |
| `-G <pattern>` | User-Agent matching for the trans-isa-scan plugin |
| `-g` | Gateway mode - listen on all interfaces, not only loopback |
| `-H` | Print password hashes for use in config file (NTLMv2 needs -u and -d) |
| `-h` | Print help info and version number |
| `-I` | Prompt for the password interactively |
| `-L [<saddr>:]<lport>:<rhost>:<rport>` | Forwarding/tunneling (OpenSSH style) through the proxy |
| `-l [<saddr>:]<lport>` | Main listening port for the NTLM proxy |
| `-M <testurl>` | Magic autodetection of proxy's NTLM dialect |
| `-N "<wildcards>"` | List of URLs to serve directly (comma separated, e.g., `*.local`) |
| `-O [<saddr>:]<lport>` | Enable SOCKS5 proxy on specified port |
| `-P <pidfile>` | Create a PID file upon successful start |
| `-p <password>` | Account password (hidden from process lists) |
| `-q` | Set Syslog logging level to DEBUG (default is INFO) |
| `-R <user>:<pass>` | Enable authorization for SOCKS5 proxy (can be used multiple times) |
| `-r "Header: val"` | Add/replace a header substitution in client requests |
| `-S <size_in_kb>` | Enable automation of GFI WebMonitor ISA scanner for files < size |
| `-s` | Do not use threads; serialize all requests (debugging only) |
| `-T <file.log>` | Redirect debug info to trace file (must be first argument, implies -v) |
| `-U <uid>` | Run as specific UID (security measure to avoid running as root) |
| `-u <user>[@<dom>]` | Specify username and optionally the domain |
| `-v` | Print verbose debugging information |
| `-w <workstation>` | Specify NetBIOS hostname (required by some proxies) |
| `-x <PAC_file>` | Specify a PAC (Proxy Auto-Config) file to load |
| `-X <sspi_type>` | Use SSPI with specified handle type (Windows only, default: negotiate) |

## Notes
- **Security**: It is highly recommended to use the `-H` flag to generate hashes rather than storing your domain password in plaintext in the configuration file or command line.
- **Configuration**: The default configuration file is usually located at `/etc/cntlm.conf`.
- **Detection**: Use the `-M` flag followed by a URL (e.g., `cntlm -M http://google.com`) to let the tool automatically determine the correct NTLM dialect for your upstream proxy.