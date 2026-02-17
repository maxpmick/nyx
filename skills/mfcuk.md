---
name: mfcuk
description: Recover keys from MiFare Classic RFID cards using the "DarkSide" attack. This tool exploits weaknesses in the MiFare Classic protocol to recover keys even when no known keys are available (zero-knowledge). Use when performing RFID security assessments, cloning MiFare Classic 1K/4K cards, or testing for protocol vulnerabilities in contactless smart cards.
---

# mfcuk

## Overview
mfcuk (MiFare Classic Universal toolKit) is a key recovery tool for MiFare Classic RFID tags. It implements the "DarkSide" attack, which allows for the recovery of keys from a tag without knowing any valid keys beforehand. It is based on `libnfc` and `crapto1`. Category: Wireless Attacks / RFID.

## Installation (if not already installed)
Assume mfcuk is already installed. If you get a "command not found" error:

```bash
sudo apt install mfcuk
```

## Common Workflows

### Recover all keys from all sectors
The most common use case for a blank or unknown tag.
```bash
mfcuk -C -R -1
```

### Recover a specific sector key with custom delays
Increasing delays can sometimes improve reliability on certain readers or tags.
```bash
mfcuk -C -R 0 -s 250 -S 250
```

### Recover key from a Proxmark3 sniffed conversation
If you have captured a handshake using a Proxmark3.
```bash
mfcuk -P 0x5c72325e:0x50829cd6:0xb8671f76:0xe00eefc9:0x4888964f
```

### Verify keys against a tag using default keys
```bash
mfcuk -C -V -1 -D
```

## Complete Command Reference

### Connection and Input/Output
| Flag | Description |
|------|-------------|
| `-C` | Require explicit connection to the reader. Required for recovery to occur. |
| `-i <file>` | Load input `mifare_classic_tag` type dump. |
| `-I <file>` | Load input extended dump specific to mfcuk (contains extra fields). |
| `-o <file>` | Output resulting `mifare_classic_tag` dump to file. |
| `-O <file>` | Output resulting extended dump to file. |

### Recovery and Verification
| Flag | Description |
|------|-------------|
| `-V <sector[:A/B/any[:key]]>` | Verify key for specified sector (`-1` for all). Optional: specify key type (A/B) and a 12-hex-digit key to override dump keys. |
| `-R <sector[:A/B/any]>` | Recover key for sector (`-1` for all). Optional: specify key type (A/B). |
| `-D` | Use default keys to verify sectors/key-types marked for verification. |
| `-d <key>` | Specify an additional 12-hex-digit default key to check. Can be used multiple times. |

### Tag Configuration
| Flag | Description |
|------|-------------|
| `-U <UID>` | Force a specific UID. Overwrites UID if a dump was loaded with `-i`. |
| `-M <type>` | Force specific tag type: `8` (1K), `24` (4K), `32` (DESFire). |
| `-F` | Fingerprint the input dump (`-i`) against known cards' data formats. |

### Timing and Sniffing
| Flag | Description |
|------|-------------|
| `-s <ms>` | Milliseconds to sleep for `SLEEP_AT_FIELD_OFF` (Default: 10). |
| `-S <ms>` | Milliseconds to sleep for `SLEEP_AFTER_FIELD_ON` (Default: 50). |
| `-P <hex>` | Recover key from Proxmark3 sniffed conversation. Format: `uid:tag_chal:nr_enc:reader_resp:tag_resp`. |
| `-p <file>` | Parse a Proxmark3 log file to extract values for the `-P` option automatically. |

### Miscellaneous
| Flag | Description |
|------|-------------|
| `-v <level>` | Set verbosity level (Default: 0). |
| `-h` | Display help and usage information. |

## Notes
- **Hardware**: Requires a `libnfc` compatible reader (e.g., ACR122U).
- **Attack Type**: The DarkSide attack is a "zero-knowledge" attack but can be slow and timing-dependent. If you already know at least one key (e.g., sector 0), tools like `mfoc` are generally faster.
- **Tag Types**: Primarily targets MiFare Classic 1K and 4K tags. Success on "Hardened" MiFare cards is not guaranteed.