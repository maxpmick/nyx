---
name: subfinder
description: Fast passive subdomain enumeration tool that discovers valid subdomains for websites by using passive online sources. Use when performing reconnaissance, information gathering, or initial footprinting during penetration testing to identify an organization's attack surface without sending traffic directly to the target's infrastructure.
---

# subfinder

## Overview
Subfinder is a subdomain discovery tool designed for passive enumeration. It utilizes a modular architecture to query various online sources (APIs, search engines, etc.) to find subdomains quickly and efficiently. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume subfinder is already installed. If you get a "command not found" error:

```bash
sudo apt install subfinder
```

## Common Workflows

### Basic passive enumeration
```bash
subfinder -d example.com
```

### Silent output for piping to other tools
```bash
subfinder -d example.com -silent | httpx
```

### Enumerate multiple domains from a list
```bash
subfinder -dL domains.txt -o results.txt
```

### Use specific sources and enable active resolution
```bash
subfinder -d example.com -s crtsh,github,virustotal -active
```

## Complete Command Reference

### Input Options
| Flag | Description |
|------|-------------|
| `-d`, `-domain string[]` | Specific domains to find subdomains for |
| `-dL`, `-list string` | File containing a list of domains for discovery |

### Source Options
| Flag | Description |
|------|-------------|
| `-s`, `-sources string[]` | Specific sources to use (e.g., `-s crtsh,github`). Use `-ls` to see all |
| `-recursive` | Use only sources that can handle subdomains recursively |
| `-all` | Use all sources for enumeration (slower but more thorough) |
| `-es`, `-exclude-sources string[]` | Sources to exclude from enumeration (e.g., `-es alienvault`) |

### Filter Options
| Flag | Description |
|------|-------------|
| `-m`, `-match string[]` | Subdomain or list of subdomains to match (file or comma separated) |
| `-f`, `-filter string[]` | Subdomain or list of subdomains to filter/remove (file or comma separated) |

### Rate-Limit Options
| Flag | Description |
|------|-------------|
| `-rl`, `-rate-limit int` | Maximum number of HTTP requests to send per second |
| `-t int` | Number of concurrent goroutines for resolving (used with `-active`) (default 10) |

### Update Options
| Flag | Description |
|------|-------------|
| `-up`, `-update` | Update subfinder to the latest version |
| `-duc`, `-disable-update-check` | Disable automatic update checks |

### Output Options
| Flag | Description |
|------|-------------|
| `-o`, `-output string` | File to write output to |
| `-oJ`, `-json` | Write output in JSONL (JSON Lines) format |
| `-oD`, `-output-dir string` | Directory to write output (used with `-dL` only) |
| `-cs`, `-collect-sources` | Include the name of the source in the output (requires `-json`) |
| `-oI`, `-ip` | Include host IP in output (requires `-active`) |

### Configuration Options
| Flag | Description |
|------|-------------|
| `-config string` | Path to flag config file (default "/root/.config/subfinder/config.yaml") |
| `-pc`, `-provider-config string` | Path to provider API config file (default "/root/.config/subfinder/provider-config.yaml") |
| `-r string[]` | Comma separated list of DNS resolvers to use |
| `-rL`, `-rlist string` | File containing a list of DNS resolvers to use |
| `-nW`, `-active` | Display active subdomains only (performs DNS resolution) |
| `-proxy string` | HTTP proxy to use with subfinder |
| `-ei`, `-exclude-ip` | Exclude IPs from the list of domains |

### Debug Options
| Flag | Description |
|------|-------------|
| `-silent` | Show only the discovered subdomains in the output |
| `-version` | Show version of subfinder |
| `-v` | Show verbose output |
| `-nc`, `-no-color` | Disable color in output |
| `-ls`, `-list-sources` | List all available sources |
| `-stats` | Report source statistics |

### Optimization Options
| Flag | Description |
|------|-------------|
| `-timeout int` | Seconds to wait before timing out (default 30) |
| `-max-time int` | Minutes to wait for enumeration results (default 10) |

## Notes
- To get the most out of subfinder, configure API keys in the `provider-config.yaml` file for sources like BinaryEdge, Censys, Chaos, GitHub, etc.
- The `-active` flag transforms subfinder from a purely passive tool to an active one by resolving the discovered subdomains.
- Use `-silent` when you intend to pipe the output to other tools like `httpx`, `naabu`, or `nuclei`.