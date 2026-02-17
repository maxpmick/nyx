---
name: sharphound
description: Collect Active Directory and Azure data for BloodHound CE. Use when performing internal network reconnaissance, privilege escalation path analysis, and Active Directory auditing. It identifies complex attack paths including GPO relations, ACLs, session data, and administrative rights.
---

# sharphound

## Overview
SharpHound is the official data collector for BloodHound CE (Community Edition). It gathers information about Active Directory and Azure environments to identify security relationships and attack paths. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume SharpHound is already installed. If the command or files are missing:

```bash
sudo apt install sharphound
```

The tool is located at `/usr/share/sharphound/`. Since it is a .NET executable, it is typically run on a Windows target, but can be executed via `mono` on Linux if necessary for certain operations.

## Common Workflows

### Standard Active Directory Collection
Collects group memberships, domain trusts, local admin rights, and session information.
```bash
SharpHound.exe -c All
```

### Targeted Domain Collection
Collect data from a specific domain using provided credentials.
```bash
SharpHound.exe -d internal.corp.com --domaincontroller 10.10.10.5 -c All
```

### Azure Environment Collection
Collects data from Azure/Entra ID.
```bash
SharpHound.exe -c Azure --AzureMethod Token --AzureToken <token>
```

### Stealthy Collection
Slows down the collection process to avoid detection by security monitoring.
```bash
SharpHound.exe -c All --throttle 5000 --jitter 10
```

## Complete Command Reference

### Collection Methods (-c, --collectionmethods)
| Method | Description |
|--------|-------------|
| `All` | Performs all collection methods except GPOLocalGroup |
| `Group` | Collects group memberships |
| `LocalAdmin` | Collects local administrators |
| `RDP` | Collects Remote Desktop users |
| `DCOM` | Collects Distributed COM users |
| `GPOLocalGroup` | Collects local groups via GPO (Slow) |
| `Session` | Collects user sessions |
| `ObjectProps` | Collects object properties (e.g., passwords last set) |
| `ComputerOnly` | Collects local admin, RDP, DCOM, and sessions |
| `LoggedOn` | Collects logged-on users (requires admin rights on targets) |
| `Trusts` | Collects domain trusts |
| `ACL` | Collects Access Control Lists |
| `Container` | Collects AD containers and OUs |
| `DcOnly` | Collects data only from Domain Controllers |
| `Azure` | Collects Azure/Entra ID data |

### General Options
| Flag | Description |
|------|-------------|
| `-d, --domain` | Specify the domain to target |
| `-s, --searchforest` | Search the entire forest instead of just the current domain |
| `--domaincontroller` | Specify a specific Domain Controller to connect to |
| `--ldapusername` | Username for LDAP connection |
| `--ldappassword` | Password for LDAP connection |
| `--zippassword` | Set a password for the output zip file |
| `--outputdirectory` | Directory to save the output files |
| `--outputprefix` | Prefix for the output filename |
| `--nozip` | Do not zip the output files |
| `--prettyprint` | Output formatted JSON (larger files) |
| `--throttle` | Milliseconds to wait between requests |
| `--jitter` | Percentage of jitter to add to throttle |
| `--randomizefilenames` | Use random strings for output filenames |
| `--memcache` | Use memory cache for performance (default) |
| `--nomemcache` | Disable memory cache |
| `--loop` | Loop collection continuously |
| `--loopinterval` | Time between loops (e.g., 2h, 30m) |

### Azure Options
| Flag | Description |
|------|-------------|
| `--azuremethod` | Method for Azure collection (Token, Interactive, DeviceCode) |
| `--azuretoken` | Provide an existing Azure Bearer token |
| `--azuretenant` | Specify the Azure tenant ID |

### Logging and Debugging
| Flag | Description |
|------|-------------|
| `-v` | Verbose output |
| `-h, --help` | Display help and exit |
| `--version` | Display version information |

## Notes
- SharpHound produces `.json` files (usually zipped) that must be uploaded to the BloodHound GUI for visualization.
- Running with `-c All` is noisy and may trigger EDR/AV alerts due to high volume of LDAP queries and SMB connections.
- The tool is provided in multiple formats in `/usr/share/sharphound/`:
    - `SharpHound.exe`: The primary .NET collector.
    - `SharpHound.ps1`: PowerShell implementation (often easier for fileless execution).
- Ensure the system time on the collection machine is synchronized with the Domain Controller to avoid authentication issues.