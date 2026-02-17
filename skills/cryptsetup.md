---
name: cryptsetup
description: Configure and manage encrypted block devices using dm-crypt and LUKS. Use for disk encryption, creating encrypted partitions, managing LUKS keyslots, and handling VeraCrypt or BitLocker compatible devices. Essential for data protection, secure storage setup, and digital forensics involving encrypted volumes.
---

# cryptsetup

## Overview
Cryptsetup is the standard tool for configuring disk encryption in Linux using the dm-crypt kernel module. It supports LUKS (Linux Unified Key Setup), plain dm-crypt, loop-AES, VeraCrypt, and BitLocker formats. Category: Reconnaissance / Information Gathering (Forensics) / Protection.

## Installation (if not already installed)
Assume the tool is installed. If not:
```bash
sudo apt install cryptsetup cryptsetup-bin
```

## Common Workflows

### Format a partition with LUKS
```bash
sudo cryptsetup luksFormat /dev/sdb1
```

### Open an encrypted device
```bash
sudo cryptsetup open /dev/sdb1 my_encrypted_disk
# Device is now available at /dev/mapper/my_encrypted_disk
```

### Close an encrypted device
```bash
sudo cryptsetup close my_encrypted_disk
```

### Add a new recovery key to an existing device
```bash
sudo cryptsetup luksAddKey /dev/sdb1
```

### Dump LUKS header information (Forensics)
```bash
sudo cryptsetup luksDump /dev/sdb1
```

## Complete Command Reference

### cryptsetup Actions
| Action | Description |
|--------|-------------|
| `open <dev> <name>` | Open device as `/dev/mapper/<name>` |
| `close <name>` | Close device (remove mapping) |
| `resize <name>` | Resize active device |
| `status <name>` | Show device status |
| `benchmark` | Benchmark ciphers |
| `repair <dev>` | Try to repair on-disk metadata |
| `reencrypt <dev>` | Reencrypt LUKS2 device |
| `erase <dev>` | Erase all keyslots (remove encryption key) |
| `convert <dev>` | Convert LUKS from/to LUKS2 format |
| `config <dev>` | Set permanent configuration options for LUKS2 |
| `luksFormat <dev>` | Formats a LUKS device |
| `luksAddKey <dev>` | Add key to LUKS device |
| `luksRemoveKey <dev>` | Removes supplied key or key file |
| `luksChangeKey <dev>` | Changes supplied key or key file |
| `luksConvertKey <dev>` | Converts a key to new pbkdf parameters |
| `luksKillSlot <dev> <n>` | Wipes key in slot `<n>` |
| `luksUUID <dev>` | Print UUID of LUKS device |
| `isLuks <dev>` | Tests device for LUKS partition header |
| `luksDump <dev>` | Dump LUKS partition information |
| `tcryptDump <dev>` | Dump TCRYPT (TrueCrypt/VeraCrypt) info |
| `bitlkDump <dev>` | Dump BITLK (BitLocker) info |
| `fvault2Dump <dev>` | Dump FVAULT2 info |
| `luksSuspend <dev>` | Suspend device and wipe key from RAM |
| `luksResume <dev>` | Resume suspended LUKS device |
| `luksHeaderBackup <dev>` | Backup LUKS header and keyslots |
| `luksHeaderRestore <dev>` | Restore LUKS header and keyslots |
| `token <action> <dev>` | Manipulate LUKS2 tokens (add, remove, import, export) |

### cryptsetup Options
| Flag | Description |
|------|-------------|
| `--type <type>` | Metadata type: `luks`, `luks1`, `luks2`, `plain`, `loopaes`, `tcrypt`, `bitlk` |
| `-c, --cipher <str>` | Cipher used (e.g., `aes-xts-plain64`) |
| `-h, --hash <str>` | Hash used for key derivation |
| `-s, --key-size <bits>` | Encryption key size |
| `-y, --verify-passphrase` | Ask for passphrase twice |
| `-d, --key-file <file>` | Read key from file |
| `-S, --key-slot <int>` | Specify slot number |
| `-q, --batch-mode` | Do not ask for confirmation |
| `--allow-discards` | Allow TRIM requests |
| `--readonly` | Create a readonly mapping |
| `--header <file>` | Use detached LUKS header |
| `--pbkdf <type>` | PBKDF algorithm: `argon2i`, `argon2id`, `pbkdf2` |
| `--iter-time <ms>` | PBKDF iteration time |
| `--veracrypt` | Scan for VeraCrypt compatible device |
| `--veracrypt-pim <int>` | Provide VeraCrypt PIM |
| `--shared` | Share device with non-overlapping segment |

### integritysetup (Data Integrity)
Used for managing dm-integrity devices.
- `format <dev>`: Format device
- `open <dev> <name>`: Open device
- `close <name>`: Close device
- `status <name>`: Show status
- `dump <dev>`: Show on-disk info

### veritysetup (Read-only Integrity)
Used for managing dm-verity (hash tree) devices.
- `format <data_dev> <hash_dev>`: Format device
- `verify <data_dev> <hash_dev> [<root_hash>]`: Verify device
- `open <data_dev> <name> <hash_dev> [<root_hash>]`: Open device
- `close <name>`: Close mapping

### cryptsetup-ssh (Experimental)
Used to unlock LUKS2 devices via remote SSH keyfiles.
- `add <device>`: Add SSH token to device
- `--ssh-server <IP/URL>`: Remote server address
- `--ssh-user <user>`: Remote username
- `--ssh-keypath <path>`: Local SSH private key
- `--ssh-path <path>`: Remote path to the keyfile

### Helper Wrappers
- `cryptdisks_start <name>`: Starts mapping defined in `/etc/crypttab`.
- `cryptdisks_stop <name>`: Stops mapping defined in `/etc/crypttab`.
- `luksformat -t <fs> <device>`: Wrapper to create LUKS and format a filesystem in one step.

## Notes
- **DANGER**: `luksFormat` and `erase` will destroy data on the target partition.
- **Forensics**: Use `luksDump` to identify the encryption algorithm and PBKDF parameters before attempting brute force.
- **VeraCrypt**: When opening VeraCrypt volumes, use the `--veracrypt` flag with `cryptsetup open`.
- **Headers**: Always backup LUKS headers (`luksHeaderBackup`) as corruption makes data unrecoverable.