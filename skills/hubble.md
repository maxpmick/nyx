---
name: hubble
description: Network, service, and security observability for Kubernetes using eBPF. Use to observe and inspect Cilium-routed traffic, monitor network flows, debug connectivity issues, and audit security policies in a Kubernetes cluster.
---

# hubble

## Overview
Hubble is a distributed networking and security observability platform for cloud-native workloads. Built on top of Cilium and eBPF, it provides deep visibility into service communication and networking infrastructure behavior in a transparent manner. Category: Sniffing & Spoofing / Network Observability.

## Installation (if not already installed)
Assume hubble is already installed. If you get a "command not found" error:

```bash
sudo apt install hubble
```

## Common Workflows

### Check Hubble status
```bash
hubble status
```

### Observe real-time network flows
```bash
hubble observe
```

### Filter flows by namespace and follow output
```bash
hubble observe --namespace kube-system -f
```

### List available Hubble nodes or identities
```bash
hubble list nodes
hubble list identities
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `--config string` | Optional config file (default "/root/.config/hubble/config.yaml") |
| `-D, --debug` | Enable debug messages |
| `-h, --help` | Help for any command or subcommand |

### Subcommands

#### `completion`
Generate the autocompletion script for the specified shell.
- **Usage**: `hubble completion [bash|zsh|fish|powershell]`

#### `config`
Modify or view hubble config.
- **Usage**: `hubble config [command]`
- **Subcommands**: `get`, `set`, `view`.

#### `list`
List Hubble objects.
- **Usage**: `hubble list [nodes|identities]`

#### `observe`
Observe flows and events of a Hubble server.
- **Usage**: `hubble observe [flags]`
- **Flags**:
    - `-f, --follow` | Follow the flow output
    - `-n, --namespace string` | Filter by namespace
    - `-o, --output string` | Output format (json|table|compact)
    - `-t, --type string` | Filter by flow type (e.g., L3/L4, L7)
    - `--last int` | Get last N flows
    - `--since string` | Show flows since a specific time (e.g., 5m, 1h)
    - `--until string` | Show flows until a specific time
    - `--verdict string` | Filter by verdict (FORWARDED, DROPPED, ERROR)
    - `--protocol string` | Filter by protocol (TCP, UDP, ICMP)
    - `--port uint16` | Filter by destination port

#### `status`
Display status of Hubble server.
- **Usage**: `hubble status [flags]`

#### `version`
Display detailed version information.
- **Usage**: `hubble version`

## Notes
- Hubble requires a running Cilium installation within a Kubernetes cluster to function.
- By default, it attempts to connect to the local Hubble relay or server; ensure your `KUBECONFIG` or Hubble context is correctly set if accessing a remote cluster.
- Use `hubble observe --help` to see the extensive list of advanced filtering flags (CIDR, Pod name, Label, etc.) available for flow inspection.