---
name: hashcat
description: World's fastest and most advanced password recovery utility. Supports over 300 hashing algorithms and five unique attack modes including brute-force, dictionary, and mask attacks. Use for password cracking, hash identification, and security auditing of credentials during penetration testing or digital forensics.
---

# hashcat

## Overview
Hashcat is a powerful, multi-platform password recovery tool that leverages CPUs, GPUs, and other hardware accelerators. It supports a vast array of hashing algorithms (MD5, SHA, NTLM, WPA/WPA2, bcrypt, etc.) and offers highly optimized kernels for maximum performance. Category: Password Attacks.

## Installation (if not already installed)
Assume hashcat is already installed. If not:
```bash
sudo apt install hashcat hashcat-data
```

## Common Workflows

### Dictionary Attack (Straight)
Crack MD5 hashes using a wordlist:
```bash
hashcat -a 0 -m 0 hashes.txt /usr/share/wordlists/rockyou.txt
```

### Mask Attack (Brute-Force)
Crack an 8-character password consisting of lowercase letters and digits:
```bash
hashcat -a 3 -m 1000 ntlm_hashes.txt ?l?l?l?l?d?d?d?d
```

### Rule-based Attack
Apply rules to a wordlist to expand the search space (e.g., adding years, toggling case):
```bash
hashcat -a 0 -m 100 hashes.txt wordlist.txt -r /usr/share/hashcat/rules/best64.rule
```

### Benchmark
Test system performance for various hash types:
```bash
hashcat -b
```

## Complete Command Reference

### General Options

| Option | Type | Description |
|--------|------|-------------|
| `-m, --hash-type` | Num | Hash-type (see `-hh` for list) |
| `-a, --attack-mode` | Num | Attack-mode (0, 1, 3, 6, 7, 9) |
| `-V, --version` | | Print version |
| `-h, --help` | | Print help. Use `-hh` for all hash-modes |
| `--quiet` | | Suppress output |
| `--hex-charset` | | Assume charset is given in hex |
| `--hex-salt` | | Assume salt is given in hex |
| `--hex-wordlist` | | Assume words in wordlist are given in hex |
| `--force` | | Ignore warnings |
| `--deprecated-check-disable` | | Enable deprecated plugins |
| `--status` | | Enable automatic update of the status screen |
| `--status-json` | | Enable JSON format for status output |
| `--status-timer` | Num | Seconds between status screen updates |
| `--stdin-timeout-abort` | Num | Abort if no input from stdin for X seconds |
| `--machine-readable` | | Display status in machine-readable format |
| `--keep-guessing` | | Keep guessing after a hash is cracked |
| `--self-test-disable` | | Disable self-test on startup |
| `--loopback` | | Add new plains to induct directory |
| `--markov-hcstat2` | File | Specify hcstat2 file to use |
| `--markov-disable` | | Disables markov-chains |
| `--markov-classic` | | Enables classic markov-chains |
| `--markov-inverse` | | Enables inverse markov-chains |
| `-t, --markov-threshold` | Num | Threshold to stop accepting new markov-chains |
| `--runtime` | Num | Abort session after X seconds |
| `--session` | Str | Define specific session name |
| `--restore` | | Restore session from --session |
| `--restore-disable` | | Do not write restore file |
| `--restore-file-path` | File | Specific path to restore file |
| `-o, --outfile` | File | Define outfile for recovered hash |
| `--outfile-format` | Str | Outfile format (1-6, comma separated) |
| `--outfile-json` | | Force JSON format in outfile |
| `--outfile-autohex-disable` | | Disable the use of $HEX[] in output |
| `--outfile-check-timer` | Num | Seconds between outfile checks |
| `-p, --separator` | Char | Separator char for hashlists and outfile |
| `--stdout` | | Print candidates only, do not crack |
| `--show` | | Show cracked hashes from potfile |
| `--left` | | Show uncracked hashes from potfile |
| `--username` | | Ignore usernames in hashfile |
| `--remove` | | Remove hashes once they are cracked |
| `--potfile-disable` | | Do not write potfile |
| `--potfile-path` | File | Specific path to potfile |
| `--debug-mode` | Num | Defines debug mode (1-5) |
| `--debug-file` | File | Output file for debugging rules |
| `--identify` | | Show supported algorithms for input hashes |

### Backend/Performance Options

| Option | Type | Description |
|--------|------|-------------|
| `-b, --benchmark` | | Run benchmark |
| `--benchmark-all` | | Run benchmark of all hash-modes |
| `-I, --backend-info` | | Show system/backend API info |
| `-d, --backend-devices` | Str | Backend devices to use (comma separated) |
| `-D, --opencl-device-types`| Str | Device types: 1: CPU, 2: GPU, 3: FPGA/Other |
| `-O, --optimized-kernel-enable`| | Enable optimized kernels (limits password length) |
| `-w, --workload-profile` | Num | 1: Low, 2: Default, 3: High, 4: Nightmare |
| `-n, --kernel-accel` | Num | Manual workload tuning: outerloop step size |
| `-u, --kernel-loops` | Num | Manual workload tuning: innerloop step size |
| `-T, --kernel-threads` | Num | Manual workload tuning: thread count |
| `--hwmon-disable` | | Disable temperature/fan monitoring |
| `--hwmon-temp-abort` | Num | Abort if temperature reaches X degrees |

### Attack Specific Options

| Option | Type | Description |
|--------|------|-------------|
| `-s, --skip` | Num | Skip X words from the start |
| `-l, --limit` | Num | Limit X words from the start + skipped |
| `-j, --rule-left` | Rule | Single rule for left wordlist |
| `-k, --rule-right` | Rule | Single rule for right wordlist |
| `-r, --rules-file` | File | Multiple rules from file |
| `-g, --generate-rules` | Num | Generate X random rules |
| `-1, --custom-charset1` | CS | User-defined charset ?1 |
| `-2, --custom-charset2` | CS | User-defined charset ?2 |
| `-i, --increment` | | Enable mask increment mode |
| `--increment-min` | Num | Start mask incrementing at X |
| `--increment-max` | Num | Stop mask incrementing at X |

### Attack Modes Reference
- **0**: Straight (Wordlist)
- **1**: Combination
- **3**: Brute-force / Mask
- **6**: Hybrid Wordlist + Mask
- **7**: Hybrid Mask + Wordlist
- **9**: Association

### Built-in Charsets
- **?l**: abcdefghijklmnopqrstuvwxyz
- **?u**: ABCDEFGHIJKLMNOPQRSTUVWXYZ
- **?d**: 0123456789
- **?h**: 0123456789abcdef
- **?H**: 0123456789ABCDEF
- **?s**:  !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
- **?a**: All above combined
- **?b**: 0x00 - 0xff

## Notes
- **Performance**: Use `-O` for a speed boost, but be aware it limits the maximum password length.
- **Workload**: Use `-w 3` or `-w 4` on dedicated cracking rigs; `-w 1` is safer for systems used simultaneously for other tasks.
- **Potfile**: Hashcat stores cracked passwords in `hashcat.potfile`. Use `--show` to view them.
- **WPA/WPA2**: Requires converting `.cap` or `.pcap` files to `.hccapx` or `.22000` format before cracking.