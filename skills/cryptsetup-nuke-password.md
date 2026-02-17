---
name: cryptsetup-nuke-password
description: Configure a "nuke password" for LUKS-encrypted partitions that, when entered at the boot prompt, destroys the encryption keys and makes data unreadable. Use when implementing anti-forensics measures, data protection strategies, or preparing a system for potential seizure where a stealthy data destruction mechanism is required.
---

# cryptsetup-nuke-password

## Overview
`cryptsetup-nuke-password` is a utility for LUKS-encrypted systems that allows the configuration of a special "nuke" passphrase. When this passphrase is entered at the early-boot decryption prompt instead of the valid unlocking password, the tool wipes all keyslots on the encrypted partition, effectively destroying access to the data. Category: Protect / Anti-Forensics.

## Installation (if not already installed)

Assume the tool is installed on Kali Linux by default. If missing:

```bash
sudo apt update
sudo apt install cryptsetup-nuke-password
```

## Common Workflows

### Initial Configuration
To set up or change the nuke password, use the debconf reconfiguration interface:
```bash
sudo dpkg-reconfigure cryptsetup-nuke-password
```
Follow the interactive prompts to enable the feature and define the secret nuke passphrase.

### Updating Initramfs
After configuring the nuke password, the initramfs must be updated to include the nuke logic in the boot process:
```bash
sudo update-initramfs -u -k all
```

### Testing (WARNING: DESTRUCTIVE)
Entering the nuke password at the boot prompt will permanently destroy the header keyslots. **Do not test this on production data without a verified header backup.**

## Complete Command Reference

The package primarily functions through a debconf configuration script and a hook in the initramfs process.

### Configuration Command

| Command | Description |
|---------|-------------|
| `dpkg-reconfigure cryptsetup-nuke-password` | Launches the interactive configuration wizard to enable/disable the nuke password and set the passphrase. |

### Internal Components
While not typically called directly by the user, these components handle the nuke logic:

| Component | Description |
|-----------|-------------|
| `/etc/initramfs-tools/hooks/cryptsetup-nuke-password` | Hook script that includes the nuke functionality into the initramfs image. |
| `/lib/cryptsetup/scripts/decrypt_derived` | (Contextual) Often used in conjunction with LUKS scripts to manage key derivation. |

## Notes
- **Irreversible**: Using the nuke password is a destructive action. Unless you have a backup of the LUKS header (`cryptsetup luksHeaderBackup`), the data is permanently lost.
- **Stealth**: The prompt for the nuke password is the same as the standard LUKS decryption prompt, providing no visual indication that a nuke password has been entered until the keys are wiped.
- **Scope**: The nuke password typically affects the partition(s) configured to be unlocked at boot via `/etc/crypttab`.
- **Dependencies**: Requires `cryptsetup` and a system using `initramfs-tools`.