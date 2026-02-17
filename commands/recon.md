---
description: Reconnaissance on a target
---
Perform reconnaissance on: $ARGUMENTS

Current engagement state:
!`nyx-memory status 2>/dev/null || echo "No active engagement — run /engage first"`

Execute a structured recon workflow. Document everything as you go using nyx-memory MCP tools. Use `nyx-log` to wrap tool executions so commands are automatically logged with timing and exit codes via `command_log`.

## Phase 1 — Passive Recon

- WHOIS lookup and registration details
- DNS enumeration: subdomains, zone transfer attempts, all record types (A, AAAA, MX, TXT, NS, SOA, SPF, DMARC, DKIM)
- Certificate transparency discovery: `crt.sh`, `subfinder`
- Technology fingerprinting from headers, responses, and public-facing assets
- Public exposure via web search (Shodan, Censys, public disclosures)
- Harvest emails/usernames: `nyx-log theHarvester -d $DOMAIN -b all`

Register every discovered host immediately with `host_discover` including any services or OS info found passively.

## Phase 2 — Active Recon

- Host discovery: `nyx-log nmap -sn $TARGET`
- Port scan with service/version detection:
  ```
  nyx-log nmap -sV -sC -O -oX recon_scan.xml $TARGET
  ```
- After the scan completes, use `ingest_tool_output` with the nmap XML/output to auto-extract hosts, services, and findings — this is faster and more reliable than manual parsing
- Subdomain brute-forcing if applicable: `nyx-log ffuf` or `nyx-log gobuster dns`
- Web directory enumeration on any HTTP/HTTPS services found:
  ```
  nyx-log feroxbuster -u $URL -w /usr/share/wordlists/dirb/common.txt -o ferox_output.txt
  ```
  If your nyx-memory version supports feroxbuster parsing, then run `ingest_tool_output`; otherwise capture findings manually with `host_update` and `finding_add`
- SSL/TLS analysis if applicable

## Documentation

- `host_discover` for every host found (with services, OS, hostnames)
- `finding_add` for anything notable: misconfigurations, exposed services, version disclosures, default pages
- `evidence_save` for raw scan output files
- `todo_add` for follow-up items discovered during recon
- `attack_path_update` if recon reveals a clear initial access vector
- Use `host_update` to append enumeration notes to specific hosts

After each phase, summarize what was found and recommend next steps. Mark recon TODOs as complete with `todo_complete`.
