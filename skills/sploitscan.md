---
name: sploitscan
description: Search for CVE information and public exploits from multiple databases including MITRE, EPSS, CISA KEV, and PoC repositories. Use when performing vulnerability analysis, prioritizing patches, or searching for exploit code associated with specific CVE IDs during penetration testing or vulnerability management.
---

# sploitscan

## Overview
SploitScan is a command-line utility designed to aggregate vulnerability data and public exploit availability for specific CVE IDs. it integrates data from MITRE, the Exploit Prediction Scoring System (EPSS), CISA's Known Exploited Vulnerabilities (KEV) catalog, and various Proof of Concept (PoC) sources. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume sploitscan is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install sploitscan
```

## Common Workflows

### Scan a single CVE
```bash
sploitscan CVE-2023-38831
```

### Scan multiple CVEs and export to HTML
```bash
sploitscan CVE-2021-44228 CVE-2017-0144 -e html
```

### Import results from a Nessus scan file
```bash
sploitscan -t nessus -i /path/to/scan_results.csv
```

### Analyze vulnerabilities from a Docker image scan
```bash
sploitscan -t docker -i docker_scan_results.json
```

## Complete Command Reference

```bash
usage: sploitscan [-h] [-e {json,JSON,csv,CSV,html,HTML}]
                  [-t {nessus,nexpose,openvas,docker}] [-i IMPORT_FILE]
                  [-c CONFIG] [-d]
                  [cve_ids ...]
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `cve_ids` | Enter one or more CVE IDs to fetch data (e.g., CVE-YYYY-NNNNN). Separate multiple IDs with spaces. Optional if `-i` is used. |

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-e`, `--export {json,csv,html}` | Export results to a file. Supported formats: `json`, `csv`, or `html` (case-insensitive). |
| `-t`, `--type {nessus,nexpose,openvas,docker}` | Specify the format/source of the import file. |
| `-i`, `--import-file <FILE>` | Path to a vulnerability scanner export file. When used, manual CVE IDs are optional. |
| `-c`, `--config <FILE>` | Path to a custom configuration file. |
| `-d`, `--debug` | Enable verbose debug output for troubleshooting. |

## Notes
- **Data Sources**: The tool queries MITRE (CVE details), FIRST.org (EPSS scores), CISA (KEV status), and various exploit databases for PoCs.
- **Patch Priority**: It interacts with the Patch Priority System to help determine which vulnerabilities require immediate attention based on exploit availability.
- **Dependencies**: Requires Python 3 and several libraries (`requests`, `tabulate`, `jinja2`, `openai`). If using AI-enhanced features via the config, an OpenAI API key may be required.