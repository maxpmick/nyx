---
name: firefox-developer-edition-kbx
description: Run Firefox Developer Edition in a containerized environment using Kaboxer. Use when a dedicated, isolated browser environment is needed for web application testing, debugging modern web technologies, or maintaining separate browser profiles and security contexts during penetration testing.
---

# firefox-developer-edition-kbx

## Overview
Firefox Developer Edition is a version of the Firefox browser tailored for web developers, featuring the latest features and powerful development tools. This specific package runs the browser inside a Docker container managed by Kaboxer (Kali Applications Boxer), providing isolation from the host system. Category: Web Application Testing.

## Installation (if not already installed)
The tool is typically pre-installed in specific Kali environments. If missing, install via:

```bash
sudo apt update
sudo apt install firefox-developer-edition-en-us-kbx
```

**Dependencies:**
- docker.io or docker-ce
- kaboxer

## Common Workflows

### Launch the browser
Simply run the command to start the containerized Firefox Developer Edition instance:
```bash
firefox-developer-edition-en-us-kbx
```

### Run with Kaboxer commands
Since this tool is a Kaboxer-managed application, you can use Kaboxer common verbs to manage the container:
```bash
kaboxer run firefox-developer-edition-en-us-kbx
```

### Stop the container
If the application hangs or needs to be reset:
```bash
kaboxer stop firefox-developer-edition-en-us-kbx
```

## Complete Command Reference

The primary command is a wrapper for the Kaboxer execution engine.

### Primary Command
`firefox-developer-edition-en-us-kbx`

### Kaboxer Integration Options
As a Kaboxer-packaged application, it supports the standard Kaboxer management commands:

| Command | Description |
|---------|-------------|
| `kaboxer run <package>` | Run the containerized application |
| `kaboxer stop <package>` | Stop the running container |
| `kaboxer status <package>` | Check the status of the container |
| `kaboxer purge <package>` | Remove the container and associated data |

## Notes
- **Isolation**: Because this runs in a container, files downloaded or changes made to the browser profile may be stored within the container's volume or specific mapped paths defined by Kaboxer.
- **Docker Requirement**: Ensure the Docker service is running (`sudo systemctl start docker`) before attempting to launch the browser.
- **Localization**: This specific package is localized for `en-US`.