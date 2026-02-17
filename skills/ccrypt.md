---
name: ccrypt
description: Encrypt and decrypt files and streams using the Rijndael (AES) block cipher. Use when securing sensitive files, performing cryptographic operations on data streams, changing encryption keys, or recovering lost keys via brute-force guessing. It serves as a modern, secure replacement for the standard unix crypt utility.
---

# ccrypt

## Overview
ccrypt is a utility for secure encryption and decryption of files and streams based on the Rijndael cipher (AES). It provides strong security for data at rest and in transit. Category: Cryptography / Steganography.

## Installation (if not already installed)
Assume ccrypt is already installed. If you get a "command not found" error:

```bash
sudo apt install ccrypt
```

## Common Workflows

### Encrypt a file
```bash
ccencrypt sensitive_data.txt
```
This creates `sensitive_data.txt.cpt` and deletes the original.

### Decrypt a file
```bash
ccdecrypt sensitive_data.txt.cpt
```
This restores `sensitive_data.txt` and deletes the encrypted version.

### View encrypted content without saving to disk
```bash
ccat sensitive_data.txt.cpt
```

### Change the encryption key of a file
```bash
ccrypt -x secret.cpt
```
Prompts for the old key and then the new key.

### Recover a forgotten key with a known fragment
```bash
ccguess -K "partial_key" encrypted_file.cpt
```

## Complete Command Reference

### ccrypt / ccencrypt / ccdecrypt / ccat
These tools share the same core engine. `ccencrypt` is a shortcut for `ccrypt -e`, `ccdecrypt` for `ccrypt -d`, and `ccat` for `ccrypt -c`.

**Usage:**
```bash
ccrypt [mode] [options] [file...]
ccencrypt [options] [file...]
ccdecrypt [options] [file...]
ccat [options] file...
```

#### Modes
| Flag | Description |
|------|-------------|
| `-e, --encrypt` | Encrypt mode |
| `-d, --decrypt` | Decrypt mode |
| `-c, --cat` | Cat mode; decrypt files to stdout |
| `-x, --keychange` | Change the encryption key |
| `-u, --unixcrypt` | Decrypt old unix crypt files |

#### Options
| Flag | Description |
|------|-------------|
| `-h, --help` | Print help message and exit |
| `-V, --version` | Print version info and exit |
| `-L, --license` | Print license info and exit |
| `-v, --verbose` | Print progress information to stderr |
| `-q, --quiet` | Run quietly; suppress warnings |
| `-f, --force` | Overwrite existing files without asking |
| `-m, --mismatch` | Allow decryption with non-matching key |
| `-E, --envvar var` | Read keyword from environment variable `var` (unsafe) |
| `-K, --key key` | Give keyword on command line (unsafe) |
| `-k, --keyfile file` | Read keyword(s) as first line(s) from file |
| `-P, --prompt prompt` | Use this prompt instead of default |
| `-S, --suffix .suf` | Use suffix `.suf` instead of default `.cpt` |
| `-s, --strictsuffix` | Refuse to encrypt files which already have suffix |
| `-F, --envvar2 var` | As `-E` for second keyword (for keychange mode) |
| `-H, --key2 key` | As `-K` for second keyword (for keychange mode) |
| `-Q, --prompt2 prompt` | As `-P` for second keyword (for keychange mode) |
| `-t, --timid` | Prompt twice for encryption keys (default) |
| `-b, --brave` | Prompt only once for encryption keys |
| `-y, --keyref file` | Encryption key must match this encrypted file |
| `-r, --recursive` | Recurse through directories |
| `-R, --rec-symlinks` | Follow symbolic links as subdirectories |
| `-l, --symlinks` | Dereference symbolic links |
| `-T, --tmpfiles` | Use temporary files instead of overwriting (unsafe) |
| `--` | End of options, filenames follow |

---

### ccguess
Used to search for or recover encryption keys when the key is partially known.

**Usage:**
```bash
ccguess [options] file...
```

#### Options
| Flag | Description |
|------|-------------|
| `-h, --help` | Print help message and exit |
| `-V, --version` | Print version info and exit |
| `-L, --license` | Print license info and exit |
| `-K, --key <key>` | Specify approximate/partial key |
| `-d, --depth` | Try up to this many changes to key (default: 5) |
| `-c, --continue` | Keep trying more keys after first match |
| `-n, --non-printable` | Allow non-printable characters in keys |
| `-t, --chartable <chars>` | Characters to use in passwords (default: printable) |

## Notes
- **Security Warning**: Providing keys via `-K` (command line) or `-E` (environment variables) is unsafe as they may be visible in process lists or shell history.
- By default, `ccrypt` deletes the original file after successful encryption/decryption. Use `ccat` or redirection if you need to preserve the original.
- The `.cpt` suffix is the default for encrypted files.