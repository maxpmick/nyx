---
name: cisco7crack
description: Encrypt and decrypt Cisco Type 7 passwords. Use when recovering stored passwords from Cisco configuration files, auditing device security, or generating Type 7 hashes for legacy Cisco IOS features.
---

# cisco7crack

## Overview
A specialized utility for the encryption and decryption of Cisco Type 7 passwords. Type 7 is a weak, reversible obfuscation method used in Cisco IOS configurations and should not be confused with the more secure Type 5 (MD5) or Type 8/9 (SHA-256/SCRYPT) hashes. Category: Password Attacks.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt install cisco7crack
```

## Common Workflows

### Decrypt a Cisco Type 7 password
```bash
cisco7crack 082F1C5A1A490D43000F5E033F78373B
```

### Encrypt a plaintext password
```bash
cisco7crack -c 'mypassword123'
```

### Encrypt using a specific salt index (0-15)
```bash
cisco7crack -c#5 'secret_key'
```

### Quiet mode for scripting
```bash
cisco7crack -q -d 04530215000500
```

## Complete Command Reference

```
usage:
   cisco7crack [-q] -c [-{a|#<0..15>}] <plaintext>
   cisco7crack [-q] [-d] <ciphertext>
   cisco7crack [-h]
```

### Options

| Flag | Description |
|------|-------------|
| `-c` | **Crypt**: Encrypt the provided `<plaintext>` string. |
| `-a` | **All**: Display all 16 possible ways (different salts) to encrypt the `<plaintext>`. Used with `-c`. |
| `-#<n>` | **Specific Salt**: Display the n-th way (where n is 0-15) to encrypt the `<plaintext>`. Used with `-c`. |
| `-d` | **Decrypt**: Decrypt the provided `<ciphertext>`. This is the default behavior if no flag is specified. |
| `-q` | **Quiet**: Suppress banner and extra output; useful for shell scripts. |
| `-h` | **Help**: Display the usage summary and version information. |

## Notes
- **Security Warning**: Cisco Type 7 passwords are not secure. They use a simple XOR cipher with a static key table. They can be decrypted instantly by anyone with access to the configuration file.
- **Salt Range**: The salt index (the first two digits of the ciphertext) ranges from 00 to 15. This tool allows you to specify which index to use when encrypting via the `-#` flag.
- **Scripting**: When using in bash scripts, combine `-c`, `-q`, and a specific salt to get a clean output string.