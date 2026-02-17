---
name: chromium
description: Open-source web browser and automation engine used for web application testing, security research, and automated browser interactions. Use when performing web-based reconnaissance, testing for cross-site scripting (XSS), verifying proxy configurations, or automating browser tasks via WebDriver (chromedriver). It includes a headless mode for server-side rendering and PDF generation.
---

# chromium

## Overview
Chromium is an open-source web browser project that provides the foundation for Google Chrome. In a security context, it is used for manual web application testing, automated vulnerability scanning, and headless browser operations. Category: Web Application Testing.

## Installation (if not already installed)
Assume the browser is installed. If specific components are missing:

```bash
sudo apt install chromium chromium-driver chromium-headless-shell
```

## Common Workflows

### Launch with a Proxy for Traffic Interception
```bash
chromium --proxy-server="http://127.0.0.1:8080" --incognito
```
Useful for routing browser traffic through Burp Suite or OWASP ZAP.

### Start with a Temporary Profile
```bash
chromium --temp-profile https://example.com
```
Ensures a clean state with no history, cookies, or cached data.

### Automated Testing with ChromeDriver
```bash
chromedriver --port=9515 --verbose
```
Starts the WebDriver server to allow tools like Selenium to control the browser.

### Headless PDF Generation
```bash
chromium-headless-shell --headless --print-to-pdf https://example.com
```
Uses the minimal headless shell to capture a webpage as a PDF.

## Complete Command Reference

### Chromium Browser Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help output |
| `-g`, `--debug` | Start a debugging session within `/usr/bin/gdb` |
| `--temp-profile` | Use a throw-away/temporary profile for this session |
| `--enable-remote-extensions` | Allow installation and updates of remote extensions |
| `--user-data-dir=DIR` | Specifies the directory for user data/profile (Default: `$HOME/.config/chromium`) |
| `--incognito` | Open in incognito mode |
| `--new-window` | Open PATH or URL in a new window |
| `--proxy-server=host:port` | Specify the HTTP/SOCKS4/SOCKS5 proxy server |
| `--no-proxy-server` | Disables the proxy server |
| `--proxy-auto-detect` | Autodetect proxy configuration |
| `--proxy-pac-url=URL` | Specify proxy autoconfiguration URL |
| `--password-store=<type>` | Set password store: `basic`, `gnome`, or `kwallet` |
| `--version` | Show version information |

#### Proxy Format Examples
- `--proxy-server="foopy:99"`: Use HTTP proxy on port 99.
- `--proxy-server="socks://foobar:1080"`: Use SOCKS v5 proxy.
- `--proxy-server="https=proxy1:80;http=socks4://baz:1080"`: Protocol-specific proxies.

### ChromeDriver Options (WebDriver)

| Flag | Description |
|------|-------------|
| `--port=PORT` | Port to listen on |
| `--adb-port=PORT` | ADB server port |
| `--log-path=FILE` | Write server log to file instead of stderr |
| `--log-level=LEVEL` | Set log level: `ALL`, `DEBUG`, `INFO`, `WARNING`, `SEVERE`, `OFF` |
| `--verbose` | Log verbosely (equivalent to `--log-level=ALL`) |
| `--silent` | Log nothing (equivalent to `--log-level=OFF`) |
| `--append-log` | Append log file instead of rewriting |
| `--replayable` | (Experimental) Log verbosely without truncating strings |
| `--version` | Print the version number and exit |
| `--url-base` | Base URL path prefix for commands (e.g., `wd/url`) |
| `--readable-timestamp` | Add readable timestamps to log |
| `--enable-chrome-logs` | Show logs from the browser |
| `--bidi-mapper-path=PATH` | Custom bidi mapper path |
| `--disable-dev-shm-usage` | Do not use `/dev/shm` (use if seeing shared memory errors) |
| `--ignore-explicit-port` | (Experimental) Ignore specified port and find a free one |
| `--allowed-ips=LIST` | Comma-separated allowlist of remote IP addresses |
| `--allowed-origins=LIST` | Comma-separated allowlist of request origins |

### Specialized Shells

- **chromium-headless-shell**: A minimal version without a GUI. Equivalent to the legacy `chromium --headless=old` flag. Used for automated screenshots, PDF generation, and scraping.
- **chromium-shell**: A minimal version of the Chromium user interface (content shell).

## Notes
- **Sandbox**: Chromium uses a setuid sandbox for security. If running in certain containerized environments, you may need the `--no-sandbox` flag (use with caution).
- **GTK Flags**: As a GTK+ app, Chromium also obeys standard GTK flags like `--display`.
- **Undocumented Flags**: Chromium contains hundreds of experimental flags not listed in the standard help output.