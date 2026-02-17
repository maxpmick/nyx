---
name: ethtool
description: Query and control network driver and hardware settings for Ethernet devices. Use to display interface information, change link speed, duplex mode, auto-negotiation, offload features, and perform hardware diagnostics. Essential for network troubleshooting, performance tuning, and sniffing/spoofing preparation.
---

# ethtool

## Overview
`ethtool` is a standard Linux utility for examining and modifying Ethernet device parameters. It interacts directly with the network device driver and hardware to manage settings like speed, port type, auto-negotiation, and checksum offloading. Categories: Sniffing & Spoofing, Wireless Attacks, Troubleshooting.

## Installation (if not already installed)
Assume `ethtool` is already installed. If missing:
```bash
sudo apt install ethtool
```

## Common Workflows

### Query interface information
```bash
ethtool eth0
```
Displays supported link modes, current speed, duplex, and auto-negotiation status.

### Change interface speed and duplex
```bash
sudo ethtool -s eth0 speed 100 duplex full autoneg off
```
Manually forces the interface to 100Mbps Full Duplex.

### Identify a physical port (Blink LED)
```bash
sudo ethtool -p eth0 10
```
Causes the physical LED on the `eth0` port to blink for 10 seconds to identify it in a rack.

### Show driver and firmware version
```bash
ethtool -i eth0
```

### View hardware statistics
```bash
ethtool -S eth0
```

## Complete Command Reference

### Basic Commands
| Command | Description |
|---------|-------------|
| `ethtool [FLAGS] DEVNAME` | Display standard information about device |
| `-s`, `--change DEVNAME` | Change generic options (speed, duplex, etc.) |
| `-i`, `--driver DEVNAME` | Show driver information |
| `-P`, `--show-permaddr DEVNAME` | Show permanent hardware address |
| `-h`, `--help` | Show help |
| `--version` | Show version number |

### Configuration Options (used with `-s`)
`[ speed %d ] [ lanes %d ] [ duplex half|full ] [ port tp|aui|bnc|mii|fibre|da ] [ mdix auto|on|off ] [ autoneg on|off ] [ advertise %x[/%x] | mode on|off ... ] [ phyad %d ] [ xcvr internal|external ] [ wol %d[/%d] | p|u|m|b|a|g|s|f|d... ] [ sopass %x:%x:%x:%x:%x:%x ] [ msglvl %d[/%d] | type on|off ... ] [ master-slave preferred-master|preferred-slave|forced-master|forced-slave ]`

### Hardware & Offload Settings
| Flag | Description |
|------|-------------|
| `-a`, `--show-pause` | Show pause options (`--src aggregate|emac|pmac`) |
| `-A`, `--pause` | Set pause options (`autoneg`, `rx`, `tx` on/off) |
| `-c`, `--show-coalesce` | Show interrupt coalescing options |
| `-C`, `--coalesce` | Set coalescing (adaptive-rx/tx, rx-usecs, tx-frames, etc.) |
| `-g`, `--show-ring` | Query RX/TX ring parameters |
| `-G`, `--set-ring` | Set ring parameters (rx, rx-mini, rx-jumbo, tx, rx-buf-len, etc.) |
| `-k`, `--show-features` | Get state of protocol offload and other features |
| `-K`, `--features` | Set protocol offload (e.g., `tso on`, `gso off`) |
| `-l`, `--show-channels` | Query multi-queue channels |
| `-L`, `--set-channels` | Set channels (rx, tx, other, combined) |
| `--show-priv-flags` | Query private flags |
| `--set-priv-flags` | Set private flags (FLAG on/off) |

### Diagnostics & Dumps
| Flag | Description |
|------|-------------|
| `-d`, `--register-dump` | Do a register dump (`raw on/off`, `file FILENAME`) |
| `-e`, `--eeprom-dump` | Do a EEPROM dump (`offset N`, `length N`) |
| `-E`, `--change-eeprom` | Change bytes in device EEPROM (`magic`, `offset`, `value`) |
| `-m`, `--module-info` | Query/Decode Module EEPROM (SFP/QSFP) |
| `-p`, `--identify` | Blink LEDs to identify port (`TIME-IN-SECONDS`) |
| `-t`, `--test` | Execute adapter self test (`online`, `offline`, `external_lb`) |
| `-S`, `--statistics` | Show adapter statistics (`--all-groups`, `--groups`, `--src`) |
| `--phy-statistics` | Show PHY-specific statistics |
| `--cable-test` | Perform a cable test |
| `--cable-test-tdr` | Print cable test time domain reflectometry data |

### Flow Classification (N-tuple)
| Flag | Description |
|------|-------------|
| `-n`, `-u`, `--show-nfc` | Show Rx network flow classification options/rules |
| `-N`, `-U`, `--config-nfc` | Configure Rx flow classification (rules, hash, etc.) |
| `-x`, `--show-rxfh` | Show Rx flow hash indirection table / RSS hash key |
| `-X`, `--set-rxfh` | Set Rx flow hash indirection table / RSS hash key |

### Advanced Features
| Flag | Description |
|------|-------------|
| `-T`, `--show-time-stamping` | Show time stamping capabilities |
| `--get-hwtimestamp-cfg` | Get hardware time stamping config |
| `--set-hwtimestamp-cfg` | Set hardware time stamping config |
| `-f`, `--flash` | Flash firmware image to device region |
| `-w`, `--get-dump` | Get dump flag/data |
| `-W`, `--set-dump` | Set dump flag |
| `--show-eee` / `--set-eee` | Manage Energy Efficient Ethernet |
| `--reset` | Reset components (flags: `mgmt`, `irq`, `dma`, `filter`, `mac`, `phy`, `all`, etc.) |
| `--show-fec` / `--set-fec` | Manage Forward Error Correction (auto, off, rs, baser, llrs) |
| `-Q`, `--per-queue` | Apply sub-commands per queue (`queue_mask %x`) |
| `--monitor` | Show kernel notifications for interface changes |

### Global Flags
| Flag | Description |
|------|-------------|
| `--debug MASK` | Turn on debugging messages |
| `-j`, `--json` | Enable JSON output format |
| `-I`, `--include-statistics` | Request device statistics related to the command |

## Notes
- Most configuration changes require `sudo` or root privileges.
- Not all network cards/drivers support every `ethtool` feature (e.g., hardware offloading or cable testing).
- Use `--monitor` to watch for real-time link state changes or configuration updates from other processes.