---
name: smbmap
description: Enumerate SMB shares, permissions, and contents across a domain or list of hosts. Use when performing reconnaissance, searching for sensitive data in shared drives, testing for null sessions, executing remote commands via WMI/PSExec, or performing file operations (upload/download/delete) during penetration testing.
---

# smbmap

## Overview
SMBMap is a handy SMB enumeration tool that allows users to list share drives, permissions, and contents across an entire domain. It supports Pass-the-Hash, remote command execution, and recursive file searching with auto-download capabilities. Category: Reconnaissance / Information Gathering, Password Attacks.

## Installation (if not already installed)
Assume smbmap is already installed. If you get a "command not found" error:

```bash
sudo apt install smbmap
```

## Common Workflows

### Basic Share Enumeration
List shares and permissions using a username and password:
```bash
smbmap -u jsmith -p password123 -d workgroup -H 192.168.1.10
```

### Pass-the-Hash Enumeration
Authenticate using an NTLM hash:
```bash
smbmap -u admin -p 'aad3b435b51404eeaad3b435b51404ee:da76f2c4c96028b7a6111aef4a50a94d' -H 172.16.0.20
```

### Recursive File Listing and Searching
Recursively list all files in all shares and search for specific patterns:
```bash
smbmap -u jsmith -p password123 -H 192.168.1.10 -r
```

### Remote Command Execution
Execute a system command on the target (requires appropriate permissions):
```bash
smbmap -u admin -p password123 -H 10.1.3.30 -x 'ipconfig /all'
```

### File Operations
Download a sensitive file from a known path:
```bash
smbmap -u jsmith -p password123 -H 192.168.1.10 --download 'C$\Users\Public\passwords.txt'
```

## Complete Command Reference

### Main Arguments
| Flag | Description |
|------|-------------|
| `-H HOST` | IP or FQDN of the target |
| `--host-file FILE` | File containing a list of hosts |
| `-u, --username USERNAME` | Username (if omitted, null session is assumed) |
| `-p, --password PASSWORD` | Password or NTLM hash (format: `LMHASH:NTHASH`) |
| `--prompt` | Prompt for a password |
| `-s SHARE` | Specify a specific share (default: `C$`) |
| `-d DOMAIN` | Domain name (default: `WORKGROUP`) |
| `-P PORT` | SMB port (default: `445`) |
| `-v, --version` | Return the OS version of the remote host |
| `--signing` | Check if host has SMB signing disabled, enabled, or required |
| `--admin` | Just report if the user is an admin |
| `--no-banner` | Removes the banner from the top of the output |
| `--no-color` | Removes the color from output |
| `--no-update` | Removes the "Working on it" message |
| `--timeout SCAN_TIMEOUT` | Set port scan socket timeout (default: 0.5 seconds) |

### Kerberos Settings
| Flag | Description |
|------|-------------|
| `-k, --kerberos` | Use Kerberos authentication |
| `--no-pass` | Use CCache file (requires `export KRB5CCNAME='~/current.ccache'`) |
| `--dc-ip IP or Host` | IP or FQDN of the Domain Controller |

### Command Execution
| Flag | Description |
|------|-------------|
| `-x COMMAND` | Execute a command (e.g., `'whoami'`) |
| `--mode CMDMODE` | Set execution method: `wmi` or `psexec` (default: `wmi`) |

### Share Drive Search
| Flag | Description |
|------|-------------|
| `-L` | List all drives on the specified host (requires ADMIN rights) |
| `-r [PATH]` | Recursively list dirs/files. If no path, lists root of ALL shares |
| `-g FILE` | Output to a file in a grep-friendly format (used with `-r`) |
| `--csv FILE` | Output results to a CSV file |
| `--dir-only` | List only directories, omit files |
| `--no-write-check` | Skip check to see if drive grants WRITE access |
| `-q` | Quiet mode: only show shares with READ/WRITE and suppress file listing during search |
| `--depth DEPTH` | Traverse directory tree to specific depth (default: 1) |
| `--exclude SHARE [SHARE ...]` | Exclude specific shares from searching/listing |
| `-A PATTERN` | Regex pattern to auto-download files on match (requires `-r`) |

### File Content Search (Experimental)
| Flag | Description |
|------|-------------|
| `-F PATTERN` | Search file contents for regex (requires admin and PowerShell on victim) |
| `--search-path PATH` | Path to search (used with `-F`, default: `C:\Users`) |
| `--search-timeout TIMEOUT` | Timeout in seconds for file search (default: 300) |

### Filesystem Interaction
| Flag | Description |
|------|-------------|
| `--download PATH` | Download a file from the remote system |
| `--upload SRC DST` | Upload a local file to the remote system |
| `--delete PATH` | Delete a remote file |
| `--skip` | Skip delete file confirmation prompt |

## Notes
- **Permissions**: Many features like `-L`, `-x`, and `-F` require administrative privileges on the target.
- **Null Sessions**: If no username is provided, SMBMap attempts a null session.
- **Regex**: The `-A` and `-F` flags use regular expressions; ensure patterns are properly quoted to avoid shell interference.