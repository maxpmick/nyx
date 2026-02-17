---
name: silenttrinity
description: An asynchronous, collaborative post-exploitation framework (C2) powered by Python 3 and .NET's DLR. It uses the "Bring Your Own Interpreter" (BYOI) technique to execute tasks via embedded scripting languages (like Boo) to bypass traditional C# detections. Use this for multi-user red teaming, post-exploitation, lateral movement, and maintaining persistence during penetration testing engagements.
---

# silenttrinity

## Overview
SILENTTRINITY is a modern C2 framework designed for stealth and flexibility. It features a multi-user/multi-server architecture, real-time communication via WebSockets, and uses Ephemeral Elliptic Curve Diffie-Hellman (ECDHE) to encrypt all traffic. Its primary innovation is the "Naga" implant, which dynamically evaluates .NET scripting languages to call .NET APIs without relying on PowerShell. Category: Post-Exploitation.

## Installation (if not already installed)
The tool is typically pre-installed in Kali Linux. If missing:

```bash
sudo apt update && sudo apt install silenttrinity
```

## Common Workflows

### Starting the Teamserver
The teamserver must be running before clients can connect. It handles the database, listeners, and implant communication.
```bash
silenttrinity teamserver <teamserver_ip> <password>
```

### Connecting the Client
Once the teamserver is active, connect the interactive CLI client:
```bash
silenttrinity client
```
Inside the client, use `connect <teamserver_ip> <password>` to begin operations.

### Basic Operation Flow (Inside Client)
1. **Create a Listener**: `listeners -> use http -> set BindIP 0.0.0.0 -> start`
2. **Generate a Stager**: `stagers -> use msbuild -> set Listener <ID> -> generate`
3. **Interact with Sessions**: Once an implant checks in, use `sessions` to list and `interact <ID>` to control.
4. **Run Modules**: `modules -> use <module_name> -> run`

## Complete Command Reference

The base command is used to launch either the client or the teamserver component.

```bash
silenttrinity [-h] [-v] (client|teamserver) [<args>...]
```

### Global Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-v`, `--version` | Show version information |

### Subcommands

#### teamserver
Starts the SILENTTRINITY teamserver.
```bash
silenttrinity teamserver [options] <bind_address> <password>
```
*Note: The teamserver requires a bind address and a shared password for client authentication.*

#### client
Starts the interactive SILENTTRINITY CLI client.
```bash
silenttrinity client
```
The client uses a `prompt-toolkit` interface. Key internal command categories include:
- `listeners`: Manage C2 communication channels (HTTP, HTTPS, etc.).
- `stagers`: Generate payloads (MSBuild, PowerShell, Wmic, etc.) to drop the Naga implant.
- `sessions`: Manage and interact with active implants.
- `modules`: Execute post-exploitation tasks (Credential dumping, situational awareness, etc.).

## Notes
- **BYOI (Bring Your Own Interpreter)**: This tool avoids `System.Management.Automation.dll` (PowerShell) entirely, making it effective against environments with heavy PowerShell logging/constrained language mode.
- **Encryption**: All communication is encrypted using ECDHE.
- **Asynchronous**: Built on `asyncio`, allowing the framework to handle a large number of concurrent connections and tasks with high performance.
- **Collaborative**: Multiple operators can connect to the same teamserver simultaneously to share sessions and data.