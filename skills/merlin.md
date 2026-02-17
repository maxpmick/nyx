---
name: merlin
description: A cross-platform post-exploitation HTTP/2 Command & Control (C2) framework. Use to establish C2 infrastructure, manage remote agents, and execute post-exploitation tasks using modern protocols like HTTP/2, QUIC, and TLS. Ideal for red teaming and advanced penetration testing scenarios requiring encrypted and evasive communication.
---

# merlin

## Overview
Merlin is a post-exploitation Command & Control (C2) tool written in Go. It utilizes HTTP/2 for communication to evade detection mechanisms that do not yet support or inspect the protocol. It includes a server for managing connections and agents for execution on target hosts. Category: Post-Exploitation.

## Installation (if not already installed)
Assume Merlin is already installed. If the `merlinserver` command is missing:

```bash
sudo apt update
sudo apt install merlin
```

Note: The `merlin` metapackage installs both `merlin-server` and `merlin-agent`.

## Common Workflows

### Starting the C2 Server
Start the server with default settings (listening on localhost:50051 for RPC):
```bash
merlinserver
```

### Starting the Server with Custom Interface and Debugging
Listen on all interfaces and enable debug logging for troubleshooting agent connections:
```bash
merlinserver -addr 0.0.0.0:443 -debug
```

### Secure Server Configuration
Run the server requiring client TLS certificate verification:
```bash
merlinserver -secure -tlsCA /path/to/ca.crt -tlsCert /path/to/server.crt -tlsKey /path/to/server.key
```

### Changing RPC Password
Set a custom password for CLI RPC clients to connect to the server:
```bash
merlinserver -password "ComplexP@ssw0rd123"
```

## Complete Command Reference

### merlinserver
The primary command to start the Merlin C2 server.

| Flag | Description |
|------|-------------|
| `-addr <string>` | The address to listen on for client connections (default "127.0.0.1:50051") |
| `-debug` | Enable debug logging |
| `-extra` | Enable extra debug logging |
| `-password <string>` | The password for CLI RPC clients to connect to this server (default "merlin") |
| `-secure` | Require client TLS certificate verification |
| `-tlsCA <string>` | TLS Certificate Authority file path to verify client certificates |
| `-tlsCert <string>` | TLS certificate file path |
| `-tlsKey <string>` | TLS private key file path |
| `-trace` | Enable trace logging |
| `-version` | Print the version number and exit |

## Notes
- **HTTP/2 Advantage**: Merlin's use of HTTP/2 allows multiple data streams to be multiplexed over a single TCP connection, making it harder for traditional security tools to detect individual C2 commands.
- **Agent Generation**: Once the server is running, you typically interact with the Merlin CLI to generate agents for various operating systems (Windows, Linux, macOS).
- **Default Credentials**: The default RPC password is `merlin`. It is highly recommended to change this in production environments using the `-password` flag.
- **Dependencies**: If building from source, Merlin requires a Go environment and several specific Go libraries (e.g., `ja3transport`, `merlin-message`). Using the Kali package handles these automatically.