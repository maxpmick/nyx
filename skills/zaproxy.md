---
name: zaproxy
description: Perform automated and manual security testing of web applications to find vulnerabilities. Use when conducting web application penetration testing, automated vulnerability scanning, API security audits (OpenAPI/GraphQL/Postman), or as an intercepting proxy to analyze and modify HTTP traffic.
---

# zaproxy (OWASP ZAP)

## Overview
The OWASP Zed Attack Proxy (ZAP) is an integrated penetration testing tool for finding vulnerabilities in web applications. It functions as an intercepting proxy, automated scanner, and reconnaissance tool. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume ZAP is installed. If the `owasp-zap` or `zaproxy` command is missing:

```bash
sudo apt update
sudo apt install zaproxy
```
Note: Requires Java (JRE) to run.

## Common Workflows

### Quick Headless Attack
Perform a quick scan against a target and save the results to an HTML file without opening the GUI.
```bash
owasp-zap -cmd -quickurl http://example.com -quickout report.html
```

### Start as a Daemon for API/Automation
Start ZAP in the background on a specific port for use with automation tools or the ZAP API.
```bash
owasp-zap -daemon -host 0.0.0.0 -port 8080 -config api.disablekey=true
```

### API Definition Scanning
Import an OpenAPI/Swagger definition and run a scan.
```bash
owasp-zap -cmd -openapiurl http://example.com/swagger.json -quickurl http://example.com -quickout api_results.html
```

### Automation Framework
Run a pre-defined automation plan (YAML/JSON) for CI/CD integration.
```bash
owasp-zap -cmd -autorun scan-plan.yaml
```

## Complete Command Reference

ZAP can be launched using `owasp-zap` or `zaproxy`.

### Core Options

| Flag | Description |
|------|-------------|
| `-version` | Reports the ZAP version |
| `-cmd` | Run inline (exits when command line options complete) |
| `-daemon` | Starts ZAP in daemon mode, i.e. without a UI |
| `-config <kvpair>` | Overrides the specified key=value pair in the configuration file |
| `-configfile <path>` | Overrides the key=value pairs with those in the specified properties file |
| `-dir <dir>` | Uses the specified directory instead of the default one |
| `-installdir <dir>` | Overrides the code that detects where ZAP has been installed |
| `-h`, `-help` | Shows all command line options, including those added by add-ons |
| `-newsession <path>` | Creates a new session at the given location |
| `-session <path>` | Opens the given session after starting ZAP |
| `-lowmem` | Use the database instead of memory as much as possible (experimental) |
| `-experimentaldb` | Use the experimental generic database code |
| `-nostdout` | Disables the default logging through standard output |
| `-loglevel <level>` | Sets the log level (overrides log4j2.properties) |
| `-sbomzip <path>` | Creates a zip file containing all available SBOMs |
| `-suppinfo` | Reports support info to the command line and exits |
| `-silent` | Ensures ZAP does not make any unsolicited requests (updates, etc.) |

### Add-on Options

| Flag | Description |
|------|-------------|
| `-notel` | Turns off telemetry calls |
| `-openapifile <path>` | Imports an OpenAPI definition from a file |
| `-openapiurl <url>` | Imports an OpenAPI definition from a URL |
| `-openapitargeturl <url>` | Overrides the server URL in the OpenAPI definition |
| `-addoninstall <id>` | Installs the add-on with specified ID from Marketplace |
| `-addoninstallall` | Install all available add-ons from the Marketplace |
| `-addonuninstall <id>` | Uninstalls the Add-on with specified ID |
| `-addonupdate` | Update all changed add-ons from the Marketplace |
| `-addonlist` | List all installed add-ons |
| `-graphqlfile <path>` | Imports a GraphQL Schema from a file |
| `-graphqlurl <url>` | Imports a GraphQL Schema from a URL |
| `-graphqlendurl <url>` | Sets the GraphQL Endpoint URL |
| `-hud` | Launches a browser with the HUD enabled (for daemon mode) |
| `-hudurl <url>` | Launches HUD browser with the specified URL |
| `-hudbrowser <type>` | Specifies HUD browser (Chrome, Firefox - default Firefox) |
| `-postmanfile <path>` | Imports a Postman collection from a file |
| `-postmanurl <url>` | Imports a Postman collection from a URL |
| `-postmanendpointurl <url>` | Overrides base URLs in the Postman collection |
| `-script <script>` | Run the specified script from commandline or load in GUI |
| `-quickurl <url>` | The URL to attack (e.g., http://www.example.com) |
| `-quickout <file>` | Write results to HTML/JSON/MD/XML (based on extension) |
| `-quickprogress` | Display progress bars while scanning |
| `-zapit <url>` | Perform a quick 'reconnaissance' scan (requires -cmd) |
| `-certload <path>` | Loads the Root CA certificate from a file |
| `-certpubdump <path>` | Dumps the Root CA public certificate (for browser import) |
| `-certfulldump <path>` | Dumps the Root CA full certificate (including private key) |
| `-host <host>` | Overrides the host of the main proxy |
| `-port <port>` | Overrides the port of the main proxy |
| `-autorun <source>` | Run automation jobs from a file or URL |
| `-autogenmin <file>` | Generate template automation file with key parameters |
| `-autogenmax <file>` | Generate template automation file with all parameters |
| `-autogenconf <file>` | Generate template automation file using current config |

## Notes
- When using `-cmd` or `-daemon`, ZAP will not open a window.
- The `-config` flag is powerful for setting API keys or disabling security features in automated environments (e.g., `-config api.key=12345`).
- For large scans, use `-lowmem` to prevent Java OutOfMemory errors.