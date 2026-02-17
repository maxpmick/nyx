---
name: crackle
description: Crack and decrypt Bluetooth Low Energy (BLE) encryption by exploiting flaws in the pairing process. Use when performing BLE security assessments, intercepting encrypted Bluetooth Smart traffic, or recovering Long Term Keys (LTK) from captured pcap files containing pairing conversations.
---

# crackle

## Overview
crackle is a tool designed to crack and decrypt BLE (Bluetooth Smart) encryption. It exploits a vulnerability in the BLE pairing process to brute force the Temporary Key (TK). Once the TK is found, it can derive the Short Term Key (STK) and the Long Term Key (LTK), allowing for full decryption of communication between a master and slave device. Category: Wireless Attacks / Password Attacks / Bluetooth.

## Installation (if not already installed)
Assume crackle is already installed. If the command is missing:

```bash
sudo apt install crackle
```

## Common Workflows

### Crack TK and recover LTK from a capture
If you have a pcap containing a full BLE pairing exchange, crackle will find the TK and output the LTK.
```bash
crackle -i pairing_capture.pcap
```

### Decrypt a capture and save to a new file
Cracks the TK and writes the decrypted traffic to a new pcap file.
```bash
crackle -i ltk_exchange.pcap -o decrypted.pcap
```

### Decrypt traffic using a known LTK
If you already possess the LTK, you can decrypt a capture that contains at least the `LL_ENC_REQ` and `LL_ENC_RSP` packets.
```bash
crackle -i encrypted_traffic.pcap -l 81b06facd90fe7a6e9bbd9cee59736a7 -o decrypted.pcap
```

## Complete Command Reference

```
crackle -i <input.pcap> [-o <output.pcap>] [-l <ltk>] [-v] [-t]
```

### Major Modes

| Mode | Description |
|------|-------------|
| **Crack TK** | Requires a PCAP containing a complete pairing conversation. If any packet is missing, cracking will fail. If an LTK exchange is present, the LTK will be dumped to stdout. |
| **Decrypt with LTK** | Requires a PCAP containing at least `LL_ENC_REQ` and `LL_ENC_RSP` (to obtain SKD and IV). Requires the `-l` flag with a valid LTK. |

### Arguments

| Flag | Description |
|------|-------------|
| `-i <input.pcap>` | Path to the input PCAP file containing BLE traffic. |
| `-o <output.pcap>` | Path to save the decrypted PCAP file. |
| `-l <ltk>` | Provide a known Long Term Key for decryption. Format: string of hex bytes, no separator, MSB to LSB (e.g., `81b06facd90fe7a6e9bbd9cee59736a7`). |
| `-v` | Enable verbose output. |
| `-t` | Run internal tests against the crypto engine to verify functionality. |

## Notes
- **Capture Completeness**: For TK cracking, the input PCAP must contain the entire pairing process. Missing packets will prevent the tool from deriving the keys.
- **LTK Format**: When using `-l`, ensure the hex string has no colons or spaces.
- **Security Domain**: Primarily used in Bluetooth Low Energy (BLE) security auditing and wireless reconnaissance.