---
name: xsser
description: Automatic framework to detect, exploit, and report XSS vulnerabilities in web-based applications. It features advanced filter bypassing, WAF/IDS evasion, and specialized injection techniques like DOM-based XSS, Cookie injection, and Cross Site Tracing (XST). Use during web application security assessments to automate the discovery and exploitation of Cross-Site Scripting vulnerabilities.
---

# xsser

## Overview
XSSer (Cross Site "Scripter") is a comprehensive framework for automated XSS auditing. It can prepare payloads, bypass filters, and generate reports. It supports various injection methods (GET, POST, Cookies, Referer) and includes specialized tools for creating XSS-laden images or Flash files. Category: Web Application Testing.

## Installation (if not already installed)
Assume xsser is already installed. If not:
```bash
sudo apt update && sudo apt install xsser
```

## Common Workflows

### Simple GET-based Audit
```bash
xsser -u "http://example.com/search.php?q=XSS"
```
Replaces the `XSS` keyword with various payloads to test for vulnerabilities.

### Automated Crawling and Auditing
```bash
xsser --all "http://example.com" -c 10
```
Crawls the target for up to 10 URLs and automatically audits them for XSS.

### POST-based Injection with Proxy (Tor)
```bash
xsser -u "http://example.com/login.php" -p "user=XSS&pass=1234" --proxy "http://localhost:8118"
```

### Bypassing WAFs using Heuristics and Encoding
```bash
xsser -u "http://example.com/page.php?id=XSS" --heuristic --Str --Hex --Modsec
```
Uses heuristics to find filters, encodes payloads with String.FromCharCode and Hex, and applies Mod-Security bypass rules.

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `--version` | Show program's version number and exit |
| `-h`, `--help` | Show help message and exit |
| `-s`, `--statistics` | Show advanced statistics output results |
| `-v`, `--verbose` | Active verbose mode output results |
| `--gtk` | Launch XSSer GTK Graphical Interface |
| `--wizard` | Start Wizard Helper for guided configuration |

### Special Features
| Flag | Description |
|------|-------------|
| `--imx=IMX` | Create an image with XSS embedded (e.g., `--imx image.png`) |
| `--fla=FLASH` | Create a flash movie with XSS embedded (e.g., `--fla movie.swf`) |
| `--xst=XST` | Test for Cross Site Tracing [CAPEC-107] |

### Select Target(s)
| Flag | Description |
|------|-------------|
| `--all=TARGET` | Automatically audit an entire target |
| `-u URL`, `--url=URL` | Enter specific target URL to audit |
| `-i READFILE` | Read target(s) urls from a file |
| `-d DORK` | Search target(s) using a search engine query |
| `-l` | Search from a pre-defined list of 'dorks' |
| `--De=ENGINE` | Use specific search engine (default: DuckDuckGo) |
| `--Da` | Search massively using all available search engines |

### HTTP/HTTPS Connection Types
| Flag | Description |
|------|-------------|
| `-g GETDATA` | Send payload using GET (use 'XSS' as placeholder) |
| `-p POSTDATA` | Send payload using POST (use 'XSS' as placeholder) |
| `-c CRAWLING` | Number of urls to crawl on target(s): 1-99999 |
| `--Cw=WIDTH` | Deeping level of crawler: 1-5 (default: 2) |
| `--Cl` | Crawl only local target(s) urls (default: FALSE) |

### Configure Request(s)
| Flag | Description |
|------|-------------|
| `--head` | Send a HEAD request before starting a test |
| `--cookie=COOKIE` | Set HTTP Cookie header |
| `--drop-cookie` | Ignore Set-Cookie header from response |
| `--user-agent=UA` | Set HTTP User-Agent header (default: SPOOFED) |
| `--referer=REF` | Set HTTP Referer header |
| `--xforw` | Set HTTP X-Forwarded-For with random IP values |
| `--xclient` | Set HTTP X-Client-IP with random IP values |
| `--headers=HDRS` | Extra HTTP headers newline separated |
| `--auth-type=TYPE` | HTTP Auth type (Basic, Digest, GSS or NTLM) |
| `--auth-cred=CRED` | HTTP Auth credentials (name:password) |
| `--check-tor` | Check if Tor is being used properly |
| `--proxy=PROXY` | Use proxy server (e.g., `http://localhost:8118`) |
| `--ignore-proxy` | Ignore system default HTTP proxy |
| `--timeout=SEC` | Connection timeout in seconds (default: 30) |
| `--retries=NUM` | Retries on connection timeout (default: 1) |
| `--threads=NUM` | Max concurrent requests (default: 5) |
| `--delay=SEC` | Delay in seconds between requests (default: 0) |
| `--tcp-nodelay` | Use the TCP_NODELAY option |
| `--follow-redirects`| Follow server redirections |
| `--follow-limit=L` | Set limit for redirection requests (default: 50) |

### Checker Systems
| Flag | Description |
|------|-------------|
| `--hash` | Send a hash to check if target is repeating content |
| `--heuristic` | Discover parameters filtered by using heuristics |
| `--discode=CODE` | Set HTTP code on reply to discard an injection |
| `--checkaturl=URL` | Check reply using alternative URL (Blind-XSS) |
| `--checkmethod=M` | Check reply using GET or POST (default: GET) |
| `--checkatdata=D` | Check reply using alternative payload |
| `--reverse-check` | Establish a reverse connection from target to XSSer |

### Vector and Payload Selection
| Flag | Description |
|------|-------------|
| `--payload=SRC` | Inject your own custom code |
| `--auto` | Inject a list of vectors provided by XSSer |
| `--auto-set=NUM` | Limit of vectors to inject (default: 1293) |
| `--auto-info` | Select ONLY vectors with INFO (default: FALSE) |
| `--auto-random` | Set random order for vectors |

### Anti-antiXSS / WAF Bypassing
| Flag | Description |
|------|-------------|
| `--Phpids0.6.5` | Target PHPIDS (0.6.5) |
| `--Phpids0.7` | Target PHPIDS (0.7) |
| `--Imperva` | Target Imperva Incapsula |
| `--Webknight` | Target WebKnight (4.1) |
| `--F5bigip` | Target F5 Big IP |
| `--Barracuda` | Target Barracuda WAF |
| `--Modsec` | Target Mod-Security |
| `--Quickdefense` | Target QuickDefense |
| `--Sucuri` | Target SucuriWAF |
| `--Firefox` | Target Firefox 12 & below |
| `--Chrome` | Target Chrome 19 & Firefox 12 |
| `--Opera` | Target Opera 10.5 & below |
| `--Iexplorer` | Target IExplorer 9 & Firefox 12 |

### Bypasser (Encoding) Options
| Flag | Description |
|------|-------------|
| `--Str` | Use String.FromCharCode() |
| `--Une` | Use Unescape() function |
| `--Mix` | Mix String.FromCharCode() and Unescape() |
| `--Dec` | Use Decimal encoding |
| `--Hex` | Use Hexadecimal encoding |
| `--Hes` | Use Hexadecimal encoding with semicolons |
| `--Dwo` | Encode IP addresses with DWORD |
| `--Doo` | Encode IP addresses with Octal |
| `--Cem=CEM` | Character Encoding Mutations (e.g., 'Mix,Une,Str,Hex') |

### Special Techniques
| Flag | Description |
|------|-------------|
| `--Coo` | Cross Site Scripting Cookie injection |
| `--Xsa` | Cross Site Agent Scripting |
| `--Xsr` | Cross Site Referer Scripting |
| `--Dcp` | Data Control Protocol injections |
| `--Dom` | Document Object Model (DOM) injections |
| `--Ind` | HTTP Response Splitting Induced code |

### Final Injections and Exploitation
| Flag | Description |
|------|-------------|
| `--Fp=PAYLOAD` | Exploit with your own final code |
| `--Fr=REMOTE` | Exploit with a remote script |
| `--Anchor` | Use 'Anchor Stealth' payloader (DOM shadows) |
| `--B64` | Base64 code encoding in META tag (rfc2397) |
| `--Onm` | Use onMouseMove() event |
| `--Ifr` | Use `<iframe>` source tag |
| `--Dos` | XSS (client-side) Denial of Service |
| `--Doss` | XSS (server-side) Denial of Service |

### Reporting and Misc
| Flag | Description |
|------|-------------|
| `--save` | Export to file (XSSreport.raw) |
| `--xml=FILE` | Export to XML format |
| `--silent` | Inhibit console output |
| `--alive=NUM` | Set limit of errors before checking if target is alive |
| `--update` | Check for latest stable version |

## Notes
- **Keyword**: Always use the string `XSS` in your `-g` or `-p` data to tell XSSer where to inject.
- **Stealth**: Use `--delay` and `--user-agent` to avoid detection by basic rate-limiting or signature-based filters.
- **DOM XSS**: The `--Dom` and `--Anchor` flags are specifically useful for modern single-page applications.