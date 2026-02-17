---
name: witnessme
description: Web inventory and screenshot tool used to automate the discovery and visual documentation of web services. It uses a headless browser to capture screenshots and page metadata. Use when performing web application reconnaissance, network service identification, or large-scale attack surface mapping to quickly visualize reachable web interfaces.
---

# witnessme

## Overview
WitnessMe is a web inventory tool inspired by EyeWitness, designed to automate the process of taking screenshots and gathering information from web services. It utilizes a headless browser (Pyppeteer) and is built to be extensible, allowing for custom functionality and API-driven interactions. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install witnessme
```

## Common Workflows

### Screenshot a list of URLs
```bash
witnessme screenshot --input-file urls.txt --output-dir ./screenshots
```

### Grab page metadata and headers without screenshots
```bash
witnessme grab --input-file targets.txt
```

### Scan a network range for web services and screenshot them
```bash
witnessme screenshot 192.168.1.0/24
```

### Start the Web API to view results
```bash
wmapi 127.0.0.1 8000
```

## Complete Command Reference

### witnessme (Main Tool)

```
usage: witnessme [-h] [--threads THREADS] [--timeout TIMEOUT] [-d] [-v] {screenshot,grab} ...
```

#### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--threads THREADS` | Number of concurrent browser tabs to open (Default: 15). High values cause high RAM usage. |
| `--timeout TIMEOUT` | Timeout for each connection attempt in seconds (Default: 15) |
| `-d`, `--debug` | Enable debug output |
| `-v`, `--version` | Show program's version number and exit |

#### Subcommand: screenshot
Used to capture visual evidence of web services.

| Flag | Description |
|------|-------------|
| `-i`, `--input-file` | File containing targets (IPs, hostnames, or URLs) |
| `-o`, `--output-dir` | Directory to save screenshots and report |
| `--proxy` | Proxy to use for requests (e.g., http://127.0.0.1:8080) |
| `--delay` | Delay in seconds after page load before taking screenshot |

#### Subcommand: grab
Used to pull headers, titles, and metadata without the overhead of full screenshots.

| Flag | Description |
|------|-------------|
| `-i`, `--input-file` | File containing targets |
| `--proxy` | Proxy to use for requests |

---

### wmapi (Web Interface/API)
Starts a FastAPI-based web server to browse the captured data and screenshots.

```
usage: wmapi [-h] [host] [port]
```

| Argument | Description |
|----------|-------------|
| `host` | IP address to bind the server to (Default: 127.0.0.1) |
| `port` | Port to bind the server to (Default: 8000) |
| `-h`, `--help` | Show help message and exit |

---

### wmdb (Database Utility)
Used for managing the underlying SQLite database where results are stored.

## Notes
- **Resource Usage**: Be cautious with the `--threads` flag; each thread spawns a headless browser instance which is memory-intensive.
- **Database**: Results are typically stored in a local SQLite database (`witnessme.db`) in the current working directory unless specified otherwise.
- **Dependencies**: Relies on `pyppeteer`, which may download a Chromium revision on first run if not present.