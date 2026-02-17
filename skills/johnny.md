---
name: johnny
description: A cross-platform Open Source GUI frontend for the John the Ripper password cracker. Use when a graphical interface is preferred for managing password cracking sessions, organizing hash files, configuring attack modes (brute-force, dictionary, mask), and visualizing cracking progress. Ideal for password auditing and recovery tasks within the Password Attacks domain.
---

# johnny

## Overview
Johnny is the official GUI for John the Ripper (JtR). It simplifies password cracking by providing a visual interface to manage complex JtR command-line operations, handle multiple hash types, and monitor real-time cracking statistics. Category: Password Attacks.

## Installation (if not already installed)
Assume johnny is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install johnny
```

**Dependencies:** john, libc6, libgcc-s1, libqt5core5t64, libqt5gui5t64, libqt5widgets5t64, libstdc++6.

## Common Workflows

### Launching the GUI
Simply run the executable to open the main interface:
```bash
johnny
```

### Basic Password Cracking Session
1. **Open Hashes**: Click the "Open password file" button to load your hash file (e.g., `/etc/shadow` or a custom export).
2. **Select Attack**: Navigate to the "Settings" or "Attack" tab to choose between "Default" (JtR's internal logic), "Dictionary", or "Incremental" modes.
3. **Start Cracking**: Click the "Start" button.
4. **View Progress**: Monitor the "Statistics" tab to see cracked passwords and remaining time.

### Configuring JtR Path
If Johnny cannot find the John the Ripper binary:
1. Go to **Settings** > **Options**.
2. Manually browse to the path of the `john` executable (usually `/usr/sbin/john` or `/usr/bin/john`).

## Complete Command Reference

Johnny is primarily a graphical application and does not feature an extensive command-line argument system for automation (as its purpose is to provide the GUI).

```bash
johnny [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Displays the help message and exits. |
| `-v`, `--version` | Displays the current version of Johnny. |

### GUI Features & Functionality

While not flags, the following components are accessible within the interface:

*   **Password Files Tab**: Import and manage multiple hash files. Supports "Add" and "Remove" operations.
*   **Attack Tab**: 
    *   **Mode Selection**: Choose between Single Crack, Wordlist, Incremental, and External modes.
    *   **Rules**: Apply JtR mangling rules to wordlists.
*   **Settings Tab**:
    *   **John Path**: Define the location of the JtR binary.
    *   **John Config**: Define the location of the `john.conf` file.
    *   **Session Management**: Save and resume cracking sessions.
*   **Statistics Tab**: Real-time display of cracked hashes, guessing speed (p/s), and hardware utilization.

## Notes
*   **JtR Dependency**: Johnny is a frontend; it requires `john` to be installed on the system to perform any actual cracking.
*   **Performance**: For high-performance cracking on large datasets, the command-line version of John the Ripper is often more efficient as it avoids the overhead of a GUI.
*   **Permissions**: When cracking system files like `/etc/shadow`, Johnny may need to be started with elevated privileges (`sudo johnny`) or the files must be copied to a user-accessible location first.