---
name: tftpd32
description: Deploy an IPv6-ready TFTP server, DHCP server, DNS, SNTP, and Syslog server on Windows environments. Use when performing lateral movement, exfiltrating data, delivering payloads to network devices, or setting up PXE boot environments during penetration testing of Windows-based networks.
---

# tftpd32

## Overview
Tftpd32 is an open-source, IPv6-ready application suite for Windows that includes a TFTP server and client, DHCP server, DNS server, SNTP server, and Syslog server. It supports TFTP options (tsize, blocksize, timeout) for high-performance data transfer. Category: Windows Resources / Exploitation / Post-Exploitation.

## Installation (if not already installed)
This package provides Windows executables typically hosted on a Kali Linux machine to be transferred to a Windows target or used in a lab environment.

```bash
sudo apt install tftpd32
```
The files are typically located in `/usr/share/windows-resources/tftpd32/` after installation.

## Common Workflows

### Serving Payloads from a Windows Target
If you have GUI access to a Windows machine and need to serve files to other devices (like VOIP phones or routers):
1. Launch `tftpd32.exe`.
2. Set "Current Directory" to the folder containing your payloads.
3. Select the appropriate "Server interface" IP.
4. Ensure the TFTP Server tab is active.

### Using the TFTP Client to Exfiltrate Data
To send a file from a compromised Windows host to a remote listener:
1. Open the "TFTP Client" tab.
2. Enter the "Host" (your listener IP).
3. Set "Port" to 69.
4. Select the "Local File" to send.
5. Click "Put".

### Setting up a Rogue DHCP Server
To intercept network traffic or perform MITM by providing malicious network configurations:
1. Navigate to the "DHCP Server" tab.
2. Configure "IP pool start address", "Size of pool", and "Boot File" (if PXE booting).
3. Set the "Def. router" and "DNS Server" to your controlled IP.

## Complete Command Reference

Tftpd32 is primarily a GUI-based application. Its functionality is divided into the following components:

### TFTP Server
- **Current Directory**: Sets the root directory for TFTP file transfers.
- **Server Interface**: Dropdown to select the local IP address to bind the service to.
- **Tsize Support**: Enables/disables the Transfer Size option.
- **Blocksize Support**: Allows negotiation of larger packet sizes for faster transfers.
- **Timeout**: Configures the retransmission timeout.

### TFTP Client
- **Host**: Target IP address or hostname.
- **Port**: Target port (default 69).
- **Local File**: Path to the file on the local machine.
- **Remote File**: Destination path/name on the remote server.
- **Get/Put**: Buttons to initiate download or upload.

### DHCP Server
- **IP pool start address**: The first IP in the range to be assigned.
- **Size of pool**: Number of available addresses.
- **Boot File**: Name of the file to be downloaded via TFTP (for PXE).
- **WINS/DNS Server**: Network services provided to DHCP clients.
- **Default Gateway**: The router address provided to clients.
- **Subnet Mask**: The network mask for the assigned IPs.
- **Domain Name**: The DNS domain assigned to the network.

### Additional Services
- **DNS Server**: Simple DNS responder for name resolution.
- **SNTP Server**: Simple Network Time Protocol server to synchronize device clocks.
- **Syslog Server**: Collects and displays syslog messages from network devices.

### Extended Features
- **Directory Facility**: Browse and manage files within the GUI.
- **Security Tuning**: Interface filtering and access control settings.
- **Early Acknowledgments**: Performance enhancement for TFTP throughput.

## Notes
- As a Windows resource package in Kali, the `.exe` files are located in `/usr/share/windows-resources/tftpd32/`. You must transfer these to a Windows environment to execute them.
- Ensure Windows Firewall allows traffic on UDP ports 67 (DHCP), 69 (TFTP), and 514 (Syslog) when running these services.
- The "IPv6 Ready" status allows for testing and exploitation in modern networking environments.