---
name: redfang
description: Locate non-discoverable Bluetooth devices by brute-forcing the last six bytes of the Bluetooth address (BD_ADDR) and attempting a remote name read. Use when performing Bluetooth reconnaissance, hidden device discovery, or wireless security auditing where target devices are not in discoverable mode.
---

# redfang

## Overview
Redfang (command name `fang`) is a proof-of-concept application designed to find non-discoverable Bluetooth devices. It bypasses the "hidden" status of a device by brute-forcing a specified range of MAC addresses and attempting to read the remote name of each address. Category: Wireless Attacks / Bluetooth.

## Installation (if not already installed)
Assume redfang is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install redfang
```

## Common Workflows

### Scan a specific address range
Brute-force a range of Bluetooth addresses to find hidden devices:
```bash
fang -r 00803789EE76-00803789EEFF
```

### Scan with discovery and logging
Scan a range, perform device discovery, and save the results to a text file:
```bash
fang -r 00803789EE76-00803789EEFF -s -o scan_results.txt
```

### Use multiple Bluetooth dongles
Distribute the workload across multiple local Bluetooth adapters (e.g., hci0, hci1, hci2) to speed up the brute-force process:
```bash
fang -r 00803789EE76-00803789EEFF -n 3
```

### Identify manufacturer codes
List the built-in manufacturer codes to simplify address range entry:
```bash
fang -l
```

## Complete Command Reference

```
fang [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-r <range>` | Specify the address range to scan (e.g., `00803789EE76-00803789EEFF`). Addresses must be 12 characters long. |
| `-o <filename>` | Output the scan results to a text logfile. |
| `-t <timeout>` | The connect timeout in microseconds (default: 10000). Increase this value for better reliability on slow devices. |
| `-n <num>` | The number of local Bluetooth dongles (threads) to use. |
| `-d` | Show debug information during the scan. |
| `-s` | Perform Bluetooth Discovery (attempt to retrieve device info). |
| `-l` | Show device manufacturer codes. |
| `-h` | Display the help message. |

## Notes
- **Address Formatting**: You can use manufacturer shortcuts with the `-r` flag if you know the prefix. Format: `manf+nnnnnn`, where `manf` is a code from the `-l` list and `nnnnnn` is the tail of the address.
- **Hardware Requirements**: The tool assumes local adapters are named sequentially starting from `hci0`. If you specify `-n 3`, it will attempt to use `hci0`, `hci1`, and `hci2`.
- **Performance**: Brute-forcing Bluetooth addresses is time-consuming. Using multiple dongles (`-n`) and a well-defined range is highly recommended.
- **Reliability**: If the tool is missing devices you know exist, try increasing the timeout value with `-t`.