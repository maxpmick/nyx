---
name: dufflebag
description: Search publicly exposed AWS Elastic Block Storage (EBS) snapshots for secrets. Use when performing cloud security audits, AWS reconnaissance, or searching for leaked credentials, configuration files, and sensitive data within public EBS volumes.
---

# dufflebag

## Overview
Dufflebag is a specialized tool designed to discover and search through public EBS snapshots for accidentally exposed secrets. Because reading EBS volumes requires cloning, creating volumes, and mounting them within an AWS environment, the tool is architected as an AWS Elastic Beanstalk application. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)

Assume dufflebag is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install dufflebag
```

**Note:** This tool is designed to run as an Elastic Beanstalk application within AWS. Running it on a local machine outside of an AWS environment will not work for the full scanning lifecycle.

## Common Workflows

### Deploying to a specific AWS region
To start the discovery and secret-searching process in a specific region:
```bash
dufflebag us-east-1
```

### Multi-region scanning
Dufflebag operates on one region at a time. To scan multiple regions, you must deploy separate instances for each:
```bash
dufflebag us-west-2
dufflebag eu-central-1
```

## Complete Command Reference

```
dufflebag AWS_REGION
```

### Arguments

| Argument | Description |
|----------|-------------|
| `AWS_REGION` | The specific AWS region to target (e.g., `us-east-1`, `us-west-2`). |

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display the help and usage message. |

## Notes
- **Environment Requirements**: Dufflebag must be deployed within an AWS environment (specifically as an Elastic Beanstalk app) to handle the automated mounting and attachment of EBS volumes.
- **Cost Warning**: Running this tool involves creating AWS resources (volumes, instances). Ensure you tear down the Elastic Beanstalk application when finished to avoid unnecessary charges.
- **Documentation**: Additional setup details and architecture information can be found in `/usr/share/doc/dufflebag/README.md`.
- **Permissions**: The AWS credentials used to deploy/run the tool must have sufficient permissions to list public snapshots, create volumes from them, and manage EC2/Elastic Beanstalk resources.