---
name: recordmydesktop
description: Capture audio and video of a Linux desktop session into Ogg Theora/Vorbis files. Use when documenting proof of concept exploits, recording terminal sessions for reporting, or creating visual walkthroughs of security vulnerabilities during penetration testing and digital forensics.
---

# recordmydesktop

## Overview
A command-line tool for recording desktop sessions. It produces high-quality Ogg encapsulated Theora-Vorbis files and minimizes system impact by only processing changed screen regions. Category: Reporting / Information Gathering.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install recordmydesktop
```

## Common Workflows

### Record full screen with audio
```bash
recordmydesktop -o assessment_demo.ogv
```

### Record a specific window by ID
```bash
recordmydesktop --windowid $(xwininfo | grep "Window id:" | cut -d" " -f4)
```

### Record a specific region with no audio and a delay
```bash
recordmydesktop -x 100 -y 100 --width 800 --height 600 --no-sound --delay 5
```

### Rescue a crashed session
```bash
recordmydesktop --rescue /tmp/rmd-session-data -o recovered_video.ogv
```

## Complete Command Reference

```
recordmydesktop [OPTIONS]^filename
```

### Generic Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Print help message and exit |
| `--version` | Print program version and exit |
| `--print-config` | Print info about options selected during compilation |

### Image Options
| Flag | Description |
|------|-------------|
| `--windowid=id` | ID of the specific window to be recorded |
| `--display=DISPLAY` | Display to connect to |
| `-x, --x=N` | Offset in x direction (N >= 0) |
| `-y, --y=N` | Offset in y direction (N >= 0) |
| `--width=N` | Width of recorded window (N > 0) |
| `--height=N` | Height of recorded window (N > 0) |
| `--dummy-cursor=color` | Color of the dummy cursor [black\|white] |
| `--no-cursor` | Disable drawing of the cursor |
| `--no-shared` | Disable usage of MIT-shared memory extension (Not Recommended) |
| `--full-shots` | Take full screenshot at every frame (Not Recommended) |
| `--follow-mouse` | Capture area follows the mouse cursor (Auto-enables --full-shots) |
| `--quick-subsampling` | Subsampling of chroma planes by discarding instead of averaging |
| `--fps=N` | Positive number denoting desired framerate |

### Sound Options
| Flag | Description |
|------|-------------|
| `--channels=N` | Number of desired sound channels |
| `--freq=N` | Desired sound frequency |
| `--buffer-size=N` | Sound buffer size in frames (ALSA or OSS) |
| `--ring-buffer-size=N` | Ring buffer size in seconds (JACK only) |
| `--device=DEVICE` | Sound device (default: default) |
| `--use-jack=p1 p2...` | Record audio from specified space-separated JACK ports |
| `--no-sound` | Do not record sound |

### Encoding Options
| Flag | Description |
|------|-------------|
| `--on-the-fly-encoding` | Encode audio-video data while recording (higher CPU usage) |
| `--v_quality=n` | Video quality 0 to 63 (default: 63) |
| `--v_bitrate=n` | Video bitrate 0 to 200,000,000 (default: 0) |
| `--s_quality=n` | Audio quality -1 to 10 |

### Misc Options
| Flag | Description |
|------|-------------|
| `--rescue=path` | Encode data from a previous, crashed session |
| `--no-wm-check` | Do not try to detect the window manager |
| `--no-frame` | Do not show the frame visualizing the recorded area |
| `--pause-shortcut=M+K` | Shortcut for (un)pausing (default: Control+Mod1+p) |
| `--stop-shortcut=M+K` | Shortcut to stop recording (default: Control+Mod1+s) |
| `--compress-cache` | Cache image data with light compression |
| `--workdir=DIR` | Temporary directory for project files (default: $HOME) |
| `--delay=n[H\|h\|M\|m]` | Delay before capture starts (seconds, minutes, or hours) |
| `--overwrite` | Overwrite existing file instead of adding a postfix |
| `-o, --output=file` | Name of recorded video (default: out.ogv) |

## Notes
- If no options are specified, the filename can be provided as a trailing argument without the `-o` switch.
- By default, encoding happens *after* the recording is stopped to save CPU resources during capture.
- Use `xwininfo` to easily find the `windowid` of a target application.