---
name: eksctl
description: Create, manage, and operate Kubernetes clusters on Amazon EKS. Use when provisioning cloud infrastructure, managing node groups, configuring IAM OIDC providers, or automating EKS cluster lifecycles during cloud security assessments or DevOps operations.
---

# eksctl

## Overview
The official CLI tool for Amazon EKS (Elastic Kubernetes Service). It automates the creation and management of Kubernetes clusters on AWS using CloudFormation. Category: Cloud Infrastructure / Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume eksctl is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install eksctl
```

## Common Workflows

### Create a default EKS cluster
```bash
eksctl create cluster --name my-cluster --region us-west-2
```

### List all clusters in a region
```bash
eksctl get cluster --region us-east-1
```

### Create an IAM OIDC provider for a cluster
```bash
eksctl utils associate-iam-oidc-provider --cluster my-cluster --approve
```

### Scale a nodegroup
```bash
eksctl scale nodegroup --cluster my-cluster --name standard-nodes --nodes 3
```

### Delete a cluster and its resources
```bash
eksctl delete cluster --name my-cluster
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `-C, --color string` | Toggle colorized logs (true, false, fabulous) (default "true") |
| `-d, --dumpLogs` | Dump logs to disk on failure if set to true |
| `-h, --help` | Help for the command |
| `-v, --verbose int` | Log level: 0 (silence), 3 (default), 4 (debug), 5 (AWS debug) |

### Commands

| Command | Description |
|---------|-------------|
| `anywhere` | EKS anywhere operations |
| `associate` | Associate resources (e.g., IAM OIDC provider) with a cluster |
| `completion` | Generates shell completion scripts for bash, zsh, or fish |
| `create` | Create resources (cluster, nodegroup, iamidentitymapping, iamserviceaccount, fargateprofile) |
| `delete` | Delete resources (cluster, nodegroup, iamidentitymapping, iamserviceaccount, fargateprofile) |
| `deregister` | Deregister a non-EKS cluster |
| `disassociate` | Disassociate resources from a cluster |
| `drain` | Drain resource(s) (e.g., nodegroup) |
| `enable` | Enable features in a cluster (e.g., repo, flux) |
| `get` | Get resource(s) (cluster, nodegroup, iamserviceaccount, fargateprofile) |
| `help` | Help about any command |
| `info` | Output the version of eksctl, kubectl, and OS info |
| `register` | Register a non-EKS cluster |
| `scale` | Scale resources (nodegroup) |
| `set` | Set values |
| `unset` | Unset values |
| `update` | Update resource(s) (cluster, nodegroup, addon, iamserviceaccount) |
| `upgrade` | Upgrade resource(s) (cluster, nodegroup) |
| `utils` | Various utility commands (e.g., `associate-iam-oidc-provider`, `describe-stacks`) |
| `version` | Output the version of eksctl |

### Subcommand Usage Patterns

#### Create Cluster
```bash
eksctl create cluster [flags]
```
*Common flags: `--name`, `--region`, `--nodegroup-name`, `--node-type`, `--nodes`, `--managed`.*

#### Get Resources
```bash
eksctl get cluster [flags]
eksctl get nodegroup --cluster <clusterName> [flags]
eksctl get iamserviceaccount --cluster <clusterName> [flags]
```

#### Delete Resources
```bash
eksctl delete cluster --name <name> [flags]
eksctl delete nodegroup --cluster <clusterName> --name <nodegroupName> [flags]
```

## Notes
- `eksctl` requires valid AWS credentials configured (via environment variables, `~/.aws/credentials`, or IAM roles).
- Most operations that modify infrastructure (create/delete) will trigger AWS CloudFormation stacks.
- Use `--verbose 4` if a command hangs to see which CloudFormation resources are being created.
- For non-EKS clusters (EKS Anywhere or registered clusters), use the `anywhere` or `register` subcommands.