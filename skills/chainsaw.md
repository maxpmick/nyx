---
name: chainsaw
description: Rapidly search and hunt through Windows forensic artefacts including Event Logs (.evtx) and MFT files. Use when performing digital forensics, incident response, or threat hunting to identify malicious activity using Sigma rules, custom detection logic, or keyword searching.
---

# chainsaw

## Overview
Chainsaw provides a powerful ‘first-response’ capability to quickly identify threats within Windows forensic artefacts. it offers a fast method of searching through event logs for keywords and identifying threats using built-in support for Sigma detection rules and custom Chainsaw detection rules. Category: Digital Forensics.

## Installation (if not already installed)
Assume chainsaw is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install chainsaw
```

## Common Workflows

### Hunt using Sigma and Chainsaw rules
```bash
chainsaw hunt /path/to/evtx/ -s /path/to/sigma/rules/ --mapping /path/to/mappings/sigma-event-logs-all.yml -r /path/to/chainsaw/rules/
```

### Search for a specific keyword (case-insensitive)
```bash
chainsaw search "mimikatz" -i /path/to/evtx/
```

### Search for specific Event IDs (e.g., PowerShell Script Block 4104)
```bash
chainsaw search -t 'Event.System.EventID: =4104' /path/to/evtx/
```

### Hunt and output results in JSON format
```bash
chainsaw hunt /path/to/evtx/ -s /path/to/sigma/ --mapping /path/to/mappings/sigma-event-logs-all.yml --json
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `--no-banner` | Hide Chainsaw's banner |
| `--num-threads <NUM_THREADS>` | Limit the thread number (default: number of CPUs) |
| `-v` | Print verbose output (use multiple times for more verbosity) |
| `-h`, `--help` | Print help information |
| `-V`, `--version` | Print version information |

### Subcommands

#### `hunt`
Hunt through artefacts using detection rules for threat detection.
- `-s, --sigma <PATH>`: Path to Sigma rules directory or file
- `-r, --rules <PATH>`: Path to Chainsaw rules directory or file
- `--mapping <PATH>`: Path to the Sigma mapping file
- `--json`: Output results in JSON format
- `--csv`: Output results in CSV format
- `--xml`: Output results in XML format
- `--full`: Display the full event content in the output

#### `search`
Search through forensic artefacts for keywords or patterns.
- `-i, --ignore-case`: Perform case-insensitive search
- `-e, --regex`: Treat the search term as a regular expression
- `-t, --tau <EXPRESSION>`: Use a Tau expression for advanced filtering (e.g., 'Event.System.EventID: =4104')
- `--json`: Output results in JSON format
- `--csv`: Output results in CSV format

#### `dump`
Dump artefacts into a different format for external analysis.
- `--json`: Dump to JSON format
- `--csv`: Dump to CSV format

#### `analyse`
Perform various analyses on artefacts (e.g., frequency analysis or statistical summaries).

#### `lint`
Lint provided rules to ensure that they load correctly and follow the required schema.

#### `help`
Print the help message or the help of a specific subcommand.

## Notes
- Chainsaw is optimized for speed and can process large volumes of `.evtx` files significantly faster than traditional tools.
- When using Sigma rules, the `--mapping` file is crucial as it tells Chainsaw how to map Sigma fields to the Windows Event Log schema.
- The tool is highly effective for "triage" phases of an investigation where quick answers are needed from a disk image or a collection of logs.