---
name: rev-proxy-grapher
description: Generate Graphviz diagrams illustrating reverse proxy flows and network topology. Use when documenting infrastructure, visualizing complex proxy chains, or mapping external-to-internal network paths during penetration testing or architecture reviews.
---

# rev-proxy-grapher

## Overview
A Python-based tool that generates visual representations of reverse proxy flows. It consumes a manually curated YAML file describing network topology and proxy definitions, optionally enriching the graph with Nmap XML scan data to provide detailed port and service information. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume the tool is already installed. If you encounter errors, install via:

```bash
sudo apt install rev-proxy-grapher
```

Dependencies: python3, python3-netaddr, python3-nmap, python3-pydotplus, python3-yaml.

## Common Workflows

### Generate a basic proxy graph
```bash
rev-proxy-grapher --topology my_network.yaml --out network_map.png
```

### Enrich graph with Nmap scan data and DNS resolution
```bash
rev-proxy-grapher --topology topology.yaml --nmap-xml scan_results.xml --resolve-dns --out infrastructure.pdf
```

### Filter graph for specific source networks
```bash
rev-proxy-grapher --topology topology.yaml --limit-ext 192.168.1.0/24 10.0.0.5 --out filtered_map.svg
```

### Adjust visual layout for complex topologies
```bash
rev-proxy-grapher --topology topology.yaml --ranksep 2.5 --fontsize 10 --font "helvetica" --out clear_map.png
```

## Complete Command Reference

```bash
rev-proxy-grapher [-h] --topology TOPOLOGY [--resolve-dns] [--nmap-xml NMAP_XML [NMAP_XML ...]] [--limit-ext LIMIT_EXT [LIMIT_EXT ...]] [--font FONT] [--fontsize FONTSIZE] [--ranksep RANKSEP] [--out OUT] [--verbose]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `--topology TOPOLOGY` | **Required.** Path to the YAML file describing the proxies and the topology of your networks (default: `topology.yaml`). |
| `--resolve-dns` | Attempt to perform DNS resolution for all IP addresses found (default: `False`). |
| `--nmap-xml <FILE> [<FILE> ...]` | Get additional node details (ports/services) from one or more Nmap XML scan files (default: `()`). |
| `--limit-ext <IP/CIDR> [<IP/CIDR> ...]` | Only include these specific source IPs or networks in the generated graph (default: `()`). |
| `--font FONT` | Specify the font to use in the graph (default: `droid sans,dejavu sans,helvetica`). |
| `--fontsize FONTSIZE` | Specify the font size to use in the graph (default: `11`). |
| `--ranksep RANKSEP` | Set the node separation distance between columns (default: `1`). |
| `--out OUT` | Write the graph into this file. The tool guesses the output format based on the file extension (e.g., .png, .svg, .pdf, .dot) (default: `graph.png`). |
| `--verbose` | Enable verbose output for troubleshooting (default: `False`). |

## Notes
- The tool requires a structured YAML file to define the topology. Ensure the YAML schema matches the expected format (refer to the tool's GitHub repository for schema examples).
- Output formats are determined by Graphviz; ensure `graphviz` is installed on the system to support various extensions like `.pdf` or `.svg`.
- When using `--nmap-xml`, ensure the Nmap scans were performed against the targets defined in your topology file for the data to correlate correctly.