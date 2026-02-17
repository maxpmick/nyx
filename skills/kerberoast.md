---
name: kerberoast
description: Attack Microsoft Kerberos implementations by performing Kerberoasting, extracting Service Principal Names (SPNs), and cracking Service Tickets (TGS-REP). Use when performing Active Directory exploitation, privilege escalation, or lateral movement to obtain cleartext passwords from service account hashes.
---

# kerberoast

## Overview
A collection of tools designed to attack Microsoft Kerberos implementations. It facilitates the extraction of service accounts, requesting Kerberos tickets, and cracking the resulting TGS-REP hashes to recover service account passwords. Category: Exploitation / Password Attacks.

## Installation (if not already installed)
Assume the tools are installed. If missing, run:

```bash
sudo apt install kerberoast
```

Dependencies: python3, python3-pyasn1, python3-scapy.

## Common Workflows

### Extracting TGS-REP hashes from a PCAP file
```bash
python3 /usr/share/kerberoast/extracttgsrepfrompcap.py capture.pcap
```

### Converting .kirbi files to John the Ripper format
```bash
python3 /usr/share/kerberoast/kirbi2john.py ticket.kirbi > hashes.txt
```

### Cracking a TGS-REP hash using a wordlist
```bash
python3 /usr/share/kerberoast/tgsrepcrack.py wordlist.txt ticket.kirbi
```

### Converting PCAP to Hashcat format
```bash
python3 /usr/share/kerberoast/krbroast-pcap2hashcat.py capture.pcap > hashes.kerberoast
```

## Complete Command Reference

The toolkit consists of several scripts located in `/usr/share/kerberoast/`.

### Core Scripts

| Script | Description |
|--------|-------------|
| `GetUserSPNs.ps1` | PowerShell script to enumerate user accounts with Service Principal Names (SPNs). |
| `GetUserSPNs.vbs` | VBScript version for enumerating SPNs in environments where PowerShell is restricted. |
| `extracttgsrepfrompcap.py` | Extracts Kerberos TGS-REP packets from a network capture (PCAP) for offline cracking. |
| `kerberoast.py` | Main Python implementation for requesting and managing Kerberos tickets. |
| `kerberos.py` | Helper library containing Kerberos protocol structures and logic. |
| `kirbi2john.py` | Converts `.kirbi` (Mimikatz/Kekeo) ticket files into a format compatible with John the Ripper. |
| `krbroast-pcap2hashcat.py` | Extracts Kerberos 5 TGS-REP etype 23 hashes from PCAP files for use with Hashcat (Mode 13100). |
| `pac.py` | Script for manipulating or parsing Privilege Attribute Certificate (PAC) data. |
| `tgsrepcrack.py` | Python-based cracker for Kerberos TGS-REP tickets using a wordlist. |

### tgsrepcrack.py Usage
```bash
python3 tgsrepcrack.py <wordlist> <tgs_file.kirbi>
```

### extracttgsrepfrompcap.py Usage
```bash
python3 extracttgsrepfrompcap.py <input.pcap>
```

## Notes
- Kerberoasting is effective because it does not require sending traffic to the target service; only the Domain Controller is contacted to request the ticket.
- Service accounts often have weak passwords and high privileges (e.g., SQL Service accounts), making them primary targets.
- For modern high-speed cracking, it is recommended to use `krbroast-pcap2hashcat.py` and then use `hashcat -m 13100`.