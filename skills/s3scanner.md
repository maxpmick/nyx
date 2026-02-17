---
name: s3scanner
description: Scan for open S3 buckets and S3-compatible storage to identify misconfigurations and dump contents. Use when performing cloud reconnaissance, identifying data leaks, auditing S3 bucket permissions, or enumerating object storage during penetration testing.
---

# s3scanner

## Overview
A tool designed to find open S3 buckets and dump their contents. It supports multi-threaded scanning across various S3-compatible APIs, checks for permission misconfigurations, and can download bucket contents locally. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume s3scanner is already installed. If you get a "command not found" error:

```bash
sudo apt install s3scanner
```

## Common Workflows

### Scan a single bucket for permissions
```bash
s3scanner -bucket my-target-bucket
```

### Bulk scan buckets from a file with enumeration
```bash
s3scanner -bucket-file buckets.txt -enumerate -threads 10
```

### Scan using a specific provider (e.g., DigitalOcean)
```bash
s3scanner -bucket target-space -provider digitalocean
```

### Scan and output results in JSON format
```bash
s3scanner -bucket-file list.txt -json > results.json
```

## Complete Command Reference

```
s3scanner [Options]
```

### Input Options (One Required)

| Flag | Type | Description |
|------|------|-------------|
| `-bucket` | string | Name of a single bucket to check |
| `-bucket-file` | string | Path to a file containing a list of bucket names to check |
| `-mq` | boolean | Connect to RabbitMQ to get bucket names. Requires config file key `mq`. (Default: false) |

### Output Options

| Flag | Type | Description |
|------|------|-------------|
| `-db` | boolean | Save results to a Postgres database. Requires config file key `db.uri`. (Default: false) |
| `-json` | boolean | Print logs to stdout in JSON format instead of human-readable text. (Default: false) |

### General Options

| Flag | Type | Description |
|------|------|-------------|
| `-enumerate` | boolean | Enumerate bucket objects. Note: This can be time-consuming for large buckets. (Default: false) |
| `-provider` | string | Object storage provider: `aws`, `custom`, `digitalocean`, `dreamhost`, `gcp`, `linode`. (Default: "aws") |
| `-threads` | int | Number of concurrent threads to use for scanning. (Default: 4) |

### Debug Options

| Flag | Type | Description |
|------|------|-------------|
| `-verbose` | boolean | Enable verbose logging for detailed output. (Default: false) |
| `-version` | boolean | Print the version information and exit. (Default: false) |

## Notes
- **Configuration**: If using the `custom` provider, RabbitMQ (`-mq`), or Postgres (`-db`), a `config.yml` file is required.
- **Config Search Paths**: The tool searches for `config.yml` in the following order:
    1. Current directory (`.`)
    2. `/etc/s3scanner/`
    3. `$HOME/.s3scanner/`
- **Provider Support**: While AWS is the default, it supports many S3-compatible APIs. Using `custom` requires manual endpoint configuration in the config file.
- **Performance**: Increasing `-threads` can speed up bulk scanning but may lead to rate limiting by the provider.