---
name: bruteshark
description: Perform network forensic analysis (NFAT) to extract passwords, reconstruct TCP sessions, build network maps, and extract hashes from PCAP files or live traffic. Use when analyzing network captures for credentials, performing post-incident forensics, or identifying plaintext protocols and weak authentication during penetration testing.
---

# bruteshark

## Overview
BruteShark is a Network Forensic Analysis Tool (NFAT) designed for deep processing and inspection of network traffic. It extracts passwords, builds network maps, reconstructs TCP sessions, and extracts hashes of encrypted passwords (convertible to Hashcat format). It is used by security researchers to identify network weaknesses and credential exposure. Category: Digital Forensics / Sniffing & Spoofing.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing, install via:

```bash
sudo apt install bruteshark
```

## Common Workflows

### Analyze a specific PCAP file for credentials and DNS
```bash
brutesharkcli -i capture.pcap -m Credentials,DNS -o ./results
```

### Process an entire directory of PCAP files
```bash
brutesharkcli -d /path/to/pcaps/ -m Credentials,NetworkMap,FileExtracting -o ./output_dir
```

### Live capture from a network interface
```bash
sudo brutesharkcli -l -p -m Credentials -o ./live_results
```
*Note: Live capture usually requires root privileges for promiscuous mode.*

### Live capture with a BPF filter
```bash
sudo brutesharkcli -l -f "port 80 or port 443" -m Credentials -o ./web_traffic
```

## Complete Command Reference

```
brutesharkcli [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-d`, `--input-dir` | The input directory containing the files to be processed. |
| `-i`, `--input` | The files to be processed separated by comma (e.g., `file1.pcap,file2.pcap`). |
| `-m`, `--modules` | The modules to run, separated by comma. Available: `Credentials`, `FileExtracting`, `NetworkMap`, `DNS`, `Voip`. |
| `-o`, `--output` | Output directory where the result files and extracted data will be saved. |
| `-p`, `--promiscuous` | Configures whether to start live capture with promiscuous mode. Use along with `-l`. |
| `-l`, `--live-capture` | Capture and process packets live from a network interface. |
| `-f`, `--filter` | Set a capture BPF (Berkeley Packet Filter) filter to the live traffic processing. |
| `--help` | Display the help screen. |
| `--version` | Display version information. |

## Notes
- **Privileges**: Running live captures (`-l`) or using promiscuous mode (`-p`) generally requires `sudo` or root permissions.
- **Hashcat Integration**: Extracted hashes are often saved in formats compatible with Hashcat for offline brute-force attacks.
- **Output**: Ensure the output directory specified with `-o` exists or that the tool has permissions to create it, as it will populate this folder with various CSVs and extracted files based on the modules selected.