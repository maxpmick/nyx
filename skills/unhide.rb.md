---
name: unhide.rb
description: Scan the system for hidden processes that may be obscured by rootkits. Use during digital forensics, incident response, or post-exploitation audits to identify malicious processes that are visible to some system calls but hidden from others.
---

# unhide.rb

## Overview
`unhide.rb` is a forensics tool and Ruby port of the original `unhide` C utility. It identifies hidden processes by comparing results from multiple system scanning methods. If a process is detected via one method but remains invisible to others, it is flagged as potentially malicious. Category: Digital Forensics / Rootkit Detection.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install unhide.rb
```

Dependencies: `procps`, `ruby`.

## Common Workflows

### Standard Scan
Run the tool to scan for hidden processes. Progress is shown on stdout, while findings are sent to stderr.
```bash
sudo unhide.rb
```

### Silent Scan (Only report findings)
Redirect progress messages to `/dev/null` to only see alerts for hidden processes.
```bash
sudo unhide.rb > /dev/null
```

### Automated Check with Exit Status
Useful for scripts or CI/CD monitoring.
```bash
sudo unhide.rb > /dev/null
status=$?
if [ $status -eq 2 ]; then
    echo "Hidden processes detected!"
elif [ $status -eq 1 ]; then
    echo "Scan error occurred."
fi
```

## Complete Command Reference

### Usage
```bash
unhide.rb
```

### Options
`unhide.rb` takes no command-line options or flags.

### Exit Status
| Status | Meaning |
|--------|---------|
| `0` | No hidden processes found |
| `1` | Something went wrong during scanning (error) |
| `2` | One or more hidden processes were detected |

## Notes
- **Permissions**: This tool must be run with root privileges (`sudo`) to access process information across the entire system.
- **Comparison to C version**: While faster than the original C implementation, `unhide.rb` does not implement every diagnostic check found in the C version and cannot be statically compiled.
- **Integration**: This tool is frequently used by `rkhunter` for automated daily rootkit scans.
- **Output**: Progress messages are printed to `stdout`. Error diagnostics and information about discovered hidden processes are printed to `stderr`.