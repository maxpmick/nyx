---
name: faraday-client
description: Connect to a Faraday server to manage vulnerability data, workspaces, and security tool reports. Use when performing collaborative penetration testing, synchronizing tool output with a central Faraday instance, or automating workspace actions via the command line and GTK interface.
---

# faraday-client

## Overview
Faraday-client is the desktop and command-line interface for the Faraday Integrated Penetration Test Environment. It allows users to interact with the Faraday server, manage workspaces, and process security tool reports through a GTK GUI or a headless CLI mode. Category: Vulnerability Analysis / Reporting.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt update && sudo apt install faraday-client
```

## Common Workflows

### Launching the GTK GUI
```bash
faraday-client --gui gtk --workspace my_pentest_project
```

### Headless Report Parsing
Import a tool report (e.g., Nmap or Nessus XML) directly into a specific workspace without opening the GUI:
```bash
faraday-client --cli --workspace internal_audit --report /path/to/nmap_scan.xml
```

### Using fplugin for Automation
List all scanned IP addresses in a specific workspace via the Faraday API:
```bash
fplugin -w internal_audit -u http://127.0.0.1:5985 get_all_ips
```

### Bulk Vulnerability Deletion
Delete vulnerabilities matching a specific regex pattern:
```bash
fplugin -w staging_env del_all_vulns_with ".*SSL.*"
```

## Complete Command Reference

### faraday-client
The main launcher for the Faraday interface and CLI report importer.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--disable-excepthook` | Disable the application exception hook for error reporting |
| `--login` | Force the application to ask for credentials |
| `--cert CERT_PATH` | Path to a valid Faraday server certificate |
| `--gui GUI` | Select interface: `gtk` or `no` (default: GTK) |
| `--cli` | Use Faraday as a CLI tool (disables GUI) |
| `-w`, `--workspace WORKSPACE` | Specify the workspace to open |
| `-r`, `--report FILENAME` | Path to a report file to be parsed by the CLI |
| `-d`, `--debug` | Enable debug mode |
| `--nodeps` | Skip dependency check |
| `-v`, `--version` | Show program's version number |
| `-n`, `--hostname HOST` | Hostname where server APIs listen (Default: localhost) |
| `-px`, `--port-xmlrpc PORT` | Port for the XMLRPC API (Default: 9876) |
| `-pr`, `--port-rest PORT` | Port for the RESTful API (Default: 9977) |

### fplugin
A command-line utility to interact with the Faraday API and run helper scripts.

```bash
fplugin [options] [command]
```

**Options:**
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-i`, `--interactive` | Run in interactive mode |
| `-w`, `--workspace WORKSPACE` | Workspace to use (default: untitled) |
| `-u`, `--url URL` | Faraday Server URL (default: http://localhost:5985) |
| `--username USERNAME` | Faraday username |
| `--password PASSWORD` | Faraday password |
| `--cert CERT_PATH` | Path to the valid Faraday server certificate |

**Available Commands (Scripts):**
- `autoclose_vulns`: Closes vulns from the current workspace if a certain time has passed
- `change_vuln_status`: Changes Vulns Status (to closed)
- `create_cred`: Creates new credentials
- `create_executive_report`: Creates a new executive report in current workspace
- `create_host`: Creates a new host in current workspace
- `create_service`: Creates a new service in a specified interface
- `create_vuln`: Creates a new vulnerability
- `create_vulnweb`: Creates a new website vulnerability in a specified service
- `create_xlsx_report`: Creates a xls report from current workspace
- `del_all_hosts`: Deletes all stored hosts
- `del_all_services_closed`: Deletes all services with a non open port
- `del_all_vulns_with`: Delete all vulnerabilities matched with regex
- `fbruteforce_services`: Perform a brute force attack on different services in a workspace
- `filter_services`: Filter services by port or service name
- `get_all_ips`: Get all scanned interfaces
- `get_severitiy_by_cwe`: Get Vulns filtered by Severity and change Severity based in CWE
- `import_csv`: Import Faraday objects from CSV file
- `list_creds`: Get all stored credentials
- `list_hosts`: List hosts
- `list_ips`: List all scanned IPs
- `list_os`: Lists all scanned OSs
- `screenshot_server`: Takes a Screenshot of the ip:ports of a given protocol

## Notes
- Ensure the Faraday Server is running before attempting to connect with `faraday-client` or `fplugin`.
- When using `fplugin`, any parameters not recognized or placed after `--` are passed directly to the underlying script.
- The GTK client is the legacy interface; modern Faraday usage often relies on the Web UI, but the client remains useful for local tool integration.