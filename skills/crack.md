---
name: crack
description: Audit Unix password files to identify weak passwords using a fast crypt() or MD5 based guessing engine. Use when performing password auditing, security assessments of local system accounts, or identifying vulnerable user credentials during penetration testing.
---

# crack

## Overview
Crack is a classic password guessing program designed to quickly locate vulnerabilities in Unix (or other) password files. It scans the contents of a password file looking for users who have chosen weak login passwords. It is available in both standard crypt() and MD5 variants. Category: Password Attacks.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install crack crack-md5 crack-common
```

## Common Workflows

### Audit a standard passwd file
```bash
Crack /etc/passwd
```

### Audit a shadow password file
```bash
sudo Crack /etc/shadow
```

### Audit multiple files with a specific format
```bash
Crack -fmt bsd /etc/master.passwd /tmp/other_passwords
```

### View cracking progress and results
```bash
Crack-Reporter
```

## Complete Command Reference

### Crack
The main engine for processing password files and initiating the cracking process.

```
Usage: Crack [options] [bindir] [[-fmt format] files]...
```

| Option | Description |
|------|-------------|
| `[options]` | General configuration flags for the cracking session |
| `[bindir]` | Specify the directory containing the Crack binaries |
| `-fmt <format>` | Specify the format of the input password files (e.g., bsd, unix, etc.) |
| `files` | One or more password files to be audited |

### Crack-Reporter
A utility to summarize the results of the cracking process, showing cracked passwords and any errors encountered.

```
Usage: Crack-Reporter [options]
```

| Output Section | Description |
|------|-------------|
| `passwords cracked` | Lists the usernames and decrypted passwords found so far |
| `errors and warnings` | Displays any issues encountered during the run |
| `done` | Indicates the report generation is complete |

## Notes
- Crack is a background-oriented tool; once started, it typically runs as a background process.
- Use `Crack-Reporter` frequently to check if any passwords have been recovered.
- The tool is highly dependent on the wordlists provided in the `crack-common` package.
- Ensure you have appropriate permissions (often root/sudo) to read sensitive files like `/etc/shadow`.