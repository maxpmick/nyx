---
name: hash-identifier
description: Identify the encryption algorithm used to generate a specific hash string. Use when encountering unknown password hashes or data signatures during penetration testing, credential auditing, or digital forensics to determine which cracking tool or method (like Hashcat or John the Ripper) should be employed.
---

# hash-identifier

## Overview
hash-identifier is a specialized tool designed to analyze and identify the different types of hashes used to encrypt data, particularly passwords. It helps security professionals determine the likely algorithm (MD5, SHA-1, NTLM, etc.) based on the hash's structure and length. Category: Password Attacks.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt install hash-identifier
```

## Common Workflows

### Interactive Identification
Launch the tool and enter hashes one by one when prompted:
```bash
hash-identifier
```
Once the prompt `HASH:` appears, paste your hash and press Enter.

### Single Hash Identification (via Pipe)
Identify a hash without entering the interactive shell:
```bash
echo "098f6bcd4621d373cade4e832627b4f6" | hash-identifier
```

## Complete Command Reference

The tool is primarily an interactive script and does not feature a wide array of command-line arguments.

### Usage
```bash
hash-identifier
```

### Interactive Commands
Once the program is running, the following inputs are recognized at the `HASH:` prompt:

| Input | Action |
|-------|--------|
| `<hash_string>` | Analyzes the string and outputs "Possible Hashs" and "Least Possible Hashs" |
| `exit` | Exits the program |
| `quit` | Exits the program |

### Supported Hash Types
The tool can identify a vast range of hashes, including but not limited to:
- **Standard Algorithms**: MD2, MD4, MD5, SHA-1, SHA-256, SHA-512, RipeMD, HAVAL, Tiger, Snefru.
- **System/Software Specific**: NTLM, Domain Cached Credentials (DCC), RAdmin v2.x, MySQL, MSSQL, Cisco-PIX, vBulletin, IPB.
- **Complex/Salted Constructions**: `md5($pass.$salt)`, `md5(sha1(md5($pass)))`, `md5($username.LF.$pass)`, and many other nested or salted iterations.

## Notes
- **Accuracy**: hash-identifier provides "Possible" and "Least Possible" matches. Because different algorithms can produce hashes of the same length and format (e.g., MD5 and NTLM are both 32-character hex strings), always verify the context of where the hash was found.
- **Next Steps**: Once a hash is identified, use the identified type to select the correct format flag in tools like `hashcat` (e.g., `-m 0` for MD5) or `john`.
- **Input**: Ensure the hash string does not contain leading or trailing whitespace for the most accurate identification.