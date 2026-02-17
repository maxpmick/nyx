---
name: netkit-tftp
description: Transfer files to and from a remote machine using the Trivial File Transfer Protocol (TFTP). Use when performing exploitation to upload payloads, exfiltrate small configuration files, or interact with network devices (routers, switches, PXE boot servers) that lack full FTP/SSH capabilities.
---

# netkit-tftp

## Overview
`tftp` is the user interface to the Internet Trivial File Transfer Protocol, which allows users to transfer files to and from a remote machine. It is typically used for booting diskless workstations or transferring configurations to network hardware. Category: Exploitation / Information Gathering.

## Installation (if not already installed)
The `tftp` package in Kali is often a transitional package for `tftp-hpa`.

```bash
sudo apt install tftp
```

## Common Workflows

### Connect and Download a File
```bash
tftp 192.168.1.50
tftp> get config.txt
tftp> quit
```

### Upload a Payload to a Target
```bash
tftp 192.168.1.50
tftp> put shell.php
tftp> quit
```

### One-liner (Non-interactive)
Note: The standard netkit-tftp client is primarily interactive. For scripted usage, commands are often piped:
```bash
echo "get backup.cfg" | tftp 192.168.1.100
```

## Complete Command Reference

### Usage
```bash
tftp [host]
```

Once started, `tftp` displays a `tftp>` prompt and accepts the following commands:

| Command | Description |
|---------|-------------|
| `? [command-name]` | Print help information. |
| `ascii` | Shorthand for `mode ascii`. |
| `binary` | Shorthand for `mode binary`. |
| `connect host [port]` | Set the host (and optionally port) for transfers. |
| `get filename` | Get a file from the remote host. |
| `get remotename localname` | Get a file and rename it locally. |
| `get file1 file2 ... fileN` | Get multiple files from the remote host. |
| `mode transfer-mode` | Set mode to `ascii` or `netascii` (8-bit) or `binary` or `octet` (8-bit). |
| `put file` | Transfer a local file to the remote host. |
| `put localfile remotefile` | Transfer a local file and rename it on the remote host. |
| `put file1 file2 ... fileN remote-directory` | Transfer multiple files to a remote directory. |
| `quit` | Exit tftp. |
| `rexmt retransmission-timeout` | Set the per-packet retransmission timeout, in seconds. |
| `status` | Show current status (mode, connected host, time-out, etc.). |
| `timeout total-transmission-timeout` | Set the total transmission timeout, in seconds. |
| `trace` | Toggle packet tracing. |
| `verbose` | Toggle verbose mode. |

## Notes
- **Security**: TFTP has no authentication or encryption. Any file transferred is sent in cleartext.
- **Permissions**: On many TFTP servers, you can only `put` (upload) a file if it already exists on the server and has world-writable permissions.
- **Binary vs ASCII**: Always use `binary` mode for executables, scripts, and compressed files to prevent corruption caused by newline conversions.
- **Block Size**: Standard TFTP uses a 512-byte block size, which can be slow over high-latency links.