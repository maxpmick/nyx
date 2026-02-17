---
name: maltego
description: Perform open-source intelligence (OSINT), data mining, and digital forensics by visualizing relationships between entities like domains, IP addresses, social media profiles, and organizations. Use when conducting information gathering, infrastructure mapping, link analysis, or social engineering reconnaissance during a penetration test or investigation.
---

# maltego

## Overview
Maltego is a comprehensive intelligence and forensics application used to gather and connect information from various sources. It visualizes data as graphs to identify hidden relationships between people, groups, companies, domains, and internet infrastructure. Category: Reconnaissance / Information Gathering, Social Engineering, Web Application Testing.

## Installation (if not already installed)
Assume Maltego is already installed. If you encounter errors, ensure Java dependencies are met:

```bash
sudo apt update
sudo apt install maltego
```

## Common Workflows

### Launch the GUI
Maltego is primarily a graphical tool. Launch it from the terminal or application menu:
```bash
maltego
```

### Open specific graph files on startup
```bash
maltego --open investigation_01.mtgl investigation_02.mtgl
```

### Import a configuration or entity package
```bash
maltego --import config_backup.mtz
```

### Run with a specific user directory
Useful for keeping different investigation profiles or settings separate:
```bash
maltego --userdir ~/.maltego/project_alpha
```

## Complete Command Reference

### Module Reload Options
| Flag | Description |
|------|-------------|
| `--reload <path/to/module.jar>` | Install or reinstall a specific module JAR file |

### Additional Module Options
| Flag | Description |
|------|-------------|
| `-z`, `--cloudDebug <arg>` | Enable cloud debugging with the specified argument |
| `-c`, `--cloud <arg>` | Specify cloud configuration |
| `--v3ProtocolDisabled` | Disable the V3 protocol |
| `-s`, `--serverHttpAllowed` | Allow HTTP communication for the server |
| `-p`, `--automationPort <arg>` | Specify the port for automation |
| `-m`, `--machine <arg>` | Run a specific machine (automated workflow) on startup |
| `-i`, `--import <arg>` | Import a configuration file (.mtz) |
| `-h`, `--hub <arg>` | Specify a Transform Hub item or configuration |
| `-o`, `--open <arg1>...<argN>` | Open one or more Maltego graph files (.mtgl) |
| `-u`, `--updates <arg>` | Specify update settings or check for updates |

### Core Options
| Flag | Description |
|------|-------------|
| `--laf <LaF classname>` | Use the specified LookAndFeel class instead of the default |
| `--fontsize <size>` | Set the base font size of the user interface in points |
| `--locale <language[:country[:variant]]>` | Use the specified locale (e.g., en:US) |
| `--userdir <path>` | Use the specified directory to store user settings and configurations |
| `--cachedir <path>` | Use the specified directory to store user cache (must be different from userdir) |
| `--nosplash` | Do not show the splash screen during startup |

## Notes
- **GUI Requirement**: Maltego is a Java-based GUI application. It requires an X11 server or a desktop environment (DISPLAY environment variable must be set). It cannot be used purely via CLI for link analysis.
- **Editions**: This package replaces the older `maltegoce` (Community Edition) and `casefile` packages.
- **API Keys**: Most "Transforms" (data queries) require API keys from third-party providers (e.g., Shodan, VirusTotal, Pipl) which are configured within the Hub inside the GUI.
- **Memory**: As a Java application, Maltego can be memory-intensive when handling large graphs with thousands of entities.