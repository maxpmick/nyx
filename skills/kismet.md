---
name: kismet
description: Detect, sniff, and monitor wireless networks including Wi-Fi, Bluetooth, Zigbee, and SDR-based protocols. Use for wardriving, wireless intrusion detection (WIDS), and site surveys to identify access points and client devices.
---

# kismet

## Overview
Kismet is a comprehensive wireless network and device detector, sniffer, and WIDS framework. It supports a wide array of hardware including Wi-Fi cards, Bluetooth interfaces, and Software Defined Radio (SDR) devices like RTL-SDR. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Kismet is typically pre-installed on Kali Linux. To install the full suite:
```bash
sudo apt install kismet
```

## Common Workflows

### Basic Wi-Fi Monitoring
Start the Kismet server using a specific Wi-Fi interface:
```bash
kismet -c wlan0
```

### Remote Capture via Websockets
Connect a local capture source to a remote Kismet server using an API key:
```bash
kismet_cap_linux_wifi --connect 192.168.1.50:2501 --apikey YOUR_API_KEY --source wlan0
```

### Converting Logs to PCAP
Convert a Kismet database log to a pcapng file for analysis in Wireshark:
```bash
kismetdb_to_pcap -i session.kismetdb -o output.pcapng
```

### Exporting Data for Google Earth
Convert captured data to KML format for geographic visualization:
```bash
kismetdb_to_kml -i session.kismetdb -o map.kml --group
```

## Complete Command Reference

### kismet / kismet_server
The main server and monitor tool.

| Flag | Description |
|------|-------------|
| `-v`, `--version` | Show version |
| `-h`, `--help` | Display help message |
| `--no-console-wrapper` | Disable server console wrapper |
| `--no-ncurses-wrapper` | Disable server console wrapper |
| `--no-ncurses` | Disable server console wrapper |
| `--debug` | Disable console wrapper and crash handling for debugging |
| `-c <datasource>` | Use the specified datasource (e.g., `wlan0`) |
| `-f`, `--config-file <file>` | Use alternate configuration file |
| `--no-line-wrap` | Turn off linewrapping of output |
| `-s`, `--silent` | Turn off stdout output after setup phase |
| `--daemonize` | Spawn detached in the background |
| `--no-plugins` | Do not load plugins |
| `--homedir <path>` | Use alternate path as home directory |
| `--confdir <path>` | Use alternate path as base config directory |
| `--datadir <path>` | Use alternate path as data directory |
| `--override <flavor>` | Load alternate configuration override |
| `-T`, `--log-types <types>` | Override activated log types |
| `-t`, `--log-title <title>` | Override default log title |
| `-p`, `--log-prefix <prefix>` | Directory to store log files |
| `-n`, `--no-logging` | Disable logging entirely |
| `--device-timeout=n` | Expire devices after N seconds |

### Capture Drivers
(Applies to `kismet_cap_linux_wifi`, `kismet_cap_linux_bluetooth`, `kismet_cap_ubertooth_one`, `kismet_cap_sdr_rtl433`, `kismet_cap_sdr_rtladsb`, `kismet_cap_hak5_wifi_coconut`, `kismet_cap_nrf_51822`, `kismet_cap_nrf_52840`, `kismet_cap_nrf_mousejack`, `kismet_cap_nxp_kw41z`, `kismet_cap_ti_cc_2531`, `kismet_cap_ti_cc_2540`, `kismet_cap_freaklabs_zigbee`, `kismet_cap_antsdr_droneid`, `kismet_cap_bladerf_wiphy`, `kismet_cap_radiacode_usb`, `kismet_cap_serial_radview`, `kismet_cap_kismetdb`, `kismet_cap_pcapfile`)

| Flag | Description |
|------|-------------|
| `--connect [host]:[port]` | Connect to remote Kismet server (default port 2501) |
| `--tcp` | Use legacy TCP remote capture protocol (port 3501) |
| `--ssl` | Use SSL for websocket connection |
| `--ssl-certificate [file]` | Use specific CA cert to validate server |
| `--user [username]` | Kismet username for websockets |
| `--password [password]` | Kismet password for websockets |
| `--apikey [key]` | Kismet API key for 'datasource' role |
| `--endpoint [path]` | Alternate websocket endpoint path |
| `--source [source def]` | Specify source to send to remote server |
| `--disable-retry` | Exit immediately on connection error |
| `--fixed-gps [lat,lon,alt]` | Set a fixed location for capture |
| `--gps-name [name]` | Set alternate GPS name for source |
| `--daemonize` | Background the capture tool |
| `--list` | List supported devices detected |
| `--autodetect [uuid]` | Look for Kismet server in announcement mode |
| `--version` | Print version and exit |

### Log Manipulation Tools

#### kismetdb_to_pcap
| Flag | Description |
|------|-------------|
| `-i`, `--in [file]` | Input kismetdb file |
| `-o`, `--out [file]` | Output file name |
| `-f`, `--force` | Overwrite existing files |
| `-v`, `--verbose` | Verbose output |
| `-s`, `--skip-clean` | Don't vacuum input database |
| `--old-pcap` | Create traditional pcap (single link type) |
| `--dlt [type #]` | Limit pcap to a single DLT |
| `--list-datasources` | List datasources in kismetdb |
| `--datasource [uuid]` | Include packets from specific datasource |
| `--split-datasource` | Split output by datasource |
| `--split-packets [num]` | Split output by packet count |
| `--split-size [kb]` | Split output by file size |
| `--list-tags` | List tags in kismetdb |
| `--tag [tag]` | Only export packets with specific tag |
| `--skip-gps` | Don't include GPS in pcapng |
| `--skip-gps-track` | Don't include GPS movement track |

#### kismetdb_dump_devices
| Flag | Description |
|------|-------------|
| `-i`, `--in [file]` | Input kismetdb file |
| `-o`, `--out [file]` | Output JSON file |
| `-f`, `--force` | Force overwrite |
| `-j`, `--json-path` | Rewrite fields to use `_` instead of `.` |
| `-e`, `--ekjson` | Write as ekjson records (one per line) |
| `-v`, `--verbose` | Verbose output |
| `-s`, `--skip-clean` | Skip SQL vacuum |

#### kismetdb_to_kml / kismetdb_to_gpx
| Flag | Description |
|------|-------------|
| `-i`, `--in [file]` | Input kismetdb file |
| `-o`, `--out [file]` | Output file |
| `-f`, `--force` | Force overwrite |
| `-v`, `--verbose` | Verbose output |
| `-s`, `--skip-clean` | Skip SQL vacuum |
| `-e`, `--exclude lat,lon,dist` | Exclude records within 'dist' meters of lat,lon |
| `--basic-location` | Use faster, less accurate average location |
| `-g`, `--group` | Group by type into folders (KML only) |

#### kismetdb_to_wiglecsv
| Flag | Description |
|------|-------------|
| `-i`, `--in [file]` | Input kismetdb file |
| `-o`, `--out [file]` | Output Wigle CSV file |
| `-f`, `--force` | Force overwrite |
| `-r`, `--rate-limit [rate]` | Limit updates per device (seconds) |
| `-c`, `--cache-limit [limit]` | Max devices to cache (default 1000) |
| `-e`, `--exclude lat,lon,dist` | Exclude records near sensitive locations |

#### Other Log Tools
- `kismetdb_clean -i [file]`: Repairs kismetdb logs with incomplete journals.
- `kismetdb_statistics -i [file] [-j]`: Shows stats; `-j` for JSON output.
- `kismetdb_strip_packets -i [in] -o [out]`: Removes packet data, keeping device metadata.

### Legacy & Drone Tools

#### kismet_drone
| Flag | Description |
|------|-------------|
| `-f`, `--config-file` | Use alternate config |
| `--no-line-wrap` | Disable line wrapping |
| `-s`, `--silent` | Silent mode after setup |
| `--daemonize` | Background mode |
| `--drone-listen` | Override drone listen options |
| `-c`, `--capture-source` | Specify packet capture source |
| `-C`, `--enable-capture-sources` | Enable specific sources (comma-separated) |

## Notes
- **Security**: Running Kismet as root is generally discouraged. Use the `kismet` group for non-root capture if configured.
- **Web Interface**: Modern Kismet uses a web UI (default `http://localhost:2501`) for monitoring.
- **KismetDB**: All data is stored in a SQLite-based `.kismetdb` format. Use the provided `kismetdb_*` tools to extract data for other applications.
- **GPS**: For wardriving, ensure `gpsd` is running or use the `--fixed-gps` flag for stationary audits.