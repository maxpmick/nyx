---
name: kali-defaults
description: Manage and verify Kali Linux system default settings, configurations, and environment scripts. Use when checking APT source integrity, handling deprecated commands, or managing system-wide configuration defaults across various Kali metapackages.
---

# kali-defaults

## Overview
The `kali-defaults` package implements core configuration settings, scripts, and environment defaults for Kali Linux. It is a foundational package included in all Kali images (core, headless, docker, etc.) to ensure a consistent environment. Category: System Configuration / Maintenance.

## Installation (if not already installed)
The package is typically pre-installed. If missing:

```bash
sudo apt install kali-defaults
```

## Common Workflows

### Verify APT Source Integrity
Check if the current `/etc/apt/sources.list` is configured correctly for Kali Linux.
```bash
kali-check-apt-sources
```

### Handle Deprecated Commands
Used primarily by package maintainers or system scripts to notify users when a command has been replaced.
```bash
kali-deprecated old-tool new-tool https://www.kali.org/docs/replacement-guide/
```

### Access System Tweaks
While `kali-setup` is provided by this package, it is deprecated and directs users to the modern replacement.
```bash
kali-tweaks
```

## Complete Command Reference

### kali-check-apt-sources
Verifies that the system is pointing to valid Kali Linux repositories. It checks for common misconfigurations or non-standard sources that might break system updates.

### kali-deprecated
A utility script to inform users about command deprecation.

**Usage:**
`kali-deprecated <old-command> <new-command> [<url>]`

| Argument | Description |
|----------|-------------|
| `<old-command>` | The name of the command being phased out |
| `<new-command>` | The name of the recommended replacement command |
| `[<url>]` | (Optional) A URL providing more context or migration instructions |

### kali-motd
Generates or displays the Kali "Message of the Day" seen upon login. It often contains dynamic information about the distribution version and links to documentation.

### kali-setup
**Deprecated.** This command now serves as a wrapper that informs the user to use `kali-tweaks` instead.

### kali-treecd
Internal utility used during the build process or environment setup to manage directory structures related to the live system or installation media.

### kali-winexec
A helper script for executing Windows binaries via Wine within the Kali environment, ensuring the correct environment variables and paths are set.

## Notes
- `kali-defaults` is a dependency for almost all `kali-tools-*` metapackages.
- For graphical desktop settings (like wallpaper, themes, and GSettings overrides), the companion package `kali-defaults-desktop` is used.
- If you are looking to customize system behavior (SSH, networking, repositories), use `kali-tweaks` rather than manually invoking scripts within `kali-defaults`.