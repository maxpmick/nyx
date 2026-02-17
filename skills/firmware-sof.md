---
name: firmware-sof
description: Provide and manage Intel Sound Open Firmware (SOF) and topology binaries required for audio functionality on modern Intel-based systems. Use when troubleshooting missing audio hardware, resolving "no sound card found" errors on Intel laptops, or performing hardware-level forensics and firmware analysis on Intel audio DSPs.
---

# firmware-sof

## Overview
The Intel Sound Open Firmware (SOF) project provides an open-source audio DSP firmware and SDK for Intel platforms. This package contains the pre-built and signed binaries (firmware and topologies) necessary for the Linux kernel to initialize and operate audio hardware on many modern Intel systems (e.g., Cannon Lake, Ice Lake, Tiger Lake, Alder Lake). Category: Hardware Support / Firmware.

## Installation (if not already installed)

The firmware is typically included in Kali Linux metapackages, but if audio hardware is not detected, install it manually:

```bash
sudo apt update
sudo apt install firmware-sof-signed
```

After installation, a reboot or a reload of the sound driver modules is usually required:
```bash
sudo modprobe -r snd_sof_pci_intel_tgl && sudo modprobe snd_sof_pci_intel_tgl
```
*(Note: Module names vary by CPU generation, e.g., `tgl` for Tiger Lake, `cnl` for Cannon Lake).*

## Common Workflows

### Verify Firmware Loading
Check the kernel ring buffer to see if the SOF firmware is loading correctly or if it is missing specific files.
```bash
sudo dmesg | grep -i sof
```

### List Installed Firmware Files
View the installed firmware and topology binaries to verify versioning or presence of specific platform support.
```bash
ls -R /lib/firmware/intel/sof/
ls -R /lib/firmware/intel/sof-tplg/
```

### Troubleshooting Audio Hardware
If the sound card is not detected, ensure the signed firmware package is present and check for "firmware load failed" errors in the logs.
```bash
journalctl -k | grep -Ei "sof|audio|snd"
```

## Complete Command Reference

This package is a collection of firmware binaries rather than an interactive CLI tool. It provides files to the kernel's firmware loader.

### File Locations

| Path | Description |
|------|-------------|
| `/lib/firmware/intel/sof/` | Contains the signed `.ri` or `.bin` firmware files for various Intel DSP generations. |
| `/lib/firmware/intel/sof-tplg/` | Contains the audio topology files (`.tplg`) which define the audio pipeline and components. |

### Related Kernel Modules
The following modules interact with these firmware files:
- `snd_sof`: Core SOF driver.
- `snd_sof_pci`: PCI bus glue for SOF.
- `snd_sof_intel_hda_common`: Common code for Intel HDA platforms.
- `snd_sof_pci_intel_cnl`: Support for Cannon Lake.
- `snd_sof_pci_intel_icl`: Support for Ice Lake.
- `snd_sof_pci_intel_tgl`: Support for Tiger Lake.
- `snd_sof_pci_intel_adl`: Support for Alder Lake.

## Notes
- **Hardware Specific**: This firmware is only relevant for Intel platforms using the Sound Open Firmware architecture. Older Intel systems use `firmware-intel-sound`.
- **Signed Binaries**: The `firmware-sof-signed` package contains binaries signed by Intel, which are required for systems with Secure Boot or hardware-enforced firmware signature verification.
- **Kernel Requirement**: SOF requires a relatively modern Linux kernel (typically 5.2+) to function correctly.