---
name: watobo
description: Perform semi-automated web application security audits using WATOBO, which functions as a local web proxy. Use when conducting manual or automated web application testing, vulnerability scanning, and traffic interception to identify security flaws in web services.
---

# watobo

## Overview
WATOBO (The Web Application Toolbox) is a semi-automated web application security auditing tool designed for security professionals. It operates as a local web proxy, allowing for the interception, modification, and automated scanning of HTTP/HTTPS traffic. Category: Web Application Testing.

## Installation (if not already installed)
Assume watobo is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install watobo
```

Dependencies: bundler, pry, ruby, ruby-fxruby, ruby-jwt, ruby-mechanize, ruby-net-http-pipeline, ruby-selenium-webdriver.

## Common Workflows

### Launching the GUI
WATOBO is primarily a GUI-based tool. Launch it from the terminal to start the proxy and management interface:
```bash
watobo
```

### Basic Interception Workflow
1. Start `watobo`.
2. Configure your browser to use WATOBO as a proxy (default is usually `localhost:8080`).
3. Browse the target application to populate the site tree.
4. Right-click on requests in the site tree to send them to the "Manual Request" editor or start an "Active Scan".

### Session Management
WATOBO allows you to define session handlers to maintain login states during automated scans, which is critical for testing authenticated areas of a web application.

## Complete Command Reference

WATOBO is primarily an interactive GUI application. The command-line interface is used to initialize the environment and launch the graphical interface.

```bash
watobo [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |

### Configuration Files
Upon startup, WATOBO loads several configuration files located in `/usr/share/watobo/config/`. These can be modified to change default behaviors:

| Config File | Description |
|-------------|-------------|
| `datastore.yml` | Settings for project data storage |
| `forwarding_proxy.yml` | Configuration for upstream proxies |
| `general.yml` | General application settings |
| `gui.yml` | GUI appearance and behavior settings |
| `interceptor.yml` | Proxy interception rules and settings |
| `ott_cache.yml` | One-Time-Token cache settings |
| `scan_policy.yml` | Default vulnerability scanning policies |
| `scanner.yml` | Engine settings for the automated scanner |
| `scope.yml` | Definition of in-scope and out-of-scope targets |
| `sid_cache.yml` | Session ID tracking and caching |

## Notes
- **GUI Loading**: WATOBO relies on `FXRuby`. Loading the GUI components may take several seconds after running the command.
- **Environment**: If you are developing modules, you can set the `DEV_ENV` environment variable to adjust how the tool loads local resources.
- **Module Errors**: You may occasionally see "uninitialized constant" errors during startup if specific modules have dependency issues; these generally do not prevent the rest of the application from functioning.
- **Proxy Setup**: Ensure your browser's CA certificates are configured if you intend to intercept HTTPS traffic through WATOBO.