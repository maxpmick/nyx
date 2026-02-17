---
name: qemu
description: Emulate various CPU architectures and full systems, or run user-mode binaries for foreign architectures. Use when performing malware analysis in isolated environments, debugging cross-compiled binaries, emulating hardware peripherals, or managing virtual disk images. Includes utilities for disk manipulation (qemu-img), network block devices (qemu-nbd), and guest-host communication (qemu-ga).
---

# QEMU

## Overview
QEMU is a generic and open source machine emulator and virtualizer. It supports full system emulation (emulating a processor and peripherals) and user-mode emulation (running binaries compiled for one CPU on another). Category: Hardware Emulation / Reverse Engineering / Exploitation.

## Installation (if not already installed)
Assume QEMU is installed. If specific components are missing:
```bash
sudo apt install qemu-system qemu-user qemu-utils qemu-guest-agent
```

## Common Workflows

### Run an x86_64 ISO with KVM acceleration
```bash
qemu-system-x86_64 -enable-kvm -m 2G -cdrom linux.iso -boot d
```

### Run a foreign architecture binary (User Mode)
```bash
qemu-aarch64 ./my-arm-binary
```

### Create and Inspect Disk Images
```bash
qemu-img create -f qcow2 disk.qcow2 20G
qemu-img info disk.qcow2
```

### Expose a disk image via NBD
```bash
qemu-nbd -c /dev/nbd0 disk.qcow2
```

## Complete Command Reference

### qemu-system-[arch]
Full system emulation for architectures including x86_64, i386, arm, aarch64, mips, ppc, riscv, s390x, etc.

#### Standard Options
| Flag | Description |
|------|-------------|
| `-h`, `-help` | Display help |
| `-version` | Display version |
| `-machine [type=]name[,prop=value]` | Select emulated machine (e.g., `q35`, `virt`). Use `accel=kvm:tcg` for acceleration |
| `-cpu model` | Select CPU model (use `-cpu help` for list) |
| `-accel [accel=]name` | Select accelerator: `kvm`, `xen`, `hvf`, `nvmm`, `whpx`, `tcg` |
| `-smp [cpus=]n[,maxcpus=m][,cores=c][,threads=t]` | Set number of CPUs and topology |
| `-m [size=]megs[,slots=n,maxmem=size]` | Configure guest RAM |
| `-k language` | Use keyboard layout (e.g., `fr`, `de`) |
| `-name string` | Set guest name |
| `-uuid uuid` | Specify machine UUID |

#### Block Device Options
| Flag | Description |
|------|-------------|
| `-hda/-hdb file` | Use file as hard disk 0/1 image |
| `-cdrom file` | Use file as CD-ROM image |
| `-drive [file=f][,if=type][,format=fmt][,cache=mode]` | Define a drive. `if`: `ide`, `scsi`, `sd`, `virtio` |
| `-blockdev driver,node-name=N,...` | Configure a block backend (stable interface) |
| `-snapshot` | Write to temporary files instead of disk images |

#### Network Options
| Flag | Description |
|------|-------------|
| `-netdev user,id=id[,hostfwd=rule]` | User mode stack (SLIRP). `hostfwd=tcp::5555-:22` |
| `-netdev tap,id=id[,ifname=name]` | Connect to a host TAP interface |
| `-netdev bridge,id=id[,br=bridge]` | Connect to a host bridge |
| `-nic [model],netdev=id[,mac=addr]` | Shortcut for NIC and backend configuration |

#### Display/Graphics Options
| Flag | Description |
|------|-------------|
| `-display type` | `gtk`, `sdl`, `vnc=host:d`, `curses`, `none`, `dbus` |
| `-nographic` | Disable graphical output; redirect serial to console |
| `-vga type` | `std`, `cirrus`, `vmware`, `qxl`, `virtio`, `none` |
| `-spice [port=p][,tls-port=tp][,addr=a]` | Enable SPICE protocol |

#### Debug/Expert Options
| Flag | Description |
|------|-------------|
| `-kernel bzImage` | Use bzImage as kernel image |
| `-append cmdline` | Use cmdline as kernel command line |
| `-initrd file` | Use file as initial ram disk |
| `-S` | Freeze CPU at startup |
| `-s` | Shorthand for `-gdb tcp::1234` |
| `-gdb dev` | Wait for GDB connection on device |
| `-d item1,...` | Enable logging (use `-d help` for items) |
| `-D logfile` | Output log to file |
| `-monitor dev` | Redirect monitor to char device (e.g., `stdio`) |
| `-enable-kvm` | Enable KVM full virtualization |

---

### qemu-user (qemu-[arch])
User mode emulation for running cross-compiled binaries.

| Flag | Description |
|------|-------------|
| `-L path` | Set the ELF interpreter prefix (library path) |
| `-g port` | Wait for GDB connection on port |
| `-s size` | Set stack size in bytes |
| `-cpu model` | Select CPU model |
| `-E var=value` | Set environment variable for target process |
| `-U var` | Unset environment variable |
| `-strace` | Log system calls |
| `-version` | Display version |

---

### qemu-img
Disk image manipulation utility.

**Commands:**
- `amend`: Update format-specific options.
- `bench`: Simple image benchmark.
- `check`: Check image integrity.
- `commit`: Commit changes to backing file.
- `compare`: Compare two images.
- `convert [-f fmt] [-O out_fmt] src out`: Copy/convert images.
- `create [-f fmt] [-o options] file [size]`: Create new image.
- `info file`: Display image information.
- `measure`: Calculate required file size for new image.
- `resize file [+|-]size`: Change image size.
- `snapshot [-l|-a|-c|-d] file`: Manage snapshots.

---

### qemu-nbd
Export QEMU disk images using the Network Block Device protocol.

| Flag | Description |
|------|-------------|
| `-p, --port=PORT` | Port to listen on (default 10809) |
| `-b, --bind=IFACE` | Interface to bind to |
| `-k, --socket=PATH` | Path to Unix socket |
| `-c, --connect=DEV` | Connect image to local NBD device (e.g., `/dev/nbd0`) |
| `-d, --disconnect` | Disconnect the specified device |
| `-r, --read-only` | Export as read-only |
| `-f, --format=FMT` | Specify image format |

---

### qemu-ga
QEMU Guest Agent daemon to run inside guests.

| Flag | Description |
|------|-------------|
| `-m, --method` | Transport: `unix-listen`, `virtio-serial` (default), `isa-serial`, `vsock-listen` |
| `-p, --path` | Device/socket path |
| `-l, --logfile` | Set logfile path |
| `-d, --daemonize` | Become a daemon |
| `-F, --fsfreeze-hook` | Enable fsfreeze hook script |

## Notes
- **Acceleration**: Always use `-enable-kvm` on x86 hosts for significant performance gains when emulating x86 guests.
- **Monitor**: Use `Ctrl-Alt-2` in graphical mode to access the QEMU monitor, or `Ctrl-a c` in `-nographic` mode.
- **Escape Sequences**: In `-nographic` mode, `Ctrl-a x` exits QEMU, `Ctrl-a h` shows help.
- **Permissions**: Using `-netdev tap` or `-netdev bridge` usually requires root or specific sudoers configuration for the QEMU bridge helper.