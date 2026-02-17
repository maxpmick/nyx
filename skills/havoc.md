---
name: havoc
description: Modern and malleable post-exploitation command and control (C2) framework. Use for red teaming, penetration testing, and adversary simulation to manage compromised endpoints, execute post-exploitation modules, and coordinate team operations.
---

# Havoc

## Overview
Havoc is a modern, malleable post-exploitation command and control framework designed for red teams and penetration testers. It features a cross-platform teamserver and a Qt-based client, supporting highly customizable agents (Demon) and external C2 profiles. Category: Post-Exploitation / Exploitation.

## Installation (if not already installed)
Assume Havoc is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install havoc
```

## Common Workflows

### Start the Teamserver
```bash
sudo havoc server --profile ./profiles/default.yaotl --debug
```
Starts the C2 server using a specific configuration profile.

### Launch the Graphical Client
```bash
havoc client
```
Opens the Qt5 GUI to connect to a running teamserver.

### View Server Help
```bash
havoc server --help
```

## Complete Command Reference

### Main Usage
```bash
havoc [flags]
havoc [command]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Help for havoc |

### Subcommands

#### client
Starts the Havoc GUI client to interact with the teamserver.

```bash
havoc client [flags]
```

#### server
Starts the Havoc Teamserver.

```bash
havoc server [flags]
```

**Server Flags:**
| Flag | Description |
|------|-------------|
| `--profile <path>` | Path to the Havoc profile file (.yaotl) |
| `--debug` | Enable debug logging output |
| `-h`, `--help` | Help for the server command |

#### help
Help about any command.

```bash
havoc help [command]
```

## Notes
- Havoc requires a profile file (usually in `.yaotl` format) to define network communication, listeners, and agent behavior.
- The teamserver usually requires root privileges to bind to privileged ports or manage certain network resources.
- Ensure `nasm` and `mingw-w64` are present if you intend to compile payloads/agents on the fly within the framework.