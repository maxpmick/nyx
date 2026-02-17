---
name: kustomize
description: Manage and customize Kubernetes configurations using a template-free, declarative approach. Use when performing security audits of Kubernetes manifests, modifying container images in deployments, applying security patches to resource configurations, or managing environment-specific overlays during penetration testing or cloud security assessments.
---

# kustomize

## Overview
Kustomize is a standalone tool for customizing Kubernetes resource configurations through a `kustomization.yaml` file. It allows for resource composition, patching, and transformation (like adding labels or changing image tags) without modifying the original YAML files. Category: Cloud Security / Kubernetes Configuration.

## Installation (if not already installed)
Assume kustomize is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install kustomize
```

## Common Workflows

### Build a kustomization target
Generate the final hydrated YAML from a directory containing a `kustomization.yaml` file.
```bash
kustomize build ./overlays/production
```

### Create a new kustomization
Initialize a directory by adding all existing YAML files to a new kustomization file.
```bash
kustomize create --autodetect
```

### Edit a kustomization (Add Image)
Update the kustomization file to use a specific security-hardened image version.
```bash
kustomize edit set image nginx=nginx:1.25.3-alpine
```

### Apply a namespace to all resources
Quickly set a target namespace for all resources defined in the current directory.
```bash
kustomize edit set namespace security-audit-namespace
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Help for kustomize |
| `--stack-trace` | Print a stack-trace on error |

### Primary Commands

#### build
Build a kustomization target from a directory or URL.
```bash
kustomize build [path_or_url] [flags]
```
*Flags:*
- `-o, --output <file>`: Write the build output to a file.
- `--enable-alpha-plugins`: Enable kustomize plugins.
- `--enable-exec`: Enable support for exec functions (security risk).
- `--enable-helm`: Enable use of helm chart inflator generator.
- `--helm-command <cmd>`: Helm command to use (default "helm").
- `--load-restrictors <string>`: If set to 'none', local kustomizations may load files from outside their root.

#### create
Create a new kustomization in the current directory.
```bash
kustomize create [flags]
```
*Flags:*
- `--autodetect`: Search for kubernetes resources in the current directory and add them to the kustomization file.
- `--resources <list>`: List of resources to add.
- `--namespace <name>`: Set the namespace.

#### edit
Edits a kustomization file (kustomization.yaml).
```bash
kustomize edit <subcommand> [args]
```
*Subcommands:*
- `add`: Add resources, configmaps, secrets, etc.
- `set`: Set images, namespace, nameprefix, namesuffix, etc.
- `remove`: Remove resources, labels, annotations, etc.
- `fix`: Update the kustomization file to the latest schema.

#### cfg
Commands for reading and writing configuration.
```bash
kustomize cfg <subcommand>
```
*Subcommands:*
- `cat`: Print resources from a directory.
- `count`: Count resources in a directory.
- `fmt`: Format configuration files.
- `grep`: Filter resources by value.
- `tree`: Display resource structure as a tree.

#### fn
Commands for running functions against configuration.
```bash
kustomize fn <subcommand>
```
*Subcommands:*
- `run`: Run a function against resources.
- `sink`: Write resources to a directory.
- `source`: Read resources from a directory.

#### localize
[Alpha] Creates a localized copy of a remote kustomization target at a local destination.
```bash
kustomize localize <source_url> <destination_dir>
```

#### completion
Generate shell completion scripts (bash, zsh, fish, powershell).

#### version
Prints the kustomize version.

### Additional Help Topics
- `docs-fn`: Documentation for Configuration Functions.
- `docs-fn-spec`: Configuration Functions Specification.
- `docs-io-annotations`: Annotations used by io.
- `docs-merge`: 2-way merge documentation.
- `docs-merge3`: 3-way merge documentation.
- `tutorials-command-basics`: Basic config command tutorials.
- `tutorials-function-basics`: Function usage tutorials.

## Notes
- Kustomize is often used via `kubectl kustomize <dir>` in modern Kubernetes environments, but the standalone binary provides more extensive editing and configuration commands.
- **Security Warning**: Using `--enable-exec` with `kustomize build` allows the execution of arbitrary binaries on the host system. Use only with trusted configurations.
- Use `kustomize edit set image` to ensure specific, audited container images are used during deployments.