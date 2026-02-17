---
name: 7zip
description: Archive and extract files with high compression ratios using 7z, ZIP, TAR, GZIP, and other formats. Use when performing digital forensics to analyze disk images (ISO, VDI, VMDK), extracting firmware/installers (MSI, NSIS, RPM), or managing encrypted archives (AES-256) during penetration testing and reverse engineering.
---

# 7zip

## Overview
7-Zip is a high-compression file archiver supporting a wide range of formats. It is essential for forensics (extracting disk images/filesystems), reverse engineering (unpacking installers/firmware), and general data management. Categories: Digital Forensics, Incident Response, Reverse Engineering.

## Installation (if not already installed)
Assume 7zip is installed. If missing:
```bash
sudo apt install 7zip 7zip-standalone
```
*Note: For RAR support, install `7zip-rar` from the non-free section.*

## Common Workflows

### Extract an archive with full paths
```bash
7z x archive.7z -o./output_dir
```

### Create an encrypted 7z archive with AES-256
```bash
7z a -pSecretPassword123 -mhe=on secure_backup.7z ./sensitive_data/
```
The `-mhe=on` switch encrypts headers (filenames).

### List contents of a disk image or installer
```bash
7z l firmware_update.bin
7z l windows_installer.msi
```

### Calculate hashes for files
```bash
7z h -scrcSHA256 *
```

## Complete Command Reference

### Binaries
- `7z`: Full featured with plugin functionality.
- `7za`: Standalone version supporting major formats.
- `7zr`: Minimal version (LZMA only).
- `7zz`: Full featured standalone executable (no plugins).
- `p7zip`: Simple wrapper for basic compression/decompression.

### Commands
| Command | Description |
|---------|-------------|
| `a` | Add files to archive |
| `b` | Benchmark |
| `d` | Delete files from archive |
| `e` | Extract files (without directory names) |
| `h` | Calculate hash values |
| `i` | Show information about supported formats |
| `l` | List contents of archive |
| `rn` | Rename files in archive |
| `t` | Test integrity of archive |
| `u` | Update files to archive |
| `x` | eXtract files with full paths |

### Switches
| Switch | Description |
|--------|-------------|
| `--` | Stop switches and @listfile parsing |
| `-ai[r[-|0]][m[-|2]][w[-]]{@listfile\|!wildcard}` | Include archives |
| `-ax[r[-|0]][m[-|2]][w[-]]{@listfile\|!wildcard}` | eXclude archives |
| `-ao{a\|s\|t\|u}` | Set Overwrite mode (Overwrite All, Skip, rename exisTing, rename qUery) |
| `-an` | Disable archive_name field |
| `-bb[0-3]` | Set output log level |
| `-bd` | Disable progress indicator |
| `-bs{o\|e\|p}{0\|1\|2}` | Set output stream for output/error/progress |
| `-bt` | Show execution time statistics |
| `-i[r[-|0]][m[-|2]][w[-]]{@listfile\|!wildcard}` | Include filenames |
| `-m{Parameters}` | Set compression Method (e.g., `-mmt` threads, `-mx` level) |
| `-mmt[N]` | Set number of CPU threads |
| `-mx[N]` | Set compression level: 1 (fastest) to 9 (ultra) |
| `-o{Directory}` | Set Output directory |
| `-p{Password}` | Set Password |
| `-r[-\|0]` | Recurse subdirectories |
| `-sa{a\|e\|s}` | Set Archive name mode |
| `-scc{UTF-8\|WIN\|DOS}` | Set charset for console input/output |
| `-scs{UTF-8\|UTF-16LE\|UTF-16BE\|WIN\|DOS\|{id}}` | Set charset for list files |
| `-scrc[CRC32\|CRC64\|SHA256\|SHA1\|XXH64\|*]` | Set hash function for x, e, h commands |
| `-sdel` | Delete files after compression |
| `-seml[.]` | Send archive by email |
| `-sfx[{name}]` | Create SFX archive |
| `-si[{name}]` | Read data from stdin |
| `-slp` | Set Large Pages mode |
| `-slt` | Show technical information for `l` (List) command |
| `-snh` | Store hard links as links |
| `-snl` | Store symbolic links as links |
| `-sni` | Store NT security information |
| `-sns[-]` | Store NTFS alternate streams |
| `-so` | Write data to stdout |
| `-spd` | Disable wildcard matching for file names |
| `-spe` | Eliminate duplication of root folder for extract command |
| `-spf[2]` | Use fully qualified file paths |
| `-ssc[-]` | Set sensitive case mode |
| `-sse` | Stop archive creating if it can't open some input file |
| `-ssp` | Do not change Last Access Time of source files |
| `-ssw` | Compress shared files |
| `-stl` | Set archive timestamp from the most recently modified file |
| `-stm{HexMask}` | Set CPU thread affinity mask (hex) |
| `-stx{Type}` | Exclude archive type |
| `-t{Type}` | Set type of archive (7z, zip, gzip, bzip2, tar) |
| `-u[-][p#][q#][r#][x#][y#][z#][!newArchiveName]` | Update options |
| `-v{Size}[b\|k\|m\|g]` | Create volumes (split archives) |
| `-w[{path}]` | Assign Work directory |
| `-x[r[-|0]][m[-|2]][w[-]]{@listfile\|!wildcard}` | eXclude filenames |
| `-y` | Assume Yes on all queries |

### p7zip Wrapper Options
| Flag | Description |
|------|-------------|
| `-c`, `--stdout` | Output data to stdout |
| `-d`, `--decompress` | Decompress file |
| `-f`, `--force` | Do not ask questions |
| `-k`, `--keep` | Keep original file |
| `-h`, `--help` | Print help |

## Notes
- **Forensics**: 7zip can open many non-standard archive formats like MBR, GPT, QCOW2, and VMDK, making it useful for quick inspection of disk images.
- **Security**: When creating encrypted archives, use the 7z format for the best security (AES-256).
- **Paths**: Use the `x` command instead of `e` if you want to preserve the original directory structure.