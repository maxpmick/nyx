---
name: twofi
description: Generate custom wordlists for password cracking by scraping Twitter for specific keywords or users. It aggregates words from tweets and sorts them by frequency. Use when performing reconnaissance, information gathering, or password attacks where target-specific or trending terminology is needed to improve brute-force or dictionary attack success rates.
---

# twofi

## Overview
twofi (Twitter Words of Interest) is a tool designed to create custom wordlists by searching Twitter for specific terms or users. It identifies frequently used words in relevant tweets, making it highly effective for generating targeted dictionaries for password cracking. Category: Reconnaissance / Information Gathering, Password Attacks.

## Installation (if not already installed)

Assume twofi is already installed. If you get a "command not found" error:

```bash
sudo apt install twofi
```

Dependencies: ruby, ruby-twitter. Note: You must configure your Twitter API credentials in the `twofi.yml` config file before use.

## Common Workflows

### Generate a wordlist from search terms
```bash
twofi --terms "pentesting,hacking,kali" --min_word_length 6
```
Searches for tweets containing these terms and returns words at least 6 characters long.

### Generate a wordlist from specific Twitter users
```bash
twofi --users "offsectraining,kalilinux" --count
```
Scrapes tweets from these users and includes the frequency count for each word.

### Using input files for bulk processing
```bash
twofi --term_file targets.txt --user_file influencers.txt -m 5 > custom_wordlist.txt
```
Reads search terms and usernames from files and saves the resulting wordlist to a file.

## Complete Command Reference

```
twofi [OPTIONS]
```

### Options

| Flag | Description |
|------|-------------|
| `--help`, `-h` | Show help message |
| `--config <file>` | Path to the config file (default: `twofi.yml`) |
| `--count`, `-c` | Include the frequency count with the words in the output |
| `--min_word_length`, `-m` | Minimum word length to include in the list |
| `--term_file`, `-T <file>` | A file containing a list of search terms (one per line) |
| `--terms`, `-t` | Comma-separated search terms. Quote words containing spaces; do not put spaces after commas |
| `--user_file`, `-U <file>` | A file containing a list of Twitter usernames (one per line) |
| `--users`, `-u` | Comma-separated usernames. Quote names containing spaces; do not put spaces after commas |
| `--verbose`, `-v` | Enable verbose output |

## Notes
- **API Credentials**: You must edit `twofi.yml` to include your Twitter API keys (Consumer Key, Consumer Secret, Access Token, and Access Token Secret).
- **Word Sorting**: By default, twofi returns the wordlist sorted by the most common words first.
- **Rate Limiting**: Be mindful of Twitter API rate limits when processing large lists of terms or users.