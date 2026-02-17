---
name: axel
description: Accelerate file downloads by using multiple connections for a single file or multiple mirrors. Use when needing to speed up the retrieval of large files, bypass per-connection bandwidth limits, or download via HTTP, HTTPS, FTP, and FTPS protocols during data exfiltration or tool staging.
---

# axel

## Overview
Axel is a light command-line download accelerator that supports HTTP, HTTPS, FTP, and FTPS. It speeds up downloads by opening multiple TCP connections to the server or utilizing multiple mirrors simultaneously. Category: Information Gathering / Utility.

## Installation (if not already installed)
Assume axel is already installed. If you get a "command not found" error:

```bash
sudo apt install axel
```

## Common Workflows

### Basic download with 10 connections
```bash
axel -n 10 https://example.com/largefile.iso
```

### Download with a speed limit (e.g., 500KB/s)
```bash
axel -s 512000 https://example.com/file.zip
```

### Download using multiple mirrors
```bash
axel http://mirror1.com/file.bin http://mirror2.com/file.bin
```

### Insecure download skipping SSL verification
```bash
axel -k https://self-signed.internal.corp/sensitive.data
```

## Complete Command Reference

```
Usage: axel [options] url1 [url2] [url...]
```

### Options

| Flag | Short | Description |
|------|-------|-------------|
| `--max-speed=x` | `-s x` | Specify maximum speed (bytes per second) |
| `--num-connections=x` | `-n x` | Specify maximum number of connections |
| `--max-redirect=x` | | Specify maximum number of redirections |
| `--output=f` | `-o f` | Specify local output file |
| `--search[=n]` | `-S[n]` | Search for mirrors and download from `n` servers |
| `--ipv4` | `-4` | Use the IPv4 protocol |
| `--ipv6` | `-6` | Use the IPv6 protocol |
| `--header=x` | `-H x` | Add HTTP header string (useful for auth or cookies) |
| `--user-agent=x` | `-U x` | Set custom User-Agent string |
| `--no-proxy` | `-N` | Do not use any proxy server |
| `--insecure` | `-k` | Don't verify the SSL certificate |
| `--no-clobber` | `-c` | Skip download if file already exists |
| `--quiet` | `-q` | Leave stdout alone (useful for scripts) |
| `--verbose` | `-v` | More status information |
| `--alternate` | `-a` | Alternate progress indicator (shows a bar for each connection) |
| `--percentage` | `-p` | Print simple percentages instead of progress bar (0-100) |
| `--timeout=x` | `-T x` | Set I/O and connection timeout |
| `--help` | `-h` | Display help information |
| `--version` | `-V` | Display version information |

## Notes
- Axel is highly effective at saturating bandwidth when the server limits speed per-connection.
- If a download is interrupted, running the same command again in the same directory will usually resume the download.
- Use the `-H` flag to pass `Authorization: Bearer <token>` or `Cookie: ...` headers for protected resources.