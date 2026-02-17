---
name: ubertooth
description: Perform Bluetooth monitoring, sniffing, and spectrum analysis using Ubertooth hardware. Use for Bluetooth Low Energy (BLE) packet capture, Classic Bluetooth (BR) discovery, AFH channel map detection, and 2.4 GHz spectrum analysis during wireless security audits or IoT penetration testing.
---

# ubertooth

## Overview
Ubertooth is an open-source 2.4 GHz wireless development platform for Bluetooth experimentation. It supports sniffing Bluetooth Low Energy (BLE), limited sniffing of Basic Rate (BR) Bluetooth Classic, and includes a 2.4 GHz spectrum analyzer. Category: Wireless Attacks / Bluetooth.

## Installation (if not already installed)
Assume the tool is installed. If commands are missing:
```bash
sudo apt install ubertooth
```

## Common Workflows

### Sniffing Bluetooth Low Energy (BLE)
Follow connections and save to a PCAP file:
```bash
ubertooth-btle -f -c capture.pcap
```

### Classic Bluetooth Discovery (Survey Mode)
Discover and list piconets (LAPs and UAPs) for 30 seconds:
```bash
ubertooth-rx -z -t 30
```

### Spectrum Analysis
Launch the graphical spectrum analyzer to visualize 2.4 GHz activity:
```bash
ubertooth-specan-ui
```

### Firmware Update
Update the Ubertooth One hardware firmware:
```bash
ubertooth-dfu -d /usr/share/ubertooth/firmware/bluetooth_rxtx.dfu -r
```

## Complete Command Reference

### ubertooth-rx (Classic Bluetooth Discovery)
| Flag | Description |
|------|-------------|
| `-l <LAP>` | Decode specific LAP (6 hex digits); if omitted, sniffs all LAPs |
| `-u <UAP>` | Decode specific UAP (2 hex digits); requires LAP |
| `-z` | Survey mode: discover and list piconets (implies -s) |
| `-i <file>` | Input file for offline analysis (default: live capture) |
| `-c <chan>` | Set fixed Bluetooth channel (Default: 39) |
| `-e <err>` | Max access code errors (0-4, default: 2) |
| `-t <sec>` | Sniff timeout in seconds (0 = no timeout) |
| `-r <file>` | Capture packets to PcapNG file |
| `-q <file>` | Capture packets to PCAP file |
| `-d <file>` | Dump packets to binary file |
| `-U <0-7>` | Set Ubertooth device index |
| `-V` | Print version information |

### ubertooth-btle (BLE Sniffing)
| Flag | Description |
|------|-------------|
| `-f` | Follow connections |
| `-n` | Don't follow, only print advertisements |
| `-p` | Promiscuous mode: sniff active connections |
| `-a[addr]` | Get/set access address (e.g., -a8e89bed6) |
| `-s<addr>` | Faux slave mode using MAC (e.g., -s22:44:66:88:aa:cc) |
| `-t<addr>` | Set connection following target (e.g., -t22:44:66:88:aa:cc/48) |
| `-tnone` | Unset connection following target |
| `-i` | Interfere with one connection and return to idle |
| `-I` | Interfere continuously |
| `-r <file>` | Capture to PCAPNG |
| `-q <file>` | Capture to PCAP (DLT_BLUETOOTH_LE_LL_WITH_PHDR) |
| `-c <file>` | Capture to PCAP (DLT_PPI + DLT_BLUETOOTH_LE_LL) |
| `-A <idx>` | Advertising channel index (default: 37) |
| `-v[01]` | Verify CRC mode (get status or enable/disable) |
| `-x <n>` | Allow n access address offenses (default: 32) |
| `-U <0-7>` | Set Ubertooth device index |

### ubertooth-afh (AFH Detection)
| Flag | Description |
|------|-------------|
| `-l <LAP>` | LAP of target piconet (6 hex digits) |
| `-u <UAP>` | UAP of target piconet (2 hex digits) |
| `-m <int>` | Threshold for channel removal (default: 5) |
| `-r` | Print AFH channel map once every second |
| `-t <sec>` | Timeout for initial detection |
| `-e <err>` | Max access code errors (0-4, default: 2) |
| `-U <0-7>` | Set Ubertooth device index |

### ubertooth-scan (Active/Passive Scan)
| Flag | Description |
|------|-------------|
| `-s` | HCI Scan: use BlueZ to scan for discoverable devices |
| `-x` | Extended scan: retrieve additional info about targets |
| `-t <sec>` | Scan time in seconds (default: 20s) |
| `-e <err>` | Max access code errors (0-4, default: 2) |
| `-b <dev>` | Bluetooth device (default: hci0) |
| `-U <0-7>` | Set Ubertooth device index |

### ubertooth-util (General Utility)
| Flag | Description |
|------|-------------|
| `-v` | Get firmware revision |
| `-I` | Identify device (flash all LEDs) |
| `-d[0-1]` | Get/set all LEDs |
| `-l[0-1]` | Get/set USR LED |
| `-S` | Stop current operation |
| `-r` | Full reset |
| `-a[0-7]` | Get/set power amplifier level |
| `-c[2400-2483]` | Get/set channel in MHz |
| `-C[0-78]` | Get/set channel index |
| `-q[1-225]` | Start LED spectrum analyzer (RSSI threshold) |
| `-t` | Initiate continuous transmit test |
| `-z` | Set squelch level |
| `-N` | Print total number of Uberteeth connected |

### ubertooth-specan (Spectrum Analyzer)
| Flag | Description |
|------|-------------|
| `-g` | Output for feedgnuplot |
| `-G` | Output for 3D feedgnuplot |
| `-d <file>` | Output to file |
| `-l <freq>` | Lower frequency (default: 2402) |
| `-u <freq>` | Upper frequency (default: 2480) |

### Other Subcommands
- **ubertooth-specan-ui**: Graphical spectrum analyzer (no options).
- **ubertooth-dfu**: Firmware updates (`-u` upload, `-d` download, `-r` reset).
- **ubertooth-debug**: CC2400 register debugging (`-r` read registers).
- **ubertooth-ducky**: Emulate USB Rubber Ducky via Bluetooth (`-q` quack).
- **ubertooth-dump**: Output raw bitstream (`-b` bitstream, `-c` classic, `-l` LE).
- **ubertooth-ego**: Sniff Yuneec E-GO skateboards (`-f` follow, `-i` interfere).
- **ubertooth-follow**: Active CLK discovery and follow for UAP/LAP.

## Notes
- Ubertooth is a passive sniffer; it does not show up as a standard Bluetooth adapter in `hciconfig` unless specific tools are running.
- For most sniffing tasks, you must identify the Lower Address Part (LAP) and Upper Address Part (UAP) of the target piconet first.
- PCAP files generated can be opened in Wireshark for protocol analysis.