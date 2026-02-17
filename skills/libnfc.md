---
name: libnfc
description: A comprehensive suite of tools for Near Field Communication (NFC) including tag enumeration, reading, writing, emulation, and relay attacks. Use when performing RFID/NFC reconnaissance, cloning MIFARE cards, emulating NFC Forum tags, or debugging PN53x-based hardware during wireless security assessments.
---

# libnfc

## Overview
libnfc is a high-level API and toolset for Near Field Communication. It supports hardware based on NXP PN531, PN532, and PN533 controller chips. The suite includes utilities for MIFARE Classic/Ultralight, Jewel tags, NFC Forum tags, and low-level chip diagnostics. Category: Wireless Attacks / RFID.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install libnfc-bin libnfc-examples libnfc-pn53x-examples
```

## Common Workflows

### List and Scan Devices
```bash
nfc-scan-device -v
nfc-list
```

### Clone a MIFARE Classic 1K Card
```bash
# Read card to dump file using Key A
nfc-mfclassic r a u mycard.mfd
# Write dump to a new card
nfc-mfclassic w a u mycard.mfd
```

### Emulate a UID
```bash
nfc-emulate-uid DEADBEEF
```

### Relay Attack (ISO14443-4)
Requires two NFC devices to relay data between a reader and a tag.
```bash
nfc-relay-picc
```

## Complete Command Reference

### nfc-list
List NFC targets.
- `-v`: Verbose display.
- `-t X`: Poll only for types according to bitfield X:
    - `1`: ISO14443A
    - `2`: Felica (212 kbps)
    - `4`: Felica (424 kbps)
    - `8`: ISO14443B
    - `16`: ISO14443B'
    - `32`: ISO14443B-2 ST SRx
    - `64`: ISO14443B-2 ASK CTx
    - `128`: ISO14443B iClass
    - `256`: ISO14443A-3 Jewel
    - `512`: ISO14443A-2 NFC Barcode
    - `1023`: Default (all types).

### nfc-mfclassic
MIFARE Classic tool.
`Usage: nfc-mfclassic f|r|R|w|W a|b u|U<01ab23cd> <dump.mfd> [<keys.mfd> [f]]`
- `f`: Format card (reset keys to FFFFFFFFFFFF, data to 00).
- `r`: Read from card.
- `R`: Unlocked read (reveals A/B keys, requires Chinese clone).
- `w`: Write to card.
- `W`: Unlocked write (overwrites block 0/UID, requires Chinese clone).
- `a|b`: Use Key A or Key B (lowercase: halt on error; uppercase `A|B`: tolerate errors).
- `u|U`: Use any UID (`u`) or specific UID (`U01ab23cd`).
- `<keys.mfd>`: Optional key file.
- `f`: Force using keyfile even if UID mismatch.

### nfc-mfultralight
MIFARE Ultralight tool.
`Usage: nfc-mfultralight r|w <dump.mfd> [OPTIONS]`
- `r|w`: Read or Write.
- `--otp`: Don't prompt for OTP Bytes.
- `--lock`: Don't prompt for Lock Bytes.
- `--dynlock`: Don't prompt for Dynamic Lock Bytes.
- `--uid`: Don't prompt for UID writing.
- `--full`: Full card write (UID + OTP + Lockbytes + Dynamic Lockbytes).
- `--with-uid <UID>`: Specify UID.
- `--pw <PWD>`: 8 HEX digit password for EV1.
- `--partial`: Allow source data size to differ from tag capacity.

### nfc-mfsetuid
Set UID on special Chinese clone cards.
- `-h`: Help.
- `-f`: Format (set all to 0xFF, reset ACLs).
- `-q`: Quiet mode.
- `[UID|BLOCK0]`: 4 HEX bytes for UID or 16 HEX bytes for Block0.

### nfc-jewel
Jewel/Topaz tag tool.
`Usage: nfc-jewel r|w DUMP`
- `r|w`: Read or Write.
- `DUMP`: Jewel Dump (JWD) file.

### nfc-emulate-uid
- `-q`: Quiet mode (improves timing).
- `[UID]`: 8 HEX digits (default: DEADBEEF).

### nfc-emulate-forum-tag4
- `-1`: Force Tag Type 4 v1.0 (default is v2.0).
- `[infile [outfile]]`: Input/output NDEF files.

### nfc-read-forum-tag3
- `-o FILE`: Extract NDEF message to file (or `-` for stdout).
- `-q`: Quiet mode.

### nfc-relay-picc
- `-q`: Quiet mode.
- `-t`: Target mode only (reader side).
- `-i`: Initiator mode only (tag side).
- `-s`: Swap roles of found devices.
- `-n N`: Add N seconds delay to mimic distance.

### nfc-scan-device
- `-v`: Verbose.
- `-i`: Intrusive scan.

### nfc-anticol
- `-q`: Quiet mode.
- `-f`: Force RATS.
- `-t`: Measure response time in cycles.

### nfc-barcode
- `-q`: Verbose mode.

### pn53x-tamashell
Interactive shell for TAMA (PN53x) commands.
- `[script]`: Optional script file.
- `p N`: Pause N milliseconds.
- `q`: Quit.
- Input: Hexadecimal notation (e.g., `02` for GetFirmware).

### Other Utilities
- `nfc-poll`: Poll first available target (`-v` for verbose).
- `nfc-emulate-forum-tag2`: Emulates NFC Forum Type 2 (NDEF).
- `nfc-emulate-tag`: Emulates a Mifare Mini.
- `nfc-relay`: General relay attack tool (`-q` for quiet).
- `nfc-dep-initiator`: D.E.P. initiator demo.
- `nfc-dep-target`: D.E.P. target demo.
- `pn53x-diagnose`: PN53x hardware diagnostic.
- `pn53x-sam`: Test Secure Access Module connection.

## Notes
- **Hardware**: ACR122U devices often require unplugging/replugging if an emulation session fails due to the internal MCU.
- **Timing**: Use Quiet mode (`-q`) in emulation/relay tasks to reduce latency.
- **Safety**: Writing to Jewel or MIFARE tags can be permanent (lock bits). Ensure you have backups of original dumps.
- **Clones**: `nfc-mfclassic` unlocked commands (`R`, `W`) and `nfc-mfsetuid` only work on "Magic" Chinese clone cards.