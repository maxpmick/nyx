---
name: ligolo-mp
description: Establish advanced multiplayer pivoting tunnels with a client-server architecture. Use when performing network pivoting, lateral movement, or collaborative penetration testing where multiple operators need to manage concurrent TUN interfaces and tunnels through a central server.
---

# ligolo-mp

## Overview
Ligolo-MP is an advanced version of Ligolo-ng featuring a client-server architecture. It enables multiple pentesters to collaborate using concurrent tunnels, automatically manages TUN interfaces, and provides a GUI for tracking connections. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume ligolo-mp is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install ligolo-mp
```

## Common Workflows

### Starting the Relay Server (Operator Side)
Start the main server to listen for both agents (compromised hosts) and operators (pentesters).
```bash
ligolo-mp -agent-addr 0.0.0.0:11601 -operator-addr 0.0.0.0:58008
```

### Connecting as an Operator
Use the client to connect to the running ligolo-mp server to manage tunnels.
```bash
ligolo-mp-client
```

### Running in Background
Start the relay server in daemon mode for persistent access.
```bash
ligolo-mp -daemon -v
```

## Complete Command Reference

### ligolo-mp (Server/Relay)
The main relay server that coordinates agents and operators.

| Flag | Description |
|------|-------------|
| `-agent-addr <string>` | Listening address for incoming agent connections (default "0.0.0.0:11601") |
| `-daemon` | Enable daemon mode to run the server in the background |
| `-max-connection <int>` | Per tunnel connection pool size (default 1024) |
| `-max-inflight <int>` | Max inflight TCP connections (default 4096) |
| `-operator-addr <string>` | Address for operator connections/GUI (default "0.0.0.0:58008") |
| `-v` | Enable verbose mode for detailed logging |

### ligolo-mp-client (Operator Client)
The tool used by pentesters to connect to the `ligolo-mp` server.

| Flag | Description |
|------|-------------|
| `-v` | Enable verbose mode |

## Notes
- Ligolo-MP automates the creation and management of TUN interfaces, reducing the manual overhead typically associated with complex pivoting scenarios.
- Ensure that the `agent-addr` port is reachable from the target network and the `operator-addr` is accessible to your team.
- This tool is specifically designed for "multiplayer" scenarios where multiple team members need to interact with the same pivot points.