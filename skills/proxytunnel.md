---
name: proxytunnel
description: Create TCP tunnels through HTTP(S) proxies using the HTTP CONNECT method. Use when bypassing restrictive firewalls that only allow HTTP/HTTPS traffic, tunneling SSH over proxy servers, or performing post-exploitation pivoting through web proxies.
---

# proxytunnel

## Overview
Proxytunnel is a tool that creates generic tunnels through HTTP(S) proxies for any TCP-based protocol. It connects stdin/stdout to an origin server through industry-standard proxies, making it ideal for bypassing firewalls or encapsulating traffic like SSH within HTTP(S). Category: Post-Exploitation / Web Application Testing.

## Installation (if not already installed)
Assume proxytunnel is already installed. If you get a "command not found" error:

```bash
sudo apt install proxytunnel
```

## Common Workflows

### SSH through a local proxy
To use with SSH, add this to your `~/.ssh/config`:
```text
Host my-home-pc
    ProxyCommand proxytunnel -p proxy.company.com:8080 -d home.example.com:22
```

### Standalone daemon mode
Run as a local listener on port 1080 that tunnels to a destination through a proxy:
```bash
proxytunnel -a 1080 -p proxy.corp.local:3128 -d target.com:443
```

### Tunneling through two proxies (Local and Remote)
```bash
proxytunnel -p localproxy:8080 -r remoteproxy:8081 -d target.com:22
```

### Authenticated proxy with SSL encryption
```bash
proxytunnel -e -P user:password -p proxy.example.com:443 -d target.com:22
```

## Complete Command Reference

### Standard Options

| Flag | Description |
|------|-------------|
| `-i, --inetd` | Run from inetd (default: off) |
| `-a, --standalone=STRING` | Run as standalone daemon on specified port or `address:port` combination |
| `-p, --proxy=STRING` | Local proxy `host:port` combination |
| `-r, --remproxy=STRING` | Remote proxy `host:port` combination (used for chaining 2 proxies) |
| `-d, --dest=STRING` | Destination `host:port` combination |
| `-e, --encrypt` | SSL encrypt data between local proxy and destination |
| `-E, --encrypt-proxy` | SSL encrypt data between client and local proxy |
| `-X, --encrypt-remproxy` | SSL encrypt data between local and remote proxy |

### Feature Specific Options

| Flag | Description |
|------|-------------|
| `-W, --wa-bug-29744` | Workaround ASF Bugzilla 29744: if SSL is active stop using it after CONNECT |
| `-B, --buggy-encrypt-proxy` | Equivalent to `-E -W` (provided for backwards compatibility) |
| `-z, --no-check-certificate` | Don't verify server SSL certificate |
| `-C, --cacert=STRING` | Path to trusted CA certificate or directory |
| `-4, --ipv4` | Enforce IPv4 connection to local proxy |
| `-6, --ipv6` | Enforce IPv6 connection to local proxy |
| `-F, --passfile=STRING` | File containing credentials for proxy authentication |
| `-P, --proxyauth=STRING` | Proxy auth credentials `user:pass` combination |
| `-R, --remproxyauth=STRING` | Remote proxy auth credentials `user:pass` combination |
| `-c, --cert=FILENAME` | Client SSL certificate (chain) |
| `-k, --key=FILENAME` | Client SSL key |
| `-N, --ntlm` | Use NTLM based authentication |
| `-t, --domain=STRING` | NTLM domain (default: autodetect) |
| `-H, --header=STRING` | Add additional HTTP headers to send to proxy |
| `-o, --host=STRING` | Send custom Host Header/SNI |
| `-x, --proctitle=STRING` | Use a different process title |

### Miscellaneous Options

| Flag | Description |
|------|-------------|
| `-v, --verbose` | Turn on verbosity |
| `-q, --quiet` | Suppress messages |
| `-h, --help` | Print help and exit |
| `-V, --version` | Print version and exit |

## Notes
- When using `-F` (passfile), the file should contain the username on the first line and the password on the second line.
- The `-e` flag is crucial when the destination service (like a web server) expects SSL/TLS, while `-E` is used when the proxy itself requires an encrypted connection (HTTPS proxy).
- For SSH usage, ensure the proxy allows the `CONNECT` method to the target port (usually 22 or 443).