---
name: ghidra
description: Analyze compiled code, perform disassembly, assembly, decompilation, and graphing using the NSA's Software Reverse Engineering (SRE) framework. Use when performing malware analysis, vulnerability research, reverse engineering binaries (PE, ELF, Mach-O), or developing automated analysis scripts in Java or Python.
---

# ghidra

## Overview
Ghidra is a comprehensive software reverse engineering (SRE) framework developed by the National Security Agency (NSA). It provides high-end software analysis tools for Windows, macOS, and Linux, supporting a wide variety of processor instruction sets and executable formats. Category: Reverse Engineering.

## Installation (if not already installed)
Assume Ghidra is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install ghidra
```

**Dependencies:** libc6, libgcc-s1, libstdc++6, openjdk-21-jdk.

## Common Workflows

### Launching the GUI
Start the interactive Ghidra project manager to begin a new analysis session.
```bash
ghidra
```

### Headless Analysis (Automated)
Run Ghidra without a GUI to analyze a binary and run a specific script.
```bash
/usr/share/ghidra/support/analyzeHeadless /path/to/project_dir ProjectName -import /path/to/binary -postScript MyAnalysisScript.java
```

### Analyzing a specific binary (GUI)
1. Run `ghidra`.
2. Create a new project (`File` -> `New Project`).
3. Press `I` or go to `File` -> `Import File` to load the target binary.
4. Double-click the file in the active project to open the CodeBrowser and start auto-analysis.

## Complete Command Reference

Ghidra is primarily a GUI-based application, but it includes several support scripts for headless operation and configuration located in `/usr/share/ghidra/support/`.

### Primary Execution
| Command | Description |
|---------|-------------|
| `ghidra` | Launches the Ghidra GUI and project manager. |

### Headless Analyzer (`analyzeHeadless`)
Used for batch processing and automated scripting.
**Usage:** `analyzeHeadless <project_location> <project_name> [options]`

| Option | Description |
|--------|-------------|
| `-import [file\|directory]` | Import a file or directory of files into the project. |
| `-process [filename]` | Process an existing file in the project. |
| `-recursive` | Recursively search directories during import. |
| `-postScript <script_name>` | Run a script after analysis (e.g., `MyScript.java` or `MyScript.py`). |
| `-preScript <script_name>` | Run a script before analysis starts. |
| `-scriptPath <path>` | Specify additional directories to search for scripts. |
| `-analysisTimeoutPerFile <seconds>` | Set a timeout for the analysis of each file. |
| `-deleteProject` | Delete the project after the headless execution completes. |
| `-readOnly` | Open the project in read-only mode; changes will not be saved. |
| `-overwrite` | Overwrite existing files in the project during import. |
| `-noanalysis` | Import the file without performing auto-analysis. |
| `-loader <loader_name>` | Specify a particular Ghidra loader to use. |
| `-processor <language_id>` | Manually specify the processor/language ID (e.g., `x86:LE:64:default`). |

### Support Scripts
Located in `/usr/share/ghidra/support/`:

| Script | Description |
|--------|-------------|
| `ghidraDebug` | Launches Ghidra in debug mode for extension development. |
| `launch.sh` | The underlying launch script for the Ghidra JVM. |
| `buildGhidraJar` | Packages Ghidra into a single JAR file for specific deployments. |

## Notes
- **Scripting:** Ghidra supports scripts written in **Java** and **Python** (via Jython). Scripts can be managed via the "Script Manager" within the CodeBrowser.
- **Project Structure:** Ghidra uses a project-based system. Files must be imported into a project before they can be analyzed.
- **Server Mode:** Ghidra supports a client-server model for collaborative reverse engineering. This requires the `ghidraServer` component to be configured.
- **Memory:** As a Java application, Ghidra can be memory-intensive. JVM options (like `-Xmx`) can be adjusted in the `ghidra.conf` or via the launch scripts if performance issues occur.