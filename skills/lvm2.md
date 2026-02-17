---
name: lvm2
description: Manage logical volumes on Linux using the Logical Volume Manager (LVM2) and Device Mapper. Use for disk management, creating snapshots, resizing partitions, managing RAID arrays, and performing digital forensics on LVM-partitioned drives. Triggered during storage enumeration, volume resizing, or disk image analysis.
---

# lvm2

## Overview
LVM2 is a userspace toolset that provides logical volume management for the Linux kernel. It allows for flexible disk space allocation, mirroring, snapshots, and striping by grouping physical disks into Volume Groups (VGs) and creating Logical Volumes (LVs). Category: Digital Forensics / Information Gathering / System Administration.

## Installation (if not already installed)
Assume lvm2 is installed. If commands are missing:
```bash
sudo apt install lvm2 dmsetup dmeventd
```

## Common Workflows

### Enumerate Storage Hierarchy
```bash
pvs    # List Physical Volumes
vgs    # List Volume Groups
lvs    # List Logical Volumes
```

### Create a new Logical Volume
```bash
pvcreate /dev/sdb1                     # Initialize physical device
vgcreate vg_data /dev/sdb1             # Create Volume Group
lvcreate -L 50G -n lv_storage vg_data  # Create 50GB Logical Volume
```

### Extend a Volume and Resize Filesystem
```bash
lvextend -L +10G -r /dev/vg_data/lv_storage
```

### Create a Read-Only Snapshot (Forensics)
```bash
lvcreate -s -n snap_evidence -L 5G /dev/vg_data/lv_target
```

## Complete Command Reference

### Physical Volume (PV) Commands

#### pvcreate
Initialize physical volume(s) for use by LVM.
`pvcreate [options] PV ...`
- `-f, --force`: Force initialization.
- `-M, --metadatatype lvm2`: Set metadata type.
- `-u, --uuid <string>`: Specify UUID.
- `-Z, --zero y|n`: Zero first 512 bytes.
- `--dataalignment <size>`: Align data to size.
- `--dataalignmentoffset <size>`: Offset alignment.
- `--bootloaderareasize <size>`: Reserve space for bootloader.
- `--labelsector <number>`: Sector for LVM label.
- `--pvmetadatacopies 0|1|2`: Number of metadata copies.
- `--metadatasize <size>`: Size of metadata area.
- `--metadataignore y|n`: Ignore metadata on this PV.
- `--norestorefile`: Do not read backup file.
- `--setphysicalvolumesize <size>`: Override device size.
- `--restorefile <file>`: Use specific backup file.

#### pvchange
Change attributes of physical volume(s).
`pvchange [options] [PV|Select ...]`
- `-a, --all`: Apply to all PVs.
- `-x, --allocatable y|n`: Allow/disallow allocation.
- `-u, --uuid`: Generate new UUID.
- `--addtag <tag>`: Add tag.
- `--deltag <tag>`: Remove tag.
- `--metadataignore y|n`: Ignore metadata.

#### pvdisplay
Display attributes of PVs.
- `-m, --maps`: Show mapping of fragments.
- `-s, --short`: Short format.
- `-C, --columns`: Columnar output.
- `-c, --colon`: Colon separated output.

#### pvmove
Move extents from one PV to another.
`pvmove [options] [SourcePV [DestPV...]]`
- `-n, --name <LV>`: Move only extents of specific LV.
- `--atomic`: Atomic move.
- `--abort`: Abort ongoing move.

#### pvremove, pvresize, pvscan, pvck
- `pvremove`: Remove LVM labels.
- `pvresize`: Resize PV to match device size.
- `pvscan`: List all PVs.
- `pvck`: Check metadata consistency. Use `--dump <headers|metadata>` or `--repair`.

---

### Volume Group (VG) Commands

#### vgcreate
Create a volume group.
`vgcreate [options] VG_new PV ...`
- `-c, --clustered y|n`: Cluster support.
- `-l, --maxlogicalvolumes <num>`: Max LVs allowed.
- `-p, --maxphysicalvolumes <num>`: Max PVs allowed.
- `-s, --physicalextentsize <size>`: Set PE size (default 4MB).
- `--shared`: Create a shared VG.
- `--systemid <string>`: Set system ID.

#### vgchange
Change VG attributes.
- `-a, --activate y|n|ay`: Activate/deactivate LVs in VG.
- `-x, --resizeable y|n`: Allow/disallow adding PVs.
- `--poll y|n`: Start/stop background conversions.
- `--refresh`: Reactivate using latest metadata.
- `--lockstart/--lockstop`: Manage shared VG locks.

#### vgextend, vgreduce
- `vgextend`: Add PVs to a VG.
- `vgreduce`: Remove PVs from a VG. Use `--removemissing` to clean up failed drives.

#### vgs, vgdisplay, vgscan, vgrename
- `vgs`: Report info about VGs.
- `vgdisplay`: Show detailed VG info.
- `vgscan`: Search for VGs on the system.
- `vgrename`: Rename a VG.

#### vgcfgbackup, vgcfgrestore
- `vgcfgbackup`: Backup VG metadata to `/etc/lvm/backup`.
- `vgcfgrestore`: Restore VG metadata from file.

---

### Logical Volume (LV) Commands

#### lvcreate
Create a logical volume.
`lvcreate [options] VG`
- `-L, --size <size>`: Absolute size (e.g., 10G).
- `-l, --extents <num[%{VG|FREE|ORIGIN}]>`: Size in PEs or percentage.
- `-n, --name <string>`: Name of the LV.
- `-s, --snapshot`: Create a COW snapshot.
- `-i, --stripes <num>`: Number of stripes.
- `-I, --stripesize <size>`: Size of stripes.
- `-m, --mirrors <num>`: Number of mirror images.
- `-T, --thin`: Create a thin LV or thin pool.
- `-V, --virtualsize <size>`: Virtual size for thin LV.
- `--type <linear|striped|snapshot|raid|thin|cache|vdo>`: Set LV type.

#### lvchange
Change LV attributes.
- `-p, --permission rw|r`: Set read/write or read-only.
- `-a, --activate y|n|ay`: Activate/deactivate.
- `--refresh`: Reload metadata.

#### lvconvert
Change LV layout (e.g., linear to mirror, thin pool conversion).
- `--repair`: Repair a mirror/raid/thin LV.
- `--replace <PV>`: Replace a specific PV in a RAID LV.
- `--splitcache / --splitmirrors`: Separate components.

#### lvextend, lvreduce, lvresize
- `-r, --resizefs`: Resize the underlying filesystem automatically.
- `-L, --size [+|-]<size>`: Change size.

#### lvs, lvdisplay, lvscan, lvremove, lvrename
- `lvs`: Report info about LVs.
- `lvdisplay`: Detailed LV info.
- `lvremove`: Remove an LV.
- `lvrename`: Rename an LV.

---

### Device Mapper & Utilities

#### dmsetup
Low-level logical volume management.
- `ls`: List devices.
- `info`: Show status.
- `table`: Show table for a device.
- `remove`: Remove a device.
- `suspend/resume`: Pause/unpause I/O.

#### blkdeactivate
Deactivate block device tree.
- `-u, --umount`: Unmount before deactivating.
- `-l, --lvmoptions retry,wholevg`: LVM specific flags.

#### fsadm
Resize or check filesystem on a device.
- `check <device>`: Run fsck.
- `resize <device> [size]`: Resize filesystem.

#### dmstats
Device-mapper statistics management.
- `list`, `create`, `delete`, `report`.

---

### Daemons and Control

#### dmeventd
Device-mapper event daemon.
- `-d`: Debug mode.
- `-f`: Foreground.
- `-R`: Restart.

#### lvmlockd / lvmlockctl
LVM locking daemon for shared storage.
- `lvmlockctl -i`: Print lock state.
- `lvmlockctl -S`: Stop all lockspaces.

#### lvmdbusd
LVM D-Bus daemon for programmatic access.

## Notes
- **Forensics**: When analyzing a disk image with LVM, use `vgscan` and `vgchange -ay` to make the volumes accessible in `/dev/mapper/`.
- **Safety**: Always use the `-t` (test) flag with LVM commands if unsure of the outcome.
- **Resizing**: The `-r` flag in `lvextend/lvreduce` is highly recommended as it handles `resize2fs` or `xfs_growfs` for you.