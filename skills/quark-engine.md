---
name: quark-engine
description: Analyze Android APK and DEX files for malware behaviors using a rule-based scoring system. Use when performing Android application security auditing, malware analysis, threat intelligence gathering, or reverse engineering to identify high-risk behaviors and generate call graphs.
---

# quark-engine

## Overview
Quark-Engine is an Android malware analysis framework that uses a unique scoring system inspired by criminal law to identify malicious patterns. It features an obfuscation-neglect Dalvik bytecode loader and provides detailed reports on suspicious behaviors, permissions, and API calls. Category: Reverse Engineering / Vulnerability Analysis.

## Installation (if not already installed)
Assume quark-engine is already installed. If you encounter errors, install via:

```bash
sudo apt install quark-engine
```

Before first use, you should download the latest analysis rules:
```bash
freshquark
```

## Common Workflows

### Basic Malware Scoring
Analyze an APK and show a summary report of detected behaviors:
```bash
quark -a sample.apk -s
```

### Detailed Behavior Analysis
Show detailed evidence (method offsets and descriptors) for a specific rule or all rules:
```bash
quark -a sample.apk -d all
```

### Generating Visual Call Graphs
Generate a PNG call graph to visualize the execution flow of suspicious behaviors:
```bash
quark -a sample.apk -g png
```

### High-Confidence Filtering
Only show results where the detection confidence is 80% or higher:
```bash
quark -a sample.apk -s -t 80
```

## Complete Command Reference

### freshquark
Downloads and updates the latest Quark rules from the official repository.
- Rules are saved to `~/.quark-engine/quark-rules/rules`.

### quark
The main analysis engine.

```
Usage: quark [OPTIONS]
```

| Flag | Description |
|------|-------------|
| `-a, --apk FILE` | **[Required]** Path to the APK file to analyze |
| `-s, --summary TEXT` | Show summary report. Optionally specify the name of a rule or label |
| `-d, --detail TEXT` | Show detail report. Optionally specify the name of a rule or label |
| `-o, --output FILE` | Output the analysis report in JSON format |
| `-w, --webreport FILE` | Generate an interactive HTML web report |
| `-r, --rule PATH` | Path to rules directory (Default: `~/.quark-engine/quark-rules/rules`) |
| `-g, --graph [png\|json]` | Create call graph in the `call_graph_image` directory |
| `-c, --classification` | Show rules classification |
| `-t, --threshold [100\|80\|60\|40\|20]` | Set the lower limit of the confidence threshold |
| `-i, --list [all\|native\|custom]` | List classes, methods, and descriptors found in the APK |
| `-p, --permission` | List all Android permissions requested by the APK |
| `-l, --label [max\|detailed]` | Show report based on the labels of the rules |
| `-C, --comparison` | Perform behaviors comparison based on max confidence of rule labels |
| `--generate-rule DIRECTORY` | Generate new rules and output them to the specified directory |
| `--core-library [androguard\|rizin]` | Specify the core library used to analyze the APK |
| `--multi-process INTEGER` | Analyze APK with N processes (Max: CPUs - 1) to speed up analysis |
| `--version` | Show the version and exit |
| `--help` | Show the help message and exit |

## Notes
- **Rule Updates**: Always run `freshquark` periodically to ensure you are testing against the latest threat intelligence.
- **Performance**: For large APKs, use the `--multi-process` flag to significantly reduce analysis time.
- **Core Libraries**: While `androguard` is the default, `rizin` can be used as an alternative backend for bytecode analysis.
- **Obfuscation**: Quark is designed to be "obfuscation-neglect," meaning it focuses on the behavioral intent (API combinations) rather than just method names.