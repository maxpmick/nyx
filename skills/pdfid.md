---
name: pdfid
description: Scan PDF files for specific keywords and metadata to identify potentially malicious content like JavaScript, auto-launch actions, or embedded files. Use when performing digital forensics, malware analysis, or initial triage of suspicious PDF documents to detect obfuscation and risky PDF elements.
---

# pdfid

## Overview
A tool designed to scan PDF files for specific keywords without fully parsing the file. It identifies elements that are often used in malicious PDFs, such as `/JavaScript`, `/JS`, `/OpenAction`, and `/Launch`, and can handle name obfuscation. Category: Digital Forensics / Malware Analysis.

## Installation (if not already installed)
Assume pdfid is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install pdfid
```

## Common Workflows

### Basic triage of a single PDF
```bash
pdfid suspicious.pdf
```
Quickly check for the presence of JavaScript or automatic actions.

### Scanning a directory for suspicious PDFs (suppressing zeros)
```bash
pdfid -s -n /path/to/directory/
```
Scans all files in the directory and only displays keywords that have a count greater than zero.

### Disarming a PDF
```bash
pdfid -d malicious.pdf
```
Attempts to disable JavaScript and auto-launch features within the PDF file.

### Scanning files listed in a text file
```bash
pdfid @files_to_scan.txt
```
Processes every file path listed in the provided text file.

## Complete Command Reference

```bash
pdfid [options] [pdf-file|zip-file|url|@file] ...
```

### Arguments
*   **pdf-file / zip-file**: Can be a single file, multiple files, or use wildcards.
*   **@file**: Run PDFiD on each file path listed in the specified text file.

### Options

| Flag | Description |
|------|-------------|
| `--version` | Show program's version number and exit |
| `-h`, `--help` | Show the help message and exit |
| `-s`, `--scan` | Scan the given directory |
| `-a`, `--all` | Display all the names (including those with 0 counts) |
| `-e`, `--extra` | Display extra data, such as dates |
| `-f`, `--force` | Force the scan of the file, even if it lacks a proper `%PDF` header |
| `-d`, `--disarm` | Disable JavaScript and auto-launch actions |
| `-p`, `--plugins=PLUGINS` | Plugins to load (separate with a comma `,` or `;`; `@file` supported) |
| `-c`, `--csv` | Output CSV data when using plugins |
| `-m`, `--minimumscore=MIN` | Minimum score for plugin results output |
| `-v`, `--verbose` | Verbose output (will also raise caught exceptions) |
| `-S`, `--select=SELECT` | Selection expression |
| `-n`, `--nozero` | Suppress output for counts equal to zero |
| `-o`, `--output=OUTPUT` | Output results to a log file |
| `--pluginoptions=OPTS` | Specific options for the loaded plugins |
| `-l`, `--literalfilenames` | Take filenames literally; do not perform wildcard matching |
| `--recursedir` | Recurse directories (wildcards and `@file` allowed) |

## Notes
- **Not a Parser**: PDFiD scans for strings and keywords; it does not validate the internal logic of the PDF.
- **Obfuscation**: The tool is effective at finding obfuscated keywords (e.g., hex-encoded names like `/J#61vaScript`).
- **Disarming**: The `-d` (disarm) flag modifies the file. Always work on a copy of the original evidence.
- **Output Interpretation**: High counts in `/JS`, `/JavaScript`, `/OpenAction`, or `/Launch` are primary indicators that a PDF warrants deeper inspection with tools like `pdf-parser` or `peepdf`.