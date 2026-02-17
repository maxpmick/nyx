---
name: calicoctl
description: Manage Calico network and security policies, view endpoint configurations, and manage Calico node instances. Use when performing Kubernetes security audits, managing network policies, inspecting container networking, or troubleshooting Calico datastores and IPAM during penetration testing or infrastructure assessments.
---

# calicoctl

## Overview
The `calicoctl` command line tool is used to manage Calico networking and security policies for Kubernetes, virtual machines, and bare-metal workloads. It allows for resource management (create, apply, delete), IP address management (IPAM), and node configuration. Category: Web Application Testing / Infrastructure Security.

## Installation (if not already installed)
Assume `calicoctl` is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install calicoctl
```

## Common Workflows

### List all network policies
```bash
calicoctl get networkpolicy -o wide
```

### Apply a security policy from a YAML file
```bash
calicoctl apply -f policy.yaml
```

### Check Calico node status
```bash
calicoctl node status
```

### Release a specific IP address
```bash
calicoctl ipam release --ip 192.168.1.100
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help screen |
| `-l`, `--log-level=<level>` | Set log level (panic, fatal, error, warn, info, debug) [default: panic] |
| `--context=<context>` | The name of the kubeconfig context to use |
| `--allow-version-mismatch` | Allow client and cluster versions mismatch |

### Subcommands

| Command | Description |
|---------|-------------|
| `create` | Create a resource by file, directory, or stdin |
| `replace` | Replace a resource by file, directory, or stdin |
| `apply` | Apply a resource (creates if missing, replaces if exists) |
| `patch` | Patch a preexisting resource in place |
| `delete` | Delete a resource identified by file, directory, stdin, or type/name |
| `get` | Get a resource identified by file, directory, stdin, or type/name |
| `label` | Add or update labels of resources |
| `validate` | Validate a resource by file, directory, or stdin without applying it |
| `convert` | Convert config files between different API versions |
| `ipam` | IP address management (release, show, configure) |
| `node` | Calico node management (status, check-system, diagnostics) |
| `version` | Display the version of this binary |
| `datastore` | Calico datastore management (migrate, check) |
| `cluster` | Access cluster information |

### Resource Types
Common resource types used with `get`, `create`, `apply`, and `delete`:
- `bgpConfiguration`
- `bgpPeer`
- `felixConfiguration`
- `globalNetworkPolicy`
- `globalNetworkSet`
- `hostEndpoint`
- `ipPool`
- `kubeControllersConfiguration`
- `networkPolicy`
- `networkSet`
- `node`
- `profile`
- `workloadEndpoint`

## Notes
- `calicoctl` requires access to the Calico datastore (etcd or Kubernetes API). Ensure your `KUBECONFIG` or environment variables are correctly set.
- Use `calicoctl <command> --help` for detailed flags specific to each subcommand (e.g., `-o yaml`, `-o json`, or `--all-namespaces`).
- When managing policies, ensure you are in the correct namespace or use the `--all-namespaces` flag where applicable.