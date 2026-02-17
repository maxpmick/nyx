---
name: nuclei
description: Fast and customizable vulnerability scanner based on a YAML DSL. It sends requests across targets using templates to identify vulnerabilities with high accuracy across HTTP, DNS, TCP, File, and other protocols. Use when performing automated vulnerability assessments, scanning large-scale infrastructure for specific CVEs, or conducting targeted security checks during reconnaissance and exploitation phases.
---

# nuclei

## Overview
Nuclei is a template-based vulnerability scanner focusing on extensive configurability and ease of use. It uses a Domain Specific Language (DSL) to model security checks, allowing for zero false positives and high-speed scanning of large numbers of hosts. Category: Vulnerability Analysis / Exploitation.

## Installation (if not already installed)
Assume nuclei is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install nuclei
```

## Common Workflows

### Basic Scan against a Single Target
```bash
nuclei -u https://example.com
```

### Scan Multiple Targets with Specific Templates
```bash
nuclei -list targets.txt -t cves/ -t exposures/
```

### Automated Web Scan (Wappalyzer Integration)
```bash
nuclei -u https://example.com -as
```

### Export Results to JSON and Markdown
```bash
nuclei -u https://example.com -json-export results.json -markdown-export reports/
```

### Filter by Severity and Protocol
```bash
nuclei -u https://example.com -severity critical,high -type http
```

## Complete Command Reference

### Target Options
| Flag | Description |
|------|-------------|
| `-u, -target string[]` | Target URLs/hosts to scan |
| `-l, -list string` | Path to file containing a list of target URLs/hosts (one per line) |
| `-eh, -exclude-hosts string[]` | Hosts to exclude (IP, CIDR, hostname) |
| `-resume string` | Resume scan using resume.cfg (clustering disabled) |
| `-sa, -scan-all-ips` | Scan all IPs associated with DNS record |
| `-iv, -ip-version string[]` | IP version to scan (4, 6) (default 4) |

### Target Format Options
| Flag | Description |
|------|-------------|
| `-im, -input-mode string` | Mode of input file (list, burp, jsonl, yaml, openapi, swagger) (default "list") |
| `-ro, -required-only` | Use only required fields in input format |
| `-sfv, -skip-format-validation` | Skip format validation when parsing input file |

### Template Options
| Flag | Description |
|------|-------------|
| `-nt, -new-templates` | Run only new templates from latest release |
| `-ntv, -new-templates-version string[]` | Run new templates added in specific version |
| `-as, -automatic-scan` | Automatic web scan using wappalyzer technology detection |
| `-t, -templates string[]` | List of template or template directory to run |
| `-turl, -template-url string[]` | Template URL or list containing template URLs to run |
| `-ai, -prompt string` | Generate and run template using AI prompt |
| `-w, -workflows string[]` | List of workflow or workflow directory to run |
| `-wurl, -workflow-url string[]` | Workflow URL or list containing workflow URLs to run |
| `-validate` | Validate the passed templates |
| `-nss, -no-strict-syntax` | Disable strict syntax check on templates |
| `-td, -template-display` | Displays the templates content |
| `-tl` | List all available templates |
| `-tgl` | List all available tags |
| `-sign` | Signs templates with private key (NUCLEI_SIGNATURE_PRIVATE_KEY) |
| `-code` | Enable loading code protocol-based templates |
| `-dut, -disable-unsigned-templates` | Disable running unsigned or mismatched signature templates |
| `-esc, -enable-self-contained` | Enable loading self-contained templates |
| `-egm, -enable-global-matchers` | Enable loading global matchers templates |
| `-file` | Enable loading file templates |

### Filtering Options
| Flag | Description |
|------|-------------|
| `-a, -author string[]` | Run templates based on authors |
| `-tags string[]` | Run templates based on tags |
| `-etags, -exclude-tags string[]` | Exclude templates based on tags |
| `-itags, -include-tags string[]` | Include tags even if excluded by default |
| `-id, -template-id string[]` | Run templates based on template IDs (wildcards allowed) |
| `-eid, -exclude-id string[]` | Exclude templates based on IDs |
| `-it, -include-templates string[]` | Path to templates to execute even if excluded |
| `-et, -exclude-templates string[]` | Path to templates to exclude |
| `-em, -exclude-matchers string[]` | Template matchers to exclude in result |
| `-s, -severity value[]` | Filter by severity (info, low, medium, high, critical, unknown) |
| `-es, -exclude-severity value[]` | Exclude by severity |
| `-pt, -type value[]` | Filter by protocol (dns, file, http, headless, tcp, workflow, ssl, websocket, whois, code, javascript) |
| `-ept, -exclude-type value[]` | Exclude by protocol type |
| `-tc, -template-condition string[]` | Run templates based on expression condition |

### Output Options
| Flag | Description |
|------|-------------|
| `-o, -output string` | Output file for findings |
| `-sresp, -store-resp` | Store all request/response pairs |
| `-srd, -store-resp-dir string` | Custom directory for stored responses (default "output") |
| `-silent` | Display findings only |
| `-nc, -no-color` | Disable ANSI color output |
| `-j, -jsonl` | Write output in JSONL format |
| `-irr, -include-rr` | Include request/response in JSON/MD (Deprecated: use -omit-raw) |
| `-or, -omit-raw` | Omit request/response pairs in output |
| `-ot, -omit-template` | Omit encoded template in JSON/JSONL output |
| `-nm, -no-meta` | Disable printing result metadata |
| `-ts, -timestamp` | Print timestamp in CLI output |
| `-rdb, -report-db string` | Nuclei reporting database for persistence |
| `-ms, -matcher-status` | Display match failure status |
| `-me, -markdown-export string` | Directory for Markdown export |
| `-se, -sarif-export string` | File for SARIF export |
| `-je, -json-export string` | File for JSON export |
| `-jle, -jsonl-export string` | File for JSONL export |
| `-rd, -redact string[]` | Redact specific keys from headers/body/params |

### Configuration Options
| Flag | Description |
|------|-------------|
| `-config string` | Path to nuclei configuration file |
| `-tp, -profile string` | Template profile config file to run |
| `-tpl, -profile-list` | List community template profiles |
| `-fr, -follow-redirects` | Enable following redirects for HTTP templates |
| `-fhr, -follow-host-redirects` | Follow redirects on the same host |
| `-mr, -max-redirects int` | Max redirects to follow (default 10) |
| `-dr, -disable-redirects` | Disable redirects for HTTP templates |
| `-rc, -report-config string` | Reporting module configuration file |
| `-H, -header string[]` | Custom header/cookie (header:value) |
| `-V, -var value` | Custom vars (key=value) |
| `-r, -resolvers string` | File containing resolver list |
| `-sr, -system-resolvers` | Use system DNS as error fallback |
| `-dc, -disable-clustering` | Disable request clustering |
| `-passive` | Enable passive HTTP response processing |
| `-fh2, -force-http2` | Force HTTP2 connection |
| `-ev, -env-vars` | Enable environment variables in templates |
| `-cc, -client-cert string` | Client certificate file (PEM) |
| `-ck, -client-key string` | Client key file (PEM) |
| `-ca, -client-ca string` | Client CA file (PEM) |
| `-sml, -show-match-line` | Show match lines for file templates |
| `-sni string` | TLS SNI hostname to use |
| `-dka, -dialer-keep-alive value` | Keep-alive duration for network requests |
| `-lfa, -allow-local-file-access` | Allow file access anywhere on system |
| `-lna, -restrict-local-network-access` | Block connections to local/private network |
| `-i, -interface string` | Network interface to use |
| `-at, -attack-type string` | Payload combinations (batteringram, pitchfork, clusterbomb) |
| `-sip, -source-ip string` | Source IP for network scan |
| `-rsr, -response-size-read int` | Max response size to read in bytes |
| `-rss, -response-size-save int` | Max response size to save in bytes (default 1048576) |
| `-reset` | Remove all configuration and data files |
| `-tlsi, -tls-impersonate` | Enable experimental JA3 TLS randomization |
| `-hae, -http-api-endpoint string` | Experimental HTTP API endpoint |

### Interactsh Options
| Flag | Description |
|------|-------------|
| `-iserver, -interactsh-server string` | Interactsh server URL |
| `-itoken, -interactsh-token string` | Auth token for self-hosted Interactsh |
| `-interactions-cache-size int` | Requests to keep in cache (default 5000) |
| `-interactions-eviction int` | Seconds before evicting from cache (default 60) |
| `-interactions-poll-duration int` | Seconds between poll requests (default 5) |
| `-interactions-cooldown-period int` | Extra time for polling before exit (default 5) |
| `-ni, -no-interactsh` | Disable Interactsh for OAST testing |

### Fuzzing (DAST) Options
| Flag | Description |
|------|-------------|
| `-ft, -fuzzing-type string` | Override fuzzing type (replace, prefix, postfix, infix) |
| `-fm, -fuzzing-mode string` | Override fuzzing mode (multiple, single) |
| `-fuzz` | Enable fuzzing templates (Deprecated: use -dast) |
| `-dast` | Enable/run DAST (fuzz) templates |
| `-dts, -dast-server` | Enable DAST server mode |
| `-dtr, -dast-report` | Write DAST scan report to file |
| `-dtst, -dast-server-token string` | DAST server token |
| `-dtsa, -dast-server-address string` | DAST server address (default "localhost:9055") |
| `-dfp, -display-fuzz-points` | Display fuzz points for debugging |
| `-fuzz-param-frequency int` | Frequency of uninteresting params before skipping (default 10) |
| `-fa, -fuzz-aggression string` | Fuzzing aggression level (low, medium, high) (default "low") |
| `-cs, -fuzz-scope string[]` | In-scope URL regex |
| `-cos, -fuzz-out-scope string[]` | Out-of-scope URL regex |

### Uncover Options
| Flag | Description |
|------|-------------|
| `-uc, -uncover` | Enable uncover engine |
| `-uq, -uncover-query string[]` | Uncover search query |
| `-ue, -uncover-engine string[]` | Search engine (shodan, censys, fofa, etc.) (default shodan) |
| `-uf, -uncover-field string` | Fields to return (ip, port, host) (default "ip:port") |
| `-ul, -uncover-limit int` | Results to return (default 100) |
| `-ur, -uncover-ratelimit int` | Override engine ratelimit (default 60) |

### Rate Limit & Concurrency
| Flag | Description |
|------|-------------|
| `-rl, -rate-limit int` | Max requests per second (default 150) |
| `-rld, -rate-limit-duration value` | Rate limit duration (default 1s) |
| `-bs, -bulk-size int` | Max hosts analyzed in parallel per template (default 25) |
| `-c, -concurrency int` | Max templates executed in parallel (default 25) |
| `-hbs, -headless-bulk-size int` | Max headless hosts in parallel (default 10) |
| `-headc, -headless-concurrency int` | Max headless templates in parallel (default 10) |
| `-jsc, -js-concurrency int` | Max JS runtimes in parallel (default 120) |
| `-pc, -payload-concurrency int` | Max payload concurrency per template (default 25) |
| `-prc, -probe-concurrency int` | HTTP probe concurrency with httpx (default 50) |

### Optimization Options
| Flag | Description |
|------|-------------|
| `-timeout int` | Time to wait in seconds (default 10) |
| `-retries int` | Number of retries for failed requests (default 1) |
| `-ldp, -leave-default-ports` | Leave default HTTP/HTTPS ports |
| `-mhe, -max-host-error int` | Max errors for a host before skipping (default 30) |
| `-te, -track-error string[]` | Add error to max-host-error watchlist |
| `-nmhe, -no-mhe` | Disable skipping host based on errors |
| `-project` | Use project folder to avoid duplicate requests |
| `-project-path string` | Specific project path (default "/tmp") |
| `-spm, -stop-at-first-match` | Stop HTTP requests after first match |
| `-stream` | Stream mode (no sorting of input) |
| `-ss, -scan-strategy value` | Strategy (auto/host-spray/template-spray) (default auto) |
| `-irt, -input-read-timeout value` | Timeout on input read (default 3m0s) |
| `-nh, -no-httpx` | Disable httpx probing for non-URL input |
| `-no-stdin` | Disable stdin processing |

### Headless Options
| Flag | Description |
|------|-------------|
| `-headless` | Enable headless browser templates |
| `-page-timeout int` | Seconds to wait for each page (default 20) |
| `-sb, -show-browser` | Show browser on screen |
| `-ho, -headless-options string[]` | Additional Chrome options |
| `-sc, -system-chrome` | Use local Chrome instead of nuclei-installed |
| `-lha, -list-headless-action` | List available headless actions |

### Debug Options
| Flag | Description |
|------|-------------|
| `-debug` | Show all requests and responses |
| `-dreq, -debug-req` | Show all sent requests |
| `-dresp, -debug-resp` | Show all received responses |
| `-p, -proxy string[]` | List of HTTP/SOCKS5 proxies |
| `-pi, -proxy-internal` | Proxy all internal requests |
| `-ldf, -list-dsl-function` | List supported DSL functions |
| `-tlog, -trace-log string` | File for request trace log |
| `-elog, -error-log string` | File for request error log |
| `-version` | Show nuclei version |
| `-hm, -hang-monitor` | Enable hang monitoring |
| `-v, -verbose` | Show verbose output |
| `-vv` | Display templates loaded for scan |
| `-svd, -show-var-dump` | Show variables dump for debugging |
| `-hc, -health-check` | Run diagnostic check up |

### Update & Cloud Options
| Flag | Description |
|------|-------------|
| `-ut, -update-templates` | Update nuclei-templates |
| `-auth` | Configure ProjectDiscovery Cloud (PDCP) API key |
| `-pd, -dashboard` | Upload/view results in PDCP dashboard |
| `-sf, -secret-file string[]` | Path to secrets for authenticated scans |

## Notes
- Nuclei templates are updated frequently; use `-ut` to ensure you have the latest vulnerability checks.
- Running as root on Linux will disable the headless browser sandbox.
- Use `-rl` (rate-limit) to avoid overwhelming targets or getting blocked by WAFs.
- The `-as` (automatic scan) flag is highly effective for initial reconnaissance as it maps technologies to relevant templates.