---
name: email2phonenumber
description: OSINT tool to obtain a target's phone number from an email address by abusing password reset design weaknesses and publicly available data. Use during reconnaissance or information gathering to link email identities to physical phone numbers through scraping, number generation, and correlation.
---

# email2phonenumber

## Overview
An OSINT tool designed to discover a target's phone number using only their email address. It automates the process of identifying partial digits from password reset pages and correlating them with generated valid phone number lists. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume the tool is installed. If the command is missing, use:

```bash
sudo apt install email2phonenumber
```

## Common Workflows

### Scrape partial digits
Scrape various online services to find the masked phone number digits associated with a target email.
```bash
email2phonenumber scrape -e target@example.com
```

### Generate potential numbers
Generate a list of all valid phone numbers for a specific region (e.g., based on NANPA records for US/Canada) to use for correlation.
```bash
email2phonenumber generate -p 1555XXX1234 -o potential_numbers.txt
```

### Bruteforce correlation
Iterate through a list of phone numbers to see which one triggers a password reset mask that matches the target's email.
```bash
email2phonenumber bruteforce -f potential_numbers.txt -e target@example.com
```

## Complete Command Reference

### Global Arguments
```
email2phonenumber [-h] {scrape,generate,bruteforce} ...
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |

---

### Subcommand: scrape
Scrapes online services for phone number digits by initiating password resets.

```
email2phonenumber scrape [-h] -e EMAIL
```

| Flag | Description |
|------|-------------|
| `-e EMAIL`, `--email EMAIL` | The target email address to scrape for |
| `-h`, `--help` | Show help for the scrape command |

---

### Subcommand: generate
Creates a list of valid phone numbers based on the country's Phone Numbering Plan (e.g., NANPA).

```
email2phonenumber generate [-h] -p PHONE_PATTERN [-o OUTPUT_FILE]
```

| Flag | Description |
|------|-------------|
| `-p PATTERN`, `--phone-pattern PATTERN` | Phone number pattern (e.g., 1555XXX1234) |
| `-o FILE`, `--output-file FILE` | File to save the generated phone numbers |
| `-h`, `--help` | Show help for the generate command |

---

### Subcommand: bruteforce
Iterates over a list of phone numbers and initiates password resets on different websites to obtain associated masked emails and correlate them to the victim's email.

```
email2phonenumber bruteforce [-h] -f FILE -e EMAIL
```

| Flag | Description |
|------|-------------|
| `-f FILE`, `--file FILE` | File containing the list of phone numbers to check |
| `-e EMAIL`, `--email EMAIL` | The target email address to correlate against |
| `-h`, `--help` | Show help for the bruteforce command |

## Notes
- This tool relies on the current design of password reset pages; if a service changes its masking logic or adds CAPTCHAs, the scraping/bruteforce effectiveness may decrease.
- Use responsibly and within legal boundaries regarding OSINT and automated interactions with web services.