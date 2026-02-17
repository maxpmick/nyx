---
name: tnscmd10g
description: Probe and enumerate information from Oracle TNS Listeners (tnslsnr). Use this tool to identify Oracle database versions, status, and configuration details by sending TNS commands to port 1521. Useful during the reconnaissance and vulnerability analysis phases of a penetration test when targeting Oracle database infrastructure.
---

# tnscmd10g

## Overview
tnscmd10g is a specialized tool designed to interact with the Oracle TNS Listener process. It allows security professionals to "prod" the listener to retrieve version information, status updates, and other environment details. Category: Database Assessment / Web Application Testing.

## Installation (if not already installed)
Assume tnscmd10g is already installed. If you encounter errors, install it via:

```bash
sudo apt install tnscmd10g
```

Dependencies: libio-socket-ip-perl, perl.

## Common Workflows

### Check Listener Status
Identify if the Oracle listener is active and get basic configuration details.
```bash
tnscmd10g status -h 192.168.1.205
```

### Retrieve Oracle Version
Determine the exact version of the TNS Listener and underlying operating system.
```bash
tnscmd10g version -h 192.168.1.205
```

### Target Oracle 10G specifically
Use the 10G specific flag to ensure compatibility with newer listener versions.
```bash
tnscmd10g version -h 192.168.1.205 --10G
```

### Test for Information Leakage
Attempt to reveal memory/packet leakage by spoofing the command size.
```bash
tnscmd10g version -h 192.168.1.205 --cmdsize 256
```

## Complete Command Reference

```bash
tnscmd10g [command] -h <hostname> [options]
```

### Commands
The `command` argument defines the TNS operation to perform. If omitted, it defaults to `ping`. Common commands include:
- `ping`: Simple reachability check.
- `version`: Returns the Oracle software version and platform details.
- `status`: Returns the listener status, including services and endpoints.

### Options

| Flag | Description |
|------|-------------|
| `-h <hostname>` | **Required.** The target IP address or hostname of the Oracle server. |
| `-p <port>` | Alternate TCP port to use (default: 1521). |
| `--logfile <file>` | Write raw packets to the specified logfile for manual analysis. |
| `--indent` | Format the output by indenting and outdenting on parentheses for better readability. |
| `--10G` | Adjusts the packet format to work correctly against Oracle 10G listeners. |
| `--rawcmd <string>` | Build and send a custom `CONNECT_DATA` string instead of using standard commands. |
| `--cmdsize <bytes>` | Specify a fake TNS command size. This is often used to test for packet leakage vulnerabilities in the listener. |

## Notes
- The default port for Oracle TNS Listeners is `1521`, but it is frequently moved to other ports (like `1522-1529`) in complex environments.
- Information gathered from `status` and `version` can be used to look up specific CVEs or misconfigurations related to the identified Oracle version.
- Use `--indent` when dealing with long `status` outputs to make the service list easier to parse.