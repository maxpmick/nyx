---
name: unrar-nonfree
description: Extract, test, and view files from RAR archives using the non-free unrar utility. Use when performing digital forensics, incident response, or malware analysis to decompress RAR files, handle multi-volume archives, or recover password-protected content.
---

# unrar-nonfree

## Overview
Unrar is a specialized utility for extracting files from .rar archives. Unlike the free version, this non-free version supports a wider range of RAR features including newer archive formats and specific compression methods. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume unrar is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install unrar
```

## Common Workflows

### Extract with full directory structure
```bash
unrar x archive.rar
```

### List archive contents (technical details)
```bash
unrar lt archive.rar
```

### Extract to a specific destination path
```bash
unrar x archive.rar /home/user/evidence/
```

### Extract a password-protected archive
```bash
unrar x -p'secretpassword' archive.rar
```

### Test archive integrity
```bash
unrar t archive.rar
```

## Complete Command Reference

```
unrar command [-switch ...] archive [file ...] [@listfiles ...] [path ...] [path_to_extract/]
```

### Commands

| Command | Description |
|---------|-------------|
| `e` | Extract files to current directory (ignores paths) |
| `l[t[a],b]` | List archive content [technical[all], bare] |
| `p` | Print file to stdout |
| `t` | Test archive files |
| `v[t[a],b]` | Verbosely list archive [technical[all], bare] |
| `x` | Extract files with full path |

### Options

| Flag | Description |
|------|-------------|
| `--` | Stop switches scanning |
| `-@[+]` | Disable [enable] file lists |
| `-ad[1,2]` | Alternate destination path |
| `-ag[format]` | Generate archive name using the current date |
| `-ai` | Ignore file attributes |
| `-ap<path>` | Set path inside archive |
| `-c-` | Disable comments show |
| `-cfg-` | Disable read configuration |
| `-cl` | Convert names to lower case |
| `-cu` | Convert names to upper case |
| `-dh` | Open shared files |
| `-ep` | Exclude paths from names |
| `-ep3` | Expand paths to full name |
| `-ep4<path>` | Exclude the path prefix from names |
| `-f` | Freshen files |
| `-id[c,d,n,p,q]` | Display or disable messages (c:clear, d:done, n:name, p:percentage, q:quiet) |
| `-ierr` | Send all messages to stderr |
| `-inul` | Disable all messages |
| `-kb` | Keep broken extracted files |
| `-me[par]` | Set encryption parameters |
| `-n<file>` | Additionally filter included files |
| `-n@` | Read additional filter masks from stdin |
| `-n@<list>` | Read additional filter masks from list file |
| `-o+` | Overwrite existing files |
| `-o-` | Do not overwrite existing files |
| `-ol[a,-]` | Process symbolic links as the link [absolute paths, skip] |
| `-om[-\|1][=lst]` | Propagate Mark of the Web |
| `-op<path>` | Set the output path for extracted files |
| `-or` | Rename files automatically |
| `-ow` | Save or restore file owner and group |
| `-p[password]` | Set password |
| `-p-` | Do not query password |
| `-r` | Recurse subdirectories |
| `-sc<chr>[obj]` | Specify the character set |
| `-si[name]` | Read data from standard input (stdin) |
| `-sl<size>` | Process files with size less than specified |
| `-sm<size>` | Process files with size more than specified |
| `-ta[mcao]<d>` | Process files modified after date <d> (YYYYMMDDHHMMSS) |
| `-tb[mcao]<d>` | Process files modified before date <d> (YYYYMMDDHHMMSS) |
| `-tn[mcao]<t>` | Process files newer than <t> time |
| `-to[mcao]<t>` | Process files older than <t> time |
| `-ts[m,c,a,p]` | Save or restore time (modification, creation, access, preserve) |
| `-u` | Update files |
| `-v` | List all volumes |
| `-ver[n]` | File version control |
| `-vp` | Pause before each volume |
| `-x<file>` | Exclude specified file |
| `-x@<list>` | Exclude files in specified list file |
| `-x@` | Read file names to exclude from stdin |
| `-y` | Assume Yes on all queries |

## Notes
- **Switches**: Every switch must be separated by whitespace (e.g., `-x -y`, not `-xy`).
- **Multi-volume**: If the archive uses RAR multiple volume format (.part1.rar, .part2.rar), specify only the first volume.
- **List Files**: Arguments starting with `@` (e.g., `@list.txt`) allow processing many files that might otherwise exceed shell command line limits.
- **Configuration**: The tool checks for `.rarrc` in `$HOME`, `/etc`, `/usr/lib`, and `/usr/local/etc`.