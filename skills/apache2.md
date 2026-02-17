---
name: apache2
description: Manage and configure the Apache HTTP Server, including enabling/disabling modules, sites, and configurations, as well as benchmarking and utility tasks. Use when deploying web servers, managing virtual hosts, testing web application performance, or configuring authentication during penetration testing and web application assessments.
---

# apache2

## Overview
The Apache HTTP Server is a secure, efficient, and extensible web server. In Kali Linux, it is used for hosting web applications, serving exploits, or managing phishing sites. It includes a suite of management scripts (a2enmod, a2ensite, etc.) and utilities (ab, htpasswd) for server administration and testing. Categories: Web Application Testing, Exploitation, Social Engineering.

## Installation (if not already installed)
Assume apache2 is already installed. If not:
```bash
sudo apt install apache2 apache2-utils
```

## Common Workflows

### Enable a new site and restart
```bash
sudo a2ensite my-phishing-page.conf
sudo apache2ctl graceful
```

### Enable SSL and Proxy modules
```bash
sudo a2enmod ssl proxy proxy_http
sudo systemctl restart apache2
```

### Benchmark a web server
```bash
ab -n 1000 -c 10 http://127.0.0.1/login.php
```

### Create a basic auth password file
```bash
htpasswd -c /etc/apache2/.htpasswd admin
```

## Complete Command Reference

### Configuration Management (a2enconf / a2disconf)
Enables or disables configuration files in `/etc/apache2/conf-available/`.
- `a2enconf [options] <configuration>`
- `a2disconf [options] <configuration>`

| Flag | Description |
|------|-------------|
| `-q`, `--quiet` | Don't show informative messages |
| `-m`, `--maintmode` | Maintainer mode (not for end users) |
| `-p`, `--purge` | (a2disconf only) Purge all traces of the config in internal database |

### Module Management (a2enmod / a2dismod)
Enables or disables modules in `/etc/apache2/mods-available/`.
- `a2enmod [options] <module>`
- `a2dismod [options] <module>`

| Flag | Description |
|------|-------------|
| `-q`, `--quiet` | Don't show informative messages |
| `-f`, `--force` | (a2dismod only) Cascade disable all modules depending on this one |
| `-m`, `--maintmode` | Maintainer mode |
| `-p`, `--purge` | (a2dismod only) Purge all traces in internal database |

### Site Management (a2ensite / a2dissite)
Enables or disables virtual hosts in `/etc/apache2/sites-available/`.
- `a2ensite [options] <site>`
- `a2dissite [options] <site>`

| Flag | Description |
|------|-------------|
| `-q`, `--quiet` | Don't show informative messages |
| `-m`, `--maintmode` | Maintainer mode |
| `-p`, `--purge` | (a2dissite only) Purge all traces in internal database |

### Server Control (apache2ctl / apache2)
Interface for controlling the Apache HTTP server.

| Flag | Description |
|------|-------------|
| `-D <name>` | Define a name for use in `<IfDefine>` directives |
| `-d <dir>` | Specify an alternate initial ServerRoot |
| `-f <file>` | Specify an alternate ServerConfigFile |
| `-C "<dir>"` | Process directive before reading config files |
| `-c "<dir>"` | Process directive after reading config files |
| `-e <level>` | Show startup errors of specific level |
| `-E <file>` | Log startup errors to file |
| `-k <action>` | Action: `start`, `restart`, `graceful`, `graceful-stop`, `stop` |
| `-v` | Show version number |
| `-V` | Show compile settings |
| `-h` | List available command line options |
| `-l` | List compiled-in modules |
| `-L` | List available configuration directives |
| `-t` | Run syntax check for config files |
| `-S` | Show parsed vhost and run settings (synonym for `-t -D DUMP_VHOSTS -D DUMP_RUN_CFG`) |
| `-M` | Show all loaded modules (synonym for `-t -D DUMP_MODULES`) |
| `-T` | Start without DocumentRoot(s) check |
| `-X` | Debug mode (one worker, do not detach) |

### Benchmarking (ab)
- `ab [options] [http[s]://]hostname[:port]/path`

| Flag | Description |
|------|-------------|
| `-n <reqs>` | Number of requests to perform |
| `-c <con>` | Number of multiple requests to make at a time |
| `-t <limit>` | Seconds to max spend on benchmarking (implies -n 50000) |
| `-s <timeout>` | Seconds to wait for each response (default 30s) |
| `-p <file>` | File containing data to POST. Use with `-T` |
| `-u <file>` | File containing data to PUT. Use with `-T` |
| `-T <type>` | Content-type header for POST/PUT |
| `-v <verb>` | Verbosity level |
| `-w` | Print results in HTML tables |
| `-i` | Use HEAD instead of GET |
| `-C <attr>` | Add cookie (e.g., 'Apache=1234') |
| `-H <attr>` | Add arbitrary header line |
| `-A <auth>` | Add Basic WWW Authentication (user:pass) |
| `-X <p:port>` | Proxy server and port |
| `-k` | Use HTTP KeepAlive |
| `-m <method>` | Specify HTTP method name |
| `-f <proto>` | Specify SSL/TLS protocol (TLS1.2, TLS1.3, etc.) |

### Authentication Utilities (htpasswd / htdigest / htdbm)
- `htpasswd [-cimB25dpsDv] [-C cost] [-r rounds] passwordfile username`
- `htdigest [-c] passwordfile realm username`
- `htdbm [-cimBdpstvx] [-C cost] [-TDBTYPE] database username`

| Flag | Description |
|------|-------------|
| `-c` | Create a new file/database |
| `-b` | Use password from command line (non-interactive) |
| `-i` | Read password from stdin |
| `-m` | Force MD5 hashing (default) |
| `-B` | Force bcrypt hashing (secure) |
| `-2` | Force SHA-256 hashing |
| `-5` | Force SHA-512 hashing |
| `-D` | (htpasswd) Delete user |
| `-v` | Verify password |

### Log Utilities
- `logresolve [-s STATFILE] [-c]` (Resolve IPs in logs)
- `rotatelogs [options] <logfile> <time|size>` (Rotate logs)
- `split-logfile < logfile` (Split log by virtual host)
- `check_forensic <log_file>` (Extract mod_log_forensic output)

### Extension Tool (apxs / apxs2)
Used for building and installing extension modules.
- `apxs -g -n <modname>` (Generate template)
- `apxs -c <files>` (Compile DSO)
- `apxs -i -a -n <modname> <dsofile>` (Install and enable)

## Notes
- **Configuration Path**: `/etc/apache2/`
- **Default Web Root**: `/var/www/html/`
- **Security**: Always run `apache2ctl configtest` (or `apache2ctl -t`) before restarting to ensure no syntax errors crash the service.
- **Permissions**: Ensure the `www-data` user has appropriate permissions to files you intend to serve.