---
name: rsmangler
description: Generate complex wordlists by performing permutations and various mangling techniques on a set of input words. Use when creating custom wordlists for password cracking, brute-forcing, or credential stuffing during penetration testing, especially when you have specific keywords related to the target.
---

# rsmangler

## Overview
RSMangler is a wordlist mangling tool that takes input words and generates all permutations and acronyms before applying various mangling rules (l33t speak, capitalization, suffixes, etc.). It is designed to create highly targeted wordlists for password attacks. Category: Password Attacks.

## Installation (if not already installed)
Assume rsmangler is already installed. If you get a "command not found" error:

```bash
sudo apt install rsmangler
```

## Common Workflows

### Basic mangling from a file
```bash
rsmangler --file wordlist.txt --output mangled.txt
```

### Piping words from STDIN with length constraints
```bash
echo "p@ssword123" | rsmangler --file - --min 6 --max 12
```

### Creating a targeted list with specific mangles disabled
By default, all mangles are **ON**. To use only specific mangles, you must manually disable the others (though the tool is primarily designed to run all and filter by length).
```bash
rsmangler --file keywords.txt --max 10 --output custom_passwords.txt
```

### Complex pipeline for password cracking
```bash
cat names.txt | rsmangler -m 8 -x 12 --file - | john --stdin --format=nt hash.txt
```

## Complete Command Reference

```
rsmangler [OPTION]
```

### Input/Output Options

| Flag | Description |
|------|-------------|
| `--file`, `-f` | The input file. Use `-` for STDIN |
| `--output`, `-o` | The output file. Use `-` for STDOUT |
| `--help`, `-h` | Show help message |

### Constraint Options

| Flag | Description |
|------|-------------|
| `--max`, `-x` | Maximum word length |
| `--min`, `-m` | Minimum word length |
| `--force` | Don't check output size before processing |
| `--allow-duplicates` | Allow duplicates in the output list |

### Mangling Options (All ON by default; use flags to turn them OFF)

| Flag | Description |
|------|-------------|
| `--perms`, `-p` | Permutate all the words |
| `--double`, `-d` | Double each word |
| `--reverse`, `-r` | Reverse the word |
| `--leet`, `-t` | l33t speak the word |
| `--full-leet`, `-T` | All possibilities l33t |
| `--capital`, `-c` | Capitalise the word |
| `--upper`, `-u` | Uppercase the word |
| `--lower`, `-l` | Lowercase the word |
| `--swap`, `-s` | Swap the case of the word |
| `--ed`, `-e` | Add "ed" to the end of the word |
| `--ing`, `-i` | Add "ing" to the end of the word |
| `--punctuation` | Add common punctuation to the end of the word |
| `--years`, `-y` | Add all years from 1990 to current year to start and end |
| `--acronym`, `-a` | Create an acronym based on all words entered in order |
| `--common`, `-C` | Add common words (admin, sys, pw, pwd) to start and end |
| `--pna` | Add 01 - 09 to the end of the word |
| `--pnb` | Add 01 - 09 to the beginning of the word |
| `--na` | Add 1 - 123 to the end of the word |
| `--nb` | Add 1 - 123 to the beginning of the word |
| `--space` | Add spaces between words |

## Notes
- **Default Behavior**: Unlike many tools, rsmangler enables **all** mangling options by default. Providing a flag for a specific mangle (like `--leet`) actually toggles that specific mangle **OFF**.
- **Performance**: Generating permutations of a large input list can result in an extremely large output file. Use `--min` and `--max` to keep the wordlist manageable.
- **Acronyms**: The `--acronym` feature uses the first letter of every word in the input file in the order they appear.