---
name: curl
description: Transfer data to or from a server using various protocols including HTTP, HTTPS, FTP, SFTP, and more. Use for web application testing, API interaction, file downloads/uploads, banner grabbing, and exploiting vulnerabilities via crafted requests.
---

# curl

## Overview
curl is a command-line tool for transferring data with URL syntax. It supports a wide range of protocols (DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMTP, SMTPS, TELNET, and TFTP) and features like SSL certificates, HTTP POST/PUT, proxies, cookies, and various authentication methods. Category: Web Application Testing / Exploitation / Information Gathering.

## Installation (if not already installed)
Assume curl is already installed. If missing:
```bash
sudo apt install curl
```

## Common Workflows

### Fetching Headers and Content
```bash
curl -i https://example.com
```

### Sending POST Data
```bash
curl -d "param1=value1&param2=value2" -X POST https://api.example.com/v1/login
```

### Downloading a File with a Specific Name
```bash
curl -o local_filename.zip https://example.com/remote_file.zip
```

### Authenticated Request with Custom User-Agent
```bash
curl -u admin:password123 -A "Mozilla/5.0" https://example.com/admin
```

### Simple File Download (wcurl)
```bash
wcurl https://example.com/file.tar.gz
```

## Complete Command Reference

### curl Options
```
Usage: curl [options...] <url>
```

| Flag | Description |
|------|-------------|
| `-d, --data <data>` | HTTP POST data |
| `-f, --fail` | Fail fast with no output on HTTP errors |
| `-h, --help <subject>` | Get help for commands (use 'all' for all options) |
| `-o, --output <file>` | Write to file instead of stdout |
| `-O, --remote-name` | Write output to file named as remote file |
| `-i, --show-headers` | Show response headers in output |
| `-s, --silent` | Silent mode (no progress bar or error messages) |
| `-T, --upload-file <file>` | Transfer local FILE to destination |
| `-u, --user <user:password>` | Server user and password |
| `-A, --user-agent <name>` | Send User-Agent <name> to server |
| `-v, --verbose` | Make the operation more talkative |
| `-V, --version` | Show version number and quit |

*Note: curl has hundreds of options. Use `curl --help all` for the full list or `curl --help <category>` (e.g., `tls`, `http`, `proxy`).*

### wcurl Options
`wcurl` is a wrapper around curl designed to simplify file downloads.

| Flag | Description |
|------|-------------|
| `--curl-options <CURL_OPTIONS>` | Specify extra options to be passed to curl |
| `-o, -O, --output <PATH>` | Use provided output path instead of URL-derived name |
| `--no-decode-filename` | Don't percent-decode the output filename |
| `--dry-run` | Print the curl command that would be invoked without executing it |
| `-V, --version` | Print version information |
| `-h, --help` | Print usage message |

### curl-config Options
Used to get information about the libcurl installation.

| Flag | Description |
|------|-------------|
| `--built-shared` | Says 'yes' if libcurl was built shared |
| `--ca` | CA bundle install path |
| `--cc` | Compiler used |
| `--cflags` | Preprocessor and compiler flags |
| `--checkfor [version]` | Check for (lib)curl of the specified version |
| `--configure` | Arguments given to configure when building curl |
| `--features` | Newline separated list of enabled features |
| `--help` | Display help and exit |
| `--libs` | Library linking information |
| `--prefix` | curl install prefix |
| `--protocols` | Newline separated list of enabled protocols |
| `--ssl-backends` | Output the SSL backends libcurl supports |
| `--static-libs` | Static libcurl library linking information |
| `--version` | Output version information |
| `--vernum` | Output version as a hexadecimal number |

## Notes
- For security testing, use `-k` or `--insecure` to bypass SSL certificate validation on self-signed targets.
- Use `-L` or `--location` to follow HTTP redirects.
- Use `-x` or `--proxy` to route traffic through tools like Burp Suite or OWASP ZAP (e.g., `-x http://127.0.0.1:8080`).