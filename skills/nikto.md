---
name: nikto
description: Perform comprehensive vulnerability scanning against web servers to identify dangerous files, outdated server software, and specific security misconfigurations. Use when conducting web application security assessments, identifying server-side vulnerabilities, or performing initial reconnaissance on web infrastructure.
---

# nikto

## Overview
Nikto is a pluggable web server and CGI scanner that performs fast security and informational checks. it identifies over 6700 potentially dangerous files/programs, checks for outdated versions of over 1250 servers, and detects version-specific problems on over 270 servers. Category: Web Application Testing / Vulnerability Analysis / Reconnaissance.

## Installation (if not already installed)
Assume Nikto is already installed. If not:
```bash
sudo apt install nikto
```

## Common Workflows

### Basic Scan
Scan a target host on the default port (80):
```bash
nikto -h 192.168.1.1
```

### Scan with SSL and Specific Port
Force SSL and target a specific port:
```bash
nikto -h https://example.com -p 443 -ssl
```

### Comprehensive Scan with Reporting
Scan with specific tuning (Interesting files, Misconfigurations, Info Disclosure, Software ID, Admin Consoles), progress display, and HTML output:
```bash
nikto -Display 1234EP -o report.html -Format htm -Tuning 123bde -host 192.168.0.102
```

### Scan via Proxy
Route the scan through a local proxy (e.g., Burp Suite):
```bash
nikto -h example.com -useproxy http://localhost:8080
```

## Complete Command Reference

### Nikto Options
| Flag | Description |
|------|-------------|
| `-ask+` | Whether to ask about submitting updates: `yes` (default), `no`, `auto` |
| `-check6` | Check if IPv6 is working (connects to ipv6.google.com or nikto.conf value) |
| `-Cgidirs+` | Scan these CGI dirs: "none", "all", or values like "/cgi/ /cgi-a/" |
| `-config+` | Use this specific config file |
| `-Display+` | Turn on/off display outputs (see Display Codes below) |
| `-dbcheck` | Check database and other key files for syntax errors |
| `-evasion+` | Encoding technique (see Evasion Codes below) |
| `-followredirects` | Follow 3xx redirects to new location |
| `-Format+` | Save file (-o) format: `csv`, `json`, `htm`, `nbe`, `sql`, `txt`, `xml` |
| `-Help` | Show help information |
| `-host+` | Target host/URL |
| `-id+` | Host authentication to use: `id:pass` or `id:pass:realm` |
| `-ipv4` | IPv4 Only |
| `-ipv6` | IPv6 Only |
| `-key+` | Client certificate key file |
| `-list-plugins` | List all available plugins |
| `-maxtime+` | Maximum testing time per host (e.g., 1h, 60m, 3600s) |
| `-mutate+` | Guess additional file names (see Mutation Codes below) |
| `-mutate-options` | Provide information for mutates |
| `-nointeractive` | Disables interactive features |
| `-nolookup` | Disables DNS lookups |
| `-nossl` | Disables the use of SSL |
| `-noslash` | Strip trailing slash from URL |
| `-no404` | Disables nikto attempting to guess a 404 page |
| `-Option` | Over-ride an option in nikto.conf (can be used multiple times) |
| `-output+` | Write output to this file ('.' for auto-name) |
| `-Pause+` | Pause between tests (seconds) |
| `-Plugins+` | List of plugins to run (default: ALL) |
| `-port+` | Port to use (default 80) |
| `-RSAcert+` | Client certificate file |
| `-root+` | Prepend root value to all requests (e.g., /directory) |
| `-Save` | Save positive responses to this directory ('.' for auto-name) |
| `-ssl` | Force SSL mode on port |
| `-Tuning+` | Scan tuning (see Tuning Codes below) |
| `-timeout+` | Timeout for requests (default 10 seconds) |
| `-Userdbs` | Load only user databases: `all` (only user dbs), `tests` (only udb_tests) |
| `-useragent` | Over-rides the default useragent |
| `-until` | Run until the specified time or duration |
| `-url+` | Target host/URL (alias of -host) |
| `-usecookies` | Use cookies from responses in future requests |
| `-useproxy` | Use proxy defined in nikto.conf or `http://server:port` |
| `-Version` | Print plugin and database versions |
| `-vhost+` | Virtual host (for Host header) |
| `-404code` | Ignore these HTTP codes as negative responses (e.g., "302,301") |
| `-404string` | Ignore this string/regex in response body as negative response |

### Code References

**Display Codes (`-Display`)**
- `1`: Show redirects
- `2`: Show cookies received
- `3`: Show all 200/OK responses
- `4`: Show URLs which require authentication
- `D`: Debug output
- `E`: Display all HTTP errors
- `P`: Print progress to STDOUT
- `S`: Scrub output of IPs and hostnames
- `V`: Verbose output

**Evasion Codes (`-evasion`)**
- `1`: Random URI encoding (non-UTF8)
- `2`: Directory self-reference (/./)
- `3`: Premature URL ending
- `4`: Prepend long random string
- `5`: Fake parameter
- `6`: TAB as request spacer
- `7`: Change the case of the URL
- `8`: Use Windows directory separator (\)
- `A`: Use a carriage return (0x0d) as a request spacer
- `B`: Use binary value 0x0b as a request spacer

**Mutation Codes (`-mutate`)**
- `1`: Test all files with all root directories
- `2`: Guess for password file names
- `3`: Enumerate user names via Apache (/~user)
- `4`: Enumerate user names via cgiwrap (/cgi-bin/cgiwrap/~user)
- `5`: Attempt to brute force sub-domain names
- `6`: Attempt to guess directory names from dictionary file

**Tuning Codes (`-Tuning`)**
- `1`: Interesting File / Seen in logs
- `2`: Misconfiguration / Default File
- `3`: Information Disclosure
- `4`: Injection (XSS/Script/HTML)
- `5`: Remote File Retrieval - Inside Web Root
- `6`: Denial of Service
- `7`: Remote File Retrieval - Server Wide
- `8`: Command Execution / Remote Shell
- `9`: SQL Injection
- `0`: File Upload
- `a`: Authentication Bypass
- `b`: Software Identification
- `c`: Remote Source Inclusion
- `d`: WebService
- `e`: Administrative Console
- `x`: Reverse Tuning Options (include all except specified)

### Replay Utility
Replay a saved scan result.
```bash
replay [options]
```
- `-file`: Parse request from this file
- `-proxy`: Send request through this proxy (format: host:port)
- `-help`: Help output

## Notes
- Nikto is not designed to be stealthy; it will be visible in web server logs.
- Use `-Tuning x` followed by specific numbers to exclude certain tests if the scan is too slow or causing issues.
- Interactive keys during scan: `v` (verbose), `d` (debug), `p` (progress), `q` (quit).