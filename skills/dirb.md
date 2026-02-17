---
name: dirb
description: Scan web servers for hidden directories and objects using a dictionary-based attack. Use when performing web application reconnaissance, discovering unlinked content, identifying sensitive directories, or brute-forcing CGI scripts during penetration testing.
---

# dirb

## Overview
DIRB is a specialized Web Content Scanner that launches dictionary-based attacks against web servers to find existing or hidden web objects. It functions as a content scanner rather than a vulnerability scanner, identifying files and directories that are not linked but exist on the server. Category: Web Application Testing.

## Installation (if not already installed)
Assume dirb is already installed. If the command is missing:

```bash
sudo apt install dirb
```

## Common Workflows

### Basic Scan with Default Wordlist
```bash
dirb http://192.168.1.10/
```
Uses the default `common.txt` wordlist to scan the target.

### Scan with Specific Wordlist and Extensions
```bash
dirb http://example.com/ /usr/share/wordlists/dirb/big.txt -X .php,.txt,.html
```
Searches for directories in `big.txt` and appends specified extensions to every request.

### Authenticated Scan with Custom Header
```bash
dirb http://example.com/ -u admin:password123 -H "X-Forwarded-For: 127.0.0.1"
```

### Non-Recursive Scan with Proxy
```bash
dirb http://example.com/ -r -p 127.0.0.1:8080
```
Prevents DIRB from descending into discovered subdirectories and routes traffic through a local proxy.

## Complete Command Reference

### dirb
```
dirb <url_base> [<wordlist_file(s)>] [options]
```

| Flag | Description |
|------|-------------|
| `-a <agent_string>` | Specify custom USER_AGENT (Default: "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)") |
| `-b` | Don't squash or merge sequences of /../ or /./ in the given URL |
| `-c <cookie_string>` | Set a cookie for the HTTP request |
| `-E <certificate>` | Use the specified client certificate file |
| `-f` | Fine-tuning of NOT_FOUND (404) detection |
| `-H <header_string>` | Add a custom header to the HTTP request |
| `-i` | Use case-insensitive search |
| `-l` | Print "Location" header when found |
| `-N <nf_code>` | Ignore responses with this HTTP code |
| `-o <output_file>` | Save output to disk |
| `-p <proxy[:port]>` | Use this proxy (Default port is 1080) |
| `-P <proxy_auth>` | Proxy Authentication (format: `username:password`) |
| `-r` | Don't search recursively |
| `-R` | Interactive Recursion (Ask which directories to scan) |
| `-S` | Silent Mode (Don't show tested words) |
| `-t` | Don't force an ending '/' on URLs |
| `-u <user:pass>` | Username and password for HTTP authentication |
| `-v` | Show also non-existent pages |
| `-w` | Don't stop on WARNING messages |
| `-x <ext_file>` | Amplify search with extensions listed in this file |
| `-X <extensions>` | Amplify search with these extensions (comma-separated) |
| `-z <milisecs>` | Add a delay in milliseconds between requests |

### dirb-gendict
Generate a dictionary incrementally based on a pattern.
```
dirb-gendict -type pattern
```

**Types:**
- `-n`: Numeric [0-9]
- `-c`: Character [a-z]
- `-C`: Uppercase character [A-Z]
- `-h`: Hexadecimal [0-f]
- `-a`: Alphanumeric [0-9a-z]
- `-s`: Case sensitive alphanumeric [0-9a-zA-Z]

**Pattern:**
An ASCII string where every 'X' character is replaced with the incremental value.
Example: `dirb-gendict -n user_X` generates `user_0` through `user_9`.

### html2dic
Extract words from an HTML file to create a custom dictionary.
```
html2dic <file>
```
Outputs a list of unique words found in the HTML file to stdout.

## Notes
- **Wordlists**: Default Kali wordlists are located in `/usr/share/wordlists/dirb/`.
- **Recursion**: By default, DIRB will recursively scan any directory it finds. Use `-r` to disable this behavior if the target site is large.
- **False Positives**: Use the `-f` flag if the server returns custom 200 OK pages for non-existent resources.