---
name: cilium-cli
description: Install, manage, and troubleshoot Cilium clusters running Kubernetes. Use when deploying Cilium CNI, enabling Hubble observability, performing network connectivity tests, managing multi-cluster meshes, or collecting system diagnostics (sysdumps) in a Kubernetes environment.
---

# cilium-cli

## Overview
The Cilium CLI is a tool for managing Cilium, an eBPF-based networking, security, and observability solution for Kubernetes. It facilitates installation via Helm, status monitoring, and deep network troubleshooting. Category: Sniffing & Spoofing / Network Management.

## Installation (if not already installed)
Assume `cilium` is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install cilium-cli
```

## Common Workflows

### Basic Installation and Status
```bash
cilium install
cilium status
```

### Connectivity Testing
Perform a comprehensive suite of connectivity tests between nodes and pods to verify CNI health:
```bash
cilium connectivity test
```

### Enable Observability (Hubble)
```bash
cilium hubble enable
cilium hubble status
```

### Troubleshooting and Diagnostics
Collect a comprehensive sysdump for debugging cluster issues:
```bash
cilium sysdump --output-filename cilium-diagnostics
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `--as string` | Username to impersonate for the operation |
| `--as-group stringArray` | Group to impersonate for the operation (repeatable) |
| `--context string` | Kubernetes configuration context to use |
| `--helm-release-name string` | Helm release name (default "cilium") |
| `-h, --help` | Help for cilium |
| `--kubeconfig string` | Path to the kubeconfig file |
| `-n, --namespace string` | Namespace Cilium is running in (default "kube-system") |

### Subcommands

| Command | Description |
|---------|-------------|
| `bgp` | Access to BGP control plane |
| `clustermesh` | Multi-cluster management and interconnection |
| `completion` | Generate autocompletion script for the specified shell |
| `config` | Manage Cilium configuration |
| `connectivity` | Connectivity troubleshooting and validation tests |
| `context` | Display the configuration context |
| `encryption` | Manage Cilium transparent encryption (IPsec/WireGuard) |
| `features` | Report which features are enabled in Cilium agents |
| `hubble` | Manage Hubble observability layer |
| `install` | Install Cilium in a Kubernetes cluster using Helm |
| `multicast` | Manage multicast groups |
| `status` | Display the status of the Cilium installation |
| `sysdump` | Collect information required to troubleshoot Cilium and Hubble |
| `uninstall` | Uninstall Cilium using Helm |
| `upgrade` | Upgrade Cilium installation using Helm |
| `version` | Display detailed version information |

### Connectivity Subcommand Options
`cilium connectivity test [flags]`
- Includes tests for pod-to-pod, pod-to-service, and egress connectivity.
- Use `--help` with this subcommand for specific test filters.

### Sysdump Options
`cilium sysdump [flags]`
- Used to gather logs, CRDs, and status from all nodes.
- Useful for providing state to maintainers or security auditors.

## Notes
- The CLI interacts directly with the Kubernetes API. Ensure your `KUBECONFIG` is correctly set or use the `--kubeconfig` flag.
- Most operations require cluster-admin permissions within the Kubernetes environment.
- `cilium status` is the fastest way to verify if the eBPF datapath is healthy across all nodes.