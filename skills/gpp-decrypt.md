---
name: gpp-decrypt
description: Decrypt Group Policy Preferences (GPP) passwords found in Active Directory XML files. Use when you have discovered a cpassword string in Groups.xml, Services.xml, Scheduledtasks.xml, or similar GPP configuration files during internal penetration testing or credential harvesting.
---

# gpp-decrypt

## Overview
A Ruby-based utility designed to decrypt the AES-256 encrypted passwords (cpassword) used in Microsoft Group Policy Preferences. Microsoft published the static AES key used for these passwords, allowing anyone with access to the GPP XML files to recover the plaintext credentials. Category: Password Attacks.

## Installation (if not already installed)
Assume gpp-decrypt is already installed. If you get a "command not found" error:

```bash
sudo apt install gpp-decrypt
```

Dependencies: ruby, rubygems.

## Common Workflows

### Decrypt a single GPP string
Extract the `cpassword` value from a GPP XML file and pass it as an argument:
```bash
gpp-decrypt "j1Uyj3Vx8TY9LtLZil2uAuZkFQA/4latT76ZwgdHdhw"
```

### Decrypting from a found XML file
If you have found a `Groups.xml` file on a Domain Controller or SYSVOL share:
```bash
# Example finding the string in a file
grep "cpassword" Groups.xml
# Decrypt the resulting string
gpp-decrypt <CPASSWORD_STRING>
```

## Complete Command Reference

```
gpp-decrypt <encrypted_string>
```

### Arguments

| Argument | Description |
|----------|-------------|
| `<encrypted_string>` | The GPP `cpassword` value (Base64 encoded string) found in the XML configuration files. |

## Notes
- This tool targets the vulnerability described in MS14-025, where Microsoft hardcoded the AES key used to encrypt passwords in Group Policy Preferences.
- Common locations for these strings include:
    - `Groups.xml`
    - `Services.xml`
    - `Scheduledtasks.xml`
    - `Datasources.xml`
    - `Printers.xml`
    - `Drives.xml`
- The tool expects the raw Base64 string. If the string contains special characters that might be interpreted by the shell, wrap it in single or double quotes.