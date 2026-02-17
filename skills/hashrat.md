---
name: hashrat
description: Generate and verify various hash types including MD5, SHA, Whirlpool, and JH. Use for file integrity checking, recursive directory hashing, forensic investigations, finding duplicate files, and generating HMAC or TOTP codes. Supports advanced features like remote hashing via SSH/HTTP, storing hashes in extended file attributes (xattr), and multiple encoding formats (Base64, Base32, Hex).
---

# hashrat

## Overview
Hashrat is a versatile hash-generation and verification utility. It supports standard algorithms (MD5, SHA1, SHA256, SHA512, Whirlpool, JH) and their HMAC versions. It excels in forensic and security contexts by supporting directory recursion, remote file hashing, and "Strict" mode which checks file metadata (mtime, owner, etc.) alongside the hash. Category: Reconnaissance / Information Gathering / Digital Forensics.

## Installation (if not already installed)
Assume hashrat is already installed. If not:
```bash
sudo apt install hashrat
```

## Common Workflows

### Recursive Hashing of a Directory
Generate SHA256 hashes for all files in a directory and its subdirectories:
```bash
hashrat -sha256 -r /path/to/directory
```

### Checking Files Against a Hash List
Verify files using a previously generated list, showing only those that fail:
```bash
hashrat -sha256 -cf hashlist.txt
```

### Finding Duplicate Files
Search for duplicate files in a directory based on their MD5 hash:
```bash
hashrat -md5 -r -dups /path/to/search
```

### Hashing Remote Files via SSH
Hash a file on a remote server without downloading it manually:
```bash
hashrat -sha256 -net ssh://user@192.168.1.50/home/user/evidence.img
```

### Generating TOTP Codes
Generate a 6-digit Google Authenticator compatible code:
```bash
hashrat -totp "JBSWY3DPEHPK3PXP"
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `--help`, `-help`, `-?` | Print help message |
| `--version`, `-version` | Print program version |
| `-list-hashes` | List all available hash types |
| `-type <hash>` | Specify hash type (supports openssl types and chaining: `-type sha256,whirl`) |
| `-hmac` | Use HMAC with the specified hash algorithm |
| `-totp <secret\|url>` | Generate TOTP code from secret or otpauth URL |
| `-digits <n>` | Number of digits for OTP codes |
| `-period <n>` | Period/lifetime for OTP codes in seconds |

### Hash Algorithms
| Flag | Description |
|------|-------------|
| `-md5` | Use MD5 algorithm |
| `-sha1` | Use SHA1 algorithm |
| `-sha256` | Use SHA256 algorithm |
| `-sha384` | Use SHA384 algorithm |
| `-sha512` | Use SHA512 algorithm |
| `-whirl`, `-whirlpool` | Use Whirlpool algorithm |
| `-jh224`, `-jh256`, `-jh384`, `-jh512` | Use JH algorithms (224, 256, 384, or 512 bits) |

### Encoding & Output Formats
| Flag | Description |
|------|-------------|
| `-8` | Octal encoding |
| `-10` | Decimal encoding |
| `-H`, `-HEX` | Uppercase Hexadecimal |
| `-32`, `-base32` | Base32 encoding |
| `-c32` | Crockford Base32 encoding |
| `-w32` | Word-safe Base32 encoding |
| `-z32` | zbase32 encoding |
| `-64`, `-base64` | Base64 encoding |
| `-i64` | Base64 with rearranged characters |
| `-p64` | Base64 with `_-` (web compatible) |
| `-r64`, `-rfc4648` | RFC4648 compatible Base64 |
| `-x64` | XXencode style Base64 |
| `-u64` | UUencode style Base64 |
| `-g64` | GEDCOM style Base64 |
| `-a85` | ASCII85 encoding |
| `-z85` | ZEROMQ variant of ASCII85 |
| `-t`, `-trad` | Traditional format (compatible with md5sum/shasum) |
| `-bsd`, `-tag`, `--tag` | BSDsum format |
| `-n <length>` | Truncate hash to `<length>` bytes |
| `-segment <len>` | Break hash into segments separated by '-' |
| `-oprefix <str>` | Prefix to add to output hashes |
| `-color` | Use ANSI colors in output |

### File & Directory Handling
| Flag | Description |
|------|-------------|
| `-r` | Recurse into directories |
| `-hid`, `-hidden` | Process hidden files (starting with `.`) |
| `-f <file>` | Hash files listed in `<file>` |
| `-i <patterns>` | Include only items matching comma-separated shell patterns |
| `-x <patterns>` | Exclude items matching comma-separated shell patterns |
| `-X <file>` | Exclude items matching patterns in `<file>` |
| `-name <patterns>` | Find-style name matching |
| `-mtime <days>` | Filter by modification time (e.g., `-10`, `+10`, `10`) |
| `-mmin <mins>` | Filter by modification time in minutes |
| `-myear <yrs>` | Filter by modification time in years |
| `-exec` | In CHECK/MATCH mode, only examine executable files |
| `-dups` | Search for duplicate files |
| `-rename` | Rename files to `<name>-<hash>.<extn>` |
| `-d` | Dereference (follow) symlinks |
| `-fs` | Stay on one file system |
| `-dir`, `-dirmode` | Create one single hash for an entire directory |
| `-devmode` | Read from file even if it is a device node |

### Check & Match Modes
| Flag | Description |
|------|-------------|
| `-c` | CHECK hashes against a list |
| `-cf` | CHECK hashes but only show failures |
| `-C <dir>` | Recursively CHECK directory against list from stdin |
| `-Cf <dir>` | Recursively CHECK directory against list; show failures only |
| `-m` | MATCH files from a list read from stdin |
| `-strict`, `-S` | Check mtime, owner, group, and inode as well as hash |
| `-h`, `-hook <script>` | Run script when a file fails CHECK or is found in MATCH/FIND |
| `-u <types>` | Update hashes during check (targets: `xattr`, `memcached`, or `<file>`) |

### Input & Network Options
| Flag | Description |
|------|-------------|
| `-lines` | Hash each line from stdin independently |
| `-rawlines`, `-rl` | Hash lines from stdin including trailing whitespace |
| `-hide-input` | Do not echo characters when reading from stdin |
| `-star-input` | Replace stdin characters with stars |
| `-iprefix <str>` | String to prefix to all input before hashing |
| `-net` | Treat arguments as `ssh://` or `http://` URLs |
| `-idfile <path>` | SSH private key for `-net` authentication |
| `-memcached <srv>` | Specify memcached server for hash storage/lookup |

### Extended Attributes (xattr) & Integration
| Flag | Description |
|------|-------------|
| `-xattr` | Store/compare hashes in extended file attributes |
| `-txattr` | Use 'trusted' xattr (root only, SYSTEM on FreeBSD) |
| `-attrs <list>` | Set specific filesystem attributes to the hash value |
| `-cache` | Use xattr hashes if younger than file mtime to speed up |
| `-xsel` | Update X11 clipboard/primary selection via Xterm sequences |
| `-clip` | Update X11 clipboard using `xsel`, `xclip`, or `pbcopy` |
| `-qr`, `-qrcode` | Display hash as a QR code (requires `qrencode` and a viewer) |
| `-cgi` | Run in HTTP CGI mode |
| `-xdialog` | Run in xdialog mode (zenity, yad, qarma) |

## Notes
- **Symlink behavior**: Hashrat can mimic other tools if invoked via symlinks (e.g., `md5sum`, `shasum`, `sha256sum`).
- **Security**: The `-txattr` flag requires root privileges as it writes to the `trusted` namespace.
- **Remote Hashing**: When using `-net`, hashrat streams the data over the network to calculate the hash locally; it does not require hashrat to be installed on the remote target.