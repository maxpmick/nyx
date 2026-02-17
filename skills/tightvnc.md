---
name: tightvnc
description: A remote display system that allows viewing and interacting with a computing desktop environment over the network. Includes a VNC server (tightvncserver), a viewer (xtightvncviewer), and password management tools. Use for remote administration, graphical session access, or during exploitation to interact with a compromised system's GUI.
---

# tightvnc

## Overview
TightVNC is a suite of tools for Virtual Network Computing (VNC) optimized for low-bandwidth connections. It includes `tightvncserver` (a wrapper to launch the X server), `Xtightvnc` (the actual server), `xtightvncviewer` (the client), and `vncpasswd` (password management). Category: Exploitation / Remote Access.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install tightvncserver xtightvncviewer tightvncpasswd
```

## Common Workflows

### Start a VNC Server
```bash
tightvncserver :1 -geometry 1280x800 -depth 24
```
Starts a session on display :1 (port 5901).

### Connect to a Remote VNC Server
```bash
xtightvncviewer 192.168.1.50:1
```

### Create an Encrypted Tunnel via SSH
```bash
xtightvncviewer -via user@gateway 10.0.0.5:1
```

### Generate a Password File Non-Interactively
```bash
echo "password123" | vncpasswd -f > my_vnc_pass
```

## Complete Command Reference

### tightvncpasswd / vncpasswd
Used to create and change passwords for TightVNC server authentication.

| Flag | Description |
|------|-------------|
| `[file]` | Specify custom password file (default: `$HOME/.vnc/passwd`) |
| `-t` | Write passwords into `/tmp/$USER-vnc/passwd` (mode 700) |
| `-f` | Filter mode: Read plain-text from stdin, write encrypted to stdout |

### tightvncserver
A wrapper script to launch `Xtightvnc`.

| Flag | Description |
|------|-------------|
| `:<DISPLAY#>` | Specify display number (e.g., `:1`) |
| `-kill :<DISPLAY#>` | Terminate the VNC server running on the specified display |
| `-name <NAME>` | Set VNC desktop name |
| `-depth <DEPTH>` | Set framebuffer depth (bits per pixel) |
| `-geometry <WxH>` | Set framebuffer width and height |
| `-httpport <num>` | Port for HTTP server |
| `-basehttpport <num>` | Base port for HTTP |
| `-alwaysshared` | Always treat new clients as shared |
| `-nevershared` | Never treat new clients as shared |
| `-pixelformat <fmt>` | Set pixel format (rgbNNN or bgrNNN) |

### Xtightvnc
The backend X server. Accepts all standard X server options plus VNC-specific ones.

| Flag | Description |
|------|-------------|
| `-geometry WxH` | Set framebuffer width & height |
| `-depth D` | Set framebuffer depth |
| `-pixelformat fmt` | Set pixel format (BGRnnn or RGBnnn) |
| `-rfbport port` | TCP port for RFB protocol (VNC) |
| `-rfbwait time` | Max time in ms to wait for RFB client |
| `-rfbauth file` | Use authentication password file |
| `-nocursor` | Don't put up a cursor |
| `-httpd dir` | Serve files via HTTP from this directory |
| `-httpport port` | Port for HTTP |
| `-deferupdate ms` | Time to defer updates (default 40) |
| `-economictranslate` | Less memory-hungry translation |
| `-lazytight` | Disable "gradient" filter in tight encoding |
| `-desktop name` | VNC desktop name (default x11) |
| `-viewonly` | Let clients only view the desktop |
| `-localhost` | Only allow connections from localhost |
| `-interface ip` | Only bind to specified interface address |
| `-inetd` | Xvnc is launched by inetd |
| `-compatiblekbd` | Set META key = ALT key |

### xtightvncviewer
The VNC client application.

| Flag | Description |
|------|-------------|
| `-help` | Print usage notice |
| `-listen [disp]` | Listen on port 5500+display for reverse connections |
| `-via gateway` | Create encrypted TCP tunnel via SSH gateway |
| `-shared` | Request shared connection (default) |
| `-noshared` | Request non-shared session |
| `-viewonly` | Disable mouse/keyboard event transfer |
| `-fullscreen` | Start in full-screen mode |
| `-noraiseonbeep` | Do not raise window on remote bell |
| `-passwd file` | File containing the encrypted password |
| `-autopass` | Read plain-text password from stdin |
| `-encodings "list"` | Preferred encodings (copyrect, tight, hextile, zlib, corre, rre, raw) |
| `-compresslevel 0-9` | Compression level for tight/zlib (1=fast, 9=best) |
| `-quality 0-9` | JPEG quality for tight encoding (0=bad/small, 9=good/large) |
| `-nojpeg` | Disable lossy JPEG compression |
| `-nocursorshape` | Disable local cursor shape updates |
| `-x11cursor` | Use real X11 cursor |
| `-bgr233` | Always use BGR233 8-bit format |
| `-owncmap` | Use a private colormap |
| `-truecolor` | Try to use TrueColor visual |
| `-depth depth` | Request specific bit depth from server |

### tightvncconnect
Tells a running VNC server to connect to a listening viewer (Reverse VNC).

```bash
tightvncconnect [-display Xvnc-display] host[:port]
```

## Notes
- **Security**: VNC traffic is unencrypted by default. Always use the `-via` option or an SSH tunnel (`-L 5901:localhost:5901`) for remote connections over untrusted networks.
- **Passwords**: Only the first 8 characters of a VNC password are significant.
- **Display Ports**: VNC display `:1` corresponds to TCP port `5901`, `:2` to `5902`, etc.
- **F8 Key**: In the viewer, press `F8` to access the utility menu (toggle full-screen, disconnect, etc.).