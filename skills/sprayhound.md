---
name: sprayhound
description: Safely perform password spraying attacks against Active Directory with Bloodhound integration. It automatically marks pwned users as owned in Bloodhound and detects attack paths to Domain Admins. Use during internal penetration testing or Active Directory assessments to identify weak credentials and escalate privileges while respecting account lockout thresholds.
---

# sprayhound

## Overview
SprayHound is a Python-based password spraying tool designed for Active Directory environments. Its primary advantage is the integration with Bloodhound, allowing it to update the Neo4j database in real-time when a password is successfully guessed. It includes safety features to prevent account lockouts by checking the `badPasswordCount` and lockout thresholds before attempting a login. Category: Exploitation / Active Directory Attacks.

## Installation (if not already installed)
Assume sprayhound is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install sprayhound
```

## Common Workflows

### Basic password spray against a domain
Spray a single password against all users discovered in the domain:
```bash
sprayhound -d adsec.local -p Winter2024!
```

### Spraying with a user list and Bloodhound integration
Spray a password against a specific list of users and update a remote Bloodhound (Neo4j) instance:
```bash
sprayhound -U users.txt -d adsec.local -p Password123! -nh 192.168.1.50 -nu neo4j -np MySecurePass
```

### Using usernames as passwords
Attempt to login using the username itself (lowercase) as the password for every user:
```bash
sprayhound -d adsec.local --lower
```

### Safe spraying with custom threshold
Only attempt a login if the user has at least 3 attempts remaining before lockout:
```bash
sprayhound -d adsec.local -p Company2024! -t 3
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--unsafe` | Enable login tries on accounts that are almost locked out |
| `--force` | Do not prompt for user confirmation before starting |
| `--nocolor` | Disable colorized output |
| `-v` | Increase verbosity level (use `-v` or `-vv`) |

### Credentials Options
| Flag | Description |
|------|-------------|
| `-u`, `--username <USER>` | Target a single username |
| `-U`, `--userfile <FILE>` | File containing a list of usernames to target |
| `-p`, `--password <PASS>` | The password to spray |
| `--lower` | Use the username in lowercase as the password |
| `--upper` | Use the username in uppercase as the password |
| `-t`, `--threshold <NUM>` | Number of password attempts allowed to remain before stopping (prevents lockout) |

### LDAP Options
| Flag | Description |
|------|-------------|
| `-dc`, `--domain-controller <IP/FQDN>` | Specify the Domain Controller to query |
| `-d`, `--domain <FQDN>` | Domain FQDN (e.g., corp.local) |
| `-lP`, `--ldap-port <PORT>` | LDAP Port (Default: 389) |
| `-lu`, `--ldap-user <USER>` | LDAP Username for initial enumeration |
| `-lp`, `--ldap-pass <PASS>` | LDAP Password for initial enumeration |
| `-lssl`, `--ldap-ssl` | Use LDAP over TLS (ldaps) |
| `-lpage`, `--ldap-page-size <SIZE>` | LDAP Paging size (Default: 200) |

### Neo4j (Bloodhound) Options
| Flag | Description |
|------|-------------|
| `-nh`, `--neo4j-host <HOST>` | Neo4J Host (Default: 127.0.0.1) |
| `-nP`, `--neo4j-port <PORT>` | Neo4J Port (Default: 7687) |
| `-nu`, `--neo4j-user <USER>` | Neo4J username (Default: neo4j) |
| `-np`, `--neo4j-pass <PASS>` | Neo4J password (Default: neo4j) |

## Notes
- **Safety**: By default, SprayHound is "safe" and will not attempt a login if it risks locking out an account based on the domain's lockout policy and the user's current `badPasswordCount`.
- **Bloodhound**: To see the impact of a successful spray, ensure your Neo4j database is populated with Bloodhound data before running the tool.
- **Permissions**: If no LDAP credentials are provided, the tool may attempt an anonymous bind, which is often disabled in modern AD environments. Provide valid low-privileged credentials for best results.