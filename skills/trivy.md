---
name: trivy
description: Comprehensive and versatile security scanner for finding vulnerabilities (CVEs), misconfigurations, secrets, and SBOMs. Use when scanning container images, local filesystems, Git repositories, Kubernetes clusters, or virtual machine images for security issues during vulnerability analysis or DevSecOps workflows.
---

# trivy

## Overview
Trivy is a multi-purpose security scanner that identifies vulnerabilities in OS packages and application dependencies, infrastructure-as-code (IaC) misconfigurations, hard-coded secrets, and software licenses. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume trivy is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install trivy
```

## Common Workflows

### Scan a Container Image
```bash
trivy image python:3.4-alpine
```

### Scan Local Filesystem for Vulnerabilities and Secrets
```bash
trivy fs /path/to/project
```

### Scan a Remote Git Repository
```bash
trivy repo https://github.com/aquasecurity/trivy-ci-test
```

### Scan Infrastructure as Code (IaC) for Misconfigurations
```bash
trivy config ./terraform-dir
```

### Generate SBOM (Software Bill of Materials)
```bash
trivy image --format cyclonedx --output sbom.json alpine:latest
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `--cache-dir string` | Cache directory (default "/root/.cache/trivy") |
| `-c, --config string` | Config path (default "trivy.yaml") |
| `-d, --debug` | Debug mode |
| `-f, --format string` | Output format (json, table, sarif, cyclonedx, spdx, spdx-json, github, cosign-vuln) |
| `--generate-default-config` | Write the default config to trivy-default.yaml |
| `-h, --help` | Help for trivy |
| `--insecure` | Allow insecure server connections |
| `-q, --quiet` | Suppress progress bar and log output |
| `--timeout duration` | Timeout (default 5m0s) |
| `-v, --version` | Show version |

### Scanning Commands

#### `image`
Scan a container image.
- `trivy image [flags] IMAGE_NAME`
- `--input string`: Scan a container image from a tar archive (e.g., `trivy image --input ruby-3.1.tar`)
- `--removed-pkgs`: Detect vulnerabilities in removed packages (for images)
- `--vuln-type string`: Comma-separated list of vulnerability types (os,library)

#### `filesystem` | `fs`
Scan local filesystem.
- `trivy fs [flags] PATH`
- `--skip-dirs string`: Comma-separated list of directories to skip
- `--skip-files string`: Comma-separated list of files to skip

#### `config`
Scan config files for misconfigurations (Terraform, Dockerfile, Kubernetes, etc.).
- `trivy config [flags] PATH`
- `--file-patterns strings`: Specify file patterns to include

#### `repository` | `repo`
Scan a remote repository.
- `trivy repo [flags] REPO_URL`

#### `kubernetes` | `k8s`
[EXPERIMENTAL] Scan kubernetes cluster.
- `trivy k8s [flags] {cluster, all, pod, etc.}`

#### `rootfs`
Scan rootfs.
- `trivy rootfs [flags] PATH`

#### `sbom`
Scan SBOM for vulnerabilities and licenses.
- `trivy sbom [flags] PATH`

#### `vm`
[EXPERIMENTAL] Scan a virtual machine image.
- `trivy vm [flags] IMAGE_PATH`

### Management Commands
| Command | Description |
|---------|-------------|
| `module` | Manage modules |
| `plugin` | Manage plugins |
| `vex` | [EXPERIMENTAL] VEX (Vulnerability Exploitability eXchange) utilities |

### Utility Commands
| Command | Description |
|---------|-------------|
| `clean` | Remove cached files (e.g., `trivy clean --all`) |
| `completion` | Generate autocompletion script (bash, zsh, fish, powershell) |
| `convert` | Convert Trivy JSON report into a different format |
| `registry` | Manage registry authentication |
| `server` | Run Trivy in server mode |
| `version` | Print the version |

## Notes
- **Performance**: The first run may be slow as Trivy downloads the vulnerability database.
- **Secrets**: Trivy scans for hard-coded secrets by default in `fs`, `image`, and `repo` commands.
- **Exit Codes**: Use `--exit-code 1` in CI/CD pipelines to fail the build if vulnerabilities are found.
- **Severity Filtering**: Use `--severity HIGH,CRITICAL` to filter results.