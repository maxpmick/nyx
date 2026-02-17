---
name: cloud-enum
description: Enumerate public resources in AWS, Azure, and Google Cloud using keywords. Discovers S3 buckets, Azure storage accounts, blobs, databases, VMs, web apps, and GCP buckets/apps. Use during the reconnaissance phase of a penetration test or OSINT investigation to identify cloud-hosted assets and potential data leaks.
---

# cloud-enum

## Overview
Multi-cloud OSINT tool that enumerates public resources across Amazon Web Services (AWS), Microsoft Azure, and Google Cloud Platform (GCP) based on provided keywords. It identifies open/protected buckets, hosted databases, virtual machines, and web applications. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume cloud-enum is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install cloud-enum
```

## Common Workflows

### Basic enumeration for a single company
```bash
cloud_enum -k examplecorp
```

### Enumeration using multiple keywords and custom threading
```bash
cloud_enum -k example -k example-dev -t 20
```

### Fast scan using a keyword list and no mutations
```bash
cloud_enum -kf keywords.txt -qs
```

### Targeted enumeration with logging
```bash
cloud_enum -k targetbrand -l results.json -f json --disable-gcp
```

## Complete Command Reference

```
usage: cloud_enum [-h] (-k KEYWORD | -kf KEYFILE) [-m MUTATIONS] [-b BRUTE]
                  [-t THREADS] [-ns NAMESERVER] [-l LOGFILE] [-f FORMAT]
                  [--disable-aws] [--disable-azure] [--disable-gcp] [-qs]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit. |
| `-k`, `--keyword KEYWORD` | Keyword to search for. Can be used multiple times for multiple keywords. |
| `-kf`, `--keyfile KEYFILE` | Input file containing one keyword per line. |
| `-m`, `--mutations MUTATIONS` | Path to mutations file. Default: `/usr/lib/cloud-enum/enum_tools/fuzz.txt` |
| `-b`, `--brute BRUTE` | List to brute-force Azure container names. Default: `/usr/lib/cloud-enum/enum_tools/fuzz.txt` |
| `-t`, `--threads THREADS` | Number of threads for HTTP brute-force. Default: 5. |
| `-ns`, `--nameserver NAMESERVER` | Specific DNS server to use for brute-force lookups. |
| `-l`, `--logfile LOGFILE` | File path to append discovered items. |
| `-f`, `--format FORMAT` | Format for the log file: `text`, `json`, or `csv`. Default: `text`. |
| `--disable-aws` | Skip all Amazon Web Services checks. |
| `--disable-azure` | Skip all Microsoft Azure checks. |
| `--disable-gcp` | Skip all Google Cloud Platform checks. |
| `-qs`, `--quickscan` | Disable all mutations and second-level scans for faster, surface-level results. |

## Notes
- **AWS Checks**: Identifies Open/Protected S3 Buckets.
- **Azure Checks**: Identifies Storage Accounts, Open Blob Containers, Hosted Databases, Virtual Machines, and Web Apps.
- **GCP Checks**: Identifies Open/Protected GCP Buckets and Google App Engine sites.
- The tool relies on DNS resolution and HTTP status codes to determine resource existence and permissions.
- Using high thread counts (`-t`) may lead to rate limiting by cloud providers.