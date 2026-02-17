---
name: snort
description: Perform network intrusion detection and prevention by sniffing, logging, and analyzing traffic against a set of rules. Use when monitoring network traffic for suspicious activity, detecting port scans, buffer overflows, or CGI attacks, and for converting legacy Snort configurations to Snort++ (Snort 3).
---

# snort

## Overview
Snort is a libpcap-based packet sniffer and logger used as a lightweight network intrusion detection system (NIDS). It features rules-based logging and content matching to detect attacks, probes, and anomalies in real-time. Category: Sniffing & Spoofing / Vulnerability Analysis.

## Installation (if not already installed)
Assume Snort is already installed. If not:
```bash
sudo apt install snort
```

## Common Workflows

### Convert Snort 2 configuration to Snort 3 (Lua)
```bash
snort2lua -c /etc/snort/snort.conf -o /etc/snort/snort.lua -r /etc/snort/converted.rules
```

### Dump Unified2 log contents to stdout
```bash
u2spewfoo /var/log/snort/snort.log.123456789
```

### Convert Unified2 logs to PCAP format
```bash
u2boat -t pcap /var/log/snort/snort.log.123456789 output.pcap
```

### Create a custom AppID detector
```bash
appid_detector_builder.sh
```
Follow the interactive prompts to define the AppId string (e.g., "InternalApp").

## Complete Command Reference

### snort
The main NIDS engine. Use help options to explore modules and configurations.

| Flag | Description |
|------|-------------|
| `-?`, `--help` | List command line options |
| `--help-commands [<prefix>]` | Output matching commands |
| `--help-config [<prefix>]` | Output matching config options |
| `--help-counts [<prefix>]` | Output matching peg counts |
| `--help-limits` | Print the integer upper bounds denoted by max* |
| `--help-module <module>` | Output description of given module |
| `--help-modules` | List all available modules with brief help |
| `--help-modules-json` | Dump description of all available modules in JSON format |
| `--help-plugins` | List all available plugins with brief help |
| `--help-options [<prefix>]` | Output matching command line options |
| `--help-signals` | Dump available control signals |
| `--list-buffers` | Output available inspection buffers |
| `--list-builtin [<prefix>]` | Output matching builtin rules |
| `--list-gids [<prefix>]` | Output matching generators |
| `--list-modules [<type>]` | List all known modules |
| `--list-plugins` | List all known modules |
| `--show-plugins` | List module and plugin versions |

### snort2lua
Converts Snort 2.x configuration files to Snort 3 (Lua) format.

| Flag | Description |
|------|-------------|
| `-?` | Show usage |
| `-h`, `--help` | Show overview of snort2lua |
| `-a`, `--print-all` | Default option. Print all data |
| `-c`, `--conf-file <file>` | The Snort configuration file to convert (Required) |
| `-d`, `--print-differences` | Print only differences between Snort and Snort++ configs to `<out_file>` |
| `-e`, `--error-file <file>` | Output all errors to specified file (Default: snort.rej) |
| `-i`, `--dont-parse-includes` | Do NOT parse files referenced via `include` or `policy_file` |
| `-m`, `--remark` | Add a remark to the end of every converted rule |
| `-o`, `--output-file <file>` | Output the new Snort++ lua configuration (Default: snort.lua) |
| `-q`, `--quiet` | Quiet mode. Only output valid configuration information |
| `-r`, `--rule-file <file>` | Output converted rules to specified file |
| `-s`, `--single-rule-file` | Write rules from included files to the rule file |
| `-t`, `--single-conf-file` | Write info from included files (excluding rules) to the output file |
| `-V`, `--version` | Print the current Snort2Lua version |
| `--bind-wizard` | Add default wizard to bindings |
| `--bind-port` | Convert port bindings |
| `--ips-policy-pattern` | Convert config bindings matching this path to IPS policy bindings |
| `--markup` | Print help in asciidoc compatible format |
| `--dont-convert-max-sessions` | Do not convert max_tcp, max_udp, max_icmp, max_ip to max_session |

### u2boat
Converts Snort's Unified2 logs to other formats.

| Flag | Description |
|------|-------------|
| `-t type` | Specify output type. Currently only `pcap` is valid |
| `<infile>` | The Unified2 log file to convert |
| `<outfile>` | The destination file for the converted data |

### u2spewfoo
Dumps the contents of Unified2 files to stdout for inspection.

| Usage | Description |
|-------|-------------|
| `u2spewfoo <infile>` | Dumps event headers, packet data, and extra data (HTTP URI, Hostname, etc.) to stdout |

### appid_detector_builder.sh
Interactive tool for creating Snort Application ID detectors.

| Usage | Description |
|-------|-------------|
| `appid_detector_builder.sh -h` | Show help for AppId string requirements |

## Notes
- Snort 3 uses Lua for configuration. Use `snort2lua` to migrate legacy `snort.conf` files.
- Unified2 is the standard binary output format for Snort; use `u2spewfoo` or `u2boat` to read these logs.
- When using help/list options for the main `snort` binary, place them last on the command line as they preempt other processing.