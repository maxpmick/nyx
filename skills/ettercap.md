---
name: ettercap
description: Multipurpose sniffer, interceptor, and logger for switched LANs. It supports active and passive dissection of many protocols, data injection, and on-the-fly content filtering. Use for Man-in-the-Middle (MiTM) attacks, ARP poisoning, sniffing switched networks, and protocol analysis during exploitation or sniffing and spoofing phases.
---

# ettercap

## Overview
Ettercap is a comprehensive suite for Man-in-the-Middle attacks. It features sniffing of live connections, content filtering on the fly, and many other interesting tricks. It supports active and passive dissection of many protocols and includes many features for network and host analysis. Categories: Exploitation, Sniffing & Spoofing, Social Engineering.

## Installation (if not already installed)
Assume ettercap is installed. If not, choose the graphical or text-only version:

```bash
sudo apt install ettercap-graphical
# OR
sudo apt install ettercap-text-only
```

## Common Workflows

### ARP Poisoning MiTM (Text Mode)
Perform ARP poisoning between a target and the gateway to sniff traffic.
```bash
sudo ettercap -T -M arp:remote /192.168.1.1/ /192.168.1.50/
```

### DNS Spoofing with Plugin
Load the dns_spoof plugin to redirect traffic.
```bash
sudo ettercap -T -P dns_spoof -M arp:remote /192.168.1.1/ /192.168.1.50/
```

### Compiling and Using a Content Filter
Create a filter to replace text in HTTP traffic, compile it, and run it.
```bash
# Compile the filter
etterfilter my_filter.filter -o my_filter.ef
# Run ettercap with the filter
sudo ettercap -T -F my_filter.ef -M arp:remote /192.168.1.1/ /192.168.1.50/
```

### Analyzing Log Files
Extract passwords from a previously saved ettercap log.
```bash
etterlog -p sniffed_data.eci
```

## Complete Command Reference

### ettercap
Usage: `ettercap [OPTIONS] [TARGET1] [TARGET2]`
TARGET format: `MAC/IP/IPv6/PORTs`

#### Sniffing and Attack Options
| Flag | Description |
|------|-------------|
| `-M, --mitm <METHOD:ARGS>` | Perform a mitm attack (e.g., `arp:remote`) |
| `-o, --only-mitm` | Don't sniff, only perform the mitm attack |
| `-b, --broadcast` | Sniff packets destined to broadcast |
| `-B, --bridge <IFACE>` | Use bridged sniff (needs 2 ifaces) |
| `-p, --nopromisc` | Do not put the iface in promisc mode |
| `-S, --nosslmitm` | Do not forge SSL certificates |
| `-u, --unoffensive` | Do not forward packets |
| `-r, --read <file>` | Read data from pcapfile |
| `-f, --pcapfilter <string>` | Set the pcap filter string |
| `-R, --reversed` | Use reversed TARGET matching |
| `-t, --proto <proto>` | Sniff only this proto (default is all) |
| `--certificate <file>` | Certificate file to use for SSL MiTM |
| `--private-key <file>` | Private key file to use for SSL MiTM |

#### User Interface Type
| Flag | Description |
|------|-------------|
| `-T, --text` | Use text only GUI |
| `-q, --quiet` | Do not display packet contents (use with -T) |
| `-s, --script <CMD>` | Issue these commands to the GUI |
| `-C, --curses` | Use curses GUI |
| `-D, --daemon` | Daemonize ettercap (no GUI) |
| `-G, --gtk` | Use GTK+ GUI |

#### Logging Options
| Flag | Description |
|------|-------------|
| `-w, --write <file>` | Write sniffed data to pcapfile |
| `-L, --log <logfile>` | Log all the traffic to this file |
| `-l, --log-info <logfile>` | Log only passive infos to this file |
| `-m, --log-msg <logfile>` | Log all the messages to this file |
| `-c, --compress` | Use gzip compression on log files |

#### Visualization Options
| Flag | Description |
|------|-------------|
| `-d, --dns` | Resolves ip addresses into hostnames |
| `-V, --visual <format>` | Set the visualization format |
| `-e, --regex <regex>` | Visualize only packets matching this regex |
| `-E, --ext-headers` | Print extended header for every pck |
| `-Q, --superquiet` | Do not display user and password |

#### General Options
| Flag | Description |
|------|-------------|
| `-i, --iface <iface>` | Use this network interface |
| `-I, --liface` | Show all the network interfaces |
| `-Y, --secondary <ifaces>` | List of secondary network interfaces |
| `-n, --netmask <netmask>` | Force this netmask on iface |
| `-A, --address <address>` | Force this local address on iface |
| `-P, --plugin <plugin>` | Launch this plugin (multiple allowed) |
| `--plugin-list <list>` | Comma-separated list of plugins |
| `-F, --filter <file>` | Load the compiled filter file |
| `-z, --silent` | Do not perform the initial ARP scan |
| `-6, --ip6scan` | Send ICMPv6 probes to discover IPv6 nodes |
| `-j, --load-hosts <file>` | Load the hosts list from file |
| `-k, --save-hosts <file>` | Save the hosts list to file |
| `-W, --wifi-key <wkey>` | Use this key to decrypt wifi (wep/wpa) |
| `-a, --config <config>` | Use alternative config file |

---

### etterfilter
Usage: `etterfilter [OPTIONS] filterfile`

| Flag | Description |
|------|-------------|
| `-o, --output <file>` | Output file (default is filter.ef) |
| `-t, --test <file>` | Test the file (debug mode) |
| `-d, --debug` | Print debug info while compiling |
| `-w, --suppress-warnings` | Ignore warnings during compilation |

---

### etterlog
Usage: `etterlog [OPTIONS] logfile`

#### General & Search Options
| Flag | Description |
|------|-------------|
| `-a, --analyze` | Analyze a log file and return useful infos |
| `-c, --connections` | Display the table of connections |
| `-f, --filter <TARGET>` | Print packets only from this target |
| `-t, --proto <proto>` | Display only this proto |
| `-p, --passwords` | Print only accounts information |
| `-u, --user <user>` | Search for info about specific user |
| `-e, --regex <regex>` | Display only packets matching regex |
| `-i, --show-client` | Show client address in password profiles |
| `-I, --client <ip>` | Search for pass from a specific client |

#### Editing & Visualization
| Flag | Description |
|------|-------------|
| `-C, --concat` | Concatenate more files into one |
| `-o, --outfile <file>` | Output file for concatenation |
| `-D, --decode` | Extract files from connections |
| `-B, --binary` | Print packets as binary |
| `-X, --hex` | Print packets in hex mode |
| `-A, --ascii` | Print packets in ascii mode (default) |
| `-T, --text` | Print packets in text mode |
| `-x, --xml` | Print host infos in xml format |

## Notes
- MiTM attacks require root privileges (`sudo`).
- Ensure IP forwarding is handled by ettercap (default) or the OS.
- Target syntax: `/192.168.1.1/ /192.168.1.10-20/` (Gateway and range of targets).