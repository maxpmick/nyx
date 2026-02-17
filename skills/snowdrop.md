---
name: snowdrop
description: Perform plain text watermarking and watermark recovery for English documents and C source code. Use when you need to identify the source of leaked documents, protect intellectual property, or perform forensic investigations by embedding hidden, redundant steganographic identifiers into text files.
---

# snowdrop

## Overview
Snowdrop provides reliable, difficult-to-remove steganographic watermarking of text documents and C source code. It uses redundant steganography across four different logical channels to remain resilient against modifications like reformatting or spell checking. Category: Digital Forensics.

## Installation (if not already installed)
Assume snowdrop is already installed. If the commands are missing:

```bash
sudo apt install snowdrop
```

## Common Workflows

### Inject a watermark into an English document
```bash
sd-eng -i original.txt watermarked.txt "Internal-Audit-Team" "Draft version 1.0"
```

### Extract a watermark from a suspected leak
Requires the original unmodified file to compare against the leaked version.
```bash
sd-eng -e original.txt leaked_copy.txt
```

### Watermark C source code with strong encryption
```bash
sd-c -6 -i main.c main_distributed.c "Licensee-ID-882"
```

### List the local watermark database
```bash
sd-eng -l
```

## Complete Command Reference

Snowdrop provides three distinct commands based on the target file type:
- `sd-eng`: For draft-quality English language text.
- `sd-engf`: For fine-quality English language text.
- `sd-c`: For C source code (experimental).

### Usage Syntax
All three commands share the same syntax:

```bash
<command> [ -6 ] -e origfile newfile
<command> [ -6 ] -l
<command> [ -6 ] -i origfile newfile "Recipient" [ "Comment" ]
```

### Options and Flags

| Flag | Description |
|------|-------------|
| `-i` | **Injection Mode**: Embeds a watermark. Requires `origfile`, `newfile`, and a `"Recipient"` string. |
| `-e` | **Extraction Mode**: Recovers a watermark. Requires the `origfile` (original) and `newfile` (the file to check). |
| `-l` | **List Mode**: Displays the contents of the watermark database for the specific module. |
| `-6` | **Strong Watermarking**: Enables 64-bit watermarking (default is 32-bit). Recommended for public documentation of abuse. |
| `-h` | Display help message. |

### Environment Variables
For `sd-eng` and `sd-engf`:
- `SD_SYNONYMS`: Can be set to point to an alternative 'synonyms' file. If used, a copy of this file must be kept for future extraction/reference.

## Notes
- **Original File Required**: To extract a watermark, you MUST have the original, un-watermarked version of the document.
- **Beta Status**: The tool is in beta; results (especially for C source code) may occasionally be corrupted. Always verify the output file.
- **Redundancy**: The tool uses four logical channels to ensure the watermark survives common text edits like reformatting.