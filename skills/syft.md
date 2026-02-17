---
name: syft
description: Generate a Software Bill of Materials (SBOM) from container images, filesystems, and archives. Use when performing vulnerability analysis, supply chain auditing, or inventorying software packages and libraries within Docker, OCI, or Singularity images and local directories.
---

# syft

## Overview
Syft is a CLI tool and Go library for generating a Software Bill of Materials (SBOM) from container images and filesystems. It discovers installed packages and libraries across various ecosystems and supports multiple output formats like CycloneDX and SPDX. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume syft is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install syft
```

## Common Workflows

### Scan a container image and output a summary table
```bash
syft scan alpine:latest
```

### Generate a CycloneDX JSON SBOM for a local directory
```bash
syft scan dir:./my-project -o cyclonedx-json=sbom.json
```

### Scan a specific platform version of a multi-arch image
```bash
syft scan --platform linux/arm64 redis:latest -o spdx-json
```

### Convert an existing Syft JSON SBOM to SPDX format
```bash
syft convert results.syft.json -o spdx-json=results.spdx.json
```

## Complete Command Reference

### Usage
`syft [SOURCE] [flags]`
`syft [command]`

### Commands

| Command | Description |
|---------|-------------|
| `attest` | Generate an SBOM as an attestation for the given [SOURCE] container image |
| `cataloger` | Show available catalogers and configuration |
| `completion` | Generate the autocompletion script for the specified shell |
| `config` | Show the syft configuration |
| `convert` | Convert between SBOM formats |
| `help` | Help about any command |
| `login` | Log in to a registry |
| `scan` | Generate an SBOM (Primary command) |
| `version` | Show version information |

### Source Schemes
Syft can automatically detect sources, or you can specify them explicitly:

| Scheme | Description |
|--------|-------------|
| `docker:image:tag` | Explicitly use the Docker daemon |
| `podman:image:tag` | Explicitly use the Podman daemon |
| `registry:image:tag` | Pull image directly from a registry |
| `docker-archive:path` | Use a tarball created from `docker save` |
| `oci-archive:path` | Use an OCI archive tarball |
| `oci-dir:path` | Read from an OCI layout directory |
| `singularity:path` | Read from a Singularity (SIF) container |
| `dir:path` | Read directly from a local directory |
| `file:path` | Read directly from a single file |

### Global Flags

| Flag | Description |
|------|-------------|
| `--base-path string` | Base directory for scanning; paths reported relative to this |
| `-c, --config stringArray` | Syft configuration file(s) to use |
| `--enrich stringArray` | Enable package data enrichment (options: `all`, `golang`, `java`, `javascript`, `python`) |
| `--exclude stringArray` | Exclude paths from being scanned using a glob expression |
| `--file string` | File to write default report to (DEPRECATED: use `--output FORMAT=PATH`) |
| `--from stringArray` | Specify the source behavior to use (e.g., docker, registry) |
| `-h, --help` | Help for syft |
| `-o, --output stringArray` | Report output format. Formats: `cyclonedx-json`, `cyclonedx-xml`, `github-json`, `purls`, `spdx-json`, `spdx-tag-value`, `syft-json`, `syft-table`, `syft-text`, `template` |
| `--override-default-catalogers stringArray` | Set the base set of catalogers to use |
| `--parallelism int` | Number of cataloger workers to run in parallel |
| `--platform string` | Platform specifier for container images (e.g., `linux/arm64`) |
| `--profile stringArray` | Configuration profiles to use |
| `-q, --quiet` | Suppress all logging output |
| `-s, --scope string` | Layers to catalog: `squashed`, `all-layers`, `deep-squashed` (default "squashed") |
| `--select-catalogers stringArray` | Add, remove, and filter the catalogers to be used |
| `--source-name string` | Set the name of the target being analyzed |
| `--source-supplier string` | The organization that supplied the component |
| `--source-version string` | Set the version of the target being analyzed |
| `-t, --template string` | Specify the path to a Go template file |
| `-v, --verbose count` | Increase verbosity (-v = info, -vv = debug) |
| `--version` | Version for syft |

## Notes
- Syft works seamlessly with **Grype** for vulnerability scanning. You can pipe Syft output into Grype: `syft alpine:latest -o json | grype`.
- When scanning filesystems (`dir:`), Syft looks for package manager metadata (e.g., `package-lock.json`, `requirements.txt`, `Gemfile.lock`).
- The `squashed` scope (default) shows the final state of the image, while `all-layers` shows packages that may have been deleted in later layers.