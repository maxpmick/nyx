---
name: tetragon
description: EBPF-based security observability and runtime enforcement tool. Use to monitor process execution, system calls, and I/O activity (network/file access) in real-time. It is particularly useful for Kubernetes-aware security monitoring, threat detection, and auditing system events via eBPF. Trigger when needing to inspect kernel-level events, audit process lifecycles, or debug container security policies.
---

# tetragon (tetra)

## Overview
Tetragon provides real-time, eBPF-based security observability and runtime enforcement. It detects and reacts to security-significant events such as process execution, system call activity, and network/file I/O. It is Kubernetes-aware, allowing for identity-based filtering (namespaces, pods). Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
Assume the `tetra` CLI is installed. If not:

```bash
sudo apt install tetragon
```
Dependencies: `bpftool`, `libc6`.

## Common Workflows

### Monitor real-time events
```bash
tetra getevents
```

### Monitor events for a specific process (JSON output)
```bash
tetra getevents -o json | jq 'select(.process_kprobe.process.binary == "/usr/bin/curl")'
```

### Check system eBPF feature availability
```bash
tetra probe
```

### Check status of the Tetragon agent
```bash
tetra status
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `-d`, `--debug` | Enable debug messages |
| `-h`, `--help` | Help for tetra |
| `--retries int` | Connection retries with exponential backoff (default 1) |
| `--server-address string` | gRPC server address |
| `--timeout duration` | Connection timeout (default 30s) |

---

### Subcommands

#### `bugtool`
Produce a tar archive with debug information for troubleshooting.
```bash
tetra bugtool [flags]
```

#### `completion`
Generate the autocompletion script for the specified shell.
```bash
tetra completion [bash|zsh|fish|powershell]
```

#### `cri`
Connect to Container Runtime Interface (CRI).
```bash
tetra cri [command]
```

#### `getevents`
Print events from the Tetragon agent.
```bash
tetra getevents [flags]
```
**Flags:**
| Flag | Description |
|------|-------------|
| `-o`, `--output` | Output format: `json`, `compact`, or `table` |
| `--namespace string` | Filter by Kubernetes namespace |
| `--pod string` | Filter by Kubernetes pod name |
| `--process string` | Filter by process name |

#### `loglevel`
Get and dynamically change the log level of the agent.
```bash
tetra loglevel [level]
```

#### `probe`
Probe for eBPF system features availability to ensure the kernel supports Tetragon requirements.
```bash
tetra probe
```

#### `stacktrace-tree`
Manage stacktrace trees for debugging kernel/user space transitions.
```bash
tetra stacktrace-tree [command]
```

#### `status`
Print health status of the Tetragon daemon and its components.
```bash
tetra status
```

#### `tracingpolicy`
Manage and inspect Tetragon tracing policies (CRDs in Kubernetes).
```bash
tetra tracingpolicy [command]
```
**Subcommands:**
- `list`: List loaded tracing policies.
- `add`: Load a new tracing policy.
- `delete`: Remove a tracing policy.

#### `version`
Print version information for both the CLI and the connected server.
```bash
tetra version
```

## Notes
- Tetragon requires a Linux kernel with eBPF support (typically 4.19+).
- When running in Kubernetes, `tetra` usually connects to the gRPC server running in the Tetragon daemonset pod. Use `--server-address` if the agent is not on localhost.
- Use `jq` to parse `getevents -o json` for complex filtering of security events.