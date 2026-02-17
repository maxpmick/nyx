---
name: 7zip
description: Extract, create, and manage compressed archives in various formats including 7z, ZIP, GZIP, BZIP2, TAR, and RAR. Use when performing digital forensics to unpack disk images or evidence files, during incident response to compress logs, or when handling password-protected archives during penetration testing.
---

# 7zip (p7zip)

## Overview
A high-compression file archiver with support for numerous formats and strong AES-256 encryption. In security contexts, it is primarily used for data extraction from forensic images, managing large datasets, and interacting with encrypted containers. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
The `p7zip` and `p7zip-full` packages are transitional; the modern command is provided by the `7zip` package.

```bash
sudo apt update && sudo apt install 7zip
```

## Common Workflows

### Extract an archive with full paths
```bash
7z x evidence.7z -o./extracted_files
```

### Create a password-protected encrypted archive
```bash
7z a -pSECRET -mhe=on secure_logs.7z ./logs/
```
The `-mhe=on` flag encrypts the archive headers (filenames).

### List contents of an archive without extracting
```bash
7z l data.zip
```

### Test archive integrity
```bash
7z t backup.tar.gz
```

## Complete Command Reference

```
7z <command> [<switches>...] <archive_name> [<file_names>...] [@listfile]
```

### Commands

| Command | Description |
|---------|-------------|
| `a` | Add files to archive |
| `b` | Benchmark |
| `d` | Delete files from archive |
| `e` | Extract files from archive (flat; ignores directory structure) |
| `h` | Calculate hash values for files |
| `i` | Show information about supported formats |
| `l` | List contents of archive |
| `rn` | Rename files in archive |
| `t` | Test integrity of archive |
| `u` | Update files to archive |
| `x` | eXtract files with full paths |

### Switches (Options)

| Switch | Description |
|--------|-------------|
| `--` | Stop switches parsing |
| `-ai[r[-|0]]{@listfile\|!wildcard}` | Include archives |
| `-ax[r[-|0]]{@listfile\|!wildcard}` | Exclude archives |
| `-ao[a\|s\|t\|u]` | Set Overwrite mode (Always, Skip, rename exisTing, rename qUantity) |
| `-an` | Disable archive_name field |
| `-bb[0-3]` | Set output log level |
| `-bd` | Disable progress indicator |
| `-bs[o\|e\|p][0-2]` | Set output stream for output/error/progress line |
| `-bt` | Show execution time statistics |
| `-i[r[-|0]]{@listfile\|!wildcard}` | Include filenames |
| `-m{Parameters}` | Set compression Method (e.g., `-mx=9` for ultra) |
| `-o{Directory}` | Set Output directory |
| `-p{Password}` | Set Password |
| `-r[-|0]` | Recurse subdirectories |
| `-sa[a\|e\|s]` | Set Archive name mode |
| `-scc{UTF-8\|WIN\|DOS}` | Set charset for console input/output |
| `-scs{UTF-8\|WIN\|DOS\|...}` | Set charset for list files |
| `-scrc[CRC32\|CRC64\|SHA1\|SHA256]` | Set hash function for `h` and `a` commands |
| `-sdel` | Delete files after compression |
| `-seml[.]` | Send archive by email |
| `-sfx[{name}]` | Create SFX (Self-Extracting) archive |
| `-si[{name}]` | Read data from stdin |
| `-slp` | Set Large Pages mode |
| `-slt` | Show technical information for `l` command |
| `-snh` | Store hard links as links |
| `-snl` | Store symbolic links as links |
| `-sni` | Store NT security information |
| `-sns[-]` | Store NTFS alternate data streams |
| `-so` | Write data to stdout |
| `-spd` | Disable wildcard matching for file names |
| `-spe` | Eliminate duplication of root folder for `x` command |
| `-spf` | Use fully qualified file paths |
| `-ssc[-]` | Set sensitive case mode |
| `-sse` | Stop archive creating if it can't open some input file |
| `-ssw` | Compress shared files |
| `-stl` | Set archive timestamp from the most recently modified file |
| `-stm{HexMask}` | Set CPU thread affinity mask (hexadecimal) |
| `-stx{Type}` | Exclude archive type |
| `-t{Type}` | Type of archive (7z, zip, gzip, bzip2, tar, etc.) |
| `-u[-][p#][q#][r#][x#][y#][z#][!newArchiveName]` | Update options |
| `-v{Size}[b\|k\|m\|g]` | Create Volumes (split archive) |
| `-w[{path}]` | Assign working directory |
| `-x[r[-|0]]{@listfile\|!wildcard}` | Exclude filenames |
| `-y` | Assume Yes on all queries |

## Notes
- **Forensics**: Use the `-slt` (Show Technical) flag with the `l` command to view detailed metadata including timestamps and attributes.
- **Encryption**: Always use `-mhe=on` with 7z format to hide filenames from users who do not have the password.
- **Performance**: Use `-mmt=on` (default) to utilize multi-threading for faster compression/decompression.