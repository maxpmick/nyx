---
name: creddump7
description: Extract Windows credentials, password hashes, and secrets from offline registry hives (SYSTEM, SAM, SECURITY). Use when performing digital forensics, offline password cracking, or post-exploitation to recover local account hashes (LM/NTLM), cached domain credentials, or LSA secrets.
---

# creddump7

## Overview
creddump7 is a Python-based toolset designed to extract various credentials and secrets from Windows registry hives. It is an updated version of the original `creddump` with fixes for modern Windows versions. It belongs to the Digital Forensics, Password Attacks, and Sniffing & Spoofing domains.

## Installation (if not already installed)
Assume the tool is already installed. If you encounter errors, install it and its dependencies:

```bash
sudo apt install creddump7
```

Dependencies: `python3`, `python3-pycryptodome`.

## Common Workflows

### Extract Local Password Hashes (SAM)
Extract LM and NTLM hashes for local user accounts.
```bash
python3 /usr/share/creddump7/pwdump.py SYSTEM SAM
```

### Extract Cached Domain Credentials
Extract "MSCACHE" hashes (Domain Cached Credentials) for domain users who have logged into the machine.
```bash
python3 /usr/share/creddump7/cachedump.py SYSTEM SECURITY
```

### Extract LSA Secrets
Extract LSA secrets, which may include service account passwords, IE passwords, and other sensitive system data.
```bash
python3 /usr/share/creddump7/lsadump.py SYSTEM SECURITY
```

## Complete Command Reference

The tool consists of three primary Python scripts located in `/usr/share/creddump7/`.

### pwdump.py
Extracts local user account hashes (LM and NTLM).

**Usage:**
```bash
python3 /usr/share/creddump7/pwdump.py <SYSTEM_HIVE> <SAM_HIVE>
```
*   `<SYSTEM_HIVE>`: Path to the Windows SYSTEM registry hive.
*   `<SAM_HIVE>`: Path to the Windows SAM registry hive.

### cachedump.py
Extracts cached domain credentials (MSCACHE/MSCASH).

**Usage:**
```bash
python3 /usr/share/creddump7/cachedump.py <SYSTEM_HIVE> <SECURITY_HIVE>
```
*   `<SYSTEM_HIVE>`: Path to the Windows SYSTEM registry hive.
*   `<SECURITY_HIVE>`: Path to the Windows SECURITY registry hive.

### lsadump.py
Extracts LSA secrets from the registry.

**Usage:**
```bash
python3 /usr/share/creddump7/lsadump.py <SYSTEM_HIVE> <SECURITY_HIVE>
```
*   `<SYSTEM_HIVE>`: Path to the Windows SYSTEM registry hive.
*   `<SECURITY_HIVE>`: Path to the Windows SECURITY registry hive.

## Notes
- This tool requires **offline** registry hives. You must first acquire these files (usually located in `C:\Windows\System32\config\`) using forensic imaging or volume shadow copy techniques if the system is live.
- On modern Kali installations, the scripts are located in `/usr/share/creddump7/`. You may need to call them with `python3` explicitly.
- The extracted hashes can be used directly with tools like `hashcat` or `John the Ripper` for cracking.