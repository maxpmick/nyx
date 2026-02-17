---
name: gqrx-sdr
description: Software defined radio (SDR) receiver and GUI application for monitoring radio frequencies. It supports AM/FM/SSB demodulation, FFT spectrum analysis, waterfall displays, and AFSK1200 decoding. Use when performing wireless reconnaissance, signal analysis, RF monitoring, or intercepting radio communications during wireless security assessments.
---

# gqrx-sdr

## Overview
Gqrx is a software defined radio (SDR) receiver implemented using GNU Radio and the Qt GUI toolkit. It functions as a wideband receiver for hardware supported by `gr-osmosdr` (RTL-SDR, HackRF, Airspy, etc.). It features FFT plots, spectrum waterfalls, and can interact with external applications via network sockets. Category: Wireless Attacks / Reconnaissance.

## Installation (if not already installed)
Assume gqrx is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install gqrx-sdr
```

**Note:** It is strongly recommended to run `volk_profile` before running gqrx to enable processor-specific optimizations for better performance.

## Common Workflows

### Launch with default configuration
```bash
gqrx
```
If it is the first run, a device configuration dialog will appear to select your SDR hardware.

### List available configurations
```bash
gqrx --list
```
Displays all saved configuration profiles.

### Launch with a specific configuration file
```bash
gqrx --conf my_sdr_setup.conf
```

### Reset configuration and reconfigure device
```bash
gqrx --reset
```
Useful if the hardware setup has changed or the application fails to start due to a configuration error.

## Complete Command Reference

```
gqrx [OPTIONS]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display the help page and exit. |
| `-s`, `--style <style>` | Use the given GUI style. Supported styles: `fusion`, `windows`. |
| `-l`, `--list` | List existing configuration files. |
| `-c`, `--conf <file>` | Start the application using a specific configuration file. |
| `-e`, `--edit` | Open the configuration file for editing before starting the application. |
| `-r`, `--reset` | Reset the configuration file to default settings. |

## Notes
- **Hardware Support:** Works with Funcube Dongle, RTL-SDR, Airspy, HackRF, BladeRF, RFSpace, USRP, and SoapySDR.
- **Troubleshooting:** If your device is not listed, check udev rules, ensure kernel drivers (like `dvb_usb_rtl28xxu`) are not blocking access, and verify the device with tools like `rtl_test` or `hackrf_info`.
- **Decoding:** Includes a built-in AFSK1200 decoder for AX.25 packets and supports RDS (Radio Data System) in Wideband FM mode.
- **Remote Interaction:** Supports network sockets for interacting with external applications.