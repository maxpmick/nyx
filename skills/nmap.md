---
name: nmap
description: Perform network discovery, port scanning, service/version detection, and OS fingerprinting. Use for reconnaissance, vulnerability assessment, and security auditing to identify active hosts, open ports, and potential attack surfaces.
---

# nmap

## Overview
Nmap ("Network Mapper") is an open-source tool for network exploration and security auditing. It uses raw IP packets to determine what hosts are available on the network, what services those hosts are offering, what operating systems they are running, what type of packet filters/firewalls are in use, and dozens of other characteristics. Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
Assume nmap is already installed. If missing:
```bash
sudo apt install nmap ncat ndiff
```

## Common Workflows

### Comprehensive Scan
Perform OS detection, version detection, script scanning, and traceroute in verbose mode.
```bash
nmap -v -A 192.168.1.1
```

### Fast Network Inventory
Quickly identify live hosts in a subnet without port scanning.
```bash
nmap -sn 192.168.0.0/24
```

### Targeted Service Audit
Scan specific ports for version information and run default scripts.
```bash
nmap -sV -p 22,80,443 -sC 10.0.0.5
```

### Compare Scan Results
Use `ndiff` to find changes between two XML scan outputs.
```bash
ndiff scan_yesterday.xml scan_today.xml
```

### Create a Listener (Ncat)
Open a persistent listener that executes a shell for a specific IP.
```bash
ncat -v --exec "/bin/bash" --allow 192.168.1.123 -l 4444 --keep-open
```

## Complete Command Reference

### Nmap Options

#### Target Specification
| Flag | Description |
|------|-------------|
| `-iL <file>` | Input from list of hosts/networks |
| `-iR <num>` | Choose random targets |
| `--exclude <h1,h2>` | Exclude hosts/networks |
| `--excludefile <f>` | Exclude list from file |

#### Host Discovery
| Flag | Description |
|------|-------------|
| `-sL` | List Scan - simply list targets to scan |
| `-sn` | Ping Scan - disable port scan |
| `-Pn` | Treat all hosts as online -- skip host discovery |
| `-PS/PA/PU/PY[list]` | TCP SYN, TCP ACK, UDP or SCTP discovery to given ports |
| `-PE/PP/PM` | ICMP echo, timestamp, and netmask request discovery probes |
| `-PO[list]` | IP Protocol Ping |
| `-n/-R` | Never do DNS resolution/Always resolve |
| `--dns-servers <s1,s2>` | Specify custom DNS servers |
| `--system-dns` | Use OS's DNS resolver |
| `--traceroute` | Trace hop path to each host |

#### Scan Techniques
| Flag | Description |
|------|-------------|
| `-sS/sT/sA/sW/sM` | TCP SYN/Connect()/ACK/Window/Maimon scans |
| `-sU` | UDP Scan |
| `-sN/sF/sX` | TCP Null, FIN, and Xmas scans |
| `--scanflags <flags>` | Customize TCP scan flags |
| `-sI <zombie[:port]>` | Idle scan |
| `-sY/sZ` | SCTP INIT/COOKIE-ECHO scans |
| `-sO` | IP protocol scan |
| `-b <relay host>` | FTP bounce scan |

#### Port Specification and Scan Order
| Flag | Description |
|------|-------------|
| `-p <ranges>` | Only scan specified ports (e.g., `-p22; -p1-65535; -p U:53,T:21`) |
| `--exclude-ports <r>` | Exclude the specified ports from scanning |
| `-F` | Fast mode - Scan fewer ports than the default scan |
| `-r` | Scan ports sequentially - don't randomize |
| `--top-ports <num>` | Scan <number> most common ports |
| `--port-ratio <ratio>` | Scan ports more common than <ratio> |

#### Service/Version Detection
| Flag | Description |
|------|-------------|
| `-sV` | Probe open ports to determine service/version info |
| `--version-intensity <0-9>` | Set from 0 (light) to 9 (try all probes) |
| `--version-light` | Limit to most likely probes (intensity 2) |
| `--version-all` | Try every single probe (intensity 9) |
| `--version-trace` | Show detailed version scan activity (debugging) |

#### Script Scan (NSE)
| Flag | Description |
|------|-------------|
| `-sC` | Equivalent to `--script=default` |
| `--script=<scripts>` | Comma separated list of directories, files, or categories |
| `--script-args=<args>` | Provide arguments to scripts |
| `--script-args-file=<f>` | Provide NSE script args in a file |
| `--script-trace` | Show all data sent and received |
| `--script-updatedb` | Update the script database |
| `--script-help=<scripts>` | Show help about scripts |

#### OS Detection
| Flag | Description |
|------|-------------|
| `-O` | Enable OS detection |
| `--osscan-limit` | Limit OS detection to promising targets |
| `--osscan-guess` | Guess OS more aggressively |

#### Timing and Performance
| Flag | Description |
|------|-------------|
| `-T<0-5>` | Set timing template (0=paranoid, 5=insane) |
| `--min-hostgroup <size>` | Minimum parallel host scan group size |
| `--max-hostgroup <size>` | Maximum parallel host scan group size |
| `--min-parallelism <num>` | Minimum probe parallelization |
| `--max-parallelism <num>` | Maximum probe parallelization |
| `--min-rtt-timeout <t>` | Minimum probe round trip time |
| `--max-rtt-timeout <t>` | Maximum probe round trip time |
| `--initial-rtt-timeout <t>` | Initial probe round trip time |
| `--max-retries <tries>` | Caps number of port scan probe retransmissions |
| `--host-timeout <time>` | Give up on target after this long |
| `--scan-delay <time>` | Adjust delay between probes |
| `--max-scan-delay <t>` | Maximum delay between probes |
| `--min-rate <number>` | Send packets no slower than <number> per second |
| `--max-rate <number>` | Send packets no faster than <number> per second |

#### Firewall/IDS Evasion and Spoofing
| Flag | Description |
|------|-------------|
| `-f; --mtu <val>` | Fragment packets (optionally w/given MTU) |
| `-D <d1,d2,ME,...>` | Cloak a scan with decoys |
| `-S <IP_Address>` | Spoof source address |
| `-e <iface>` | Use specified interface |
| `-g/--source-port <p>` | Use given port number |
| `--proxies <urls>` | Relay connections through HTTP/SOCKS4 proxies |
| `--data <hex>` | Append a custom payload to sent packets |
| `--data-string <str>` | Append a custom ASCII string to sent packets |
| `--data-length <num>` | Append random data to sent packets |
| `--ip-options <opt>` | Send packets with specified ip options |
| `--ttl <val>` | Set IP time-to-live field |
| `--spoof-mac <mac>` | Spoof your MAC address |
| `--badsum` | Send packets with a bogus TCP/UDP/SCTP checksum |

#### Output
| Flag | Description |
|------|-------------|
| `-oN <file>` | Output scan in normal format |
| `-oX <file>` | Output scan in XML format |
| `-oS <file>` | Output scan in s|<rIpt kIddi3 format |
| `-oG <file>` | Output scan in Grepable format |
| `-oA <basename>` | Output in the three major formats at once |
| `-v` | Increase verbosity level (use -vv for more) |
| `-d` | Increase debugging level (use -dd for more) |
| `--reason` | Display the reason a port is in a particular state |
| `--open` | Only show open (or possibly open) ports |
| `--packet-trace` | Show all packets sent and received |
| `--iflist` | Print host interfaces and routes |
| `--append-output` | Append to rather than clobber output files |
| `--resume <file>` | Resume an aborted scan |
| `--noninteractive` | Disable runtime interactions via keyboard |
| `--stylesheet <path>` | XSL stylesheet to transform XML output to HTML |
| `--webxml` | Reference stylesheet from Nmap.Org |
| `--no-stylesheet` | Prevent associating of XSL stylesheet w/XML output |

#### Misc
| Flag | Description |
|------|-------------|
| `-6` | Enable IPv6 scanning |
| `-A` | Enable OS detection, version detection, script scanning, and traceroute |
| `--datadir <dir>` | Specify custom Nmap data file location |
| `--send-eth` | Send using raw ethernet frames |
| `--send-ip` | Send using raw IP packets |
| `--privileged` | Assume that the user is fully privileged |
| `--unprivileged` | Assume the user lacks raw socket privileges |
| `-V` | Print version number |
| `-h` | Print help summary page |

---

### Ncat Options
`ncat [options] [hostname] [port]`

| Flag | Description |
|------|-------------|
| `-4 / -6` | Use IPv4 / IPv6 only |
| `-U, --unixsock` | Use Unix domain sockets only |
| `--vsock` | Use vsock sockets only |
| `-C, --crlf` | Use CRLF for EOL sequence |
| `-c, --sh-exec <cmd>` | Executes the given command via /bin/sh |
| `-e, --exec <cmd>` | Executes the given command |
| `--lua-exec <file>` | Executes the given Lua script |
| `-g <hop1,...>` | Loose source routing hop points (8 max) |
| `-G <n>` | Loose source routing hop pointer |
| `-m, --max-conns <n>` | Maximum simultaneous connections |
| `-d, --delay <time>` | Wait between read/writes |
| `-o, --output <file>` | Dump session data to a file |
| `-x, --hex-dump <f>` | Dump session data as hex to a file |
| `-i, --idle-timeout` | Idle read/write timeout |
| `-p, --source-port` | Specify source port to use |
| `-s, --source <addr>` | Specify source address to use |
| `-l, --listen` | Bind and listen for incoming connections |
| `-k, --keep-open` | Accept multiple connections in listen mode |
| `-n, --nodns` | Do not resolve hostnames via DNS |
| `-t, --telnet` | Answer Telnet negotiations |
| `-u, --udp` | Use UDP instead of TCP |
| `--sctp` | Use SCTP instead of TCP |
| `-v, --verbose` | Set verbosity level |
| `-w, --wait <time>` | Connect timeout |
| `-z` | Zero-I/O mode, report connection status only |
| `--append-output` | Append rather than clobber output files |
| `--send-only` | Only send data, ignore received |
| `--recv-only` | Only receive data, never send |
| `--no-shutdown` | Continue half-duplex when receiving EOF |
| `--allow / --allowfile` | Allow specific hosts to connect |
| `--deny / --denyfile` | Deny specific hosts from connecting |
| `--broker` | Enable connection brokering mode |
| `--chat` | Start a simple chat server |
| `--proxy <addr>` | Specify proxy host |
| `--proxy-type <t>` | "http", "socks4", or "socks5" |
| `--proxy-auth <auth>` | Authenticate with proxy |
| `--proxy-dns <type>` | Specify where to resolve proxy destination |
| `--ssl` | Connect or listen with SSL |
| `--ssl-cert / --ssl-key` | Specify SSL certificate/key files |
| `--ssl-verify` | Verify trust and domain name of certificates |
| `--ssl-trustfile` | PEM file containing trusted certificates |
| `--ssl-ciphers` | Cipherlist to use |
| `--ssl-servername` | Request distinct server name (SNI) |
| `--ssl-alpn` | ALPN protocol list to use |

---

### Nping Options
`nping [Probe mode] [Options] {target}`

#### Probe Modes
| Flag | Description |
|------|-------------|
| `--tcp-connect` | Unprivileged TCP connect probe mode |
| `--tcp` | TCP probe mode |
| `--udp` | UDP probe mode |
| `--icmp` | ICMP probe mode |
| `--arp` | ARP/RARP probe mode |
| `--tr, --traceroute` | Traceroute mode (TCP/UDP/ICMP only) |

#### TCP/UDP Options
| Flag | Description |
|------|-------------|
| `-p, --dest-port <p>` | Set destination port(s) |
| `-g, --source-port <p>` | Set source port |
| `--seq <num>` | Set sequence number (TCP) |
| `--flags <list>` | Set TCP flags (ACK,PSH,RST,SYN,FIN...) |
| `--ack <num>` | Set ACK number (TCP) |
| `--win <size>` | Set window size (TCP) |
| `--badsum` | Use a random invalid checksum |

#### ICMP Options
| Flag | Description |
|------|-------------|
| `--icmp-type <type>` | ICMP type |
| `--icmp-code <code>` | ICMP code |
| `--icmp-id <id>` | Set identifier |
| `--icmp-seq <n>` | Set sequence number |
| `--icmp-redirect-addr` | Set redirect address |
| `--icmp-orig-time` | Set originate timestamp |

#### IP/Ethernet Options
| Flag | Description |
|------|-------------|
| `-S, --source-ip` | Set source IP address |
| `--dest-ip <addr>` | Set destination IP address |
| `--tos <tos>` | Set type of service field |
| `--ttl <hops>` | Set time to live [0-255] |
| `--df / --mf / --evil` | Set IP flags (Don't Frag, More Frag, Evil) |
| `--dest-mac <mac>` | Set destination MAC address |
| `--source-mac <mac>` | Set source MAC address |

---

### Ndiff Options
`ndiff [option] FILE1 FILE2`

| Flag | Description |
|------|-------------|
| `-h, --help` | Display help |
| `-v, --verbose` | Show hosts and ports that haven't changed |
| `--text` | Display output in text format (default) |
| `--xml` | Display output in XML format |

---

### Zenmap Options
`zenmap [options] [result files]`

| Flag | Description |
|------|-------------|
| `--confdir=DIR` | Use DIR as configuration directory |
| `-f, --file=FILES` | Specify scan result file (Nmap XML) |
| `-n, --nmap` | Run Nmap with the specified args |
| `-p, --profile=P` | Begin with the specified profile |
| `-t, --target=T` | Specify a target |

## Notes
- **Privileges**: Many scan types (like `-sS`) and OS detection (`-O`) require root privileges.
- **Stealth**: Use timing templates (`-T0` or `-T1`) and decoys (`-D`) to avoid detection by IDS/IPS.
- **Performance**: Adjust `--min-rate` or `-T4` for faster scans on reliable networks.
- **NSE**: Nmap scripts are located in `/usr/share/nmap/scripts/`. Use `--script-help` to understand what a script does before running it.