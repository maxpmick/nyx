---
description: Comprehensive vulnerability scan
---
Run comprehensive vulnerability scanning against: $ARGUMENTS

Known hosts:
!`nyx-memory notes_read hosts 2>/dev/null || echo "No hosts documented yet — run /recon first"`

Execute targeted scans based on discovered services. Wrap every tool execution with `nyx-log` for automatic command logging. Use `ingest_tool_output` after every supported scan to auto-extract hosts, services, and findings.

## Network Services

- Full port scan if not already done:
  ```
  nyx-log nmap -p- -sV --min-rate 1000 -oX full_port_scan.xml $TARGET
  ```
  Then `ingest_tool_output` on the XML output
- NSE vulnerability scripts on discovered ports:
  ```
  nyx-log nmap --script vuln -p $PORTS -oX vuln_scan.xml $TARGET
  ```
  Then `ingest_tool_output` on the result
- Service-specific enumeration based on what's open:
  - **SMB** (445): `nyx-log enum4linux-ng -A $TARGET`, `nyx-log smbmap -H $TARGET`
  - **SNMP** (161): `nyx-log snmpcheck -t $TARGET`
  - **LDAP** (389/636): `nyx-log ldapsearch` queries
  - **RPC** (111): `nyx-log rpcclient -U "" $TARGET`
  - **DNS** (53): zone transfers, version queries
  - **SMTP** (25): `nyx-log smtp-user-enum`

## Web Applications (if HTTP/HTTPS found)

- `nyx-log nikto -h $URL -output nikto_results.txt` → then `ingest_tool_output`
- `nyx-log feroxbuster -u $URL -w /usr/share/wordlists/dirb/common.txt -o ferox.txt` → run `ingest_tool_output` only if this parser exists in your nyx-memory version
- `nyx-log ffuf -u $URL/FUZZ -w /usr/share/wordlists/dirb/common.txt -o ffuf.json -of json` → run `ingest_tool_output` only if this parser exists in your nyx-memory version
- CMS detection → specific scanners: `wpscan`, `joomscan`, `droopescan`
- Manual checks: SQLi, XSS, SSRF, IDOR, auth bypass, file upload, path traversal
- API endpoint discovery and testing if applicable

## Authentication Services

- Default credential checks on all discovered services
- Brute-force only if explicitly authorized in scope

## SSL/TLS

- `nyx-log sslscan $TARGET` or `nyx-log testssl.sh $TARGET`

## Documentation

- `ingest_tool_output` is your primary tool after running supported parsers (always include nmap/masscan/gobuster/nikto; ffuf/feroxbuster only when supported by your nyx-memory build)
- `finding_add` for anything not auto-captured: manual discoveries, logic flaws, chained vulns. Include severity (critical/high/medium/low/info) and CVSS where applicable
- `evidence_save` for raw output files and screenshots
- `host_update` to append scan notes to host files
- `dead_end_log` for services that were investigated but yielded nothing useful
- `todo_add` for exploitation candidates

Provide a prioritized summary at the end: critical and high findings first, with a recommended exploitation order.
