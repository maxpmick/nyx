---
name: maskprocessor
description: High-performance word generator with a per-position configurable charset using Hashcat-style masks. Use when generating custom wordlists for password cracking, brute-force attacks, or when specific password patterns (e.g., "Company2023!") are known or suspected.
---

# maskprocessor

## Overview
Maskprocessor (mp32/mp64) is a fast word list generator that enumerates combinations from a user-defined keyspace. It supports different alphabets at different positions in a generation template ('mask'), allowing for more fine-tuned candidate generation than naive brute force. Category: Password Attacks.

## Installation (if not already installed)
Assume maskprocessor is already installed. If you get a "command not found" error:

```bash
sudo apt install maskprocessor
```

## Common Workflows

### Basic Mask Generation
Generate words starting with "pass" followed by one digit and one lowercase letter:
```bash
mp64 pass?d?l
```

### Custom Charset and Increment Mode
Generate passwords of length 4 to 6 using a custom charset (digits + 'abc') for all positions:
```bash
mp64 -1 ?dabc -i 4:6 ?1?1?1?1?1?1
```

### Complex Pattern with Output File
Generate a list where the first char is uppercase, followed by 5 lowercase, and 2 digits, saving to a file:
```bash
mp64 -o wordlist.txt ?u?l?l?l?l?l?d?d
```

### Calculate Combinations
Check how many passwords a mask will generate without actually producing them:
```bash
mp64 --combinations ?u?l?l?d?s
```

## Complete Command Reference

The tool provides both `mp32` (32-bit) and `mp64` (64-bit) binaries. `mp64` is recommended for modern systems.

```
Usage: mp64 [options]... mask
```

### Startup Options
| Flag | Description |
|------|-------------|
| `-V`, `--version` | Print version |
| `-h`, `--help` | Print help |

### Increment Options
| Flag | Description |
|------|-------------|
| `-i`, `--increment=NUM:NUM` | Enable increment mode. 1st NUM=start length, 2nd NUM=stop length. Example: `-i 4:8` searches lengths 4-8 (inclusive) |

### Misc Options
| Flag | Description |
|------|-------------|
| `--combinations` | Calculate number of combinations and exit |
| `--hex-charset` | Assume charset is given in hex |
| `-q`, `--seq-max=NUM` | Maximum number of multiple sequential characters |
| `-r`, `--occurrence-max=NUM` | Maximum number of occurrence of a character |

### Resources Options
| Flag | Description |
|------|-------------|
| `-s`, `--start-at=WORD` | Start at specific position in the keyspace |
| `-l`, `--stop-at=WORD` | Stop at specific position in the keyspace |

### Files Options
| Flag | Description |
|------|-------------|
| `-o`, `--output-file=FILE` | Write output to specified file instead of stdout |

### Custom Charsets
| Flag | Description |
|------|-------------|
| `-1`, `--custom-charset1=CS` | User-definable charset 1 |
| `-2`, `--custom-charset2=CS` | User-definable charset 2 |
| `-3`, `--custom-charset3=CS` | User-definable charset 3 |
| `-4`, `--custom-charset4=CS` | User-definable charset 4 |

*Example: `--custom-charset1=?dabcdef` sets the `?1` placeholder to `0123456789abcdef`.*

### Built-in Charsets
| Placeholder | Description |
|-------------|-------------|
| `?l` | `abcdefghijklmnopqrstuvwxyz` (Lowercase) |
| `?u` | `ABCDEFGHIJKLMNOPQRSTUVWXYZ` (Uppercase) |
| `?d` | `0123456789` (Digits) |
| `?s` | ` !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~` (Special) |
| `?a` | `?l?u?d?s` (All) |
| `?b` | `0x00 - 0xff` (Binary) |

## Notes
- Maskprocessor is extremely fast; piping its output to other tools (like `aircrack-ng` or `hashcat`) is a common way to perform "on-the-fly" brute force without storing massive wordlists on disk.
- Use `mp64` for better performance on 64-bit Kali Linux installations.