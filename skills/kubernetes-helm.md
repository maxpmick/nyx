---
name: kubernetes-helm
description: Manage Kubernetes Charts to find, share, and deploy applications. Use when performing Kubernetes security audits, deploying containerized tools, managing cluster resources, or investigating misconfigured Helm releases during post-exploitation or cloud-native penetration testing.
---

# kubernetes-helm

## Overview
Helm is the package manager for Kubernetes. It uses "Charts" (packages of pre-configured Kubernetes resources) to manage complex applications. In a security context, it is used to enumerate deployed services, identify sensitive configurations in releases, or deploy security tooling into a cluster. Category: Exploitation / Post-Exploitation / Cloud Security.

## Installation (if not already installed)
Assume Helm is already installed. If the command is missing:

```bash
sudo apt install kubernetes-helm
```

## Common Workflows

### Search and Install a Chart
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm search repo wordpress
helm install my-release bitnami/wordpress
```

### Enumerate Releases and Resources
```bash
helm list --all-namespaces
helm get manifest <release-name>
```

### Inspect Chart Values for Sensitive Info
```bash
helm show values <chart-name>
```

### Debugging Deployment Issues
```bash
helm install <release-name> <chart> --dry-run --debug
```

## Complete Command Reference

### Available Commands

| Command | Description |
|---------|-------------|
| `completion` | Generate autocompletion scripts for the specified shell |
| `create` | Create a new chart with the given name |
| `dependency` | Manage a chart's dependencies |
| `env` | Helm client environment information |
| `get` | Download extended information of a named release |
| `help` | Help about any command |
| `history` | Fetch release history |
| `install` | Install a chart |
| `lint` | Examine a chart for possible issues |
| `list` | List releases |
| `package` | Package a chart directory into a chart archive |
| `plugin` | Install, list, or uninstall Helm plugins |
| `pull` | Download a chart from a repository and (optionally) unpack it |
| `push` | Push a chart to remote |
| `registry` | Login to or logout from a registry |
| `repo` | Add, list, remove, update, and index chart repositories |
| `rollback` | Roll back a release to a previous revision |
| `search` | Search for a keyword in charts |
| `show` | Show information of a chart |
| `status` | Display the status of the named release |
| `template` | Locally render templates |
| `test` | Run tests for a release |
| `uninstall` | Uninstall a release |
| `upgrade` | Upgrade a release |
| `verify` | Verify that a chart has been signed and is valid |
| `version` | Print the client version information |

### Global Flags

| Flag | Description |
|------|-------------|
| `--burst-limit int` | Client-side default throttling limit (default 100) |
| `--debug` | Enable verbose output |
| `-h, --help` | Help for helm |
| `--kube-apiserver string` | Address and port for the Kubernetes API server |
| `--kube-as-group stringArray` | Group to impersonate (can be repeated) |
| `--kube-as-user string` | Username to impersonate |
| `--kube-ca-file string` | CA file for the Kubernetes API server connection |
| `--kube-context string` | Name of the kubeconfig context to use |
| `--kube-insecure-skip-tls-verify` | Skip Kubernetes API server certificate validation |
| `--kube-tls-server-name string` | Server name for API server certificate validation |
| `--kube-token string` | Bearer token used for authentication |
| `--kubeconfig string` | Path to the kubeconfig file |
| `-n, --namespace string` | Namespace scope for the request |
| `--qps float32` | Queries per second for Kubernetes API |
| `--registry-config string` | Path to the registry config file |
| `--repository-cache string` | Path to the directory containing cached repository indexes |
| `--repository-config string` | Path to the file containing repository names and URLs |

### Environment Variables

| Variable | Description |
|----------|-------------|
| `$HELM_CACHE_HOME` | Alternative location for storing cached files |
| `$HELM_CONFIG_HOME` | Alternative location for storing Helm configuration |
| `$HELM_DATA_HOME` | Alternative location for storing Helm data |
| `$HELM_DEBUG` | Run Helm in Debug mode |
| `$HELM_DRIVER` | Backend storage driver (configmap, secret, memory, sql) |
| `$HELM_DRIVER_SQL_CONNECTION_STRING` | Connection string for SQL storage driver |
| `$HELM_MAX_HISTORY` | Maximum number of helm release history |
| `$HELM_NAMESPACE` | Namespace used for helm operations |
| `$HELM_NO_PLUGINS` | Set to 1 to disable plugins |
| `$HELM_PLUGINS` | Path to the plugins directory |
| `$HELM_REGISTRY_CONFIG` | Path to the registry config file |
| `$HELM_REPOSITORY_CACHE` | Path to the repository cache directory |
| `$HELM_REPOSITORY_CONFIG` | Path to the repositories file |
| `$KUBECONFIG` | Alternative Kubernetes configuration file |
| `$HELM_KUBEAPISERVER` | Kubernetes API Server Endpoint |
| `$HELM_KUBECAFILE` | Kubernetes certificate authority file |
| `$HELM_KUBEASGROUPS` | Groups to use for impersonation (comma-separated) |
| `$HELM_KUBEASUSER` | Username to impersonate |
| `$HELM_KUBECONTEXT` | Name of the kubeconfig context |
| `$HELM_KUBETOKEN` | Bearer KubeToken for authentication |
| `$HELM_KUBEINSECURE_SKIP_TLS_VERIFY` | Skip API server TLS validation |
| `$HELM_KUBETLS_SERVER_NAME` | Server name for API server certificate validation |
| `$HELM_BURST_LIMIT` | Default burst limit (default 100) |
| `$HELM_QPS` | Queries Per Second |

## Notes
- Helm relies on the current Kubernetes context. Ensure `kubectl` is configured correctly or use the `--kubeconfig` flag.
- The `HELM_DRIVER` defaults to `secret` in most modern installations, meaning Helm release information is stored as Kubernetes Secrets in the release namespace.
- Use `helm get values <release>` to see user-supplied values, which often contain passwords or API keys if not handled via ExternalSecrets.