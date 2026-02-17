---
name: hashcat-utils
description: A collection of specialized utilities for advanced password cracking and wordlist manipulation. Use these tools to preprocess wordlists, generate candidates, convert hash formats, and optimize dictionaries for use with Hashcat during password recovery or penetration testing engagements.
---

# hashcat-utils

## Overview
Hashcat-utils is a set of small, standalone binaries designed to perform specific functions in the password cracking workflow. These tools assist in tasks like wordlist merging, rule manipulation, hash conversion, and candidate generation. Category: Password Attacks.

## Installation (if not already installed)
Assume the utilities are already installed. If a command is missing:

```bash
sudo apt install hashcat-utils
```

## Common Workflows

### Generating a custom wordlist from a mask
```bash
maskprocessor.bin ?l?l?l?d?d > custom_list.txt
```

### Combining two wordlists for a combinator attack
```bash
combinator.bin wordlist1.txt wordlist2.txt > combined.txt
```

### Cleaning a wordlist of invalid characters
```bash
hcstatgen.bin < raw_list.txt > cleaned_list.txt
```

### Converting a CAP file to HCCAPX for Hashcat
```bash
cap2hccapx.bin input.cap output.hccapx
```

## Complete Command Reference

The hashcat-utils package consists of several individual binaries. Below are the usage patterns for the most common utilities included in the suite.

### Wordlist & Candidate Utilities

| Binary | Usage | Description |
|--------|-------|-------------|
| `combinator.bin` | `combinator.bin file1 file2` | Each word in file1 is concatenated with each word in file2. |
| `combinator3.bin` | `combinator3.bin file1 file2 file3` | Each word in file1 is concatenated with file2 and file3. |
| `cutb.bin` | `cutb.bin offset length < file` | Cuts a specific byte range from each line in a file. |
| `expander.bin` | `expander.bin < file` | Expands words by calculating all possible combinations of characters. |
| `gate.bin` | `gate.bin offset mod < file` | Splits a wordlist into chunks based on the line number (useful for distributed processing). |
| `hcstatgen.bin` | `hcstatgen.bin < file` | Generates `.hcstat` files from wordlists for use with hybrid attacks. |
| `len.bin` | `len.bin min max < file` | Filters a wordlist by word length (inclusive). |
| `morph.bin` | `morph.bin depth < file` | Generates new wordlists based on character frequency and position. |
| `permute.bin` | `permute.bin < file` | Generates all possible permutations of characters within each word. |
| `prepare.bin` | `prepare.bin < file` | Prepares a wordlist by removing duplicates and sorting (basic). |
| `req-len.bin` | `req-len.bin min max < file` | Similar to `len.bin`, filters words by length. |
| `req-digit.bin` | `req-digit.bin min max < file` | Filters words based on the number of digits they contain. |
| `rli.bin` | `rli.bin file1 file2` | Removes lines in file1 that are present in file2 (Remove Line Infile). |
| `rli2.bin` | `rli2.bin file1 file2 [fileN]` | Faster version of `rli` for multiple files. |
| `splitlen.bin` | `splitlen.bin output_dir < file` | Splits a wordlist into multiple files based on word length. |
| `toke.bin` | `toke.bin < file` | Tokenizes wordlists based on common delimiters. |

### Rule & Mask Utilities

| Binary | Usage | Description |
|--------|-------|-------------|
| `maskprocessor.bin` | `maskprocessor.bin [options] mask` | High-performance mask generator (supports `?l`, `?u`, `?d`, `?s`, `?a`). |
| `ruleutils.bin` | `ruleutils.bin [options]` | Various utilities for manipulating Hashcat `.rule` files. |

### Conversion & Format Utilities

| Binary | Usage | Description |
|--------|-------|-------------|
| `cap2hccapx.bin` | `cap2hccapx.bin input.cap output.hccapx [filter]` | Converts WPA/WPA2 capture files to Hashcat's hccapx format. |
| `des_crypt_to_hashcat.bin` | `des_crypt_to_hashcat.bin < file` | Converts DES crypt hashes to a format Hashcat understands. |
| `keyspace.bin` | `keyspace.bin mask` | Calculates the total number of combinations for a given mask. |

## Notes
- Most utilities are designed to work with pipes (`|`) and redirection (`>`), allowing for complex wordlist processing chains.
- For large-scale wordlist manipulation, `rli2.bin` is significantly more efficient than standard `grep` or `sort/uniq` combinations.
- `cap2hccapx.bin` is essential for modern WPA cracking workflows.