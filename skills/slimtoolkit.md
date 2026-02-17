---
name: slimtoolkit
description: Inspect, optimize, and debug container images to reduce size and improve security. Use when performing container analysis, reverse engineering Dockerfiles, minifying images, generating Seccomp/AppArmor profiles, or linting Dockerfiles during DevOps and security audits.
---

# slimtoolkit

## Overview
SlimToolkit (formerly DockerSlim) is a comprehensive tool for container optimization and analysis. It allows users to "x-ray" images to see their contents, lint Dockerfiles for best practices, and "build" minified versions of images by profiling their execution. It also auto-generates security profiles (Seccomp/AppArmor) to harden containers. Category: Vulnerability Analysis / Exploitation.

## Installation (if not already installed)
Assume SlimToolkit is already installed. If you encounter errors, ensure Docker is running and install via:

```bash
sudo apt update
sudo apt install slimtoolkit
```
*Note: Requires `docker.io` and `libc6`.*

## Common Workflows

### X-Ray an image
Analyze the layers and reverse engineer the Dockerfile of an existing image:
```bash
slimtoolkit xray --target my-app-image:latest
```

### Minify a container image
Automatically profile a container and create a smaller, more secure version:
```bash
slimtoolkit build --target my-app-image:latest --http-probe
```

### Lint a Dockerfile
Check a Dockerfile for security issues and optimization opportunities:
```bash
slimtoolkit lint --target /path/to/Dockerfile
```

### Debug a running container
Launch a side-car container to debug a target container:
```bash
slimtoolkit debug --target container_id_or_name
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `--report value` | Command report location (default: "slim.report.json"; set to "off" to disable) |
| `--check-version` | Check if current version is outdated (default: true) |
| `--debug` | Enable debug logs (default: false) |
| `--verbose` | Enable info logs (default: false) |
| `--quiet` | Quiet CLI execution mode (default: false) |
| `--log-level value` | Set logging level (debug, info, warn, error, fatal, panic) (default: "warn") |
| `--log value` | Log file to store logs |
| `--log-format value` | Set log format (text, json) (default: "text") |
| `--output-format value` | Set output format (text, json) (default: "text") |
| `--tls` | Use TLS (default: true) |
| `--tls-verify` | Verify TLS (default: true) |
| `--tls-cert-path value` | Path to TLS cert files |
| `--crt-api-version value`| Container runtime API version (default: "1.24") |
| `--host value` | Docker host address |
| `--state-path value` | App state base path |
| `--in-container` | App is running in a container (default: false) |
| `--archive-state value` | Archive app state to selected Docker volume (default: slim-state) |
| `--no-color` | Disable color output (default: false) |
| `--version, -v` | Print the version |

### Subcommands
| Command | Alias | Description |
|---------|-------|-------------|
| `xray` | `x` | Shows image contents and reverse engineers Dockerfile |
| `lint` | `l` | Analyzes container instructions in Dockerfiles |
| `build` | `b` | Analyzes, profiles, and optimizes images; generates security profiles |
| `merge` | `m` | Merge two container images (optimized for minified images) |
| `images` | `i` | Get information about container images |
| `registry` | `r` | Execute registry operations |
| `vulnerability` | `vuln`| Execute vulnerability related tools and operations |
| `profile` | `p` | Collects fat image information and generates a report |
| `version` | `v` | Shows slim and docker version information |
| `appbom` | `a` | Show application Bill of Materials (BOM) |
| `update` | `u` | Updates slim |
| `install` | `in` | Installs slim |
| `run` | `r` | Run one or more containers |
| `debug` | `dbg` | Debug target container from a side-car container |

---

### slim-sensor
The `slim-sensor` is an internal component typically managed by `slimtoolkit`, but can be run standalone.

| Flag | Description |
|------|-------------|
| `-a, -lifecycle-hook` | Path to executable for sensor lifecycle events (post-start, etc) |
| `-appbom, -b` | Get sensor application BOM |
| `-artifacts-dir, -e` | Output directory for sensor artifacts (default "/opt/_slim/artifacts") |
| `-c, -command-file` | JSONL-encoded file with sensor commands (standalone mode) |
| `-d, -debug` | Enable debug logging |
| `-f, -log-format` | Logging format ('text', or 'json') (default "text") |
| `-l, -log-level` | Logging level (debug, info, warn, error, fatal, panic) (default "info") |
| `-log-file, -o` | Redirect logging to a file |
| `-m, -mode` | Execution mode ('controlled' or 'standalone') (default "controlled") |
| `-mondel, -n` | Enable monitor data event logging |
| `-s, -stop-signal` | Signal to stop the target app (default "TERM") |
| `-w, -stop-grace-period`| Time to wait for graceful termination (default 5s) |

## Notes
- **Security**: When using `build`, SlimToolkit monitors the container's activity. Ensure you exercise all application paths (e.g., via the `--http-probe` flag or manual interaction) to ensure the minified image includes all necessary files.
- **Docker Requirement**: SlimToolkit interacts directly with the Docker daemon; ensure the current user has permissions to run docker commands.