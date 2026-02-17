---
name: cmseek
description: Detect and audit over 180 Content Management Systems (CMS) including WordPress, Joomla, and Drupal. Use when performing web application reconnaissance, identifying CMS versions, or discovering potential vulnerabilities associated with specific CMS platforms during penetration testing.
---

# cmseek

## Overview
CMSeeK is a comprehensive CMS detection and exploitation suite capable of identifying over 180 different CMSs. It performs deep scans to detect versions, themes, plugins, and potential vulnerabilities. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
CMSeeK is typically pre-installed on Kali Linux. If missing, install via:

```bash
sudo apt update && sudo apt install cmseek
```

## Common Workflows

### Guided Interactive Scan
Run the tool without arguments to enter the interactive menu system, which is helpful for beginners or complex audits.
```bash
cmseek
```

### Basic Single Target Scan
Quickly identify the CMS and version of a specific domain.
```bash
cmseek -u https://example.com
```

### Fast CMS Detection (Light Scan)
Skip deep scanning and only perform CMS and version detection to save time.
```bash
cmseek -u https://example.com --light-scan
```

### Multi-Site Batch Scanning
Scan a list of targets from a file without manual intervention between sites.
```bash
cmseek -l targets.txt --batch
```

## Complete Command Reference

```bash
cmseek [OPTIONS] <Target Specification>
```

### Target Specification
| Flag | Description |
|------|-------------|
| `-u URL`, `--url URL` | Target URL to scan |
| `-l LIST`, `--list LIST` | Path to a file containing a list of sites for multi-site scanning (comma separated) |

### Manipulating Scan
| Flag | Description |
|------|-------------|
| `-i cms`, `--ignore--cms cms` | Specify CMS IDs to skip to avoid false positives (comma separated) |
| `--strict-cms cms` | Only check target against a list of provided CMS IDs (comma separated) |
| `--skip-scanned` | Skip target if its CMS was previously detected in a prior session |
| `--light-scan` | Skip Deep Scan; perform CMS and version detection only |
| `-o`, `--only-cms` | Only detect the CMS type; ignore deep scan and version detection |

### Redirect Handling
| Flag | Description |
|------|-------------|
| `--follow-redirect` | Follow all/any HTTP redirect(s) |
| `--no-redirect` | Skip all redirects and test only the input target(s) |

### User Agent Options
| Flag | Description |
|------|-------------|
| `-r`, `--random-agent` | Use a random user agent for requests |
| `--googlebot` | Use the Googlebot user agent |
| `--user-agent <UA>` | Specify a custom user agent string |

### Output & Verbosity
| Flag | Description |
|------|-------------|
| `-v`, `--verbose` | Increase output verbosity |
| `--version` | Show CMSeeK version and exit |

### Help & Miscellaneous
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `--clear-result` | Delete all previous scan results |
| `--batch` | Never prompt to "press enter" after every site in a list is scanned |

## Notes
- Scan results are typically stored in the `Result` directory within the CMSeeK installation path or `~/.cmseek/`.
- When using the `-l` flag, ensure the file contains URLs separated by commas or newlines depending on the version's specific parser.
- Use `--light-scan` or `-o` when performing large-scale reconnaissance to avoid being blocked by Web Application Firewalls (WAFs) during deep inspection phases.