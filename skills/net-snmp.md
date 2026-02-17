---
name: net-snmp
description: A suite of applications used to implement SNMP v1, v2c, and v3 using both IPv4 and IPv6. Use for network reconnaissance, enumerating system information (users, processes, disk usage), and managing network devices. It includes tools for walking MIB trees, getting/setting OIDs, and receiving traps.
---

# net-snmp

## Overview
Net-SNMP is a comprehensive suite of tools for the Simple Network Management Protocol (SNMP). It provides a framework for management information exchange between agents and clients. Security domains: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Net-SNMP is typically pre-installed on Kali. If missing:
```bash
sudo apt install snmp snmpd snmptrapd
```
To resolve OIDs to text descriptions, install the MIB downloader:
```bash
sudo apt install snmp-mibs-downloader
```

## Common Workflows

### Enumerate System Information (Walk)
```bash
snmpwalk -v 2c -c public 192.168.1.1
```

### Check Disk Space via SNMP
```bash
snmpdf -v 2c -c public 192.168.1.1
```

### List Running Processes
```bash
snmpps -v 2c -c public 192.168.1.1
```

### Translate OID to Name
```bash
snmptranslate .1.3.6.1.2.1.1.1.0
```

## Complete Command Reference

### Global Options (Common to most snmp* tools)
| Flag | Description |
|------|-------------|
| `-v 1\|2c\|3` | Specifies SNMP version |
| `-c COMMUNITY` | Set community string (v1/v2c) |
| `-a PROTOCOL` | Auth protocol (MD5\|SHA\|SHA-224\|SHA-256\|SHA-384\|SHA-512) |
| `-A PASS` | Auth passphrase |
| `-x PROTOCOL` | Privacy protocol (DES\|AES\|AES-192\|AES-256) |
| `-X PASS` | Privacy passphrase |
| `-l LEVEL` | Security level (noAuthNoPriv\|authNoPriv\|authPriv) |
| `-u USER` | Security name |
| `-m MIBLIST` | Load specific MIBs (ALL loads everything) |
| `-O OUTOPTS` | Output display options (f: full OIDs, n: numeric, q: quick) |

---

### snmpwalk / snmpbulkwalk
Retrieve a subtree of management values.
```bash
snmpwalk [OPTIONS] AGENT [OID]
```
- `-Cc`: Do not check returned OIDs are increasing.
- `-Ci`: Include given OID in search range.
- `-Cp`: Print number of variables found.
- `-Ct`: Display wall-clock time for walk.

---

### snmpget / snmpgetnext / snmpbulkget
Fetch specific OID values.
```bash
snmpget [OPTIONS] AGENT OID [OID]...
```
- `-Cn<NUM>`: (Bulk) Set non-repeaters.
- `-Cr<NUM>`: (Bulk) Set max-repeaters.

---

### snmpset
Modify OID values on an agent.
```bash
snmpset [OPTIONS] AGENT OID TYPE VALUE
```
**Types:** `i` (INTEGER), `u` (unsigned), `t` (TIMETICKS), `a` (IP), `o` (OBJID), `s` (STRING), `x` (HEX), `d` (DECIMAL), `b` (BITS), `F` (float), `D` (double).

---

### snmpdf
Display disk space usage.
- `-Cu`: Use UCD-SNMP dskTable.
- `-Ch`: Human readable (MiB, GiB).
- `-CH`: Human readable SI (MB, GB).

---

### snmpps
Display process table.
- `-Cp`: Show path instead of name.
- `-Ca`: Show parameters.
- `-Ct`: Sort by CPU.
- `-Cm`: Sort by Memory.

---

### snmptranslate
Translate OIDs between numeric and textual forms.
- `-T TRANSOPTS`: `p` (tree), `d` (details), `o` (OID report), `z` (child OIDs).

---

### snmpusm
Maintain SNMPv3 users.
```bash
snmpusm [OPTIONS] AGENT COMMAND
```
**Commands:** `create`, `delete`, `activate`, `deactivate`, `cloneFrom`, `changekey`, `passwd`.

---

### snmpvacm
Maintain SNMPv3 View-based Access Control.
**Commands:** `createAccess`, `deleteAccess`, `createSec2Group`, `createView`, `createAuth`.

---

### snmpd (Daemon)
The SNMP agent daemon.
- `-c FILE`: Read specific config.
- `-f`: Do not fork.
- `-L <LOGOPTS>`: Log to `e` (stderr), `o` (stdout), `f file` (file), `s` (syslog).
- `-p FILE`: Store PID in file.
- `-X`: Run as AgentX subagent.

---

### snmptrapd (Trap Receiver)
Daemon to receive and log traps.
- `-a`: Ignore auth failure traps.
- `-n`: No DNS lookups.
- `-t`: Prevent logging to syslog.

---

### net-snmp-config
Returns information about installed libraries.
- `--create-snmpv3-user`: Interactive user creation.
- `--cflags / --libs`: Compilation/Link flags.

---

### encode_keychange
Produce KeyChange string for SNMPv3.
- `-t md5|sha1`: Hash type.
- `-E [0x]ID`: EngineID.

---

### mib2c
Generate C code templates from MIB nodes.
- `-c config`: Config file.
- `-f prefix`: Output file prefix.

---

### fixproc
Fixes a process based on database rules.
- `-min / -max`: Process count limits.
- `-kill / -restart / -exist`: Actions to take.

---

### agentxtrap
Send AgentX NotifyPDU to a master agent.
- `-x ADDRESS`: AgentX address.
- `-U uptime`: Set uptime.

---

### snmpcheck
Check host SNMP access (Tk/Ascii interface).
- `-n`: List only, don't fix.
- `-y`: Always fix problems.

---

### snmpconf
Interactive configuration file creator.
- `-i`: Install to system path.
- `-g GROUP`: Ask grouped questions.

---

### snmpdelta
Monitor differences in Counter values.
- `-Cp period`: Poll period.
- `-CT`: Tabular output.

---

### snmpnetstat
Display network status via SNMP.
- `-Cr`: Routing table.
- `-Ci`: Interface table.

---

### snmpping
Command an agent to ping a remote host.
- `-Cc <pings>`: Number of pings (1-15).
- `-Cs <size>`: Extra data size.

---

### tkmib
Interactive graphical MIB browser.
- `-o OID`: Start at specific OID.

## Notes
- SNMP community strings (like `public` or `private`) are often left at defaults; always test for these during recon.
- SNMPv3 provides significantly better security (encryption/authentication) than v1/v2c.
- For OID resolution to work, you must often edit `/etc/snmp/snmp.conf` and comment out the line `mibs :`.