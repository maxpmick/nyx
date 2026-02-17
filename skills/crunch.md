---
name: crunch
description: Generate custom wordlists through combinations and permutations of character sets. Use when performing password cracking, brute-force attacks, or whenever a specific dictionary of strings is required based on length and character constraints.
---

# crunch

## Overview
Crunch is a wordlist generator that creates lists based on user-defined criteria including minimum length, maximum length, and character sets. It supports standard characters, symbols, Unicode, and complex patterns. Category: Password Attacks.

## Installation (if not already installed)
Assume crunch is already installed. If you get a "command not found" error:

```bash
sudo apt install crunch
```

## Common Workflows

### Generate a simple numeric wordlist
Create all possible 4 to 6 digit numeric combinations and save to a file:
```bash
crunch 4 6 0123456789 -o numeric_passwords.txt
```

### Use a predefined charset
Generate 8-character passwords using the "mixalpha-numeric" character set defined in the default charset.lst:
```bash
crunch 8 8 -f /usr/share/crunch/charset.lst mixalpha-numeric
```

### Pattern-based generation
Generate 5-character strings starting with "pass" followed by a digit:
```bash
crunch 5 5 -t pass%
```

### Pipe to a cracker
Generate wordlists on the fly and pipe directly to a tool like Aircrack-ng to save disk space:
```bash
crunch 8 8 0123456789 | aircrack-ng -w - -e MyNetwork capture.cap
```

## Complete Command Reference

```
crunch <min> <max> [options]
```

### Positional Arguments
| Argument | Description |
|----------|-------------|
| `min` | The minimum length of the strings to generate. |
| `max` | The maximum length of the strings to generate. |
| `[characters]` | Optional string of characters to use. If omitted, crunch uses the default lowercase alphabet. |

### Options

| Flag | Description |
|------|-------------|
| `-b <size>` | Maximum size of the output file (e.g., 1mb, 2gb, 10tib). Requires `-o START`. |
| `-c <number>` | Number of lines to write to the output file. Requires `-o START`. |
| `-d <number><symbol>` | Limit the number of duplicate characters (e.g., `-d 2@` limits lowercase to 2 consecutive). |
| `-e <string>` | Stop generating words at the specified string. |
| `-f <path> <name>` | Specify a charset file and the name of the set within that file (e.g., `/usr/share/crunch/charset.lst lalpha`). |
| `-i` | Invert the output order (from `zyx` to `abc`). |
| `-l <string>` | Literal interpretation of `@`, `,`, `%`, `^` when using the `-t` option. |
| `-o <file>` | Write the output to the specified file instead of stdout. |
| `-p <string1> <string2> ...` | Generate permutations of the provided strings/words instead of character combinations. |
| `-q <file>` | Like `-p` but reads the strings from the specified file. |
| `-r` | Resume a previous session. Requires the same command as the original run. |
| `-s <string>` | Start generating words at the specified string. |
| `-t <pattern>` | Set a specific pattern. Symbols: `@` (lower), `,` (upper), `%` (numbers), `^` (symbols). |
| `-u` | Suppress the print of the wordlist size before starting. |
| `-z <type>` | Compress the output file. Valid types: `gzip`, `bzip2`, `lzma`, `7z`. |

## Notes
- **Disk Space**: Wordlists can grow extremely large (PB scale). Always check the size estimate crunch provides before proceeding.
- **Piping**: To avoid filling up storage, pipe crunch output directly into your cracking tool using `|`.
- **Placeholder Symbols**: When using `-t`, the symbols are:
  - `@` = Lowercase alpha characters
  - `,` = Uppercase alpha characters
  - `%` = Numeric characters
  - `^` = Special characters/symbols
- **Default Charset File**: Usually located at `/usr/share/crunch/charset.lst`.