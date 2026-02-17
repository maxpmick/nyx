---
name: siege
description: HTTP/HTTPS regression testing and benchmarking utility. Use to stress test single or multiple URLs, simulate concurrent users, and measure server performance (hits, bytes, response time). Ideal for vulnerability analysis, web application testing, and identifying Denial of Service (DoS) thresholds or performance bottlenecks.
---

# siege

## Overview
Siege is an HTTP/HTTPS load tester and benchmarking utility. It can stress test a single URL or multiple URLs simultaneously, reporting hits, bytes transferred, response time, concurrency, and return status. It supports GET/POST, cookies, basic authentication, and transaction logging. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume siege is already installed. If missing:

```bash
sudo apt install siege
```

## Common Workflows

### Simple Benchmark
Run a benchmark against a single URL with 25 concurrent users for 1 minute:
```bash
siege -c25 -t1M -b http://example.com/
```

### Internet Simulation
Simulate 50 users hitting URLs randomly from a file with a random delay:
```bash
siege -c50 -i -f urls.txt
```

### Testing with Custom Headers
Send a specific User-Agent and Authorization header:
```bash
siege -c10 -r5 --header="Authorization: Bearer token123" --user-agent="Mozilla/5.0" http://example.com/api
```

### Incremental Load Testing (Bombardment)
Start with 5 users, increase by 10 users for 20 trials, with a 1s delay:
```bash
bombardment urls.txt 5 10 20 1
```

## Complete Command Reference

### siege
Main benchmarking tool.

| Flag | Description |
|------|-------------|
| `-V`, `--version` | Print version number |
| `-h`, `--help` | Print help section |
| `-C`, `--config` | Show current configuration |
| `-v`, `--verbose` | Print notifications to screen |
| `-q`, `--quiet` | Suppress output (turns verbose off) |
| `-g`, `--get` | Pull down HTTP headers and display transaction (debugging) |
| `-p`, `--print` | Like GET, but prints the entire page |
| `-c`, `--concurrent=NUM` | Number of concurrent users (default: 10) |
| `-r`, `--reps=NUM` | Number of times to run the test |
| `-t`, `--time=NUMm` | Timed testing (S=seconds, M=minutes, H=hours). Ex: `1H` |
| `-d`, `--delay=NUM` | Random delay before each request (between .001 and NUM) |
| `-b`, `--benchmark` | Benchmark mode: no delays between requests |
| `-i`, `--internet` | Internet user simulation: hits URLs from file randomly |
| `-f`, `--file=FILE` | Select a specific URLs file |
| `-R`, `--rc=FILE` | Specify a custom siegerc file |
| `-l`, `--log[=FILE]` | Log to FILE (default: `/var/log/siege.log`) |
| `-m`, `--mark="text"` | Mark the log file with a specific string |
| `-H`, `--header="text"` | Add a custom header to request (can be used multiple times) |
| `-A`, `--user-agent="text"` | Set the User-Agent header |
| `-T`, `--content-type="text"` | Set the Content-Type header |
| `-j`, `--json-output` | Print final statistics to stdout as JSON |
| `--no-parser` | Turn off the HTML page parser |
| `--no-follow` | Do not follow HTTP redirects |

### bombardment
A wrapper script to run siege with an ever-increasing number of users.

**Usage:** `bombardment [urlfile] [initial_clients] [increment] [trials] [delay]`

| Argument | Description |
|----------|-------------|
| `urlfile` | File containing one or more URLs to test |
| `initial_clients` | Number of clients to use on the first run |
| `increment` | Number of clients to add to each ensuing run |
| `trials` | Number of times to run siege |
| `delay` | Seconds each client waits between requests |

### siege.config
Builds a `.siege/siege.conf` template in the user's home directory.

**Usage:** `siege.config` (No arguments)

## Notes
- **Safety:** Stress testing can crash services. Ensure you have authorization before running high-concurrency benchmarks.
- **Configuration:** Use `siege.config` to generate a default configuration file at `~/.siege/siege.conf` to customize default timeouts and limits.
- **HTTPS:** This version of siege includes native SSL/TLS support.
- **Stats:** The `delay` time is not counted in the final performance statistics.