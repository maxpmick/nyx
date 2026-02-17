---
name: patchleaks
description: Analyze security patches by comparing two versions of a codebase to identify changed lines and perform vulnerability analysis. Use when researching CVEs, performing patch diffing, validating security fixes, or developing exploits based on vendor-provided updates.
---

# patchleaks

## Overview
PatchLeaks is a tool designed to bridge the gap between a CVE number and the actual vulnerable code. It compares an unpatched and a patched version of a codebase, highlights the changes made by the vendor, and provides an AI-assisted explanation of the security implications. Category: Vulnerability Analysis / Exploitation.

## Installation (if not already installed)
Assume the tool is already installed. If the command is not found:

```bash
sudo apt update && sudo apt install patchleaks
```

## Common Workflows

### Start the web interface on a specific port
```bash
patchleaks -p 8080
```
Launches the local web server on port 8080. You can then navigate to `http://127.0.0.1:8080` to upload codebases and manage products.

### Run with multi-threaded AI analysis
```bash
patchleaks -t 4
```
Starts the server and allocates 4 threads for processing AI-driven vulnerability analysis of the code diffs.

### Bind to all interfaces
```bash
patchleaks -host 0.0.0.0 -p 9000
```
Makes the PatchLeaks interface accessible over the network on port 9000.

## Complete Command Reference

The tool can be invoked using either `patchleaks` or `PatchLeaks`. Both commands support the same flags.

```
patchleaks [options]
```

### Options

| Flag | Type | Description |
|------|------|-------------|
| `-host` | string | Host address to bind the web server to (default "127.0.0.1") |
| `-p` | int | Port to run the server on (default: random free port) |
| `-t` | int | Number of threads for AI analysis (default: 1) |
| `-h` | N/A | Display help and usage information |

## Notes
- **Web Interface**: PatchLeaks operates primarily through a web UI. Upon execution, it parses HTML templates located in `/usr/share/patchleaks/templates/`.
- **AI Integration**: The tool includes settings for AI analysis (configured via the web UI) to explain why specific code changes matter for security.
- **Data Management**: The interface allows for managing "Products" (software projects), "Library" (versions/codebases), and "Reports" (analysis results).
- **Dependencies**: Requires `libc6`, `libjs-jquery`, and `node-fortawesome-fontawesome-free` for the web interface to function correctly.