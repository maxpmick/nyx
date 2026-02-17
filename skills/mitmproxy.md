---
name: mitmproxy
description: Intercept, inspect, and modify HTTP/HTTPS traffic using an interactive console, web interface, or command-line tool. Use when performing web application testing, API analysis, traffic sniffing, or man-in-the-middle attacks to view and manipulate requests and responses on the fly.
---

# mitmproxy

## Overview
mitmproxy is a suite of interactive man-in-the-middle proxies for HTTP and HTTPS. It includes `mitmproxy` (console interface), `mitmweb` (web-based interface), and `mitmdump` (command-line version). It allows for real-time traffic manipulation, scripted changes via Python, and SSL/TLS interception. Category: Sniffing & Spoofing / Web Application Testing.

## Installation (if not already installed)
Assume mitmproxy is already installed. If not:
```bash
sudo apt install mitmproxy
```

## Common Workflows

### Interactive Traffic Inspection
Start the console interface on a specific port:
```bash
mitmproxy -p 8080
```

### Headless Traffic Logging
Save all intercepted traffic to a file without a GUI:
```bash
mitmdump -w traffic.flow
```

### Web-based Interface
Start the proxy and open the web UI for easier viewing:
```bash
mitmweb --web-port 8081 --listen-port 8080
```

### Modify Headers on the Fly
Automatically change the User-Agent for all requests:
```bash
mitmdump -H "/~q/User-Agent/Mozilla/5.0"
```

### Transparent Proxying
Intercept traffic without client configuration (requires OS-level routing):
```bash
mitmproxy --mode transparent
```

## Complete Command Reference

### Global Options (Available in mitmproxy, mitmdump, mitmweb)

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `--version` | Show version number and exit |
| `--options` | Show all options and their default values |
| `--commands` | Show all commands and their signatures |
| `--set option[=value]` | Set an option. Booleans: true/false/toggle. Sequences: multiple invocations |
| `-q, --quiet` | Quiet mode |
| `-v, --verbose` | Increase log verbosity |
| `--mode, -m MODE` | Proxy type: `regular`, `transparent`, `socks5`, `reverse:SPEC`, `upstream:SPEC`, `wireguard[:PATH]` |
| `--anticache` | Strip request headers that might cause 304-not-modified |
| `--showhost` | Use Host header for URL display |
| `--show-ignored-hosts` | Record ignored flows in UI (increases memory usage) |
| `--rfile, -r PATH` | Read flows from file |
| `--scripts, -s SCRIPT` | Execute a Python script (can be used multiple times) |
| `--stickycookie FILTER` | Set sticky cookie filter matched against requests |
| `--stickyauth FILTER` | Set sticky auth filter matched against requests |
| `--save-stream-file, -w PATH` | Stream flows to file. Use `+` to append. Supports strftime() |
| `--anticomp` | Try to convince servers to send un-compressed data |

### Proxy Options

| Flag | Description |
|------|-------------|
| `--listen-host HOST` | Address to bind proxy server(s) to |
| `--listen-port, -p PORT` | Port to bind proxy server(s) to (Default: 8080 for regular) |
| `--no-server, -n` | Do not start a proxy server |
| `--ignore-hosts HOST` | Regex to ignore hosts and forward traffic without processing |
| `--allow-hosts HOST` | Opposite of --ignore-hosts |
| `--tcp-hosts HOST` | Generic TCP SSL proxy mode for matching hosts (intercepted but raw) |
| `--upstream-auth USER:PASS` | HTTP Basic auth for upstream/reverse proxy requests |
| `--proxyauth SPEC` | Require proxy auth: "user:pass", "any", "@path", or "ldap:..." |
| `--store-streamed-bodies` | Store bodies when streaming to allow inspection |
| `--rawtcp` | Enable/disable raw TCP connections (Default: enabled) |
| `--http2` | Enable/disable HTTP/2 support (Default: enabled) |

### SSL Options

| Flag | Description |
|------|-------------|
| `--certs SPEC` | SSL certs: "[domain=]path". PEM format |
| `--cert-passphrase PASS` | Passphrase for decrypting private keys |
| `--ssl-insecure, -k` | Do not verify upstream server SSL/TLS certificates |

### Replay Options

| Flag | Description |
|------|-------------|
| `--client-replay, -C PATH` | Replay client requests from a saved file |
| `--server-replay, -S PATH` | Replay server responses from a saved file |
| `--server-replay-extra {forward,kill,204,400,404,500}` | Behavior for extra requests during replay |
| `--server-replay-reuse` | Don't remove flows from server replay state after use |
| `--server-replay-refresh` | Refresh server replay responses (dates, cookies, etc.) |

### Modification Options (Patterns: `[/filter]/regex/[@]replacement`)

| Flag | Description |
|------|-------------|
| `--map-remote, -M PATTERN` | Map remote resources to another remote URL |
| `--map-local PATTERN` | Map remote resources to a local file/directory |
| `--modify-body, -B PATTERN` | Replace body content using regex. `@` for file path |
| `--modify-headers, -H PATTERN` | Modify headers. Empty value removes the header |

### Interface Specific Options

#### mitmproxy (Console)
| Flag | Description |
|------|-------------|
| `--console-layout {horizontal,single,vertical}` | Set console layout |
| `--console-layout-headers` | Show layout component headers |
| `--intercept FILTER` | Intercept filter expression |
| `--view-filter FILTER` | Limit the view to matching flows |

#### mitmdump (CLI)
| Flag | Description |
|------|-------------|
| `filter_args` | Positional argument: Filter expression for view and save |
| `--flow-detail LEVEL` | Detail level: 0 (quiet) to 4 (very verbose) |

#### mitmweb (Web)
| Flag | Description |
|------|-------------|
| `--web-open-browser` | Automatically start a browser |
| `--web-port PORT` | Web UI port (Default: 8081) |
| `--web-host HOST` | Web UI host |
| `--intercept FILTER` | Intercept filter expression |

## Notes
- **CA Certificate**: To intercept HTTPS, you must install the mitmproxy CA certificate on the client device. After starting mitmproxy, visit `mitm.it` on the proxied device to download it.
- **Filters**: Use filter expressions (e.g., `~u google` for URLs containing "google", `~m POST` for POST requests) to manage large volumes of traffic.
- **Security**: Using `--ssl-insecure` or `-k` makes the proxy session vulnerable to upstream MITM attacks. Use only in controlled testing environments.