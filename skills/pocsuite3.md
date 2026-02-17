---
name: pocsuite3
description: Open-sourced remote vulnerability testing and proof-of-concept development framework. Use for automated vulnerability verification, exploitation, and reverse shell handling. It supports loading local or remote PoCs (from Seebug), integrating with search engines like ZoomEye, Shodan, and Fofa for target discovery, and provides a console mode for interactive testing.
---

# pocsuite3

## Overview
Pocsuite3 is a powerful proof-of-concept (PoC) engine and vulnerability testing framework developed by the Knownsec 404 Team. It allows security researchers to verify vulnerabilities (verify mode), exploit them (attack mode), or obtain interactive shells (shell mode). Category: Vulnerability Analysis / Exploitation.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install pocsuite3
```

## Common Workflows

### Verify a vulnerability against a single target
```bash
pocsuite -u http://example.com/ -r test_poc.py --verify
```

### Attack a target using a remote PoC from Seebug
```bash
pocsuite -u http://example.com/ -r ssvid-97343 --attack
```

### Bulk scan targets from a file using multiple threads
```bash
pocsuite -f targets.txt -r exploit.py --verify --threads 20
```

### Search for targets via ZoomEye dork and verify
```bash
pocsuite --dork "app:apache" --zoomeye-token <TOKEN> -r apache_poc.py --verify
```

### Start an interactive console
```bash
poc-console
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--version` | Show program's version number and exit |
| `--update` | Update Pocsuite3 |
| `-n`, `--new` | Create a PoC template |
| `-v {0-6}` | Verbosity level: 0-6 (default 1) |

### Target Selection
| Flag | Description |
|------|-------------|
| `-u`, `--url URL` | Target URL/CIDR (e.g., "http://www.site.com/vuln.php?id=1") |
| `-f`, `--file FILE` | Scan multiple targets given in a textual file (one per line) |
| `-p`, `--ports PORTS` | Add additional port to each target ([proto:]port, e.g., 8080, https:10000) |
| `-s` | Skip target's default port, only use additional port |
| `-r POC` | Load PoC file from local path or remote from Seebug website |
| `-k POC_KEYWORD` | Filter PoC by keyword, e.g., "ecshop" |
| `-c CONFIGFILE` | Load options from a configuration INI file |
| `-l` | Show all PoC files from local storage |

### Mode Options
| Flag | Description |
|------|-------------|
| `--verify` | Run PoC with verify mode (non-intrusive check) |
| `--attack` | Run PoC with attack mode (exploit) |
| `--shell` | Run PoC with shell mode (get reverse shell) |

### Request Customization
| Flag | Description |
|------|-------------|
| `--cookie COOKIE` | HTTP Cookie header value |
| `--host HOST` | HTTP Host header value |
| `--referer REFERER` | HTTP Referer header value |
| `--user-agent AGENT` | HTTP User-Agent header value (default random) |
| `--proxy PROXY` | Use a proxy (protocol://host:port) |
| `--proxy-cred CRED` | Proxy authentication credentials (name:password) |
| `--timeout TIMEOUT` | Seconds to wait before timeout (default 10) |
| `--retry RETRY` | Timeout retrials times (default 0) |
| `--delay DELAY` | Delay between two requests of one thread |
| `--headers HEADERS` | Extra headers (e.g., "key1: value1\nkey2: value2") |
| `--http-debug LEVEL` | HTTP debug level (default 0) |
| `--session-reuse` | Enable requests session reuse |
| `--session-reuse-num NUM`| Requests session reuse number |

### Account & API Tokens
| Flag | Description |
|------|-------------|
| `--ceye-token TOKEN` | CEye token |
| `--oob-server SERVER` | Interactsh server to use (default "interact.sh") |
| `--oob-token TOKEN` | Authentication token for protected interactsh server |
| `--seebug-token TOKEN` | Seebug token |
| `--zoomeye-token TOKEN` | ZoomEye token |
| `--shodan-token TOKEN` | Shodan token |
| `--fofa-user USER` | Fofa user |
| `--fofa-token TOKEN` | Fofa token |
| `--quake-token TOKEN` | Quake token |
| `--hunter-token TOKEN` | Hunter token |
| `--censys-uid UID` | Censys UID |
| `--censys-secret SECRET` | Censys secret |

### Modules & Search Engine Dorks
| Flag | Description |
|------|-------------|
| `--dork DORK` | Zoomeye dork used for search |
| `--dork-zoomeye DORK` | Zoomeye dork used for search |
| `--dork-shodan DORK` | Shodan dork used for search |
| `--dork-fofa DORK` | Fofa dork used for search |
| `--dork-quake DORK` | Quake dork used for search |
| `--dork-hunter DORK` | Hunter dork used for search |
| `--dork-censys DORK` | Censys dork used for search |
| `--max-page PAGE` | Max page used in search API |
| `--page-size SIZE` | Page size used in search API |
| `--search-type TYPE` | Search type used in search API (v4, v6, web) |
| `--vul-keyword KEY` | Seebug keyword used for search |
| `--ssv-id SSVID` | Seebug SSVID number for target PoC |
| `--lhost HOST` | Connect back host for shell mode |
| `--lport PORT` | Connect back port for shell mode |
| `--tls` | Enable TLS listener in shell mode |
| `--comparison` | Compare popular web search engines |
| `--dork-b64` | Specify if dork is in base64 format |

### Optimization & Output
| Flag | Description |
|------|-------------|
| `-o`, `--output PATH` | Output file to write (JSON Lines format) |
| `--plugins PLUGINS` | Load plugins to execute |
| `--pocs-path PATH` | User defined poc scripts path |
| `--threads THREADS` | Max number of concurrent network requests (default 150) |
| `--batch` | Automatically choose default choice without asking |
| `--requires` | Check install_requires |
| `--quiet` | Activate quiet mode, working without logger |
| `--ppt` | Hide sensitive information when published to network |
| `--pcap` | Use scapy to capture flow |
| `--rule` | Export Suricata rules (request and response) |
| `--rule-req` | Only export request rule |
| `--rule-filename NAME` | Specify the name of the export rule file |
| `--no-check` | Disable URL protocol correction and honeypot check |

### Docker Environment
| Flag | Description |
|------|-------------|
| `--docker-start` | Run the docker for PoC |
| `--docker-port PORT` | Publish a container's port(s) to the host |
| `--docker-volume VOL` | Bind mount a volume |
| `--docker-env ENV` | Set environment variables |
| `--docker-only` | Only run docker environment |

### Web Hook & PoC Definitions
| Flag | Description |
|------|-------------|
| `--dingtalk-token TOKEN` | Dingtalk access token |
| `--dingtalk-secret SEC` | Dingtalk secret |
| `--wx-work-key KEY` | Weixin Work key |
| `--options` | Show all definition options for the loaded PoC |

## Notes
- **poc-console**: Launching `poc-console` provides an interactive environment. Type `help` inside the console for available commands.
- **Legal Disclaimer**: Usage of pocsuite3 for attacking targets without prior mutual consent is illegal.
- **PoC Sources**: PoCs can be local files or referenced by SSVID from Seebug.