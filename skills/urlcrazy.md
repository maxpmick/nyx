---
name: urlcrazy
description: Generate and test domain typos and variations to detect and perform typo squatting, URL hijacking, phishing, and corporate espionage. Use when performing reconnaissance, brand protection, phishing simulations, or information gathering to identify malicious or deceptive domains targeting a specific organization.
---

# urlcrazy

## Overview
urlcrazy is a domain typo generator that identifies potential typo-squatting and URL hijacking opportunities. It generates variations of a target domain using various algorithms like character omission, transposition, and keyboard proximity. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume urlcrazy is already installed. If you get a "command not found" error:

```bash
sudo apt install urlcrazy
```

## Common Workflows

### Basic typo generation and resolution
Generate variations for a domain and check if they are registered/resolved.
```bash
urlcrazy example.com
```

### Fast generation without DNS resolution
Generate variations quickly without performing any network lookups.
```bash
urlcrazy -r example.com
```

### Target specific keyboard layouts
Generate typos based on the Dvorak keyboard layout instead of the default QWERTY.
```bash
urlcrazy -k dvorak example.com
```

### Export results to CSV
Generate variations and save the report to a file for further analysis.
```bash
urlcrazy -o results.csv example.com
```

## Complete Command Reference

```
Usage: urlcrazy [options] <domain>
```

### General Options

| Flag | Description |
|------|-------------|
| `-k`, `--keyboard <layout>` | Options: `qwerty`, `azerty`, `qwertz`, `dvorak` (default: `qwerty`) |
| `-p`, `--popularity` | Check domain popularity via Google |
| `-r`, `--no-resolve` | Do not resolve hostnames |
| `-i`, `--show-invalid` | Show invalid domain names |
| `-f`, `--format <type>` | Output format: `human`, `csv` (default: `human`) |
| `-o`, `--output <file>` | Output file |
| `-n`, `--ns` | Check for nameserver records |
| `-u`, `--user-agent <string>` | User-agent string to use (default: urlcrazy/0.7.3) |
| `-h`, `--help` | Display help message |
| `-v`, `--version` | Display version information |

### Typo Generation Algorithms
The tool automatically applies these variations:
- **Character Omission**: Removing a character from the domain.
- **Character Repeat**: Repeating a character in the domain.
- **Character Swap**: Swapping adjacent characters.
- **Character Replacement**: Replacing a character with an adjacent key on the specified keyboard.
- **Character Insertion**: Inserting a character adjacent to the original key.
- **Missing Dot**: Removing the dot between the subdomain and domain.
- **Strip Dash**: Removing dashes from the domain name.
- **Singular/Plural**: Adding or removing an 's' at the end of the domain.
- **Common Misspellings**: Using a database of common English misspellings.
- **Homoglyphs**: Replacing characters with similar-looking characters (e.g., 'o' with '0').
- **Vowel Swap**: Swapping vowels within the domain.
- **Bit Flipping**: Changing bits in the ASCII representation of characters.
- **Wrong TLD**: Swapping the Top Level Domain (e.g., .com to .net).

## Notes
- **File Descriptor Limit**: If you receive a warning about file descriptor limits, increase them using `ulimit -n 10000` before running the tool to ensure all threads can operate correctly.
- **Performance**: DNS resolution can be slow for large sets of variations; use `-r` if you only need the list of potential domains.
- **Legal**: Only use this tool for authorized security testing and brand protection activities.