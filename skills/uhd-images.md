---
name: uhd-images
description: Manage and download firmware and FPGA images for USRP (Universal Software Radio Peripheral) devices. Use when setting up SDR hardware, resolving "UHD firmware mismatch" errors, or preparing a wireless testing environment involving Ettus Research hardware.
---

# uhd-images

## Overview
This package provides the necessary firmware and FPGA images for the USRP (Universal Software Radio Peripheral) family of devices. These images are required for the hardware to function correctly with the UHD (USRP Hardware Driver) software stack. Category: Wireless Attacks / SDR.

## Installation (if not already installed)
The images are typically installed via the package manager, but can also be fetched using the `uhd_images_downloader` utility provided by the `uhd-host` package.

```bash
sudo apt update
sudo apt install uhd-images
```

## Common Workflows

### Download all available images
Automatically fetches the latest compatible FPGA and firmware images for all supported USRP models.
```bash
sudo uhd_images_downloader
```

### Download images for a specific device
Reduces download time and storage by only fetching files for a specific hardware target (e.g., B200).
```bash
uhd_images_downloader -t b200
```

### Check installed image versions
Verify which images are currently available on the local system.
```bash
uhd_images_downloader --list-installed
```

## Complete Command Reference

The primary interface for managing these images is the `uhd_images_downloader` script.

### Usage
```bash
uhd_images_downloader [Options]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--list-installed` | List the images that are already installed on the system |
| `-i <directory>`, `--install-location=<directory>` | Set the custom directory where images should be installed |
| `-t <targets>`, `--targets=<targets>` | Specify specific hardware targets to download (comma-separated). Examples: `b200`, `x300`, `n200`, `octoclock` |
| `-u <url>`, `--url=<url>` | Specify a custom URL/base path to download images from |
| `-v`, `--verbose` | Enable verbose output for debugging download issues |
| `-q`, `--quiet` | Suppress non-error output during the download process |
| `--force` | Force download and overwrite existing images even if versions match |
| `--no-checksum` | Skip the MD5 checksum verification of downloaded files |
| `--buffer-size=<size>` | Set the download buffer size (default: 8192) |
| `--proxy=<proxy>` | Use a proxy for the download (e.g., `http://user:pass@proxy:port`) |

## Notes
- **Firmware Mismatch**: If you encounter an error stating "UHD Error: firmware compatible version (X.X) but found (Y.Y)", running `uhd_images_downloader` is the standard fix.
- **Storage**: The full image set can exceed 100MB. Use the `-t` flag if disk space or bandwidth is limited.
- **Permissions**: You may need `sudo` to write images to the default system directory (`/usr/share/uhd/images`).