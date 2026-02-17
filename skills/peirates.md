---
name: peirates
description: Automate Kubernetes penetration testing to escalate privileges and pivot through a cluster. Use when performing security assessments of Kubernetes environments, stealing service account tokens, obtaining remote code execution in pods, or attempting to gain full cluster control.
---

# peirates

## Overview
Peirates is a Kubernetes penetration testing tool that enables attackers to escalate privileges and pivot through a Kubernetes cluster. It automates known techniques to collect service accounts, obtain further code execution, and gain control of the cluster infrastructure. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume peirates is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install peirates
```

## Common Workflows

### Basic Cluster Interaction
Run a simple command (defaulting to `hostname`) against the API server using a known service account token:
```bash
peirates -u https://10.96.0.1:6443 -t <JWT_TOKEN>
```

### Executing Commands on Specific Pods
Run a custom command across a specific list of pods to verify execution or gather environment details:
```bash
peirates -u https://10.96.0.1:6443 -t <JWT_TOKEN> -L pod-alpha,pod-beta -c "id; env"
```

### Automated Exploitation
When run without specific pod lists, peirates will attempt to discover available pods and automate the collection of service accounts and secrets to facilitate lateral movement.

## Complete Command Reference

```
peirates [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-L <string>` | List of comma-separated Pods to target (e.g., `pod1,pod2,pod3`) |
| `-c <string>` | Command to run in pods (default: `hostname`) |
| `-t <string>` | Token (JWT) for authentication with the Kubernetes API |
| `-u <string>` | API Server URL (e.g., `https://10.96.0.1:6443`) (default: `https://:`) |

## Notes
- Peirates is most effective when run from within a compromised pod, as it can leverage the local service account token typically found at `/var/run/secrets/kubernetes.io/serviceaccount/token`.
- The tool is designed to automate the "post-exploitation" phase of a Kubernetes audit.
- Ensure the API Server URL includes the correct port (usually 6443 or 8443).