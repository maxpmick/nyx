---
name: cloudbrute
description: Enumerate infrastructure, files, and applications across major cloud providers including Amazon, Google, Microsoft, DigitalOcean, Alibaba, Vultr, and Linode. Use when performing reconnaissance on a target's cloud footprint, searching for publicly accessible storage buckets, or identifying cloud-hosted applications during penetration testing and bug bounty hunting.
---

# cloudbrute

## Overview
CloudBrute is a fast, concurrent black-box enumerator designed to find a target company's infrastructure and assets on top cloud providers. It supports cloud detection via IPINFO API and source code analysis, featuring user-agent and proxy randomization. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume cloudbrute is already installed. If the command is not found:

```bash
sudo apt update && sudo apt install cloudbrute
```

## Common Workflows

### Enumerate Cloud Storage for a Domain
Search for storage buckets and objects associated with a specific domain and keyword using a wordlist.
```bash
cloudbrute -d example.com -k example -w /usr/share/wordlists/dirb/common.txt -m storage
```

### Enumerate Cloud Applications with High Concurrency
Search for hosted applications across all supported providers using 100 threads and a custom output file.
```bash
cloudbrute -d example.com -k example -w wordlist.txt -m app -t 100 -o cloud_apps.txt
```

### Targeted Cloud Provider Search with Proxy
Force a search on specific providers defined in the config while using a proxy list for anonymity.
```bash
cloudbrute -d example.com -k example -w wordlist.txt -c amazon,google -p proxies.txt -a true
```

## Complete Command Reference

```
cloudbrute [Arguments]
```

### Arguments

| Flag | Long Flag | Description |
|------|-----------|-------------|
| `-h` | `--help` | Print help information |
| `-d` | `--domain` | Target domain to investigate |
| `-k` | `--keyword` | Keyword used to generate URLs for brute forcing |
| `-w` | `--wordlist` | Path to the wordlist file |
| `-c` | `--cloud` | Force a search on specific providers (check config.yaml providers list) |
| `-t` | `--threads` | Number of concurrent threads. Default: 80 |
| `-T` | `--timeout` | Timeout per request in seconds. Default: 10 |
| `-p` | `--proxy` | Path to a file containing a proxy list |
| `-a` | `--randomagent` | Enable user agent randomization |
| `-D` | `--debug` | Show debug logs. Default: false |
| `-q` | `--quite` | Suppress all output. Default: false |
| `-m` | `--mode` | Enumeration mode: `storage` or `app`. Default: storage |
| `-o` | `--output` | Output file path. Default: out.txt |
| `-C` | `--configFolder`| Path to the configuration folder. Default: /etc/cloudbrute/config |

## Notes
- **Supported Providers**: 
    - Microsoft (Storage, Apps)
    - Amazon (Storage, Apps)
    - Google (Storage, Apps)
    - DigitalOcean (Storage)
    - Vultr (Storage)
    - Linode (Storage)
    - Alibaba (Storage)
- The tool performs unauthenticated (black-box) enumeration.
- Ensure your keyword is specific to the target to reduce false positives.
- Using a high number of threads (`-t`) may lead to rate limiting; consider using proxies (`-p`) and random agents (`-a`) to mitigate this.