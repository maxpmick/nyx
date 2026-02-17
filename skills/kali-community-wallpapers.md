---
name: kali-community-wallpapers
description: Install and manage community-contributed wallpapers for the Kali Linux desktop environment. Use when customizing the visual appearance of the operating system, preparing a system for presentation, or installing aesthetic assets submitted by the Kali community.
---

# kali-community-wallpapers

## Overview
A collection of wallpapers created and submitted by the Kali Linux community. This package serves as a transitional dummy package that ensures the installation of `kali-wallpapers-community`, which contains the actual high-resolution image assets. Category: Customization / Desktop Environment.

## Installation (if not already installed)

Assume the wallpapers are already available in the system background settings. If they are missing or you need to ensure the latest community set is installed:

```bash
sudo apt update
sudo apt install kali-community-wallpapers
```

Note: `kali-community-wallpapers` is a transitional package. The actual assets are contained within `kali-wallpapers-community`.

## Common Workflows

### Install all community wallpapers
```bash
sudo apt install kali-wallpapers-community
```

### Locate installed wallpaper files
After installation, wallpapers are typically stored in the standard system backgrounds directory. You can list them to verify installation:
```bash
ls -l /usr/share/backgrounds/kali-community/
```

### Set wallpaper via command line (XFCE)
If using the default Kali XFCE desktop, you can script the wallpaper change:
```bash
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s /usr/share/backgrounds/kali-community/filename.png
```

## Complete Command Reference

This package does not provide a standalone CLI tool; it is a data package managed via the APT package manager.

### Package Management Commands

| Command | Description |
|---------|-------------|
| `sudo apt install kali-community-wallpapers` | Installs the transitional package and its dependencies. |
| `sudo apt install kali-wallpapers-community` | Installs the actual community-generated wallpaper assets. |
| `sudo apt remove kali-community-wallpapers` | Safely removes the dummy package (can be done once the main wallpaper package is installed). |

## Notes
- **Transitional Status**: `kali-community-wallpapers` is now a dummy package. The assets have been moved to the `kali-wallpapers` source package under the name `kali-wallpapers-community`.
- **Storage Location**: Images are generally installed to `/usr/share/backgrounds/`.
- **Desktop Integration**: Once installed, these wallpapers appear automatically in the "Desktop Settings" or "Appearance" menus of GNOME, XFCE, and KDE Plasma.