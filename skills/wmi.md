---
name: wmi-client
description: Execute remote queries and commands on Windows systems using the Windows Management Instrumentation (WMI) protocol. Use when performing reconnaissance, lateral movement, or remote administration on Windows hosts during penetration testing or red team engagements.
---

# wmi-client

## Overview
The `wmi-client` package provides tools (`wmic` and `wmis`) based on Samba4 sources to interact with WMI services on Windows machines (2000/XP/2003 and later). It uses RPC/DCOM mechanisms for remote command execution and data retrieval. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume the tool is installed. If not:
```bash
sudo apt install wmi-client
```

## Common Workflows

### Query System Information
Retrieve operating system details from a remote host:
```bash
wmic -U "DOMAIN\Administrator%Password123" //192.168.1.10 "SELECT Name, Version, FreePhysicalMemory FROM Win32_OperatingSystem"
```

### List Running Processes
Enumerate all active processes on a target:
```bash
wmic -U "user%pass" //10.0.0.5 "SELECT Name, ProcessId, ExecutablePath FROM Win32_Process"
```

### Remote Command Execution (wmis)
Execute commands on a remote system via WMI:
```bash
wmis -U "admin%password" //192.168.1.50
```

### Using a Credentials File
Avoid putting passwords in the command history:
```bash
wmic -A /path/to/creds.txt //192.168.1.10 "SELECT * FROM Win32_ComputerSystem"
```
*File format: `username = <name>`, `password = <pass>`, `domain = <domain>`*

## Complete Command Reference

### wmic
Used for performing WMI queries (WQL) against a remote host.

**Usage:** `wmic [options] //host "query"`

| Flag | Description |
|------|-------------|
| `--namespace=STRING` | WMI namespace, default to `root\cimv2` |
| `--delimiter=STRING` | Delimiter to use when querying multiple values, default to `\|` |
| `-?, --help` | Show help message |
| `--usage` | Display brief usage message |
| `-V, --version` | Print version |

### wmis
Used for remote interaction/execution via WMI.

**Usage:** `wmis [options] //host`

| Flag | Description |
|------|-------------|
| `-?, --help` | Show help message |
| `--usage` | Display brief usage message |
| `-V, --version` | Print version |

### Shared Options (wmic & wmis)

#### Authentication Options
| Flag | Description |
|------|-------------|
| `-U, --user=[DOMAIN\]USER[%PASS]` | Set the network username and optionally password |
| `-N, --no-pass` | Don't ask for a password |
| `--password=STRING` | Specify password separately |
| `-A, --authentication-file=FILE` | Get credentials from a specified file |
| `-S, --signing=on\|off\|required` | Set the client signing state |
| `-P, --machine-pass` | Use stored machine account password (implies -k) |
| `--simple-bind-dn=STRING` | DN to use for a simple bind |
| `-k, --kerberos=STRING` | Use Kerberos authentication |
| `--use-security-mechanisms=STR` | Restricted list of available authentication mechanisms |

#### Connection Options
| Flag | Description |
|------|-------------|
| `-R, --name-resolve=ORDER` | Use specific name resolution services (lmhosts, host, wins, bcast) |
| `-O, --socket-options=OPTIONS` | Socket options to use |
| `-n, --netbiosname=NAME` | Primary netbios name |
| `-W, --workgroup=WORKGROUP` | Set the workgroup name |
| `--realm=REALM` | Set the realm name |
| `-i, --scope=SCOPE` | Use this Netbios scope |
| `-m, --maxprotocol=PROTOCOL` | Set max protocol level |

#### Common Samba Options
| Flag | Description |
|------|-------------|
| `-d, --debuglevel=LEVEL` | Set debug level |
| `--debug-stderr` | Send debug output to STDERR |
| `-s, --configfile=FILE` | Use alternative configuration file |
| `--option=name=value` | Set smb.conf option from command line |
| `-l, --log-basename=BASE` | Basename for log/debug files |
| `--leak-report` | Enable talloc leak reporting on exit |
| `--leak-report-full` | Enable full talloc leak reporting on exit |

## Notes
- WMI typically requires administrative privileges on the target machine.
- Modern Windows systems may require specific firewall rules (RPC/DCOM) to be enabled for remote WMI access.
- If the password contains special characters, wrap the entire `-U` argument in quotes.