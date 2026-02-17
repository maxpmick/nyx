---
name: llm-tools-nmap
description: A plugin for the LLM (Large Language Model) CLI tool that provides Nmap network scanning capabilities through function calling. Use when you need an LLM to autonomously perform network discovery, port scanning, and security auditing by executing Nmap commands and interpreting the results.
---

# llm-tools-nmap

## Overview
`llm-tools-nmap` is a plugin for Simon Willison's `llm` tool. it enables LLMs to perform network discovery and security scanning tasks by providing a functional interface to the Nmap security scanner. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)

Assume the tool is already installed. If the plugin is missing or you encounter errors, use the following commands:

```bash
sudo apt install llm-tools-nmap
```

Dependencies: `llm`, `nmap`, `python3`.

## Common Workflows

### Registering the tool with an LLM
To use the Nmap capabilities, you must use a model that supports tool/function calling (e.g., GPT-4o, Claude 3.5 Sonnet) and pass the tools flag.

```bash
llm "Scan the local network for open web ports" --tools
```

### Direct Nmap execution via LLM
Ask the LLM to perform a specific scan. The LLM will generate the appropriate Nmap flags, execute the command, and summarize the findings.

```bash
llm "Perform a service version scan on 192.168.1.50 and tell me what software is running" --tools
```

### Combining Reconnaissance
The LLM can use Nmap to verify live hosts before performing deeper analysis.

```bash
llm "Find all live hosts in 10.0.0.0/24 and then check if any have port 445 open" --tools
```

## Complete Command Reference

This package functions as a plugin for the `llm` CLI. It does not have its own standalone binary but instead exposes functions to the `llm` environment.

### Plugin Integration
When the plugin is installed, it registers Nmap as a "tool" that the LLM can invoke.

| Component | Description |
|-----------|-------------|
| `llm --tools` | Enables the LLM to access the Nmap function calling interface. |
| `nmap` | The underlying system binary used by the plugin to execute scans. |

### Function Capabilities
The plugin allows the LLM to execute Nmap with various parameters, typically including:
- **Target Specification**: IPv4/IPv6 addresses, hostnames, and CIDR ranges.
- **Port Specification**: Individual ports, ranges, or top ports.
- **Scan Types**: SYN scans, UDP scans, Service detection, and OS fingerprinting.
- **Scripting**: Access to the Nmap Scripting Engine (NSE).

## Notes
- **Permissions**: Nmap often requires root privileges for raw socket scans (e.g., `-sS`, `-O`). Ensure the user running `llm` has the necessary sudo permissions if the LLM attempts these scans.
- **Safety**: The LLM determines the Nmap arguments. Always review the proposed command if the LLM environment provides a confirmation prompt.
- **Environment**: This tool requires a functional `nmap` installation on the system path.