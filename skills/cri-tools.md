---
name: cri-tools
description: A suite of command-line tools for interacting with and validating Kubernetes Container Runtime Interface (CRI) implementations. Use `crictl` for inspecting, managing, and debugging containers, pods, and images on a node. Use `critest` for validating CRI runtime compliance and performance. Essential for Kubernetes node-level troubleshooting, container forensics, and runtime security analysis.
---

# cri-tools

## Overview
`cri-tools` provides a CLI and validation test suite for the Kubelet Container Runtime Interface (CRI). It consists of `crictl`, a tool for managing container runtimes (like containerd or CRI-O), and `critest`, a validation tool for CRI implementations. Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install cri-tools
```

## Common Workflows

### List running pods and containers
```bash
crictl pods
crictl ps
```

### Inspect a specific container's logs and status
```bash
crictl logs <container-id>
crictl inspect <container-id>
```

### Execute a command inside a running container
```bash
crictl exec -it <container-id> /bin/sh
```

### Pull an image and run a pod
```bash
crictl pull nginx
crictl runp pod-config.yaml
```

### Run CRI validation tests
```bash
critest --runtime-endpoint unix:///run/containerd/containerd.sock --ginkgo.v
```

## Complete Command Reference: crictl

### Global Options
| Flag | Description |
|------|-------------|
| `--config, -c` | Location of client config file (default: "/etc/crictl.yaml") |
| `--debug, -D` | Enable debug mode |
| `--enable-tracing` | Enable OpenTelemetry tracing |
| `--image-endpoint, -i` | Endpoint of CRI image manager service |
| `--profile-cpu` | Write a pprof CPU profile to path |
| `--profile-mem` | Write a pprof memory profile to path |
| `--runtime-endpoint, -r` | Endpoint of CRI container runtime service |
| `--timeout, -t` | Timeout for connecting to server (default: 2s) |
| `--tracing-endpoint` | Address for gRPC tracing collector (default: "127.0.0.1:4317") |
| `--tracing-sampling-rate-per-million` | Samples per million spans (default: -1) |

### Commands
| Command | Description |
|---------|-------------|
| `attach` | Attach to a running container |
| `checkpoint` | Checkpoint one or more running containers |
| `completion` | Output shell completion code |
| `config` | Get, set and list crictl configuration options |
| `create` | Create a new container |
| `events` | Stream the events of containers |
| `exec` | Run a command in a running container |
| `imagefsinfo` | Return image filesystem info |
| `images` | List images |
| `info` | Display information of the container runtime |
| `inspect` | Display the status of one or more containers |
| `inspecti` | Return the status of one or more images |
| `inspectp` | Display the status of one or more pods |
| `logs` | Fetch the logs of a container |
| `metricdescs` | List metric descriptors available through CRI |
| `metricsp` | List pod metrics (unstructured key/value pairs) |
| `pods` | List pods |
| `port-forward` | Forward local port to a pod |
| `ps` | List containers |
| `pull` | Pull an image from a registry |
| `rm` | Remove one or more containers |
| `rmi` | Remove one or more images |
| `rmp` | Remove one or more pods |
| `run` | Run a new container inside a sandbox |
| `runp` | Run a new pod |
| `runtime-config` | Retrieve the container runtime configuration |
| `start` | Start one or more created containers |
| `stats` | List container(s) resource usage statistics |
| `statsp` | List pod statistics (structured API) |
| `stop` | Stop one or more running containers |
| `stopp` | Stop one or more running pods |
| `update` | Update one or more running containers |
| `update-runtime-config` | Update the runtime configuration |
| `version` | Display runtime version information |

## Complete Command Reference: critest

### Ginkgo Test Control
| Flag | Description |
|------|-------------|
| `--ginkgo.seed` | Seed used to randomize the spec suite |
| `--ginkgo.randomize-all` | Randomize all specs together |
| `--ginkgo.parallel.process` | Worker process number for parallel runs |
| `--ginkgo.parallel.total` | Total number of worker processes |
| `--ginkgo.parallel.host` | Address for synchronization server |
| `--ginkgo.label-filter` | Filter specs by labels (e.g., `!fruit`) |
| `--ginkgo.sem-ver-filter` | Filter by semantic version constraints |
| `--ginkgo.focus` | Run specs matching this regex |
| `--ginkgo.skip` | Skip specs matching this regex |
| `--ginkgo.focus-file` | Run specs in matching files |
| `--ginkgo.skip-file` | Skip specs in matching files |

### Failure & Output Handling
| Flag | Description |
|------|-------------|
| `--ginkgo.fail-on-pending` | Fail if any specs are pending |
| `--ginkgo.fail-fast` | Stop suite after first failure |
| `--ginkgo.flake-attempts` | Retry failed tests N times |
| `--ginkgo.fail-on-empty` | Fail if no specs are run |
| `--ginkgo.no-color` | Suppress color output |
| `--ginkgo.v` | Verbose output |
| `--ginkgo.vv` | Maximal verbosity (includes skipped/pending) |
| `--ginkgo.succinct` | Succinct report |
| `--ginkgo.trace` | Print full stack trace on failure |
| `--ginkgo.show-node-events` | Print Enter/Exit events on failure |
| `--ginkgo.github-output` | Optimized output for GitHub Actions |
| `--ginkgo.silence-skips` | Do not print skipped tests |
| `--ginkgo.json-report` | Generate JSON report file |
| `--ginkgo.junit-report` | Generate JUnit XML report file |
| `--ginkgo.teamcity-report` | Generate Teamcity report file |

### Debugging & Performance
| Flag | Description |
|------|-------------|
| `--ginkgo.dry-run` | Walk hierarchy without running tests |
| `--ginkgo.poll-progress-after` | Emit progress reports after duration |
| `--ginkgo.timeout` | Suite timeout (default: 1h) |
| `--ginkgo.output-interceptor-mode` | Strategy: `dup`, `swap`, or `none` |
| `-benchmark` | Run benchmarks instead of validation tests |
| `-parallel` | Number of parallel test nodes (default 1) |

### CRI Specific Flags
| Flag | Description |
|------|-------------|
| `-config` | Location of client config file |
| `-image-endpoint` | Image service socket |
| `-runtime-endpoint` | Runtime service socket |
| `-runtime-handler` | Runtime handler to use in test |
| `-test-images-file` | YAML file for custom container images |
| `-websocket-attach` | Use websocket for attach streaming tests |
| `-websocket-exec` | Use websocket for exec streaming tests |
| `-websocket-portforward` | Use websocket for portforward streaming tests |

## Notes
- `crictl` requires a valid configuration file (usually `/etc/crictl.yaml`) or explicit endpoint flags to connect to the container runtime.
- Default runtime endpoints checked: `unix:///run/containerd/containerd.sock`, `unix:///run/crio/crio.sock`, `unix:///var/run/cri-dockerd.sock`.
- `critest` is intensive and should be run in environments where temporary pod/container creation is acceptable.