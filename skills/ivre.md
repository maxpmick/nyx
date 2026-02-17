---
name: ivre
description: A network reconnaissance framework (Instrument de veille sur les réseaux extérieurs) used for both passive and active reconnaissance. It integrates with Nmap, ZMap, Masscan, Zeek (Bro), and p0f to collect, store, and analyze network data. Use it to build a large-scale network knowledge base, perform flow analysis, manage active scanning campaigns, and visualize network footprints.
---

# ivre

## Overview
IVRE (or DRUNK - Dynamic Recon of UNKnown networks) is an open-source framework for network reconnaissance. It provides tools for passive reconnaissance (flow analytics via Zeek, Argus, Nfdump; fingerprinting via p0f) and active reconnaissance (Nmap/ZMap integration). It relies on a database backend (MongoDB, PostgreSQL, or MySQL) to store and query scan results and network metadata. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume IVRE is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install ivre
```

Note: IVRE requires a database backend (usually MongoDB) to be configured for most commands to function.

## Common Workflows

### Initialize the Database (MongoDB)
Before using IVRE, you typically need to initialize the data structures:
```bash
ivre scan2db --init
ivre ipinfo --init
ivre ipdata --init
```

### Import Nmap XML Scans
Import existing Nmap results into the IVRE database for analysis:
```bash
ivre scan2db -c MY_CAMPAIGN -s MY_SOURCE /path/to/nmap_output.xml
```

### Run Active Scans
Run a scan using Nmap through the IVRE framework:
```bash
ivre runscans --network 192.168.1.0/24 --output Nmap
```

### Passive Reconnaissance (Zeek/Bro)
Import Zeek logs for passive network analysis:
```bash
ivre zeek2db /var/log/zeek/*.log
```

### Query the Database
Search for specific open ports or services via the CLI:
```bash
ivre scancli --search "service:http"
```

## Complete Command Reference

IVRE uses a subcommand-based architecture. Use `ivre help [COMMAND]` for specific details on each.

### Core Subcommands

| Command | Description |
|---------|-------------|
| `airodump2db` | Import airodump-ng CSV output into the database |
| `arp2db` | Import ARP logs/data into the database |
| `auditdom` | Perform domain name auditing and reconnaissance |
| `db2view` | Generate view data from the main database |
| `flow2db` | Import network flow data (Argus, Nfdump) |
| `flowcli` | Command-line interface to query flow data |
| `getmoduli` | Extract Diffie-Hellman moduli from scan results |
| `getwebdata` | Fetch and store web-related data (screenshots, headers) |
| `httpd` | Start the IVRE web interface server |
| `ipcalc` | IP address calculator and subnet tool |
| `ipdata` | Manage and import IP metadata (GeoIP, AS numbers) |
| `iphost` | Manage host-related information |
| `ipinfo` | Manage and query the IP information database |
| `localscan` | Run local scripts to gather host information |
| `macdata` | Manage MAC address vendor data (OUI) |
| `macinfo` | Query information about MAC addresses |
| `p0f2db` | Import p0f passive fingerprinting logs |
| `passiverecon2db` | Import generic passive reconnaissance data |
| `passivereconworker` | Background worker for passive recon processing |
| `plotdb` | Generate graphical plots from database content |
| `runscans` | Main tool to execute active Nmap/ZMap scans |
| `runscansagent` | Agent for distributed scanning |
| `runscansagentdb` | Manage the database for scan agents |
| `scan2db` | Import Nmap or Masscan XML results into the database |
| `scancli` | Command-line interface to query scan results |
| `scanstatus` | Check the status of ongoing or completed scans |
| `sort` | Utility to sort and filter scan data |
| `version` | Display IVRE version and dependency status |
| `view` | Manage and query "views" (aggregated data) |
| `weblog2db` | Import HTTP server logs (Apache, Nginx) |
| `zeek2db` | Import Zeek (formerly Bro) network analysis logs |

### Global Options
Most commands support:
- `-h`, `--help`: Show help message for the command.
- `--init`: Initialize the database collection/table for that specific tool.
- `-v`, `--verbose`: Increase output verbosity.

## Notes
- **Database Requirement**: IVRE is a framework, not just a standalone tool. It requires a running database (MongoDB is the default and most supported) to store results.
- **Web Interface**: The `ivre httpd` command launches a web-based GUI for exploring the data, usually accessible at `http://localhost:8080`.
- **Integration**: IVRE is highly effective at merging data from multiple sources (e.g., seeing Nmap results alongside passive p0f fingerprints for the same IP).