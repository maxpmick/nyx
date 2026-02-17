---
name: cewl
description: Generate custom wordlists by spidering a target URL and extracting unique words, metadata, and email addresses. Use when performing password cracking attacks, brute-force preparation, or information gathering to create highly targeted dictionaries based on a specific organization's web content.
---

# cewl

## Overview
CeWL (Custom Word List generator) is a Ruby application that spiders a given URL to a specified depth and returns a list of words found on the pages. It is designed to create targeted wordlists for password crackers like John the Ripper or Hashcat. It can also extract email addresses for username lists and metadata from discovered documents (PDF, Office) to identify potential usernames. Category: Password Attacks / Information Gathering.

## Installation (if not already installed)
Assume CeWL is already installed. If the command is missing:

```bash
sudo apt install cewl
```

## Common Workflows

### Basic wordlist generation
Spider a site to the default depth (2) and output words to the terminal:
```bash
cewl https://www.example.com
```

### Targeted wordlist for cracking
Spider to depth 2, minimum word length of 5, and save to a file:
```bash
cewl -d 2 -m 5 -w custom_wordlist.txt https://www.example.com
```

### Extracting emails and metadata
Spider a site, extract email addresses to a separate file, and include metadata from files:
```bash
cewl -e --email_file emails.txt -a --meta_file metadata.txt https://www.example.com
```

### Extracting usernames from local files (FAB)
Use the FAB (Files Already Bagged) utility to extract author/creator metadata from a list of downloaded documents:
```bash
fab-cewl document1.pdf document2.docx
```

## Complete Command Reference

### cewl Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message |
| `-k`, `--keep` | Keep the downloaded file |
| `-d <x>`, `--depth <x>` | Depth to spider to (default: 2) |
| `-m <x>`, `--min_word_length` | Minimum word length (default: 3) |
| `-x <x>`, `--max_word_length` | Maximum word length (default: unset) |
| `-o`, `--offsite` | Let the spider visit other sites |
| `--exclude <file>` | A file containing a list of paths to exclude |
| `--allowed <regex>` | A regex pattern that path must match to be followed |
| `-w <file>`, `--write` | Write the output to the specified file |
| `-u <agent>`, `--ua <agent>` | User agent string to send |
| `-n`, `--no-words` | Don't output the wordlist (useful when only seeking emails/meta) |
| `-g <x>`, `--groups <x>` | Return groups of words as well |
| `--lowercase` | Lowercase all parsed words |
| `--with-numbers` | Accept words containing numbers as well as just letters |
| `--convert-umlauts` | Convert common ISO-8859-1 (Latin-1) umlauts (ä-ae, ö-oe, ü-ue, ß-ss) |
| `-a`, `--meta` | Include meta data extracted from files |
| `--meta_file <file>` | Output file for extracted meta data |
| `-e`, `--email` | Include email addresses found in mailto links |
| `--email_file <file>` | Output file for email addresses |
| `--meta-temp-dir <dir>` | Temporary directory used by exiftool (default: /tmp) |
| `-c`, `--count` | Show the count for each word found |
| `-v`, `--verbose` | Enable verbose output |
| `--debug` | Show extra debug information |

#### Authentication
| Flag | Description |
|------|-------------|
| `--auth_type` | Authentication type: `digest` or `basic` |
| `--auth_user` | Authentication username |
| `--auth_pass` | Authentication password |

#### Proxy Support
| Flag | Description |
|------|-------------|
| `--proxy_host` | Proxy host address |
| `--proxy_port` | Proxy port (default: 8080) |
| `--proxy_username` | Username for proxy authentication |
| `--proxy_password` | Password for proxy authentication |

#### Headers
| Flag | Description |
|------|-------------|
| `--header`, `-H` | Custom header in `name:value` format (can be used multiple times) |

### fab-cewl Options
FAB (Files Already Bagged) extracts metadata from Office (pre-2007 and 2007+) and PDF formats.

```bash
fab-cewl [OPTION] ... filename/list
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message |
| `-v` | Enable verbose output |

## Notes
- CeWL is pronounced "cool".
- The tool is highly effective for creating "context-aware" wordlists that reflect the specific terminology of a target organization.
- Use the `--lowercase` flag if the target system is case-insensitive or if you plan to apply your own mutations later.
- Be cautious with the `-o` (offsite) flag as it can significantly increase the scope and duration of the crawl.