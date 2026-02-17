---
name: dirbuster
description: Brute force directories and file names on web/application servers to discover hidden content. Use when performing web application reconnaissance, directory enumeration, or vulnerability analysis to find unlinked pages, configuration files, or administrative interfaces.
---

# dirbuster

## Overview
DirBuster is a multi-threaded Java application designed to brute force directories and file names on web and application servers. It uses custom-generated wordlists derived from internet crawls to identify actual paths used by developers, or can perform pure brute force. Category: Web Application Testing / Information Gathering.

## Installation (if not already installed)
Assume DirBuster is already installed. If the command is missing:

```bash
sudo apt install dirbuster
```
Requires: `default-jre`.

## Common Workflows

### Launch Graphical User Interface (GUI)
To start the interactive GUI mode:
```bash
dirbuster
```

### Headless Scan (CLI)
Run a non-interactive scan against a target with a specific wordlist and extensions:
```bash
dirbuster -H -u http://192.168.1.10/ -l /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt -e php,txt,html
```

### Fast Threaded Scan
Increase speed by using more threads (default is 10):
```bash
dirbuster -H -u https://example.com/ -t 50 -g
```

### Non-Recursive Discovery
Search only the specified start point without descending into discovered directories:
```bash
dirbuster -H -u http://example.com/ -s /admin/ -R
```

## Complete Command Reference

While typically launched as `dirbuster`, it is a Java wrapper. The underlying usage is:
`java -jar DirBuster-1.0-RC1.jar -u <URL> [Options]`

### Options

| Flag | Description |
|------|-------------|
| `-u <URL>` | **Required.** Target URL (e.g., http://example.com/) |
| `-h` | Display the help message |
| `-H` | Start DirBuster in headless mode (no GUI). Report is auto-saved on exit |
| `-l <file>` | Wordlist to use for list-based brute force. Default: `/usr/share/dirbuster/wordlists/directory-list-2.3-small.txt` |
| `-g` | Only use GET requests (Default: Not set, uses HEAD/GET) |
| `-e <list>` | File extension list separated by commas (e.g., `asp,aspx`). Default: `php` |
| `-t <int>` | Number of connection threads to use. Default: `10` |
| `-s <path>` | Start point of the scan. Default: `/` |
| `-v` | Verbose output. Default: Not set |
| `-P` | Don't parse HTML for links. Default: Not set |
| `-R` | Don't be recursive. Default: Not set |
| `-r <file>` | File to save report to. Default: `DirBuster-Report-[hostname]-[port].txt` |

## Notes
- **Wordlists**: Kali Linux stores DirBuster wordlists in `/usr/share/dirbuster/wordlists/`.
- **Java Dependency**: As a Java application, ensure your environment has a functional JRE if running in custom containers.
- **Recursive Scanning**: By default, DirBuster will recursively scan every directory it finds. This can take a very long time on large sites; use `-R` to disable this behavior if only the root or a specific path is of interest.
- **Headless Mode**: When using `-H`, the tool provides progress in the terminal and saves the results to a text file automatically.