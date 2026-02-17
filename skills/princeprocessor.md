---
name: princeprocessor
description: Generate password candidates using the PRobability INfinite Chained Elements (PRINCE) algorithm. It builds chains of concatenated words from a single input wordlist, acting as an advanced combinator attack. Use during password cracking or security auditing when a dictionary attack is insufficient and you need to generate complex candidates based on word combinations and probability.
---

# princeprocessor

## Overview
Princeprocessor (PP) is a standalone password candidate generator that implements the PRINCE algorithm. Unlike standard combinator attacks that merge two different wordlists, PP takes a single wordlist and creates "chains" of 1 to N words concatenated together. It is highly efficient for generating candidates that follow human-like password patterns. Category: Password Attacks.

## Installation (if not already installed)
Assume princeprocessor is already installed. If the command is missing:

```bash
sudo apt install princeprocessor
```

## Common Workflows

### Basic candidate generation
Generate combinations from a wordlist and pipe them directly into a cracker like Hashcat:
```bash
princeprocessor wordlist.txt | hashcat -m 0 hashes.txt
```

### Constrained length generation
Generate candidates that are between 8 and 12 characters long, using a maximum of 3 elements per chain:
```bash
princeprocessor --pw-min=8 --pw-max=12 --elem-cnt-max=3 wordlist.txt
```

### Distributed processing
Skip the first 1 million candidates and limit the output to the next 1 million for parallel processing:
```bash
princeprocessor --skip=1000000 --limit=1000000 wordlist.txt > part2.txt
```

### Calculate keyspace
Determine how many total combinations will be generated without actually producing them:
```bash
princeprocessor --keyspace wordlist.txt
```

## Complete Command Reference

```
princeprocessor [options] [<] wordlist
```

### Startup Options
| Flag | Description |
|------|-------------|
| `-V`, `--version` | Print version |
| `-h`, `--help` | Print help |

### Misc Options
| Flag | Description |
|------|-------------|
| `--keyspace` | Calculate total number of combinations |

### Optimization Options
| Flag | Description |
|------|-------------|
| `--pw-min=NUM` | Print candidate only if length is greater than NUM |
| `--pw-max=NUM` | Print candidate only if length is smaller than NUM |
| `--elem-cnt-min=NUM` | Minimum number of elements per chain |
| `--elem-cnt-max=NUM` | Maximum number of elements per chain |
| `--wl-dist-len` | Calculate output length distribution from wordlist |
| `--wl-max=NUM` | Load only NUM words from input wordlist (use 0 to disable) |
| `-c`, `--dupe-check-disable` | Disable duplicates check for faster initial load |
| `--save-pos-disable` | Disable saving the position for later resume |

### Resources Options
| Flag | Description |
|------|-------------|
| `-s`, `--skip=NUM` | Skip NUM passwords from start (useful for distributed tasks) |
| `-l`, `--limit=NUM` | Limit output to NUM passwords (useful for distributed tasks) |

### Files Options
| Flag | Description |
|------|-------------|
| `-o`, `--output-file=FILE` | Write results to specified FILE instead of stdout |

### Amplifier Options
| Flag | Description |
|------|-------------|
| `--case-permute` | For each word beginning with a letter, generate an additional version with the opposite case for that first letter |

## Notes
- The input wordlist should be sorted by frequency (most common words first) for the PRINCE algorithm to be most effective, as it prioritizes chains based on probability.
- When piping to a cracker, ensure the cracker is set to STDIN mode (e.g., `hashcat -a 0`).
- Using `--elem-cnt-max` is recommended for large wordlists to prevent the keyspace from becoming unmanageably large.