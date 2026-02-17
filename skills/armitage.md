---
name: armitage
description: Manage cyber attacks and red team collaboration using a graphical user interface for the Metasploit Framework. Use when visualizing network targets, recommending exploits, managing multiple Meterpreter sessions, or coordinating multi-player red team operations during exploitation and post-exploitation phases.
---

# armitage

## Overview
Armitage is a scriptable red team collaboration tool for Metasploit that visualizes targets, recommends exploits, and exposes advanced post-exploitation features. It functions as a graphical front-end that simplifies complex Metasploit operations and allows multiple operators to connect to a single Metasploit instance. Category: Exploitation.

## Installation (if not already installed)
Assume Armitage is already installed. If not, use the following:

```bash
sudo apt update
sudo apt install armitage
```
Dependencies: metasploit-framework, openjdk-11-jre.

## Common Workflows

### Starting a Local Instance
Launch Armitage to start a local Metasploit RPC daemon and connect the GUI:
```bash
armitage
```

### Starting a Team Server
To allow multiple users to collaborate, start the team server on a reachable IP with a shared password:
```bash
sudo teamserver <external_IP> <password>
```

### Connecting to a Team Server
1. Run `armitage`.
2. In the connect dialog, enter the `Host` (IP of the team server), `Port` (default 55553), `User` (msf), and the `Pass` defined when starting the team server.
3. Verify the SSL fingerprint provided by the team server console.

## Complete Command Reference

### armitage
The main graphical client. It handles starting the Metasploit RPC daemon (`msfrpcd`) automatically if a local connection is desired.

```bash
armitage
```

### teamserver
The server-side component used for collaboration. It binds Metasploit's RPC service to an external interface and manages shared access.

```bash
teamserver <external IP address> <team password>
```

| Argument | Description |
|----------|-------------|
| `<external IP address>` | The IP address of the server that must be reachable by Armitage clients on port 55553. |
| `<team password>` | A shared password used by the team to authenticate to the Armitage team server. |

## Notes
- **Port Requirements**: The team server listens on port **55553** by default. Ensure firewall rules allow this traffic for remote collaborators.
- **Java Version**: Armitage requires modern Java (OpenJDK 11+). Older versions like Java 1.6 are explicitly unsupported.
- **Metasploit Integration**: Armitage relies entirely on the Metasploit Framework; ensure `msfconsole` is functional before troubleshooting Armitage connectivity.
- **Security**: The team server generates an X509 certificate for SSL encryption. Always verify the SHA-1 fingerprint when connecting to a remote server to prevent Man-in-the-Middle attacks.