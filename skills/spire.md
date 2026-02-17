---
name: spire
description: Establish trust between software systems using the SPIFFE Runtime Environment (SPIRE). Use to attest running software, issue SPIFFE IDs/SVIDs, and facilitate mTLS or JWT-based authentication between workloads. Relevant for cloud security, container orchestration, and zero-trust architecture testing during penetration testing or infrastructure auditing.
---

# spire

## Overview
SPIRE (the SPIFFE Runtime Environment) is a toolchain of APIs for establishing trust between software systems across diverse hosting platforms. It exposes the SPIFFE Workload API to attest workloads and issue identities (SVIDs), enabling secure mTLS connections, JWT signing, and authentication to databases or cloud providers. Category: Infrastructure Security / Authentication.

## Installation (if not already installed)
Assume SPIRE is already installed. If you get a "command not found" error:

```bash
sudo apt install spire
```

## Common Workflows

### Validate Configuration Files
Before running the server or agent, ensure the configuration files are syntactically correct.
```bash
spire-server validate /etc/spire/server.conf
spire-agent validate /etc/spire/agent.conf
```

### Start the SPIRE Server
Run the server using a specific configuration file.
```bash
spire-server run -config /etc/spire/server.conf
```

### Generate a Join Token for an Agent
Create a one-time token to allow a new agent to connect to the server.
```bash
spire-server token generate -spiffeID spiffe://example.org/myagent
```

### Check Health Status
Verify if the local SPIRE components are functioning correctly.
```bash
spire-server healthcheck
spire-agent healthcheck
```

## Complete Command Reference

### spire-agent
The agent runs on every node where a workload is running.

**Usage:** `spire-agent [--version] [--help] <command> [<args>]`

| Command | Description |
|---------|-------------|
| `api` | Interact with the agent APIs |
| `healthcheck` | Determines agent health status |
| `run` | Runs the agent |
| `validate` | Validates a SPIRE agent configuration file |

### spire-server
The server manages identities and attestation logic.

**Usage:** `spire-server [--version] [--help] <command> [<args>]`

| Command | Description |
|---------|-------------|
| `agent` | Manage registered agents (list, evict, show) |
| `bundle` | Manage the trust bundle (show, set, delete) |
| `entry` | Manage registration entries (create, list, update, delete) |
| `federation` | Manage federation relationships |
| `healthcheck` | Determines server health status |
| `jwt` | Manage JWT SVIDs (mint, inspect) |
| `localauthority` | Manage local authority keys |
| `logger` | Adjust the logging level at runtime |
| `run` | Runs the server |
| `token` | Manage join tokens (generate) |
| `upstreamauthority` | Interact with upstream authorities |
| `validate` | Validates a SPIRE server configuration file |
| `x509` | Manage X.509 SVIDs (mint, inspect) |

## Notes
- SPIRE requires a configuration file (usually in HCL format) to define plugins for node attestation, workload attestation, and key storage.
- The `spire-server run` and `spire-agent run` commands are typically managed by systemd or container orchestrators in production.
- Security Domain: Identity and Access Management (IAM) / Cloud Security.