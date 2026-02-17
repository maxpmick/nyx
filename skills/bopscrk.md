---
name: bopscrk
description: Generate smart and powerful targeted wordlists by combining personal information, keywords, and song lyrics with various transformations. Use when performing password cracking, brute-force attacks, or social engineering assessments where custom, target-specific wordlists are required.
---

# bopscrk

## Overview
bopscrk is a targeted-attack wordlist creator that combines personal information related to a target and transforms the results into potential passwords. It includes a unique lyricpass module to incorporate song lyrics from specific artists into the wordlist generation process. Category: Password Attacks.

## Installation (if not already installed)
Assume bopscrk is already installed. If the command is not found, use:

```bash
sudo apt install bopscrk
```

## Common Workflows

### Interactive Mode
The easiest way to generate a targeted list by answering prompts about the target's name, birthday, and interests.
```bash
bopscrk -i -o target_wordlist.txt
```

### Combining Specific Keywords with Transformations
Generate a wordlist using specific keywords, applying leet speak and case transformations, with a specific length constraint.
```bash
bopscrk -w "Company,Admin,2023,Password" -l -c -m 8 -M 15 -o custom.txt
```

### Lyric-Based Wordlist
Create a wordlist based on the lyrics of specific artists, combined with leet transformations.
```bash
bopscrk -a "Nirvana,Radiohead" -l -o lyrics_passwords.txt
```

### Complex Combinations
Combine up to 3 words at a time from a provided list to create longer passphrases/passwords.
```bash
bopscrk -w "security,p@ss,winter,2024" -n 3 -o complex.txt
```

## Complete Command Reference

```
usage: bopscrk [-h] [-i] [-w ] [-m ] [-M ] [-c] [-l] [-n ] [-a ] [-o ] [-C ] [--version]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-i`, `--interactive` | Interactive mode: the script will ask questions about the target to gather seed words |
| `-w <words>` | Words to combine, comma-separated (these will be combined with all other gathered words) |
| `-m`, `--min <int>` | Minimum length for the words to generate (default: 4) |
| `-M`, `--max <int>` | Maximum length for the words to generate (default: 12) |
| `-c`, `--case` | Enable case transformations (e.g., upper, lower, capitalized) |
| `-l`, `--leet` | Enable leet (1337) transformations (e.g., a -> 4, e -> 3) |
| `-n <int>` | Maximum amount of words to combine each time (default: 2) |
| `-a`, `--artists <names>` | Artists to search for song lyrics, comma-separated (lyricpass module) |
| `-o`, `--output <file>` | Output file to save the generated wordlist (default: tmp.txt) |
| `-C`, `--config <file>` | Specify a custom configuration file to use (default: `/usr/lib/python3/dist-packages/bopscrk/bopscrk.cfg`) |
| `--version` | Print the version and exit |

## Notes
- The tool is highly effective for "Personalized Password Guessing" where users often combine names, dates, and hobbies.
- Using the `-n` flag with a high number or a large list of artists/words can significantly increase the size of the output file and the time required for generation.
- The lyricpass module requires an active internet connection to fetch lyrics via the `python3-requests` dependency.