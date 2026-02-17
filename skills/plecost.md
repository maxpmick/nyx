---
name: plecost
description: WordPress fingerprinter tool used to identify installed plugins, their versions, and associated CVE vulnerabilities. Use when performing web application reconnaissance, WordPress vulnerability assessments, or identifying outdated CMS components during penetration testing.
---

# plecost

## Overview
Plecost is a WordPress fingerprinting tool that searches for and retrieves information about installed plugin versions. It analyzes target URLs to identify the WordPress core version and plugins, cross-referencing them with a local database of CVEs. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume plecost is already installed. If you encounter errors, install via:

```bash
sudo apt install plecost
```

## Common Workflows

### Basic Scan
Scan a target using the default wordlist (top 200 most common plugins):
```bash
plecost http://example.com/wordpress
```

### High-Performance Scan
Scan using a larger wordlist and 10 concurrent connections to speed up discovery:
```bash
plecost -w plugin_list_1000.txt --concurrency 10 http://example.com
```

### Vulnerability Research
Update the local CVE and plugin databases before performing a scan:
```bash
plecost --update-all
plecost -vv -o report.json http://example.com
```

### Database Querying
Check for known vulnerabilities associated with a specific plugin without scanning a host:
```bash
plecost -vp akismet
```

## Complete Command Reference

```bash
plecost [options] [TARGET ...]
```

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-v`, `--verbosity` | Verbosity level: `-v`, `-vv`, `-vvv` |
| `-o <file>` | Report file with extension: `.xml` or `.json` |
| `-nb` | Don't display the tool banner |

### Scanner Options
| Flag | Description |
|------|-------------|
| `--hostname <name>` | Set custom hostname for the HTTP request |
| `-np`, `--no-plugins` | Do not try to find plugin versions |
| `-nc`, `--no-check-wordpress` | Do not check WordPress connectivity |
| `-nv`, `--no-wordpress-version` | Do not check WordPress version |
| `-f`, `--force-scan` | Force scan even if no WordPress installation is detected |
| `-j`, `--jackass-modes` | Jackass mode: unlimited connections to remote host |

### Wordlist Options
| Flag | Description |
|------|-------------|
| `-w <wordlist>`, `--wordlist <wordlist>` | Set custom wordlist (Default: 200 most common) |
| `-l`, `--list-wordlist` | List embedded available wordlists |

### Advanced Options
| Flag | Description |
|------|-------------|
| `-c <num>`, `--concurrency <num>` | Number of parallel processes/connections |

### Update Options
| Flag | Description |
|------|-------------|
| `--update-cve` | Update the local CVE database |
| `--update-plugins` | Update the local plugins list |
| `--update-all` | Update CVE, plugins, and core databases |

### Database Search Options
| Flag | Description |
|------|-------------|
| `-sp`, `--show-plugins` | Display all plugins currently in the local database |
| `-vp <plugin>`, `--plugin-cves <plugin>` | Display known CVEs for a specific plugin |
| `--cve <cve_id>` | Display specific details of a CVE |

## Notes
- **Rate Limiting**: Using high concurrency (`-c`) or "jackass mode" (`-j`) may trigger Web Application Firewalls (WAF) or result in 403/429 errors from the target server.
- **Accuracy**: Plugin detection is based on the presence of specific paths; if a site uses security plugins to hide the `/wp-content/plugins/` directory, results may be limited.
- **Legacy Flags**: Some older documentation references `-n`, `-s`, `-M`, or `-i`. In current versions, use `-w` for wordlists and `-c` for concurrency.