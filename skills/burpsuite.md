---
name: burpsuite
description: Perform security testing of web applications using an integrated platform for mapping, analysis, and exploitation. Use when intercepting HTTP/S traffic, performing manual web security testing, scanning for vulnerabilities, or automating web attacks during penetration testing.
---

# burpsuite

## Overview
Burp Suite is an integrated platform for performing security testing of web applications. It combines advanced manual techniques with automation to support the entire testing process, from initial mapping and attack surface analysis to finding and exploiting vulnerabilities. Category: Web Application Testing.

## Installation (if not already installed)
Assume Burp Suite is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install burpsuite
```

Dependencies: `default-jre`, `java-wrappers`.

## Common Workflows

### Launch the GUI with default settings
```bash
burpsuite --use-defaults
```

### Open a specific project file
```bash
burpsuite --project-file /home/kali/projects/target_app.burp
```

### Load custom configuration files on startup
```bash
burpsuite --user-config-file=my_user_settings.json --config-file=project_settings.json
```

### Run without extensions for troubleshooting
```bash
burpsuite --disable-extensions
```

## Complete Command Reference

```bash
burpsuite [Options]
```

### General Options

| Flag | Description |
|------|-------------|
| `--help` | Print the help message |
| `--version` | Print version details |
| `--disable-extensions` | Prevent loading of extensions on startup |
| `--diagnostics` | Print diagnostic information |
| `--use-defaults` | Start with default settings |
| `--data-dir` | Specify data directory |
| `--project-file` | Open the specified project file; this will be created as a new project if the file does not exist |
| `--config-file` | Load the specified project configuration file(s); this option may be repeated to load multiple files |
| `--user-config-file` | Load the specified user configuration file(s); this option may be repeated to load multiple files |
| `--auto-repair` | Automatically repair a corrupted project file specified by the `--project-file` option |
| `--unpause-spider-and-scanner` | Do not pause the Spider and Scanner when opening an existing project |
| `--disable-auto-update` | Suppress auto update behavior |

### Collaborator Options

| Flag | Description |
|------|-------------|
| `--collaborator-server` | Run in Collaborator server mode |
| `--collaborator-config` | Specify Collaborator server configuration file; defaults to `collaborator.config` |

### Development Options

| Flag | Description |
|------|-------------|
| `--developer-extension-class-name` | Fully qualified name of locally-developed extension class; extension will be loaded from the classpath |

## Notes
- Burp Suite is primarily a GUI-based tool. While it can be launched from the CLI with the flags above, most interactions occur within the application window.
- Ensure your browser is configured to use Burp's proxy (default: `127.0.0.1:8080`) and the Burp CA certificate is installed for HTTPS interception.
- The `--project-file` option is essential for maintaining state across testing sessions in Professional/Enterprise editions.