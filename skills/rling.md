---
name: rling
description: A high-performance utility suite for removing duplicate lines and matching lines between files, similar to hashcat-utils' rli but significantly faster. Use when deduplicating large wordlists, comparing leaked credential sets, extracting passwords from result files, or performing frequency analysis on password data during password attacks and information gathering.
---

# rling

## Overview
rling is a high-speed replacement for the `rli` utility. It compares a single input file against one or more reference files to remove duplicates or find commonalities. The suite also includes tools for password extraction (`getpass`) and wordlist manipulation by length (`splitlen`). Category: Password Attacks.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install rling
```

## Common Workflows

### Remove duplicates from a wordlist
```bash
rling input.txt unique_output.txt
```

### Remove lines found in a "known" list from a new wordlist
```bash
rling new_passwords.txt cleaned_output.txt rockyou.txt
```

### Extract the second field from a colon-delimited potfile
```bash
getpass -d ":" -f 2 hashcat.potfile > extracted_passwords.txt
```

### Split a wordlist into multiple files based on password length
```bash
splitlen -o passwords_#.txt big_wordlist.txt
```
This creates files like `passwords_8.txt`, `passwords_10.txt`, etc.

## Complete Command Reference

### rling
Remove matching lines from a file.
`rling input output [remfil1 remfile2 ...]`

| Flag | Description |
|------|-------------|
| `-i` | Ignore any error/missing files on remove list |
| `-d` | Removes duplicate lines from input (on by default) |
| `-D file` | Write duplicates to specified file |
| `-n` | Do not remove duplicate lines from input |
| `-c` | Output lines common to input and remove files |
| `-s` | Sort output (default is input order). Makes `-b` and `-f` faster |
| `-t <num>` | Number of threads to use |
| `-p <prime>` | Force size of hash table |
| `-b` | Use binary search vs hash (slower, but less memory) |
| `-2` | Use rli2 mode - all files must be sorted. Low memory usage |
| `-f` | Use files instead of memory (slower, but small memory) |
| `-l [len]` | Limit all matching to a specific length |
| `-M <size>` | Maximum memory to use for `-f` mode |
| `-T <path>` | Directory to store temp files in |
| `-q [cahwl]` | Frequency analysis: `a` (all), `c` (count), `l` (length), `w` (word), `s` (stats), `h` (histogram) |
| `-h` | Show help |

*Note: `stdin` and `stdout` can be used in place of any filename.*

### getpass
Extract passwords from result/pot files.
`getpass [options] [file]`

| Flag | Description |
|------|-------------|
| `-c [spec]` | Set extraction to N-, N-M, or -M (like `cut`) |
| `-d [val]` | Set delimiter (character, decimal, or 0x-hex) |
| `-f [field]` | Set extraction to field number (starts at 1) |
| `-n` | Disable extension exclusion entirely |
| `-t` | Disable extension expansion (e.g., prevents file.txt -> file.txt.md5) |
| `-x [file]` | Read excluded extension list from file |
| `-S <exp>` | Sets $HEX[] conversion for char or range (e.g., a-f, 0x61) |
| `-U <exp>` | Resets $HEX[] conversion for char or range |
| `-h` | Show help |

*Default excluded extensions: .txt, .orig, .test, .csalt.txt, .fixme, .new*

### splitlen
Split wordlists into files based on line length.
`splitlen -o filename file [..file]`

| Flag | Description |
|------|-------------|
| `-u` | Remove $HEX[] encoding from input |
| `-o <file>` | Output filename. `#` is replaced by length. If no `#`, length is appended |
| `-c <char>` | Use specific char as place to insert number in `-o` file |
| `-s` | Sorts by length into a single output file |
| `-M <size>` | Sets the final buffer size for `-s` option |
| `-S <exp>` | Sets $HEX[] conversion for char or range |
| `-U <exp>` | Resets $HEX[] conversion for char or range |

## Notes
- `rling` is optimized for speed and can handle massive wordlists that crash standard `sort -u` or `uniq` operations.
- When memory is an issue, use the `-f` (file-based) or `-2` (sorted mode) flags.
- The tool supports `$HEX[]` notation commonly used in hashcat for non-printable characters.