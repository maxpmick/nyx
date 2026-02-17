---
name: trufflehog
description: Search through git repositories, filesystems, S3 buckets, and other sources for secrets and credentials, digging deep into commit history and branches. Use when performing secret scanning, credential leakage audits, or post-exploitation reconnaissance to find accidentally committed API keys, passwords, or tokens.
---

# trufflehog

## Overview
TruffleHog is a high-performance scanner designed to find credentials (secrets) across various platforms. it supports verification of found secrets against service APIs to reduce false positives. Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
Assume trufflehog is already installed. If not:
```bash
sudo apt update && sudo apt install trufflehog
```

## Common Workflows

### Scan a local directory
```bash
trufflehog filesystem /path/to/project
```

### Scan a public GitHub repository with history
```bash
trufflehog git https://github.com/target/repo.git
```

### Scan a Docker image for secrets
```bash
trufflehog docker --image target-image:latest
```

### Scan and output verified results to JSON
```bash
trufflehog git https://github.com/target/repo.git --json --results=verified
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `-h, --help` | Show context-sensitive help. |
| `--log-level` | Logging verbosity 0 (info) to 5 (trace). Use -1 to disable. |
| `--profile` | Enables profiling server on :18066. |
| `-j, --json` | Output in JSON format. |
| `--json-legacy` | Use pre-v3.0 JSON format (git, gitlab, github only). |
| `--github-actions` | Output in GitHub Actions format. |
| `--concurrency` | Number of concurrent workers (default: 6). |
| `--no-verification` | Don't verify the results against remote APIs. |
| `--results` | Types to output: `verified`, `unknown`, `unverified`, `filtered_unverified`. |
| `--no-color` | Disable colorized output. |
| `--allow-verification-overlap` | Allow verification of similar credentials across detectors. |
| `--filter-unverified` | Only output first unverified result per chunk per detector. |
| `--filter-entropy` | Filter unverified results with Shannon entropy (e.g., 3.0). |
| `--config` | Path to configuration file. |
| `--print-avg-detector-time` | Print average time spent on each detector. |
| `--no-update` | Don't check for updates. |
| `--fail` | Exit with code 183 if results are found. |
| `--fail-on-scan-errors` | Exit with non-zero code if an error occurs during scan. |
| `--verifier` | Set custom verification endpoints. |
| `--custom-verifiers-only` | Only use custom verification endpoints. |
| `--detector-timeout` | Max time scanning chunks per detector (e.g., 30s). |
| `--archive-max-size` | Max size of archive to scan (e.g., 4MB). |
| `--archive-max-depth` | Max depth of archive to scan. |
| `--archive-timeout` | Max time to spend extracting an archive. |
| `--include-detectors` | Comma separated list of detector types/IDs to include. |
| `--exclude-detectors` | Comma separated list of detector types/IDs to exclude. |
| `--no-verification-cache` | Disable verification caching. |
| `--force-skip-binaries` | Force skipping binaries. |
| `--force-skip-archives` | Force skipping archives. |
| `--skip-additional-refs` | Skip additional references. |
| `--user-agent-suffix` | Suffix to add to User-Agent. |
| `--version` | Show application version. |

### Commands and Sub-module Options

| Command | Usage / Required Flags |
|---------|------------------------|
| `git` | `trufflehog git <uri>` - Scan git repositories. |
| `github` | `trufflehog github` - Scan GitHub repositories. |
| `github-experimental` | `trufflehog github-experimental --repo=REPO` - Run experimental scans. |
| `gitlab` | `trufflehog gitlab --token=TOKEN` - Scan GitLab repositories. |
| `filesystem` | `trufflehog filesystem <path>...` - Scan local files. |
| `s3` | `trufflehog s3` - Scan S3 buckets. |
| `gcs` | `trufflehog gcs` - Scan GCS buckets. |
| `syslog` | `trufflehog syslog --format=FORMAT` - Scan syslog. |
| `circleci` | `trufflehog circleci --token=TOKEN` - Scan CircleCI. |
| `docker` | `trufflehog docker --image=IMAGE` - Scan Docker Image. |
| `travisci` | `trufflehog travisci --token=TOKEN` - Scan TravisCI. |
| `postman` | `trufflehog postman` - Scan Postman. |
| `elasticsearch` | `trufflehog elasticsearch` - Scan Elasticsearch. |
| `jenkins` | `trufflehog jenkins --url=URL` - Scan Jenkins. |
| `huggingface` | `trufflehog huggingface` - Scan HuggingFace assets. |
| `stdin` | `trufflehog stdin` - Scan content from standard input. |
| `multi-scan` | `trufflehog multi-scan` - Scan multiple sources from config. |
| `analyze` | `trufflehog analyze` - Analyze API keys for permissions. |

## Notes
- **Verification**: By default, TruffleHog attempts to "verify" secrets by sending them to the respective service (e.g., AWS, Slack). This confirms if the secret is still active but leaves logs on the target service. Use `--no-verification` if stealth is required.
- **Performance**: For large repositories, adjust `--concurrency` and `--detector-timeout` to optimize speed.
- **Entropy**: Use `--filter-entropy` to reduce noise from random strings that aren't necessarily secrets.