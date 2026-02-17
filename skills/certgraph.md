---
name: certgraph
description: Crawl the graph of certificate Subject Alternative Names (SANs) to discover related domains and subdomains. Use when performing reconnaissance, host name enumeration, or mapping the infrastructure of a target via SSL/TLS certificates and Certificate Transparency logs.
---

# certgraph

## Overview
CertGraph is a tool designed to crawl SSL certificates and create a directed graph where domains are nodes and the Subject Alternative Names (SANs) are edges. It helps identify "chains" of trust and shared infrastructure between domains. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)

Assume certgraph is already installed. If you get a "command not found" error:

```bash
sudo apt install certgraph
```

## Common Workflows

### Basic HTTP-based enumeration
```bash
certgraph example.com
```
Crawls the certificate of the target domain using the default HTTP driver and prints new domains as they are discovered.

### Enumeration using Certificate Transparency (CT) logs
```bash
certgraph -driver crtsh -ct-subdomains example.com
```
Uses the crt.sh driver to search CT logs, including subdomains in the search.

### Deep discovery with DNS validation
```bash
certgraph -depth 10 -dns -details example.com
```
Increases the BFS depth to 10, validates if discovered domains have DNS records, and prints the full adjacency list upon completion.

### Exporting results for visualization
```bash
certgraph -json example.com > graph.json
```
Outputs the discovered graph in JSON format, which can be used for web-based UI visualizations.

## Complete Command Reference

```
certgraph [OPTION]... HOST...
```

### Options

| Flag | Description |
|------|-------------|
| `-cdn` | Include certificates from CDNs (Content Delivery Networks) |
| `-ct-expired` | Include expired certificates in certificate transparency search |
| `-ct-subdomains` | Include sub-domains in certificate transparency search |
| `-depth uint` | Maximum BFS depth to go (default 5) |
| `-details` | Print details about the domains crawled (adjacency list) |
| `-dns` | Check for DNS records to determine if domain is registered |
| `-driver string` | Driver to use: `crtsh`, `google`, `http`, `smtp` (default "http") |
| `-json` | Print the graph as json, can be used for graph in web UI |
| `-parallel uint` | Number of certificates to retrieve in parallel (default 10) |
| `-sanscap int` | Max number of uniq TLD+1 domains in cert to include; 0 has no limit (default 80) |
| `-save string` | Save retrieved certificates to specified folder in PEM format |
| `-timeout uint` | TCP timeout in seconds (default 10) |
| `-tldplus1` | For every domain found, add tldPlus1 of the domain's parent |
| `-updatepsl` | Update the default Public Suffix List |
| `-verbose` | Enable verbose logging |
| `-version` | Print version and exit |

## Notes
- The `http` driver connects directly to the host over TCP to retrieve the certificate.
- The `crtsh` and `google` drivers query Certificate Transparency logs, which can find domains that are no longer active or are not reachable via direct connection.
- Use `-sanscap` to prevent "poisoning" your graph with massive certificates from providers like Cloudflare or Let's Encrypt that might list hundreds of unrelated domains.