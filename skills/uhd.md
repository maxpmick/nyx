---
name: uhd
description: Interface and manage Ettus Research USRP (Universal Software Radio Peripheral) devices. Use for SDR (Software Defined Radio) operations including device discovery, firmware/FPGA image management, hardware calibration, and RFNoC image building. Essential for wireless security auditing, signal analysis, and RF exploitation.
---

# uhd

## Overview
The Universal Hardware Driver (UHD) is the host driver for all Ettus Research products. It provides the necessary tools and libraries to communicate with USRP hardware for receiving and transmitting radio signals. Category: Wireless Attacks / SDR.

## Installation (if not already installed)
UHD tools are typically pre-installed in Kali Linux. If missing:
```bash
sudo apt update
sudo apt install uhd-host
```

## Common Workflows

### Device Discovery and Information
Locate connected USRP devices and verify their configuration:
```bash
uhd_find_devices
uhd_usrp_probe --args "addr=192.168.10.2"
```

### Firmware and FPGA Management
Download the latest images and flash a device:
```bash
uhd_images_downloader
uhd_image_loader --args "type=usrp2,addr=192.168.10.2" --fpga-path="/path/to/image.bit"
```

### Hardware Calibration
Calibrate RX/TX IQ balance to improve signal quality:
```bash
uhd_cal_rx_iq_balance --args "addr=192.168.10.2"
uhd_cal_tx_dc_offset --args "addr=192.168.10.2"
```

### RFNoC Module Creation
Create a new Out-of-Tree (OOT) RFNoC module:
```bash
rfnoc_modtool create my_module
```

## Complete Command Reference

### uhd_find_devices
Discovery utility for USRP hardware.
- `--help`: Show help message.
- `--args arg`: Device address arguments (e.g., `addr=192.168.10.2`).

### uhd_usrp_probe
Detailed peripheral report utility.
- `--help`: Show help message.
- `--version`: Print version string.
- `--args arg`: Device address arguments.
- `--tree`: Print complete property tree.
- `--string arg`: Query a string value from the property tree.
- `--double arg`: Query a double precision floating point value.
- `--int arg`: Query an integer value.
- `--sensor arg`: Query a sensor value.
- `--range arg`: Query a range (gain, bandwidth, frequency, etc.).
- `--vector`: Interpret string query as std::vector.
- `--init-only`: Skip queries, only initialize device.
- `--interactive-reg-iface arg`: Spawn shell to peek/poke registers (RFNoC only).

### uhd_images_downloader
Firmware and FPGA image retrieval tool.
- `-t, --types TYPES`: RegEx to select image sets (e.g., `x3.*`).
- `-i, --install-location LOC`: Custom install location.
- `-m, --manifest-location LOC`: Custom manifest location.
- `-I, --inventory-location LOC`: Custom inventory location.
- `-l, --list-targets`: Print available targets.
- `--url-only`: Only print URLs when listing.
- `--buffer-size SIZE`: Set download buffer size (default: 8192).
- `--download-limit LIMIT`: Threshold for approval (default: 1GB).
- `--http-proxy PROXY`: Specify HTTP(S) proxy.
- `-b, --base-url URL`: Set base URL for downloads.
- `-k, --keep`: Keep archives after extraction.
- `-T, --test`: Verify archives before extraction.
- `-y, --yes`: Answer yes to all questions.
- `-n, --dry-run`: Print targets without downloading.
- `--refetch`: Ignore inventory and download all.
- `-q, --quiet` / `-v, --verbose`: Adjust verbosity.

### uhd_image_loader
Flash firmware/FPGA images to devices.
- `--args arg`: Device and loader arguments.
- `--fw-path arg`: Path to firmware.
- `--fpga-path arg`: Path to FPGA image.
- `--out-path arg`: Output path for downloaded .bit file.
- `--no-fw`: Skip firmware burning.
- `--no-fpga`: Skip FPGA burning.
- `--download`: Download image to a file.

### usrpctl
High-level peripheral configuration tool.
- `id`: Identifies device.
- `find`: Print devices found.
- `probe`: Report detailed info.
- `reset`: Reset subcomponents.
- `-v`: Increase verbosity (-v to -vvvvv).

### Calibration Tools
- **uhd_adc_self_cal**: `--args arg` (Device address).
- **uhd_cal_rx_iq_balance / uhd_cal_tx_dc_offset / uhd_cal_tx_iq_balance**:
    - `--verbose`: Enable verbose output.
    - `--args arg`: Device address.
    - `--subdev arg`: Subdevice (e.g., 'A').
    - `--tx_wave_freq arg`: Transmit wave frequency (Hz).
    - `--tx_wave_ampl arg`: Transmit wave amplitude.
    - `--tx_gain arg`: Tx gain in dB.
    - `--rx_offset / --tx_offset arg`: LO offset in Hz.
    - `--freq_start / --freq_stop / --freq_step arg`: Sweep parameters.
    - `--nsamps arg`: Samples per capture.
    - `--precision arg`: Correction precision (default 0.0001).

### rfnoc_modtool
RFNoC OOT module management.
- `add`: Add block based on descriptor.
- `create`: Create new module.
- `add-gr-oot`: Add GNU Radio OOT module.
- `make-yaml`: YAML creation wizard.
- `add-grc`: Add GRC bindings.
- `add-gr-block`: Add GNU Radio block for RFNoC block.
- `-C DIRECTORY`: Change directory.
- `-l LOG_LEVEL`: Set log level.

### rfnoc_image_builder
Build UHD images with RFNoC blocks.
- `-y, --yaml-config`: Path to YML config.
- `-r, --grc-config`: Path to GRC file.
- `-d, --device`: Device type (x300, n310, etc.).
- `-t, --target`: Specific build target (e.g., X310_HG).
- `-j, --jobs`: Parallel make jobs.
- `-p, --vivado-path`: Path to Xilinx Vivado.
- `-G, --generate-only`: Generate files without building.
- `-R, --reuse`: Reuse existing files.
- `-s, --save-project`: Save Vivado project.

### usrp2_card_burner
N-Series FPGA/Firmware burner.
- `--dev=DEV`: Raw device path.
- `--fw=FW`: Firmware path.
- `--fpga=FPGA`: FPGA path.
- `--list`: List raw devices.
- `--force`: Override safety checks.

## Notes
- Ensure you have the correct permissions (often requires `sudo` or udev rules) to access USRP hardware via USB or Network.
- Network-based USRPs (N-series, X-series) usually default to IP `192.168.10.2`.
- Always run `uhd_images_downloader` after updating the `uhd-host` package to ensure compatibility between host drivers and device firmware.