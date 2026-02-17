---
name: dscan
description: Distribute nmap scans across several hosts by aggregating and splitting address ranges. Use when performing large-scale network reconnaissance, distributed vulnerability scanning, or when a single host is insufficient to handle the volume of network scanning required.
---

# dscan

## Overview
dscan is a wrapper around nmap designed to distribute scanning tasks across multiple agents. It manages address range splitting, supports scan resumption, and uses a centralized configuration file to coordinate distributed scanning efforts. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)

Assume dscan is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install dscan
```

Dependencies: python3, python3-libnmap.

## Common Workflows

### Initialize a new scan configuration
```bash
dscan --name internal-audit config --create --network 192.168.1.0/24 --ports 80,443,8080
```

### Start the dscan server
```bash
dscan --name internal-audit srv --listen 0.0.0.0 --port 5000
```

### Connect an agent to the server to perform work
```bash
dscan --name internal-audit agent --server 10.0.0.5 --port 5000
```

### Resume a paused or interrupted scan
```bash
dscan --name internal-audit srv --resume
```

## Complete Command Reference

```
dscan [-h] --name NAME {srv,agent,config} ...
```

### Global Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `--name NAME` | Unique identifier for the scan session/configuration |

### Subcommands

#### config
Used to define or modify the parameters of a distributed scan.

| Flag | Description |
|------|-------------|
| `--create` | Initialize a new scan configuration |
| `--network <range>` | Specify the target network range (CIDR or range) |
| `--ports <ports>` | Specify the ports to scan (nmap format) |
| `--nmap-args <args>` | Pass custom arguments directly to the underlying nmap process |
| `--split <size>` | Define the size of chunks to split the network into for distribution |

#### srv (Server)
The central controller that manages the state of the scan and distributes tasks to agents.

| Flag | Description |
|------|-------------|
| `--listen <ip>` | IP address the server should bind to |
| `--port <port>` | Port the server should listen on |
| `--resume` | Resume a previously stopped scan session |
| `--status` | Display the current progress of the distributed scan |
| `--output <file>` | Specify file to aggregate and save nmap results |

#### agent
The worker node that connects to a server, receives a range, executes nmap, and returns results.

| Flag | Description |
|------|-------------|
| `--server <ip>` | IP address of the dscan server |
| `--port <port>` | Port of the dscan server |
| `--threads <num>` | Number of parallel nmap processes to run on the agent |

## Notes
- Ensure the `--name` parameter is consistent across the server and all agents participating in the same scan.
- The server must be reachable by all agents on the specified port.
- dscan relies on `python3-libnmap` to parse and manage nmap execution and output.