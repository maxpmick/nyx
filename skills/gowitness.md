---
name: gowitness
description: Web screenshot utility using Chrome Headless to generate screenshots of web interfaces. Use when performing web application reconnaissance, large-scale network scanning, or visual auditing of discovered HTTP/HTTPS services to quickly identify interesting targets.
---

# gowitness

## Overview
gowitness is a website screenshot utility written in Golang that uses Chrome Headless to capture screenshots of web interfaces. It includes a report viewer to process results and is designed for efficiency during large-scale reconnaissance. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
Assume gowitness is already installed. If you get a "command not found" error:

```bash
sudo apt install gowitness
```
Note: Requires `chromium` and `libc6`.

## Common Workflows

### Scan a single URL
```bash
gowitness scan single --url https://example.com
```

### Scan a list of targets from a file
```bash
gowitness scan file --file targets.txt
```

### Scan a CIDR range
```bash
gowitness scan cidr --cidr 192.168.1.0/24
```

### Launch the web-based report viewer
```bash
gowitness report server --address 127.0.0.1:8080
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `-D, --debug-log` | Enable debug logging |
| `-h, --help` | Help for gowitness |
| `--profile` | Enable CPU, memory, and trace profiling (writes to profiles/\<timestamp\>/) |
| `-q, --quiet` | Silence (almost all) logging |

---

### Subcommand: `scan`
Perform various scans to capture screenshots.

#### `scan single`
Capture a screenshot of a single URL.
- `--url <string>`: The URL to screenshot.
- `--output <string>`: Output directory for screenshots.
- `--resolution <string>`: Screenshot resolution (e.g., 1440,900).

#### `scan file`
Capture screenshots from a list of targets in a file.
- `-f, --file <string>`: File containing targets (one per line).
- `-t, --threads <int>`: Number of concurrent threads.

#### `scan cidr`
Capture screenshots of all hosts in a CIDR range.
- `-c, --cidr <string>`: CIDR range to scan.
- `-p, --ports <string>`: Comma-separated list of ports (default: 80,443).

#### `scan nmap`
Capture screenshots from an Nmap XML output file.
- `-f, --file <string>`: Path to the Nmap XML file.

---

### Subcommand: `report`
Work with gowitness reports and captured data.

#### `report server`
Start a local web server to view captured screenshots and metadata.
- `-a, --address <string>`: Address to bind the server to (default: "localhost:7171").
- `-d, --db-path <string>`: Path to the gowitness database.

#### `report list`
List entries in the gowitness database.

#### `report export`
Export captured data.

---

### Subcommand: `version`
Get the gowitness version information.

### Subcommand: `help`
Help about any command.

## Notes
- gowitness uses a SQLite database (usually `gowitness.sqlite7`) in the current directory to store scan metadata.
- Ensure `chromium` or `google-chrome` is installed and accessible in the system PATH, as gowitness relies on it for rendering.
- When scanning large ranges, adjust `--threads` carefully to avoid resource exhaustion on the local machine or triggering rate limits on the target.