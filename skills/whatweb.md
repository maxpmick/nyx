---
name: whatweb
description: Identify web technologies including CMS, blogging platforms, JavaScript libraries, web servers, and embedded devices. Use when performing web reconnaissance, vulnerability analysis, or fingerprinting a target's technology stack to identify version numbers, email addresses, and potential attack vectors.
---

# whatweb

## Overview
WhatWeb is a next-generation web scanner that identifies technologies used by websites. It features over 900 plugins to recognize content management systems (CMS), statistics packages, web frameworks, and more. It can also identify version numbers, account IDs, and SQL errors. Category: Reconnaissance / Information Gathering, Vulnerability Analysis, Web Application Testing.

## Installation (if not already installed)
Assume whatweb is already installed. If you encounter a "command not found" error:

```bash
sudo apt install whatweb
```

## Common Workflows

### Basic scan of a single target
```bash
whatweb example.com
```

### Aggressive scan with verbose output
```bash
whatweb -a 3 -v www.wired.com
```
Level 3 aggression makes additional requests if a level 1 plugin is matched, helping to identify exact versions.

### Network-wide scan with prefixing
```bash
whatweb --no-errors --url-prefix https:// 192.168.0.0/24
```
Scans an entire CIDR range specifically for HTTPS services while suppressing error messages.

### Scan from file with specific plugin and suffix
```bash
whatweb -i targets.txt --url-suffix /crossdomain.xml -p crossdomain_xml
```
Reads targets from a file, appends a path, and runs only the `crossdomain_xml` plugin.

## Complete Command Reference

### Target Selection
| Flag | Description |
|------|-------------|
| `<TARGETs>` | Enter URLs, hostnames, IP addresses, filenames, or IP ranges (CIDR, x.x.x-x, or x.x.x.x-x.x.x.x) |
| `--input-file=FILE`, `-i` | Read targets from a file. Use `/dev/stdin` to pipe targets |

### Target Modification
| Flag | Description |
|------|-------------|
| `--url-prefix` | Add a prefix to target URLs |
| `--url-suffix` | Add a suffix to target URLs |
| `--url-pattern` | Insert targets into a URL (e.g., `example.com/%insert%/robots.txt`) |

### Aggression
| Flag | Description |
|------|-------------|
| `--aggression`, `-a=LEVEL` | Set aggression level (Default: 1) |
| `1. Stealthy` | One HTTP request per target; follows redirects |
| `3. Aggressive` | Makes additional requests if a level 1 plugin is matched |
| `4. Heavy` | Makes many HTTP requests; attempts URLs from all plugins |

### HTTP Options
| Flag | Description |
|------|-------------|
| `--user-agent`, `-U=AGENT` | Identify as AGENT instead of WhatWeb/0.6.3 |
| `--header`, `-H` | Add an HTTP header (e.g., "Foo:Bar"). Empty value removes a header |
| `--follow-redirect=WHEN` | When to follow redirects: `never`, `http-only`, `meta-only`, `same-site`, or `always` (Default: always) |
| `--max-redirects=NUM` | Maximum number of redirects (Default: 10) |

### Authentication
| Flag | Description |
|------|-------------|
| `--user`, `-u=<user:pass>` | HTTP basic authentication |
| `--cookie`, `-c=COOKIES` | Use cookies (e.g., 'name=value; name2=value2') |
| `--cookie-jar=FILE` | Read/save cookies to a file |
| `--no-cookies` | Disable automatic cookie handling |

### Proxy
| Flag | Description |
|------|-------------|
| `--proxy` | `<hostname[:port]>` Set proxy (Default: 8080) |
| `--proxy-user` | `<username:password>` Set proxy credentials |

### Plugins
| Flag | Description |
|------|-------------|
| `--list-plugins`, `-l` | List all plugins |
| `--info-plugins`, `-I=[SEARCH]` | List detailed info for plugins; optionally search keywords |
| `--search-plugins=STRING` | Search plugins for a keyword |
| `--plugins`, `-p=LIST` | Select plugins (comma-delimited). Supports modifiers +/- and directories |
| `--grep`, `-g=STR\|REGEX` | Search for string or regex in results |
| `--custom-plugin=DEF` | Define a custom plugin (e.g., `":text=>'powered by abc'"` ) |
| `--dorks=PLUGIN` | List Google dorks for the selected plugin |

### Output & Logging
| Flag | Description |
|------|-------------|
| `--verbose`, `-v` | Verbose output (plugin descriptions). Use twice for debugging |
| `--colour`, `--color=WHEN` | Control color: `never`, `always`, or `auto` |
| `--quiet`, `-q` | Do not display brief logging to STDOUT |
| `--no-errors` | Suppress error messages |
| `--log-brief=FILE` | Log brief, one-line output |
| `--log-verbose=FILE` | Log verbose output |
| `--log-errors=FILE` | Log errors |
| `--log-xml=FILE` | Log XML format |
| `--log-json=FILE` | Log JSON format |
| `--log-sql=FILE` | Log SQL INSERT statements |
| `--log-sql-create=FILE` | Create SQL database tables |
| `--log-json-verbose=FILE` | Log JSON Verbose format |
| `--log-magictree=FILE` | Log MagicTree XML format |
| `--log-object=FILE` | Log Ruby object inspection format |
| `--log-mongo-database` | Name of MongoDB database |
| `--log-mongo-collection` | Name of MongoDB collection (Default: whatweb) |
| `--log-mongo-host` | MongoDB hostname/IP (Default: 0.0.0.0) |
| `--log-mongo-username` | MongoDB username |
| `--log-mongo-password` | MongoDB password |
| `--log-elastic-index` | Elastic index name (Default: whatweb) |
| `--log-elastic-host` | Elastic host:port (Default: 127.0.0.1:9200) |

### Performance & Stability
| Flag | Description |
|------|-------------|
| `--max-threads`, `-t` | Number of simultaneous threads (Default: 25) |
| `--open-timeout` | Connection timeout in seconds (Default: 15) |
| `--read-timeout` | Read timeout in seconds (Default: 30) |
| `--wait=SECONDS` | Wait between connections (useful for single-threaded scans) |

## Notes
- Aggression level 1 is recommended for initial discovery to avoid triggering WAFs or rate limits.
- Use `--no-cookies` when scanning with very high thread counts to improve performance.
- Custom plugins can be defined on the fly using the `--custom-plugin` flag for specific string or MD5 matches.