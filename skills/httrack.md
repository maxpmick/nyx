---
name: httrack
description: Copy websites to a local directory for offline browsing, building recursive directory structures and preserving relative links. Use for website mirroring, web application reconnaissance, offline analysis of target sites, and archiving web content during penetration testing or digital forensics.
---

# httrack

## Overview
HTTrack is an offline browser utility that allows you to download a World Wide Web site from the Internet to a local directory. It builds recursively all directories, fetching HTML, images, and other files. It preserves the original site's relative link-structure, allowing for seamless offline navigation. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
Assume HTTrack is already installed. If not:
```bash
sudo apt install httrack
```

## Common Workflows

### Basic Website Mirror
```bash
httrack http://www.example.com/ -O /tmp/websites/example
```
Mirrors the site into the specified output directory.

### Mirror with Filters and Depth
```bash
httrack http://www.example.com/ +*.com/*.jpg -mime:application/* -r3
```
Mirrors the site with a depth of 3, including all JPG files from .com domains but excluding application MIME types.

### Update an Existing Mirror
```bash
cd /path/to/existing/mirror && httrack --update
```
Updates the mirror in the current folder without re-downloading unchanged files.

### Spider Mode (Link Testing)
```bash
httrack http://www.example.com/ --spider
```
Tests links and reports errors/warnings without downloading the full site content.

## Complete Command Reference

### Usage
```bash
httrack <URLs> [-option] [+<URL_FILTER>] [-<URL_FILTER>] [+<mime:MIME_FILTER>] [-<mime:MIME_FILTER>]
```

### General Options
| Flag | Description |
|------|-------------|
| `-O` | Path for mirror/logfiles+cache (`-O path_mirror[,path_cache_and_logfiles]`) |
| `--path <param>` | Long form of `-O` |

### Action Options
| Flag | Description |
|------|-------------|
| `-w` | Mirror web sites (default) |
| `-W` | Mirror web sites, semi-automatic (interactive) |
| `-g` | Just get files (saved in current directory) |
| `-i` | Continue an interrupted mirror using the cache |
| `-Y` | Mirror ALL links located in the first level pages |

### Proxy Options
| Flag | Description |
|------|-------------|
| `-P` | Proxy use (`-P proxy:port` or `-P user:pass@proxy:port`) |
| `%f` | Use proxy for FTP (`%f0` to disable) |
| `%b` | Use local hostname to make/send requests |

### Limits Options
| Flag | Description |
|------|-------------|
| `-rN` | Set mirror depth to N (default: 9999) |
| `%eN` | Set external links depth to N (default: 0) |
| `-mN` | Max file length for non-html file |
| `-mN,N2` | Max file length for non-html (N) and html (N2) |
| `-MN` | Maximum overall size that can be uploaded/scanned |
| `-EN` | Maximum mirror time in seconds (e.g., 3600=1 hour) |
| `-AN` | Maximum transfer rate in bytes/seconds (1000=1KB/s) |
| `%cN` | Max number of connections/seconds (default: 10) |
| `-GN` | Pause transfer if N bytes reached until lock file is deleted |

### Flow Control
| Flag | Description |
|------|-------------|
| `-cN` | Number of multiple connections (default: 8) |
| `-TN` | Timeout in seconds for non-responding links |
| `-RN` | Number of retries for timeouts/errors (default: 1) |
| `-JN` | Traffic jam control: minimum transfer rate tolerated |
| `-HN` | Host abandoned if: 0=never, 1=timeout, 2=slow, 3=both |

### Links Options
| Flag | Description |
|------|-------------|
| `%P` | Extended parsing (Javascript/unknown tags). `%P0` to disable |
| `-n` | Get non-html files 'near' an html file (outside directory) |
| `-t` | Test all URLs (including forbidden ones) |
| `%L <file>` | Add all URLs located in text file (one per line) |
| `%S <file>` | Add all scan rules located in text file |

### Build Options
| Flag | Description |
|------|-------------|
| `-NN` | Structure type (0=original, 1-105=predefined, or custom) |
| `%N` | Delayed type check (%N0=none, %N1=unknown, %N2=always) |
| `%D` | Cached delayed type check for updates (%D1=don't wait) |
| `%M` | Generate RFC MIME-encapsulated full-archive (.mht) |
| `-LN` | Long names (L1=long, L0=8.3, L2=ISO9660) |
| `-KN` | Link type (K0=relative, K=absolute, K4=original) |
| `-x` | Replace external html links by error pages |
| `%x` | Disable passwords for external websites |
| `%q` | Include query string for local files |
| `-o` | Generate output html file in case of error (404) |
| `-X` | Purge old files after update (`-X0` to keep) |
| `%p` | Preserve html files 'as is' |
| `%T` | Links conversion to UTF-8 |

### Spider Options
| Flag | Description |
|------|-------------|
| `-bN` | Accept cookies (0=no, 1=yes) |
| `-u` | Check document type if unknown (u0=no, u1=/, u2=always) |
| `-sN` | Follow robots.txt (0=never, 1=sometimes, 2=always, 3=strict) |
| `%h` | Force HTTP/1.0 requests |
| `%k` | Use HTTP Keep-Alive if possible |
| `%B` | Tolerant requests (accept bogus responses) |
| `%s` | Update hacks (limit re-transfers) |
| `%u` | URL hacks (strip //, www. duplication) |
| `%A` | Assume mime type (e.g., `-%A php3=text/html`) |
| `@iN` | Protocol (0=both, 4=IPv4, 6=IPv6) |

### Browser ID Options
| Flag | Description |
|------|-------------|
| `-F` | User-agent string |
| `%R` | Referer field |
| `%E` | From email address |
| `%F` | Footer string in HTML code |
| `%l` | Preferred language (e.g., "en, fr") |
| `%a` | Accepted formats (MIME types) |
| `%X` | Additional HTTP header line |

### Log, Index, Cache
| Flag | Description |
|------|-------------|
| `-C` | Cache usage (C0=none, C1=priority, C2=test update) |
| `-k` | Store all files in cache |
| `%n` | Do not re-download locally erased files |
| `%v` | Display filenames in realtime (%v1=short, %v2=full) |
| `-Q` | Quiet mode (no log) |
| `-q` | Quiet mode (no questions) |
| `-z` | Extra info in log |
| `-Z` | Debug log |
| `-v` | Verbose log on screen |
| `-f` | Log in files (default) |
| `-f2` | One single log file |
| `-I` | Make an index (default) |
| `%i` | Make a top index for project folder |
| `%I` | Make a searchable index |

### Expert & Dangerous Options
| Flag | Description |
|------|-------------|
| `-pN` | Priority mode (p0=scan only, p1=html only, p3=all) |
| `-S` | Stay on the same directory |
| `-D` | Can only go down into subdirs |
| `-U` | Can only go to upper directories |
| `-B` | Can go both up & down |
| `-a` | Stay on the same address |
| `-d` | Stay on the same principal domain |
| `-l` | Stay on the same TLD (.com, etc) |
| `-e` | Go everywhere on the web |
| `%!` | **DANGEROUS**: Bypass security/bandwidth limits |

### Shortcuts
- `--mirror`: `-w`
- `--get`: `-qg`
- `--list`: `-%L`
- `--mirrorlinks`: `-Y`
- `--testlinks`: `-r1p0C0I0t`
- `--spider`: `-p0C0I0t`
- `--skeleton`: `-p1`
- `--update`: `-iC2`
- `--continue`: `-iC1`
- `--clean`: Erase cache & log files

## ProxyTrack
Proxy server to serve content archived by HTTrack.
- **Usage**: `proxytrack <proxy-addr:port> <ICP-addr:port> [archive_files]`
- **Convert**: `proxytrack --convert <output_path> [archive_files]`

## WebHTTrack (htsserver)
Web interface for HTTrack.
- **Usage**: `htsserver [path/] [keyword value ...]`
- **Example**: `htsserver /usr/share/httrack/ path $HOME/websites lang 1` (then browse `http://localhost:8080/`)

## Notes
- **Security**: Use `%! --disable-security-limits` with extreme caution as it can overwhelm target servers and get your IP banned.
- **Structure**: The `-N` option is highly flexible for organizing how files are saved locally. `N1001` is often used to avoid creating a "web" subdirectory.
- **Robots**: By default, HTTrack respects `robots.txt`. Use `-s0` to ignore it (ensure legal authorization).