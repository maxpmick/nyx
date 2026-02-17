---
name: john
description: A powerful, multi-purpose password cracking tool. It supports hundreds of hash types and includes various modes like dictionary attacks, brute force, and rule-based mangling. Use when auditing password strength, cracking captured hashes (Linux shadow, Windows NTLM, etc.), or extracting and cracking passwords from encrypted files (ZIP, PDF, SSH keys, etc.) during penetration testing or forensics.
---

# john

## Overview
John the Ripper (JtR) is an active password cracking tool designed to identify weak passwords. It supports numerous hash types including Unix crypt(3), Windows LM/NTLM, and many others via its "Jumbo" version. It includes a suite of "2john" utilities to convert various file formats into crackable hashes. Category: Password Attacks.

## Installation (if not already installed)
Assume john is already installed. If missing:
```bash
sudo apt install john
```

## Common Workflows

### Crack Linux Shadow Passwords
First, combine the passwd and shadow files, then crack:
```bash
unshadow /etc/passwd /etc/shadow > myhashes.txt
john --wordlist=/usr/share/wordlists/rockyou.txt myhashes.txt
```

### Crack a ZIP file password
```bash
zip2john secret.zip > zip.hash
john --format=PKZIP zip.hash
```

### Crack a Raw MD5 Hash
```bash
echo "ad0234829205b9033196ba818f7a872b" > hash.txt
john --format=raw-md5 --wordlist=/usr/share/john/password.lst hash.txt
```

### Show Cracked Passwords
```bash
john --show myhashes.txt
```

## Complete Command Reference

### Main John Options
```
Usage: john [OPTIONS] [PASSWORD-FILES]
```

| Flag | Description |
|------|-------------|
| `--help` | Print usage summary |
| `--single[=SECTION[,..]]` | "Single crack" mode, using default or named rules |
| `--single=:rule[,..]` | Same, using "immediate" rule(s) |
| `--single-seed=WORD[,WORD]` | Add static seed word(s) for all salts in single mode |
| `--single-wordlist=FILE` | Short wordlist with static seed words/morphemes |
| `--single-user-seed=FILE` | Wordlist with seeds per username (user:password[s] format) |
| `--single-pair-max=N` | Override max. number of word pairs generated (default 6) |
| `--no-single-pair` | Disable single word pair generation |
| `--[no-]single-retest-guess` | Override config for SingleRetestGuess |
| `--wordlist[=FILE]` | Wordlist mode, read words from FILE |
| `--stdin` | Read wordlist from stdin |
| `--pipe` | Like --stdin, but bulk reads, and allows rules |
| `--rules[=SECTION[,..]]` | Enable word mangling rules (default or named) |
| `--rules=:rule[;..]]` | Use "immediate" rule(s) |
| `--rules-stack=SECTION` | Stacked rules, applied after regular rules |
| `--rules-skip-nop` | Skip any NOP ":" rules |
| `--loopback[=FILE]` | Extract words from a .pot file |
| `--mem-file-size=SIZE` | Size threshold for wordlist preload (default 2048 MB) |
| `--dupe-suppression` | Suppress all dupes in wordlist |
| `--incremental[=MODE]` | "Incremental" mode (brute force) |
| `--incremental-charcount=N` | Override CharCount for incremental mode |
| `--external=MODE` | External mode or word filter |
| `--mask[=MASK]` | Mask mode using MASK |
| `--markov[=OPTIONS]` | "Markov" mode |
| `--mkv-stats=FILE` | "Markov" stats file |
| `--prince[=FILE]` | PRINCE mode, read words from FILE |
| `--prince-loopback[=FILE]` | Fetch words from a .pot file for PRINCE |
| `--prince-elem-cnt-min=N` | Min elements per chain (1) |
| `--prince-elem-cnt-max=N` | Max elements per chain (8) |
| `--prince-skip=N` | Initial skip |
| `--prince-limit=N` | Limit number of candidates generated |
| `--prince-wl-dist-len` | Calculate length distribution from wordlist |
| `--prince-wl-max=N` | Load only N words from input wordlist |
| `--prince-case-permute` | Permute case of first letter |
| `--prince-mmap` | Memory-map infile |
| `--prince-keyspace` | Just show total keyspace |
| `--subsets[=CHARSET]` | "Subsets" mode |
| `--make-charset=FILE` | Make a charset, FILE will be overwritten |
| `--stdout[=LENGTH]` | Just output candidate passwords [cut at LENGTH] |
| `--session=NAME` | Give a new session the NAME |
| `--status[=NAME]` | Print status of a session |
| `--restore[=NAME]` | Restore an interrupted session |
| `--[no-]crack-status` | Emit status line when a password is cracked |
| `--progress-every=N` | Emit status line every N seconds |
| `--show[=left]` | Show cracked passwords [if =left, then uncracked] |
| `--show=formats` | Show information about hashes in a file (JSON) |
| `--show=invalid` | Show lines that are not valid for selected format(s) |
| `--test[=TIME]` | Run tests and benchmarks for TIME seconds |
| `--stress-test[=TIME]` | Loop self tests forever |
| `--test-full=LEVEL` | Run more thorough self-tests |
| `--no-mask` | Used with --test for alternate benchmark w/o mask |
| `--skip-self-tests` | Skip self tests |
| `--users=[-]LOGIN\|UID` | Load this (these) user(s) only |
| `--groups=[-]GID` | Load users of this (these) group(s) only |
| `--shells=[-]SHELL` | Load users with this (these) shell(s) only |
| `--salts=[-]COUNT[:MAX]` | Load salts with COUNT hashes |
| `--fork=N` | Fork N processes |
| `--node=MIN-MAX/TOTAL` | This node's number range out of TOTAL count |
| `--save-memory=LEVEL` | Enable memory saving (1..3) |
| `--log-stderr` | Log to screen instead of file |
| `--verbosity=N` | Change verbosity (1-6, default 3) |
| `--no-log` | Disables creation of john.log |
| `--config=FILE` | Use FILE instead of john.conf |
| `--encoding=NAME` | Input encoding (e.g., UTF-8) |
| `--field-separator-char=C` | Use 'C' instead of ':' |
| `--[no-]keep-guessing` | Try finding plaintext collisions |
| `--list=WHAT` | List capabilities (e.g., formats, subformats) |
| `--format=NAME` | Force hash of type NAME |

### Conversion Utilities (X2john)

| Tool | Usage | Description |
|------|-------|-------------|
| `unshadow` | `unshadow PASSWD SHADOW` | Combines passwd and shadow files |
| `zip2john` | `zip2john [opts] file.zip` | Extract hash from ZIP |
| `rar2john` | `rar2john file.rar` | Extract hash from RAR |
| `pdf2john` | `pdf2john file.pdf` | Extract hash from PDF |
| `ssh2john` | `ssh2john id_rsa` | Extract hash from SSH private key |
| `keepass2john` | `keepass2john database.kdbx` | Extract hash from KeePass |
| `bitlocker2john` | `bitlocker2john -i image` | Extract hash from BitLocker image |
| `gpg2john` | `gpg2john file.gpg` | Extract hash from GPG file |
| `hccap2john` | `hccap2john file.hccap` | Convert Hashcat capture to John |
| `office2john` | `office2john file.docx` | Extract hash from MS Office |

### Helper Utilities

#### unique
Removes duplicates from a wordlist.
```bash
unique [-v] [-inp=in] [-cut=len] [-mem=num] OUTPUT-FILE
```
- `-v`: Verbose mode.
- `-inp=fname`: Read from file instead of stdin.
- `-cut=len`: Trim lines to length.
- `-ex_file=XX`: Use file XX to exclude words from output.

#### mailer
Warns users about weak passwords.
```bash
mailer PASSWORD-FILE
```

#### base64conv
```bash
base64conv [-l] [-i intype] [-o outtype] [-q] [-w] [-e] [-f flag]
```
- Types: `raw`, `hex`, `mime`, `crypt`, `cryptBS`.

## Notes
- **Performance**: Use `--fork=N` to utilize multiple CPU cores.
- **Wordlists**: Default Kali wordlists are in `/usr/share/wordlists/`.
- **Pot File**: John stores cracked passwords in `~/.john/john.pot`.
- **Formats**: Use `john --list=formats` to see all supported hash types. Use the most specific format possible to increase speed.