---
name: clamav
description: Anti-virus toolkit for Unix used for scanning files, directories, and mail for malware and viruses. Use when performing malware analysis, system auditing, securing mail servers, or verifying the integrity of uploaded files and archives during a penetration test or forensic investigation.
---

# clamav

## Overview
Clam AntiVirus (ClamAV) is an open-source anti-virus toolkit designed for detecting Trojans, viruses, malware, and other malicious threats. It includes a multi-threaded scanner daemon (clamd), a command-line scanner (clamscan), and a tool for automatic database updates (freshclam). It supports numerous archive formats, executables (ELF/PE), and document types (MS Office, PDF, HTML). Category: Protect / Vulnerability Analysis.

## Installation (if not already installed)
Assume ClamAV is installed. If not, install the suite via:
```bash
sudo apt install clamav clamav-daemon clamav-freshclam
```

## Common Workflows

### Update Virus Database
Always update signatures before scanning to ensure detection of the latest threats.
```bash
sudo freshclam
```

### Scan a Directory Recursively
Scan a specific path and only show infected files, sounding a bell on detection.
```bash
clamscan -r --infected --bell /home/user/downloads
```

### Scan Using the Daemon (Faster)
If the `clamav-daemon` is running, use `clamdscan` for significantly faster performance on large batches of files.
```bash
clamdscan --multiscan --fdpass /var/www/html
```

### Generate MD5 Signatures for Files
Use `sigtool` to generate signatures for known malicious files to add to a custom database.
```bash
sigtool --md5 malicious_sample.exe > custom.hdb
```

## Complete Command Reference

### clamscan
Command-line scanner for files and directories.

| Flag | Description |
|------|-------------|
| `--help`, `-h` | Show help |
| `--version`, `-V` | Print version number |
| `--verbose`, `-v` | Be verbose |
| `--archive-verbose`, `-a` | Show filenames inside scanned archives |
| `--debug` | Enable libclamav's debug messages |
| `--quiet` | Only output error messages |
| `--stdout` | Write to stdout instead of stderr |
| `--no-summary` | Disable summary at end of scanning |
| `--infected`, `-i` | Only print infected files |
| `--suppress-ok-results`, `-o` | Skip printing OK files |
| `--bell` | Sound bell on virus detection |
| `--tempdir=DIR` | Create temporary files in DIR |
| `--leave-temps[=yes/no]` | Do not remove temporary files |
| `--force-to-disk[=yes/no]` | Create temporary files for nested scans |
| `--gen-json[=yes/no]` | Generate JSON metadata (for testing/dev) |
| `--database=FILE/DIR`, `-d` | Load virus database from FILE or DIR |
| `--official-db-only[=yes/no]` | Only load official signatures |
| `--fail-if-cvd-older-than=N` | Return nonzero if DB is older than N days |
| `--log=FILE`, `-l` | Save scan report to FILE |
| `--recursive`, `-r` | Scan subdirectories recursively |
| `--allmatch`, `-z` | Continue scanning after finding a match |
| `--cross-fs[=yes/no]` | Scan files on other filesystems |
| `--follow-dir-symlinks[=0/1/2]` | Follow directory symlinks (0=never, 1=direct, 2=always) |
| `--follow-file-symlinks[=0/1/2]` | Follow file symlinks (0=never, 1=direct, 2=always) |
| `--file-list=FILE`, `-f` | Scan files listed in FILE |
| `--remove[=yes/no]` | Remove infected files (CAUTION) |
| `--move=DIR` | Move infected files into DIR |
| `--copy=DIR` | Copy infected files into DIR |
| `--exclude=REGEX` | Don't scan file names matching REGEX |
| `--exclude-dir=REGEX` | Don't scan directories matching REGEX |
| `--include=REGEX` | Only scan file names matching REGEX |
| `--include-dir=REGEX` | Only scan directories matching REGEX |
| `--bytecode[=yes/no]` | Load bytecode from the database |
| `--bytecode-unsigned[=yes/no]` | Load unsigned bytecode (CAUTION) |
| `--bytecode-timeout=N` | Set bytecode timeout in ms |
| `--statistics[=none/bytecode/pcre]` | Collect and print execution statistics |
| `--detect-pua[=yes/no]` | Detect Possibly Unwanted Applications |
| `--exclude-pua=CAT` | Skip PUA category CAT |
| `--include-pua=CAT` | Load PUA category CAT |
| `--detect-structured[=yes/no]` | Detect structured data (SSN, Credit Card) |
| `--structured-ssn-format=X` | SSN format (0=normal, 1=stripped, 2=both) |
| `--structured-ssn-count=N` | Min SSN count to generate a detect |
| `--structured-cc-count=N` | Min CC count to generate a detect |
| `--structured-cc-mode=X` | CC mode (0=all, 1=credit cards only) |
| `--scan-mail`, `--scan-pe`, `--scan-elf`, `--scan-ole2`, `--scan-pdf`, `--scan-swf`, `--scan-html`, `--scan-xmldocs`, `--scan-hwp3`, `--scan-onenote`, `--scan-archive`, `--scan-image` | Enable/disable specific scanners (Default: yes) |
| `--phishing-sigs`, `--phishing-scan-urls` | Email/URL phishing detection |
| `--heuristic-alerts` | Enable heuristic alerts |
| `--alert-broken`, `--alert-broken-media` | Alert on corrupted PE/ELF or graphics |
| `--alert-encrypted`, `--alert-encrypted-archive`, `--alert-encrypted-doc` | Alert on encrypted files |
| `--alert-macros` | Alert on OLE2 files with VBA macros |
| `--max-scantime=N` | Max scan time in ms |
| `--max-filesize=N` | Max file size to scan |
| `--max-scansize=N` | Max data to scan per container |
| `--max-files=N` | Max files per container |
| `--max-recursion=N` | Max archive recursion level |
| `--disable-cache` | Disable hash sum caching |

### clamdscan
Client for the `clamd` daemon. Faster than `clamscan` as the database is pre-loaded in memory.

| Flag | Description |
|------|-------------|
| `--multiscan`, `-m` | Force MULTISCAN mode (parallel scanning) |
| `--fdpass` | Pass filedescriptor to clamd (useful if clamd runs as different user) |
| `--stream` | Force streaming files to clamd |
| `--reload` | Request clamd to reload virus database |
| `--ping A[:I]` | Ping clamd up to A times at interval I |
| `--wait`, `-w` | Wait up to 30s for clamd to start |

### freshclam
Virus database update utility.

| Flag | Description |
|------|-------------|
| `--daemon`, `-d` | Run in daemon mode |
| `--checks=N`, `-c` | Number of checks per day (1-50) |
| `--user=USER`, `-u` | Run as USER |
| `--no-dns` | Force old non-DNS verification method |
| `--on-update-execute=CMD` | Execute CMD after successful update |
| `--update-db=DBNAME` | Only update database DBNAME |

### sigtool
Signature and database management tool.

| Flag | Description |
|------|-------------|
| `--hex-dump` | Convert stdin to hex string |
| `--md5`, `--sha1`, `--sha256` | Generate checksum signatures for files |
| `--mdb`, `--imp` | Generate section or import table hash signatures |
| `--info=FILE`, `-i` | Print database information |
| `--unpack=FILE`, `-u` | Unpack a CVD/CLD file |
| `--list-sigs` | List signature names |
| `--find-sigs=REGEX` | Find signatures matching REGEX |
| `--vba=FILE` | Extract VBA/Word6 macro code |

### clambc
Bytecode analysis and testing tool.

| Flag | Description |
|------|-------------|
| `--force-interpreter`, `-f` | Force interpreter instead of JIT |
| `--info`, `-i` | Print info about bytecode |
| `--printsrc`, `-p` | Print bytecode source |
| `--trace <0..7>`, `-T` | Set bytecode trace level |

### clamdtop
Interactive monitor for the ClamAV daemon.
- Usage: `clamdtop [host[:port] /path/to/clamd.sock]`

### clamconf
Configuration utility to display or generate ClamAV settings.
- `--non-default`, `-n`: Only display non-default settings.
- `--generate-config=NAME`, `-g`: Generate example config.

## Notes
- **Permissions**: When using `clamdscan`, use `--fdpass` if the daemon runs as a different user (usually `clamav`) to allow it to access files owned by the current user.
- **Performance**: `clamscan` loads the entire database into memory every time it runs. For frequent scanning, use `clamd` and `clamdscan`.
- **False Positives**: Anti-virus tools can flag legitimate pentest tools (like Metasploit payloads) as malicious. Use `--exclude` to ignore known safe directories.
- **Safety**: Never run bytecode signatures from untrusted sources as they may result in arbitrary code execution.