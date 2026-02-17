---
name: davtest
description: Test WebDAV enabled servers by uploading test executable files and checking if they can be executed. Use when performing web application testing, vulnerability analysis of WebDAV services, or attempting to gain initial access via misconfigured file upload permissions.
---

# davtest

## Overview
DAVTest is a testing tool for WebDAV enabled servers. It works by uploading various test executable files (php, asp, jsp, etc.) and then checking if those files can be executed on the target. This allows penetration testers to quickly determine if a DAV service is exploitable. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume davtest is already installed. If the command is missing:

```bash
sudo apt install davtest
```

## Common Workflows

### Basic WebDAV Scan
Test a target URL for file upload and execution vulnerabilities:
```bash
davtest -url http://192.168.1.209/dav/
```

### Authenticated Testing with Cleanup
Test a protected WebDAV share and ensure all uploaded test files are deleted afterward:
```bash
davtest -url http://example.com/webdav/ -auth user:password -cleanup
```

### Bypass PUT Restrictions using MOVE
Attempt to upload a text file and then rename (MOVE) it to an executable extension to bypass simple file upload filters:
```bash
davtest -url http://example.com/dav/ -move
```

### Upload a Custom Backdoor
Upload a specific local shell/backdoor to a specific location on the server:
```bash
davtest -url http://example.com/dav/ -uploadfile shell.php -uploadloc /uploads/shell.php
```

## Complete Command Reference

```bash
davtest -url <url> [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-url <url>` | **Required.** The URL of the DAV location to test |
| `-auth <user:pass>` | Authorization credentials in `username:password` format |
| `-realm <realm>` | Specify the Authentication Realm |
| `-cleanup` | Delete everything uploaded to the server when the test is finished |
| `-directory <name>` | Postfix portion of the directory to create (appended to DavTestDir_) |
| `-debug <1-3>` | DAV debug level: 1 (basic), 2 & 3 (logs requests/responses to `/tmp/perldav_debug.txt`) |
| `-move` | PUT text files first, then MOVE them to executable extensions |
| `-copy` | PUT text files first, then COPY them to executable extensions |
| `-nocreate` | Do not create a new directory on the server; test in the provided URL |
| `-quiet` | Only print out the final summary |
| `-rand <string>` | Use the specified string instead of a random string for filenames |
| `-sendbd <type>` | Send backdoors: `auto` (for any succeeded test) or `ext` (matching file names in backdoors/ dir) |
| `-uploadfile <file>` | Upload this specific local file (requires `-uploadloc`) |
| `-uploadloc <path>` | Upload the file to this relative location/name (requires `-uploadfile`) |

## Notes
- WebDAV misconfigurations often allow the `PUT` method but may restrict certain extensions. Using `-move` or `-copy` is a common technique to bypass these restrictions.
- The tool creates a directory named `DavTestDir_[random_string]` by default to avoid cluttering the root directory.
- Ensure you have permission to test the target, as this tool actively writes files to the remote server.