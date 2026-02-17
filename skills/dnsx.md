---
name: dnsx
description: Perform fast and multi-purpose DNS queries, record enumeration, and wildcard filtering using the retryabledns library. Use when performing DNS reconnaissance, validating active subdomains, identifying CDN/ASN information, or conducting DNS tracing and zone transfer (AXFR) tests during penetration testing.
---

# dnsx

## Overview
dnsx is a high-performance DNS toolkit designed for bulk resolution and record probing. It supports multiple record types (A, AAAA, CNAME, PTR, NS, MX, TXT, SOA, CAA), DNS tracing, and automated wildcard filtering. It is highly integrable into automation pipelines via stdin/stdout. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume dnsx is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install dnsx
```

## Common Workflows

### Basic Subdomain Resolution
Resolve a list of subdomains and display only those that have valid A records:
```bash
cat subdomains.txt | dnsx -silent
```

### Extract Specific Records
Query MX and NS records for a list of domains and display the responses:
```bash
dnsx -l domains.txt -mx -ns -resp
```

### Wildcard Filtering and Brute Force
Brute force subdomains using a wordlist while automatically filtering out wildcard DNS results:
```bash
dnsx -d example.com -w subdomains-top1000.txt -wt 5
```

### DNS Tracing
Trace the DNS delegation path for a specific domain:
```bash
echo "example.com" | dnsx -trace -v
```

### JSON Output with ASN/CDN Information
Perform resolution and identify if the IP belongs to a CDN or specific ASN:
```bash
dnsx -l subdomains.txt -resp -cdn -asn -json -o results.json
```

## Complete Command Reference

### Input Options
| Flag | Description |
|------|-------------|
| `-l`, `-list` | List of sub(domains)/hosts to resolve (file or stdin) |
| `-d`, `-domain` | List of domain to bruteforce (file or comma separated or stdin) |
| `-w`, `-wordlist` | List of words to bruteforce (file or comma separated or stdin) |

### Query Options
| Flag | Description |
|------|-------------|
| `-a` | Query A record (default) |
| `-aaaa` | Query AAAA record |
| `-cname` | Query CNAME record |
| `-ns` | Query NS record |
| `-txt` | Query TXT record |
| `-srv` | Query SRV record |
| `-ptr` | Query PTR record |
| `-mx` | Query MX record |
| `-soa` | Query SOA record |
| `-axfr` | Query AXFR (Zone Transfer) |
| `-caa` | Query CAA record |

### Filter Options
| Flag | Description |
|------|-------------|
| `-re`, `-resp` | Display DNS response |
| `-ro`, `-resp-only` | Display DNS response only |
| `-rc`, `-rcode` | Filter result by DNS status code (e.g., `-rcode noerror,servfail,refused`) |

### Probe Options
| Flag | Description |
|------|-------------|
| `-cdn` | Display CDN name |
| `-asn` | Display host ASN information |

### Rate-Limit Options
| Flag | Description |
|------|-------------|
| `-t`, `-threads` | Number of concurrent threads to use (default 100) |
| `-rl`, `-rate-limit` | Number of DNS requests per second (default -1, disabled) |

### Update Options
| Flag | Description |
|------|-------------|
| `-up`, `-update` | Update dnsx to latest version |
| `-duc`, `-disable-update-check` | Disable automatic dnsx update check |

### Output Options
| Flag | Description |
|------|-------------|
| `-o`, `-output` | File to write output |
| `-json` | Write output in JSONL (JSON Lines) format |

### Debug Options
| Flag | Description |
|------|-------------|
| `-hc`, `-health-check` | Run diagnostic check up |
| `-silent` | Display only results in the output |
| `-v`, `-verbose` | Display verbose output |
| `-raw`, `-debug` | Display raw DNS response |
| `-stats` | Display stats of the running scan |
| `-version` | Display version of dnsx |

### Optimization Options
| Flag | Description |
|------|-------------|
| `-retry` | Number of DNS attempts to make (must be at least 1) (default 2) |
| `-hf`, `-hostsfile` | Use system host file |
| `-trace` | Perform DNS tracing |
| `-trace-max-recursion` | Max recursion for DNS trace (default 32767) |
| `-resume` | Resume existing scan |
| `-stream` | Stream mode (wordlist, wildcard, stats, and stop/resume will be disabled) |

### Configurations Options
| Flag | Description |
|------|-------------|
| `-r`, `-resolver` | List of resolvers to use (file or comma separated) |
| `-wt`, `-wildcard-threshold` | Wildcard filter threshold (default 5) |
| `-wd`, `-wildcard-domain` | Domain name for wildcard filtering (other flags ignored, only JSON supported) |

## Notes
- **Wildcards**: dnsx handles wildcard subdomains automatically by checking for multiple random subdomains and establishing a baseline.
- **Performance**: For large-scale scans, adjust `-t` (threads) and `-rl` (rate-limit) to avoid overwhelming your network or being blocked by resolvers.
- **Resolvers**: Using a custom list of trusted resolvers (`-r`) is recommended for more accurate results and to bypass local DNS limitations.