---
name: patator
description: Multi-purpose brute-forcer with a modular design used to attack various protocols including HTTP, SSH, SMB, MySQL, and more. Use when performing password cracking, service enumeration, or fuzzing during penetration testing or vulnerability assessments.
---

# patator

## Overview
Patator is a modular and flexible multi-purpose brute-forcer. It consolidates the functionality of many separate brute-forcing tools into a single framework, supporting protocols from network services (SSH, FTP) to databases (MySQL, MSSQL) and web applications. Category: Password Attacks / Web Application Testing.

## Installation (if not already installed)
Assume patator is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install patator
```

## Common Workflows

### MySQL Brute Force
Brute-force the MySQL root user using a password list, ignoring "Access denied" messages.
```bash
patator mysql_login host=127.0.0.1 user=root password=FILE0 0=/usr/share/wordlists/rockyou.txt -x ignore:fgrep='Access denied for user'
```

### HTTP POST Brute Force
Brute-force a login form using a list of usernames and passwords.
```bash
patator http_fuzz url=http://example.com/login method=POST body='user=FILE0&pass=FILE1' 0=users.txt 1=passwords.txt -x ignore:code=200
```

### SSH Brute Force
Attempt to login via SSH with a specific user and a list of passwords.
```bash
patator ssh_login host=192.168.1.10 user=admin password=FILE0 0=passwords.txt
```

### DNS Subdomain Forward Lookup
Brute-force subdomains using a wordlist.
```bash
patator dns_forward domain=FILE0.example.com 0=subdomains.txt
```

## Complete Command Reference

### Usage
```bash
patator <module> [module_options] [global_options]
```

### Available Modules
| Module | Description |
| :--- | :--- |
| `ftp_login` | Brute-force FTP |
| `ssh_login` | Brute-force SSH |
| `telnet_login` | Brute-force Telnet |
| `smtp_login` | Brute-force SMTP |
| `smtp_vrfy` | Enumerate valid users using SMTP VRFY |
| `smtp_rcpt` | Enumerate valid users using SMTP RCPT TO |
| `finger_lookup` | Enumerate valid users using Finger |
| `http_fuzz` | Brute-force HTTP |
| `rdp_gateway` | Brute-force RDP Gateway |
| `ajp_fuzz` | Brute-force AJP |
| `pop_login` | Brute-force POP3 |
| `pop_passd` | Brute-force poppassd |
| `imap_login` | Brute-force IMAP4 |
| `ldap_login` | Brute-force LDAP |
| `dcom_login` | Brute-force DCOM |
| `smb_login` | Brute-force SMB |
| `smb_lookupsid` | Brute-force SMB SID-lookup |
| `rlogin_login` | Brute-force rlogin |
| `vmauthd_login` | Brute-force VMware Authentication Daemon |
| `mssql_login` | Brute-force MSSQL |
| `oracle_login` | Brute-force Oracle |
| `mysql_login` | Brute-force MySQL |
| `mysql_query` | Brute-force MySQL queries |
| `rdp_login` | Brute-force RDP (NLA) |
| `pgsql_login` | Brute-force PostgreSQL |
| `vnc_login` | Brute-force VNC |
| `dns_forward` | Forward DNS lookup |
| `dns_reverse` | Reverse DNS lookup |
| `snmp_login` | Brute-force SNMP v1/2/3 |
| `ike_enum` | Enumerate IKE transforms |
| `unzip_pass` | Brute-force the password of encrypted ZIP files |
| `keystore_pass` | Brute-force the password of Java keystore files |
| `sqlcipher_pass` | Brute-force the password of SQLCipher-encrypted databases |
| `umbraco_crack` | Crack Umbraco HMAC-SHA1 password hashes |
| `tcp_fuzz` | Fuzz TCP services |
| `dummy_test` | Testing module |

### Module Options Pattern
Patator uses a unique syntax for inputs. You define a placeholder (e.g., `FILE0`) in the module command and then define what `0` is:
- `FILE0`: Iterates through a file.
- `0=path/to/wordlist`: Defines the source for `FILE0`.
- `RANGE0`: Iterates through a range (e.g., `0=0-100`).

### Global Options
To see specific options for a module, run `patator <module> --help`. Common global flags include:

| Flag | Description |
| :--- | :--- |
| `-h`, `--help` | Show help message and exit |
| `-v`, `--verbose` | Increase verbosity |
| `-x` | Filter results (e.g., `-x ignore:code=404` or `-x ignore:fgrep='failed'`) |
| `-t` | Number of threads (default varies by module) |
| `-r` | Rate limit (requests per second) |

## Notes
- **Filtering**: The `-x` flag is critical for suppressing unsuccessful attempts. You can filter by HTTP code, string match (`fgrep`), or regex (`egrep`).
- **Flexibility**: Unlike tools like Hydra, Patator allows you to fuzz any part of a request (headers, paths, body parameters) by using the `FILEn` syntax.
- **Dependencies**: Some modules require specific Python libraries (e.g., `python3-paramiko` for SSH, `python3-mysqldb` for MySQL). These are typically pre-installed on Kali.