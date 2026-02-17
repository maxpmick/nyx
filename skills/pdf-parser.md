---
name: pdf-parser
description: Parse PDF documents to identify and extract fundamental elements like indirect objects, streams, and metadata. Use when performing digital forensics, malware analysis of suspicious PDF files, or manual inspection of PDF structures without rendering the document.
---

# pdf-parser

## Overview
pdf-parser is a tool designed to parse PDF documents to identify the fundamental elements used in the analyzed file. It does not render the PDF but instead allows for the inspection of objects, streams, and headers. It is particularly useful for identifying malicious code, hidden objects, or malformed elements in PDF files. Category: Digital Forensics.

## Installation (if not already installed)

Assume pdf-parser is already installed. If you get a "command not found" error:

```bash
sudo apt install pdf-parser
```

## Common Workflows

### Display PDF Statistics
Quickly see the count of objects, types, and versions within a PDF.
```bash
pdf-parser -a suspicious.pdf
```

### Search for JavaScript or Actions
Identify objects that might contain executable code or automatic actions.
```bash
pdf-parser --search "/JS" suspicious.pdf
pdf-parser --search "/JavaScript" suspicious.pdf
pdf-parser --search "/OpenAction" suspicious.pdf
```

### Extract and Decompress a Specific Object
Select an object by ID, apply filters (like FlateDecode), and dump the content to a file.
```bash
pdf-parser -o 12 -f -d object_12_content.bin suspicious.pdf
```

### Search for Strings in Streams
Search for specific strings inside stream objects, including those that are compressed/filtered.
```bash
pdf-parser --searchstream "cmd.exe" --unfiltered suspicious.pdf
```

## Complete Command Reference

```
pdf-parser [options] pdf-file|zip-file|url
```

### General Options

| Flag | Description |
|------|-------------|
| `--version` | Show program's version number and exit |
| `-h`, `--help` | Show help message and exit |
| `-m`, `--man` | Print manual |
| `-v`, `--verbose` | Display malformed PDF elements |
| `-D`, `--debug` | Display debug info |
| `-j`, `--jsonoutput` | Produce JSON output |
| `-n`, `--nocanonicalizedoutput` | Do not canonicalize the output |

### Selection Options

| Flag | Description |
|------|-------------|
| `-o OBJECT`, `--object=OBJECT` | ID(s) of indirect object(s) to select; use comma (,) to separate IDs |
| `-r REFERENCE`, `--reference=REFERENCE` | ID of indirect object being referenced |
| `-t TYPE`, `--type=TYPE` | Type of indirect object to select (e.g., /Catalog, /Page) |
| `-e ELEMENTS`, `--elements=ELEMENTS` | Type of elements to select (cxtsi: comment, xref, trailer, startxref, indirect object) |
| `-k KEY`, `--key=KEY` | Key to search in dictionaries |

### Search and Analysis Options

| Flag | Description |
|------|-------------|
| `-a`, `--stats` | Display stats for PDF document (object counts, types, etc.) |
| `-s SEARCH`, `--search=SEARCH` | String to search in indirect objects (except streams) |
| `--searchstream=SEARCHSTREAM` | String to search in streams |
| `--unfiltered` | Search in unfiltered streams |
| `--casesensitive` | Case sensitive search in streams |
| `--regex` | Use regex to search in streams |
| `-H`, `--hash` | Display hash of objects |
| `-y YARA`, `--yara=YARA` | YARA rule (or directory or @file) to check streams |
| `--yarastrings` | Print YARA strings |

### Content and Stream Options

| Flag | Description |
|------|-------------|
| `-f`, `--filter` | Pass stream object through filters (FlateDecode, ASCIIHexDecode, ASCII85Decode, LZWDecode, RunLengthDecode) |
| `-w`, `--raw` | Raw output for data and filters |
| `-c`, `--content` | Display content for objects without streams or with streams without filters |
| `-O`, `--objstm` | Parse stream of /ObjStm objects |
| `-d DUMP`, `--dump=DUMP` | Filename to dump stream content to |
| `-x EXTRACT`, `--extract=EXTRACT` | Filename to extract malformed content to |
| `--overridingfilters=FILTERS` | Override filters with given filters (use "raw" for raw stream content) |
| `--decoders=DECODERS` | Decoders to load (comma separated; @file supported) |
| `--decoderoptions=OPTIONS` | Options for the decoder |

### Generation Options

| Flag | Description |
|------|-------------|
| `-g`, `--generate` | Generate a Python program that creates the parsed PDF file |
| `--generateembedded=OBJ` | Generate a Python program that embeds the selected indirect object as a file |

## Notes
- This tool is for analysis, not for viewing. It is highly effective at finding obfuscated content in PDF-based attacks.
- When searching for malicious content, always use `--unfiltered` to ensure you are searching the decompressed data.
- The tool supports URLs and ZIP files as input in addition to local PDF files.