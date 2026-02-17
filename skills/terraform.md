---
name: terraform
description: Build, change, and version infrastructure safely and efficiently using Infrastructure as Code (IaC). Use when provisioning cloud resources, managing service providers, automating environment deployments, or performing infrastructure audits and state management during penetration testing or red teaming operations.
---

# terraform

## Overview
Terraform is an open-source tool that codifies APIs into declarative configuration files. It allows for infrastructure to be versioned, shared, and re-used. It uses execution plans to show intended changes before execution and builds a resource graph to parallelize modifications. Category: Infrastructure Management / Automation.

## Installation (if not already installed)
Assume terraform is already installed. If you get a "command not found" error:

```bash
sudo apt install terraform
```

## Common Workflows

### Initialize and Deploy Infrastructure
```bash
terraform init
terraform plan -out=project.plan
terraform apply "project.plan"
```

### Inspect Current State
```bash
terraform show
terraform output
```

### Reformat Configuration Files
```bash
terraform fmt -recursive
```

### Destroy Managed Infrastructure
```bash
terraform destroy
```

## Complete Command Reference

### Global Options
These options must be used before the subcommand.

| Flag | Description |
|------|-------------|
| `-chdir=DIR` | Switch to a different working directory before executing the subcommand |
| `-help` | Show help output for Terraform or a specific subcommand |
| `-version` | Show the current Terraform version (alias for `version` subcommand) |

### Main Commands

| Subcommand | Description |
|------------|-------------|
| `init` | Prepare your working directory for other commands (downloads providers/modules) |
| `validate` | Check whether the configuration is internally consistent and valid |
| `plan` | Generate and show an execution plan of required changes |
| `apply` | Create or update infrastructure according to configuration |
| `destroy` | Destroy all previously-created infrastructure managed by the state |

### Advanced and Utility Commands

| Subcommand | Description |
|------------|-------------|
| `console` | Try Terraform expressions at an interactive command prompt |
| `fmt` | Reformat your configuration files in the standard HCL style |
| `force-unlock` | Release a stuck lock on the current workspace state |
| `get` | Install or upgrade remote Terraform modules |
| `graph` | Generate a Graphviz graph of the steps in an operation |
| `import` | Associate existing infrastructure with a Terraform resource |
| `login` | Obtain and save credentials for a remote host (e.g., Terraform Cloud) |
| `logout` | Remove locally-stored credentials for a remote host |
| `metadata` | Metadata related commands |
| `output` | Show output values from your root module |
| `providers` | Show the providers required for this configuration |
| `refresh` | Update the state to match real-world resources (deprecated by `plan -refresh-only`) |
| `show` | Show the current state or a saved plan file in human-readable format |
| `state` | Advanced state management (mv, rm, list, pull, push) |
| `taint` | Mark a resource instance as degraded, forcing recreation on next apply |
| `test` | Execute integration tests for Terraform modules |
| `untaint` | Remove the 'tainted' state from a resource instance |
| `version` | Show the current Terraform version |
| `workspace` | Workspace management (create, select, list, delete) |

## Notes
- **State Files**: Terraform stores the state of your managed infrastructure in `terraform.tfstate`. This file may contain sensitive information (secrets, passwords) in plaintext.
- **Execution Plans**: Always run `terraform plan` before `terraform apply` to verify the changes that will be made to the environment.
- **Provider Credentials**: Terraform usually requires environment variables or configuration files containing API keys for cloud providers (AWS, Azure, GCP).