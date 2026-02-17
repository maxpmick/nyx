---
name: kali-wallpapers
description: Manage and install various collections of Kali Linux wallpapers from different release years, including legacy BackTrack backgrounds and mobile-specific versions. Use when customizing the desktop environment's appearance, restoring classic Kali aesthetics, or installing complete sets of official system backgrounds.
---

# kali-wallpapers

## Overview
A collection of packages providing official wallpapers for Kali Linux across different versions and eras. These packages allow users to install specific yearly themes or the entire historical catalog of Kali and BackTrack backgrounds. Category: Desktop Customization / System Aesthetics.

## Installation (if not already installed)

Wallpapers are installed via the APT package manager. To install the complete collection:

```bash
sudo apt update
sudo apt install kali-wallpapers-all
```

## Common Workflows

### Install the latest 2025 wallpaper set
```bash
sudo apt install kali-wallpapers-2025
```

### Restore classic BackTrack and early Kali wallpapers
```bash
sudo apt install kali-wallpapers-legacy
```

### Install wallpapers for mobile/NetHunter devices
```bash
sudo apt install kali-wallpapers-mobile-2023
```

### Clean up old wallpaper packages
If you have multiple yearly packages and only want the current one (keeping in mind `kali-themes-common` requires at least the latest):
```bash
sudo apt purge kali-wallpapers-2019.4 kali-wallpapers-2020.4
```

## Complete Package Reference

The following packages are available within the `kali-wallpapers` source:

| Package Name | Description |
|--------------|-------------|
| `kali-wallpapers-2025` | Default wallpapers for Kali Linux 2025 and newer releases. |
| `kali-wallpapers-2024` | Default wallpapers for Kali Linux 2024 and newer releases. |
| `kali-wallpapers-2023` | Default wallpapers for Kali Linux 2023 and newer releases. |
| `kali-wallpapers-2022` | Default wallpapers for Kali Linux 2022 and newer releases. |
| `kali-wallpapers-2020.4` | Wallpapers used in Kali Linux between versions 2020.4 and 2021.3. |
| `kali-wallpapers-2019.4` | Wallpapers used in Kali Linux between versions 2019.4 and 2020.3. |
| `kali-wallpapers-legacy` | Historical wallpapers and resources from BackTrack and early Kali Linux versions. |
| `kali-wallpapers-all` | Metapackage that installs every available wallpaper package listed above. |
| `kali-wallpapers-mobile-2023` | Specific wallpapers designed for Kali Linux Mobile (NetHunter) 2023 and newer. |
| `kali-legacy-wallpapers` | Transitional dummy package; installs `kali-wallpapers-legacy` for backward compatibility. |

## Notes
- **Storage:** The `kali-wallpapers-legacy` package is significantly larger (~139 MB) than the yearly releases as it contains a vast historical archive.
- **Dependencies:** The latest yearly wallpaper package is typically a dependency of `kali-themes-common`. Removing all wallpaper packages may trigger the removal of core desktop theme components.
- **File Location:** Once installed, wallpapers are typically located in `/usr/share/backgrounds/` or `/usr/share/wallpapers/`.