---
name: libfreefare
description: Manipulate MIFARE RFID cards including Classic, DESFire, and Ultralight types. Use when performing RFID reconnaissance, cloning tags, reading/writing NDEF messages, or formatting tags for NFC compatibility during physical security assessments and wireless testing.
---

# libfreefare

## Overview
The libfreefare project provides a suite of command-line utilities for interacting with MIFARE RFID cards. It supports various card families including MIFARE Classic, DESFire (EV1), and Ultralight. Category: Wireless Attacks / RFID.

## Installation (if not already installed)
Assume the tools are installed. If commands are missing:

```bash
sudo apt install libfreefare-bin
```

## Common Workflows

### Format a MIFARE Classic card
```bash
mifare-classic-format -y
```

### Read NDEF data from a DESFire card
```bash
mifare-desfire-read-ndef -o data.ndef
```

### Write an NDEF message to a MIFARE Classic card
```bash
mifare-classic-write-ndef -i message.ndef
```

### Get information from a DESFire card
```bash
mifare-desfire-info
```

## Complete Command Reference

### MIFARE Classic Tools

#### mifare-classic-format
Format a MIFARE Classic card.
- `-f`: Fast format (only erase MAD).
- `-y`: Do not ask for confirmation (dangerous).
- `keyfile`: Use keys from dump in addition to internal default keys.

#### mifare-classic-read-ndef
Extract NDEF message from a MIFARE Classic card.
- `-y`: Do not ask for confirmation.
- `-o FILE`: Extract NDEF message if available in FILE.

#### mifare-classic-write-ndef
Write NDEF message to a MIFARE Classic card.
- `-y`: Do not ask for confirmation.
- `-i FILE`: Use FILE as NDEF message to write on card ("-" = stdin).

### MIFARE DESFire Tools

#### mifare-desfire-info
Display information about a MIFARE DESFire target.
- No additional flags.

#### mifare-desfire-format
Format a MIFARE DESFire card.
- `-y`: Do not ask for confirmation (dangerous).
- `-K <KEY>`: Provide another PICC key than the default one (16 hex chars).

#### mifare-desfire-create-ndef
Turn MIFARE DESFire targets into NFC Forum Type 4 Tags.
- `-y`: Do not ask for confirmation.
- `-K <KEY>`: Provide another PICC key than the default one.

#### mifare-desfire-read-ndef
Read NDEF payload from a MIFARE DESFire formatted as NFC Forum Type 4 Tag.
- `-y`: Do not ask for confirmation.
- `-o FILE`: Extract NDEF message if available in FILE.
- `-k <KEY>`: Provide another NDEF Tag Application key than the default one.

#### mifare-desfire-write-ndef
Write NDEF payload into a MIFARE DESFire formatted as NFC Forum Type 4 Tag.
- `-y`: Do not ask for confirmation.
- `-i FILE`: Use FILE as NDEF message to write on card ("-" = stdin).
- `-k <KEY>`: Provide another NDEF Tag Application key than the default one.

#### mifare-desfire-access
Manage access to MIFARE DESFire targets.
- No additional flags.

#### mifare-desfire-ev1-configure-ats
Configure Answer To Select (ATS) for DESFire EV1.
- `-y`: Do not ask for confirmation (dangerous).
- `-K <KEY>`: Provide another PICC key than the default one.

#### mifare-desfire-ev1-configure-default-key
Configure the default key for DESFire EV1.
- `-y`: Do not ask for confirmation.

#### mifare-desfire-ev1-configure-random-uid
Configure random UID for DESFire EV1.
- `-y`: Do not ask for confirmation (dangerous).
- `-K <KEY>`: Provide another PICC key than the default one.

### MIFARE Ultralight Tools

#### mifare-ultralight-info
Display information about a MIFARE Ultralight target.
- No additional flags.

## Notes
- These tools require a compatible NFC reader (supported by `libnfc`) to be connected to the system.
- The `-y` flag bypasses safety prompts; use with caution as it can overwrite or lock tags permanently.
- Default keys are used unless specified with `-K` or `-k`.