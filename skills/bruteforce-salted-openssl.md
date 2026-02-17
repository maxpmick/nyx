---
name: bruteforce-salted-openssl
description: Crack passphrases for files encrypted with the OpenSSL command line tool. Supports both exhaustive brute-force (charset-based) and dictionary attacks. Use during penetration testing or digital forensics when encountering encrypted files (often with .enc extension) created via `openssl enc`.
---

# bruteforce-salted-openssl

## Overview
A specialized tool designed to recover passwords for files encrypted using OpenSSL's salted format. It supports multi-threading, custom charsets, and various symmetric ciphers and digests available in the system's OpenSSL libraries. Category: Password Attacks / Digital Forensics.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install bruteforce-salted-openssl
```

## Common Workflows

### Dictionary Attack
Try passwords from a wordlist against an AES-256-CBC encrypted file (default cipher):
```bash
bruteforce-salted-openssl -f /usr/share/wordlists/rockyou.txt encrypted_file.enc
```

### Exhaustive Brute-Force with Custom Charset
Try all 6-character passwords consisting only of lowercase letters and numbers, using 8 threads:
```bash
bruteforce-salted-openssl -t 8 -l 6 -m 6 -s "abcdefghijklmnopqrstuvwxyz0123456789" encrypted_file.enc
```

### Cracking with Known Prefix/Suffix
If you remember the password starts with "Pass" and ends with "2023", but forgot 3 characters in the middle:
```bash
bruteforce-salted-openssl -b "Pass" -e "2023" -l 11 -m 11 encrypted_file.enc
```

### Specific Cipher and Digest
Cracking a file encrypted with a specific legacy configuration (e.g., DES3 and SHA1):
```bash
bruteforce-salted-openssl -c des3 -d sha1 -f wordlist.txt secret.enc
```

## Complete Command Reference

```
bruteforce-salted-openssl [options] <filename>
```

### Options

| Flag | Description |
|------|-------------|
| `-1` | Stop the program after finding the first password candidate. |
| `-a` | List the available cipher and digest algorithms supported by the system. |
| `-B <file>` | Search using binary passwords (instead of character passwords). Write candidates to `<file>`. |
| `-b <string>` | Beginning of the password (prefix). Default: `""`. |
| `-c <cipher>` | Cipher for decryption (e.g., aes-256-cbc, des3). Default: `aes-256-cbc`. |
| `-d <digest>` | Digest for key and IV generation (e.g., md5, sha256). Default: `md5`. |
| `-e <string>` | End of the password (suffix). Default: `""`. |
| `-f <file>` | Dictionary mode: Read passwords from `<file>` instead of generating them. |
| `-h` | Show help and quit. |
| `-L <n>` | Limit the maximum number of tested passwords to `<n>`. |
| `-l <length>` | Minimum password length (including prefix and suffix). Default: `1`. |
| `-M <string>` | Success criteria: Consider decryption successful if data starts with `<string>`. |
| `-p <n>` | Preview and check the first `<n>` decrypted bytes for the magic string. Default: `1024`. |
| `-m <length>` | Maximum password length (including prefix and suffix). Default: `8`. |
| `-N` | Ignore decryption errors (similar to `openssl -nopad`). |
| `-n` | Ignore salt (similar to `openssl -nosalt`). |
| `-s <string>` | Password character set for exhaustive mode. Default: `0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz`. |
| `-t <n>` | Number of threads to use. Default: `1`. |
| `-v <n>` | Print progress info every `<n>` seconds. |
| `-w <file>` | Session management: Restore state from `<file>` if it exists, and save state to it regularly. |

## Notes
- **Success Detection**: By default, the tool assumes success if the decrypted data contains at least 90% printable ASCII characters. Use `-M` if you know the specific file header (e.g., `PDF-` or `PNG`).
- **Performance**: Use the `-t` flag to match the number of CPU cores for maximum speed.
- **Progress**: You can send a `USR1` signal to a running process to force a progress update: `kill -USR1 <pid>`.
- **Ciphers**: Use `-a` to see exactly which strings to pass to the `-c` and `-d` flags based on your local OpenSSL installation.