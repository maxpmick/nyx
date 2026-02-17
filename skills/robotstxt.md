---
name: robotstxt
description: Parse and validate robots.txt files to determine which URLs are allowed or disallowed for specific crawlers. Use when performing web reconnaissance, identifying hidden directories, or testing robots.txt exclusion protocol compliance during web application security assessments.
---

# robotstxt

## Overview
A Go-based implementation of the robots.txt exclusion protocol. It provides a utility to check if specific bots are permitted to crawl certain paths based on a site's robots.txt file. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
Assume the tool is already installed. If the `robots.txt-check` command is missing:

```bash
sudo apt install robotstxt
```

## Common Workflows

### Check bot access against a remote robots.txt
```bash
robots.txt-check -robots-url https://example.com/robots.txt -bot "GoogleBot"
```

### Verify access for a custom user-agent
```bash
robots.txt-check -robots-url http://192.168.1.50/robots.txt -bot "Sqlmap"
```

## Complete Command Reference

### robots.txt-check
The primary CLI tool for validating robots.txt rules.

| Flag | Description |
|------|-------------|
| `-bot <string>` | The User-Agent string to simulate (default: "GoogleBot") |
| `-robots-url <string>` | The full URL to the robots.txt file to be parsed |
| `-h` | Show help and usage information |

## Notes
- This tool is useful for identifying "hidden" paths that developers explicitly ask search engines not to index, which often contain sensitive information or administrative panels.
- Ensure the `-robots-url` includes the protocol (http/https) and the full path to the `.txt` file.