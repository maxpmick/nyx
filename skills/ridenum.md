---
name: ridenum
description: Perform RID cycling attacks to enumerate user accounts through SMB null sessions and SID-to-RID translation. Use when performing Active Directory or Windows reconnaissance, identifying valid usernames via null sessions, or conducting automated password brute-forcing against discovered accounts.
---

# ridenum

## Overview
Rid Enum is a Python-based tool designed for RID (Relative Identifier) cycling attacks. It attempts to enumerate user accounts on Windows-based systems by leveraging null sessions. If a password file is provided, the tool will automatically transition from enumeration to a brute-force attack against the discovered accounts. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume ridenum is already installed. If you encounter errors, install it and its dependencies:

```bash
sudo apt install ridenum
```
Dependencies: python3, python3-pexpect.

## Common Workflows

### Basic RID Enumeration
Enumerate users on a target IP by cycling RIDs from 500 to 1000 using a null session:
```bash
ridenum 192.168.1.50 500 1000
```

### Enumeration with Automated Brute Force
Enumerate RIDs and immediately attempt to brute force discovered users with a wordlist:
```bash
ridenum 192.168.1.50 500 50000 /usr/share/wordlists/rockyou.txt
```

### Using an Existing Username File
If you already have a list of users (formatted as `DOMAIN\USERNAME`), you can provide it to skip enumeration and move to brute forcing:
```bash
ridenum 192.168.1.50 500 50000 "" "" /root/dict.txt /root/user.txt
```

## Complete Command Reference

```bash
ridenum <server_ip> <start_rid> <end_rid> <optional_password_file> <optional_username_filename>
```
*Note: The tool's internal help and usage strings vary slightly in argument order; the standard functional syntax follows the pattern below.*

### Arguments

| Argument | Description |
|----------|-------------|
| `<server_ip>` | The IP address of the target Windows/SMB server. |
| `<start_rid>` | The RID to start the enumeration from (e.g., 500 for Administrator). |
| `<end_rid>` | The RID to stop the enumeration at (e.g., 1000 or 50000). |
| `<optional_password_file>` | Path to a dictionary file to brute force discovered users. |
| `<optional_username_filename>` | Path to a file containing pre-discovered usernames (Format: `DOMAIN\USERNAME`). |

### Positional Usage (Extended)
Based on the source documentation's example string:
`./ridenum.py <server_ip> <start_rid> <end_rid> <optional_username> <optional_password> <optional_password_file> <optional_username_filename>`

*   **optional_username**: Specific username to use for the connection.
*   **optional_password**: Specific password to use for the connection.

## Notes
- **Null Sessions**: This tool relies on the target having SMB null sessions enabled or being susceptible to SID-to-RID translation without authentication.
- **Format**: When providing a manual username file, ensure it follows the `DOMAINNAME\USERNAME` format for the tool to parse it correctly.
- **Dependencies**: The tool requires `python3-pexpect` to handle the interactive nature of SMB connections during brute-force attempts.