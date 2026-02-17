---
name: forensic-artifacts
description: Access a community-sourced, machine-readable knowledge base of forensic artifacts. Use when identifying locations of interest on a file system, determining where specific user activities are logged, or automating evidence collection during digital forensics and incident response (DFIR).
---

# forensic-artifacts

## Overview
Forensic Artifacts is a project providing a standardized, machine-readable (YAML) knowledge base of forensic artifacts. It defines where specific data resides on various operating systems (Windows, Linux, macOS) to assist forensic tools and investigators in locating evidence like logs, configuration files, and user activity traces. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)

The package provides both the raw YAML definitions and a Python library to interact with them.

```bash
sudo apt update
sudo apt install forensic-artifacts python3-artifacts
```

## Common Workflows

### Locate Artifact Definitions
The raw YAML files containing the artifact definitions are stored in the shared data directory. You can grep through these to find specific paths or registry keys.
```bash
ls /usr/share/forensic-artifacts/
grep -r "History" /usr/share/forensic-artifacts/
```

### Using the Python API to List Artifacts
You can use a simple Python script to programmatically access the knowledge base.
```python
from artifacts import reader
from artifacts import registry

# Initialize the registry
artifact_registry = registry.ArtifactDefinitionsRegistry()
artifact_reader = reader.YamlArtifactsReader()

# Load artifacts from the default Kali path
artifact_registry.ReadFromDirectory(artifact_reader, '/usr/share/forensic-artifacts/definitions')

# Print names of all loaded artifacts
for artifact_definition in artifact_registry.GetDefinitions():
    print(artifact_definition.name)
```

### Searching for OS-Specific Artifacts
Filter definitions based on the target operating system (e.g., Windows).
```bash
grep -l "os_platform: \[Windows\]" /usr/share/forensic-artifacts/definitions/*.yaml
```

## Complete Command Reference

This tool is primarily a data library. It does not provide a standalone "binary" command but is utilized via the Python 3 API or by parsing the YAML files directly.

### Data Locations
- `/usr/share/forensic-artifacts/`: Base directory for artifact data.
- `/usr/share/forensic-artifacts/definitions/`: Directory containing individual YAML files for each artifact type (e.g., browsers, operating system components, applications).

### Python `artifacts` Library API

| Module/Method | Description |
|---------------|-------------|
| `artifacts.reader.YamlArtifactsReader()` | Object used to parse the YAML definition files. |
| `artifacts.registry.ArtifactDefinitionsRegistry()` | The central registry that holds and manages loaded artifact definitions. |
| `.ReadFromDirectory(reader, path)` | Method to load all `.yaml` files from a specific directory into the registry. |
| `.ReadFromFile(reader, path)` | Method to load a single `.yaml` artifact file. |
| `.GetDefinitions()` | Returns an iterator over all loaded `ArtifactDefinition` objects. |
| `ArtifactDefinition.name` | The unique identifier of the artifact. |
| `ArtifactDefinition.sources` | A list of source dicts (File, Path, Registry Key, etc.) defining where the data lives. |
| `ArtifactDefinition.labels` | Metadata labels (e.g., "Browser", "Logs", "Antivirus"). |
| `ArtifactDefinition.supported_os` | List of operating systems the artifact applies to. |

## Notes
- This package is a dependency for many advanced forensic tools like `plaso` (log2timeline).
- The definitions are highly granular, often including specific glob patterns for file paths and specific keys for Windows Registry hives.
- When performing a manual investigation, use these YAML files as a "cheat sheet" to ensure you haven't missed standard forensic locations for a specific application.