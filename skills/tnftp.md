---
name: tnftp
description: Transfer files over the network using FTP, HTTP, HTTPS, and local file protocols. Use when performing file transfers, interacting with FTP servers, downloading payloads via HTTP/S, or bypassing restricted environments using an enhanced FTP client with proxy and IPv6 support.
---

# tnftp

## Overview
tnftp is an enhanced FTP client (originally from NetBSD) that supports command-line editing, URL fetching (HTTP, HTTPS, FTP), IPv6, and transfer-rate throttling. It is a versatile tool for both interactive file management and automated command-line downloads. Category: Sniffing & Spoofing / Information Gathering.

## Installation (if not already installed)

Assume tnftp is already installed. If you get a "command not found" error:

```bash
sudo apt install tnftp
```

## Common Workflows

### Download a file via HTTP/HTTPS
```bash
tnftp -o local_file.txt http://example.com/remote_file.txt
```

### Connect to an FTP server anonymously
```bash
tnftp -n ftp.example.com
```

### Upload a file using a URL-style command
```bash
tnftp -u ftp://user:password@ftp.example.com/path/to/upload/ local_file.txt
```

### Download with rate limiting
```bash
tnftp -T all,50k http://example.com/large_file.iso
```
Limits the transfer to 50KB/s.

## Complete Command Reference

### Usage Patterns
```
tnftp [-46AadefginpRtVv] [-N NETRC] [-o OUTPUT] [-P PORT] [-q QUITTIME] [-r RETRY] [-s SRCADDR] [-T DIR,MAX[,INC]] [-x XFERSIZE] [[USER@]HOST [PORT]] [[USER@]HOST:[PATH][/]] [file:///PATH] [ftp://[USER[:PASSWORD]@]HOST[:PORT]/PATH[/][;type=TYPE]] [http://[USER[:PASSWORD]@]HOST[:PORT]/PATH] [https://[USER[:PASSWORD]@]HOST[:PORT]/PATH]
tnftp -u URL FILE ...
tnftp -?
```

### General Options

| Flag | Description |
|------|-------------|
| `-4` | Forces tnftp to use IPv4 addresses only |
| `-6` | Forces tnftp to use IPv6 addresses only |
| `-A` | Force active mode FTP |
| `-a` | Causes tnftp to bypass normal login procedure and use anonymous login |
| `-d` | Enables debugging |
| `-e` | Disables command-line editing |
| `-f` | Forces a cache reload for HTTP transfers |
| `-g` | Disables file name globbing |
| `-i` | Turns off interactive prompting during multiple file transfers |
| `-n` | Restrains tnftp from attempting "auto-login" upon initial connection |
| `-p` | Use passive mode for data transfers (default) |
| `-R` | Restart a failed download (resume) |
| `-t` | Enables packet tracing |
| `-V` | Disable the progress meter and other verbose output |
| `-v` | Verbose; show all responses from the remote server |
| `-?` | Display help/usage information |

### Advanced Configuration Options

| Flag | Description |
|------|-------------|
| `-N netrc` | Use `netrc` instead of the default `~/.netrc` file |
| `-o output` | Specify the output filename for URL-based fetches |
| `-P port` | Specify the port number to connect to |
| `-q quittime` | Quit if the connection is stalled for `quittime` seconds |
| `-r retry` | Number of times to retry a connection if it fails |
| `-s srcaddr` | Set the local IP address for all connections |
| `-T dir,max[,inc]` | Set transfer rate throttle. `dir` is 'get', 'put', or 'all'. `max` is bytes/sec. `inc` is the increment |
| `-u URL FILE` | Upload `FILE` to the specified `URL` |
| `-x xfersize` | Set the size of the socket send/receive buffers |

## Notes
- tnftp is the default `ftp` client on many modern Kali installations (via a transitional package).
- It supports `$http_proxy` and `$ftp_proxy` environment variables for proxied connections.
- Context-sensitive command and filename completion is available within the interactive shell.
- Use the `-p` (passive) flag if you are behind a firewall or NAT that blocks incoming data connections.