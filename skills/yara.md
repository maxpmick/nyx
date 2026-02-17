---
name: yara
description: Identify and classify malware samples by matching textual or binary patterns against files, directories, or running processes using custom rules. Use when performing malware analysis, digital forensics, incident response, or scanning a system for known indicators of compromise (IOCs).
---

# yara

## Overview
YARA is the "pattern matching swiss army knife" for malware researchers. It allows for the creation of complex rules based on textual or binary strings and boolean logic to identify malware families or specific file characteristics. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume YARA is already installed. If the command is missing:

```bash
sudo apt install yara
```

## Common Workflows

### Scan a file with a specific rule
```bash
yara /path/to/rules.yar /path/to/suspect_file
```

### Recursively scan a directory and print matching strings
```bash
yara -r -s /path/to/rules.yar /path/to/directory
```

### Scan a running process by PID
```bash
yara /path/to/rules.yar 1234
```

### Compile rules for faster subsequent scanning
```bash
yarac /path/to/source_rules.yar compiled_rules.yarc
yara -C compiled_rules.yarc /path/to/target
```

### Scan using external variables
```bash
yara -d filename=test.exe -d user=admin /path/to/rules.yar /path/to/target
```

## Complete Command Reference

### yara
Find files matching patterns and rules.
`Usage: yara [OPTION]... [NAMESPACE:]RULES_FILE... FILE | DIR | PID`

| Flag | Long Option | Description |
|------|-------------|-------------|
| | `--atom-quality-table=FILE` | Path to a file with the atom quality table |
| `-C` | `--compiled-rules` | Load compiled rules |
| `-c` | `--count` | Print only number of matches |
| `-E` | `--strict-escape` | Warn on unknown escape sequences |
| `-d` | `--define=VAR=VALUE` | Define external variable |
| `-q` | `--disable-console-logs` | Disable printing console log messages |
| | `--fail-on-warnings` | Fail on warnings |
| `-f` | `--fast-scan` | Fast matching mode |
| `-h` | `--help` | Show help and exit |
| `-i` | `--identifier=ID` | Print only rules named IDENTIFIER |
| | `--max-process-memory-chunk=N` | Max chunk size for process memory (default=1073741824) |
| `-l` | `--max-rules=NUMBER` | Abort scanning after matching a NUMBER of rules |
| | `--max-strings-per-rule=N` | Max number of strings per rule (default=10000) |
| `-x` | `--module-data=MOD=FILE` | Pass FILE's content as extra data to MODULE |
| `-n` | `--negate` | Print only not satisfied rules (negate) |
| `-N` | `--no-follow-symlinks` | Do not follow symlinks when scanning |
| `-w` | `--no-warnings` | Disable warnings |
| `-m` | `--print-meta` | Print metadata |
| `-D` | `--print-module-data` | Print module data |
| `-M` | `--module-names` | Show module names |
| `-e` | `--print-namespace` | Print rules' namespace |
| `-S` | `--print-stats` | Print rules' statistics |
| `-s` | `--print-strings` | Print matching strings |
| `-L` | `--print-string-length` | Print length of matched strings |
| `-X` | `--print-xor-key` | Print xor key and plaintext of matched strings |
| `-g` | `--print-tags` | Print tags |
| `-r` | `--recursive` | Recursively search directories |
| | `--scan-list` | Scan files listed in FILE, one per line |
| `-z` | `--skip-larger=NUMBER` | Skip files larger than the given size |
| `-k` | `--stack-size=SLOTS` | Set maximum stack size (default=16384) |
| `-t` | `--tag=TAG` | Print only rules tagged as TAG |
| `-p` | `--threads=NUMBER` | Use specified NUMBER of threads to scan a directory |
| `-a` | `--timeout=SECONDS` | Abort scanning after the given number of SECONDS |
| `-v` | `--version` | Show version information |

### yarac
Compile rules to a binary format for faster loading.
`Usage: yarac [OPTION]... [NAMESPACE:]SOURCE_FILE... OUTPUT_FILE`

| Flag | Long Option | Description |
|------|-------------|-------------|
| | `--atom-quality-table=FILE` | Path to a file with the atom quality table |
| `-d` | `--define=VAR=VALUE` | Define external variable |
| | `--fail-on-warnings` | Fail on warnings |
| `-h` | `--help` | Show help and exit |
| `-E` | `--strict-escape` | Warn on unknown escape sequences |
| | `--max-strings-per-rule=N` | Max number of strings per rule (default=10000) |
| `-w` | `--no-warnings` | Disable warnings |
| `-v` | `--version` | Show version information |

## Notes
- Rules can be grouped using namespaces by prefixing the rule file with `namespace:`.
- When scanning large directories, use `-p` (threads) to improve performance.
- The `-s` flag is essential for identifying exactly where a pattern matched within a binary.