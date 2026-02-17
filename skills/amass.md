---
name: amass
description: Perform in-depth DNS enumeration, attack surface mapping, and external asset discovery using open-source information gathering and active reconnaissance. Use when performing subdomain discovery, identifying organizational assets, mapping network infrastructure, or tracking changes in an attack surface over time.
---

# amass

## Overview
Amass is a comprehensive tool for information security professionals to perform network mapping and external asset discovery. It utilizes DNS enumeration, web scraping, certificate transparency logs, and numerous APIs to build a detailed picture of a target's infrastructure. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume `amass` is already installed. If missing:

```bash
sudo apt install amass
```

## Common Workflows

### Passive Subdomain Enumeration
Quickly find subdomains using only passive sources (no direct traffic to target).
```bash
amass enum -passive -d example.com
```

### Active Enumeration with Brute Forcing
Perform a deep dive including brute forcing and active DNS resolution.
```bash
amass enum -active -brute -d example.com -src -ip
```

### Visualizing the Attack Surface
Generate an interactive HTML graph of the discovered infrastructure.
```bash
amass viz -enum 1 -html
```

### Tracking Changes
Compare the results of the last two enumerations to see what has changed.
```bash
amass track -d example.com
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `-help` | Show the program usage message |
| `-version` | Print the Amass version number |

### Subcommands

#### enum
Interface with the engine that performs enumerations.

| Flag | Description |
|------|-------------|
| `-active` | Attempt zone transfers and certificate pulling |
| `-aw` | Path to a different wordlist file for alterations |
| `-bl` | Blacklist of subdomains to be ignored |
| `-blf` | Path to a file providing blacklisted subdomains |
| `-brute` | Perform brute force subdomain enumeration |
| `-config` | Path to the YAML configuration file |
| `-d` | Domain names separated by commas (can be used multiple times) |
| `-df` | Path to a file providing root domain names |
| `-dir` | Path to the directory containing the graph database |
| `-exclude` | Data sources to be excluded from the enumeration |
| `-include` | Data sources to be included in the enumeration |
| `-ip` | Show the IP addresses for discovered names |
| `-list` | Print all available data sources |
| `-log` | Path to the log file where errors will be written |
| `-max-dns-queries` | Maximum number of concurrent DNS queries |
| `-min-for-recursive` | Number of subdomains required for recursive brute forcing |
| `-nocolor` | Disable color output |
| `-norecursive` | Turn off recursive brute forcing |
| `-o` | Path to the text output file |
| `-passive` | A purely passive mode of operation |
| `-p` | Ports separated by commas (default: 80, 443) |
| `-r` | IP addresses of preferred DNS resolvers |
| `-rf` | Path to a file providing preferred DNS resolvers |
| `-src` | Print data sources for the discovered names |
| `-timeout` | Number of minutes to let enumeration run |
| `-v` | Print verbose log messages |
| `-w` | Path to a different wordlist file for brute forcing |

#### viz
Analyze OAM data to generate graph visualizations.

| Flag | Description |
|------|-------------|
| `-d3` | Output a D3.js v4 force simulation HTML file |
| `-dot` | Output a Graphviz DOT file |
| `-enum` | The ID of the enumeration to visualize |
| `-gexf` | Output a Gephi Graph Exchange XML Format file |
| `-graphistry` | Output a Graphistry JSON file |
| `-maltego` | Output a Maltego GraphML file |

#### track
Analyze OAM data to identify newly discovered assets.

| Flag | Description |
|------|-------------|
| `-d` | Domain names separated by commas |
| `-df` | Path to a file providing root domain names |
| `-dir` | Path to the directory containing the graph database |
| `-history` | Show the history of all enumerations |
| `-last` | The number of recent enumerations to compare |

#### assoc
Query the OAM (Open Asset Model) along the walk defined by the triples.

#### engine
Run the Amass collection engine to populate the OAM database.

#### subs
Analyze and present discovered subdomains and associated data.

## Notes
- Amass relies heavily on external APIs. For best results, provide API keys in a `config.yaml` file.
- The tool uses a graph database to store findings; by default, this is located in `~/.config/amass`.
- Use the `-passive` flag if you want to avoid any direct interaction with the target's infrastructure.