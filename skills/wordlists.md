---
name: wordlists
description: Access and manage a collection of common wordlists used for password cracking, directory brute-forcing, and DNS enumeration. Use when performing credential stuffing, dictionary attacks, web path discovery, or subdomain enumeration during penetration testing.
---

# wordlists

## Overview
The `wordlists` package provides a centralized directory (`/usr/share/wordlists`) containing links to various dictionaries and wordlists installed by other Kali tools. Its primary feature is the inclusion of the `rockyou.txt` wordlist, a standard for password cracking. Category: Reconnaissance / Information Gathering, Password Attacks, Vulnerability Analysis.

## Installation (if not already installed)
Assume the package is installed on Kali Linux. If missing:

```bash
sudo apt update && sudo apt install wordlists
```

## Common Workflows

### Decompressing RockYou
The `rockyou.txt` file is stored compressed to save space. You must decompress it before use with tools like Hashcat or John the Ripper.
```bash
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
```

### Listing Available Wordlists
View all available wordlist categories and symbolic links to tool-specific lists.
```bash
ls -lh /usr/share/wordlists/
```

### Using RockYou with John the Ripper
```bash
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt
```

### Using Dirb wordlists for Web Discovery
```bash
dirb http://example.com /usr/share/wordlists/dirb/common.txt
```

## Complete Command Reference

The `wordlists` package primarily functions as a filesystem repository located at `/usr/share/wordlists`.

### Directory Structure and Links

| Path / Link | Target / Description |
|-------------|----------------------|
| `/usr/share/wordlists/rockyou.txt.gz` | The primary RockYou password list (Compressed) |
| `/usr/share/wordlists/brutespray` | Link to `/usr/share/brutespray/wordlist` |
| `/usr/share/wordlists/dirb` | Link to `/usr/share/dirb/wordlists` |
| `/usr/share/wordlists/dirbuster` | Link to `/usr/share/dirbuster/wordlists` |
| `/usr/share/wordlists/dnsmap.txt` | Link to `/usr/share/dnsmap/wordlist_TLAs.txt` |
| `/usr/share/wordlists/fasttrack.txt` | Link to `/usr/share/set/src/fasttrack/wordlist.txt` |
| `/usr/share/wordlists/fern-wifi` | Link to `/usr/share/fern-wifi-cracker/extras/wordlists` |
| `/usr/share/wordlists/john.lst` | Link to `/usr/share/john/password.lst` |
| `/usr/share/wordlists/legion` | Link to `/usr/share/legion/wordlists` |
| `/usr/share/wordlists/metasploit` | Link to `/usr/share/metasploit-framework/data/wordlists` |
| `/usr/share/wordlists/nmap.lst` | Link to `/usr/share/nmap/nselib/data/passwords.lst` |
| `/usr/share/wordlists/seclists` | Link to `/usr/share/seclists` (if installed) |
| `/usr/share/wordlists/sqlmap.txt` | Link to `/usr/share/sqlmap/data/txt/wordlist.txt` |
| `/usr/share/wordlists/wfuzz` | Link to `/usr/share/wfuzz/wordlist` |
| `/usr/share/wordlists/wifite.txt` | Link to `/usr/share/dict/wordlist-probable.txt` |

### Command Options
The `wordlists` command itself is a simple script to display the help/structure.

| Flag | Description |
|------|-------------|
| `-h` | Display the wordlist directory structure and help message |

## Notes
- **RockYou Size**: Once decompressed, `rockyou.txt` is approximately 134 MB and contains 14,344,392 lines.
- **SecLists**: While a link exists in the directory, the `seclists` package is a separate large installation (`sudo apt install seclists`) that provides thousands of additional specialized lists.
- **Permissions**: You may need `sudo` to decompress `rockyou.txt.gz` if you are writing the output back to the `/usr/share/wordlists/` directory.