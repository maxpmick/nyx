---
name: nfs-utils
description: A suite of tools for managing Network File System (NFS) clients and servers. Use for discovering NFS exports, mounting remote shares, analyzing NFS traffic statistics, and configuring kernel-level NFS services. Essential for reconnaissance of networked storage, vulnerability analysis of file sharing configurations, and post-exploitation data access.
---

# nfs-utils

## Overview
NFS-utils provides the user-space programs necessary to use the Linux NFS client and server. It includes tools for mounting (`mount.nfs`), information gathering (`showmount`), and performance monitoring (`nfsstat`, `nfsiostat`). Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install nfs-common nfs-kernel-server
```

## Common Workflows

### Enumerate NFS Exports
Discover what directories a remote server is sharing:
```bash
showmount -e <target-ip>
```

### Mount a Remote Share
Mount a discovered export to a local directory:
```bash
mkdir /mnt/nfs_share
mount.nfs <target-ip>:/exported/path /mnt/nfs_share -o nolock
```

### Check NFS Statistics
View client-side RPC and network statistics:
```bash
nfsstat -c
```

### Monitor I/O Performance
Display per-mount statistics every 5 seconds:
```bash
nfsiostat 5
```

## Complete Command Reference

### Client & Common Tools (nfs-common)

#### showmount
Show mount information for an NFS server.
- `-a, --all`: List both the client hostname or IP address and mounted directory in host:dir format.
- `-d, --directories`: List only the directories mounted by some client.
- `-e, --exports`: Show the NFS server's export list.
- `-h, --help`: Show help.
- `-v, --version`: Show version.
- `--no-headers`: Do not print the descriptive header.

#### mount.nfs / mount.nfs4
Mount a Network File System.
- `-r`: Mount file system readonly.
- `-v`: Verbose.
- `-w`: Mount file system read-write.
- `-f`: Fake mount; do not actually mount.
- `-n`: Do not update `/etc/mtab`.
- `-s`: Tolerate sloppy mount options.
- `-o <options>`: NFS specific options (e.g., `nolock`, `vers=3`, `proto=tcp`).

#### umount.nfs / umount.nfs4
Unmount a Network File System.
- `-f`: Force unmount.
- `-l`: Lazy unmount (detach now, clean up later).
- `-r`: Remount.

#### nfsstat
List NFS statistics.
- `-m, --mounts`: Show statistics on mounted NFS filesystems.
- `-c, --client`: Show NFS client statistics.
- `-s, --server`: Show NFS server statistics.
- `-2, -3, -4`: Show specific NFS version statistics.
- `-o <facility>`: Show statistics for: `nfs`, `rpc`, `net`, `fh`, `io`, `ra`, `rc`, `all`.
- `-v, --verbose, --all`: Same as `-o all`.
- `-r, --rpc`: Show RPC statistics.
- `-n, --nfs`: Show NFS statistics.
- `-Z[#], --sleep[=#]`: Collect stats until interrupted (optional interval #).
- `-S, --since <file>`: Show difference between current and saved stats.
- `-l, --list`: Print stats in list format.

#### nfsiostat
Emulate iostat for NFS mount points.
- `-a, --attr`: Display attribute cache statistics.
- `-d, --dir`: Display directory operation statistics.
- `-p, --page`: Display page cache statistics.
- `-s, --sort`: Sort by ops/second.
- `-l <list>`: Print stats for first LIST mount points.

#### mountstats
Displays NFS client per-mount statistics.
- `mountstats`: Default; RPC, event, and byte counts.
- `nfsstat`: nfsstat-like statistics.
- `iostat`: iostat-like statistics.

#### nfsconf
Query/Set NFS configuration.
- `-v`: Increase verbosity.
- `--file <file>`: Load specific config file.
- `--dump [file]`: Output configuration.
- `--get [--arg sub] <sec> <tag>`: Get specific value.
- `--set [--arg sub] <sec> <tag> <val>`: Set value.
- `--unset [--arg sub] <sec> <tag>`: Remove value.

#### rpc.statd
NSM service daemon.
- `-F, --foreground`: No-daemon mode.
- `-d, --no-syslog`: Log to stderr.
- `-p <port>`: Port to listen on.
- `-o <port>`: Outgoing port.
- `-n <name>`: Local hostname.
- `-P <path>`: State directory path.
- `-N`: Notify only mode.
- `-L, --no-notify`: Do not perform notification.

#### Other Common Daemons
- `blkmapd [-hdf]`: pNFS block layout mapping daemon.
- `nfsidmap [-vh] [-c | -u | -g | -r key | -d | -l | -t timeout]`: ID mapper upcall.
- `rpc.gssd [-flMnvrDHC] [-p pipe] [-k keytab] [-d cache] [-t timeout]`: RPCSEC_GSS daemon.
- `rpc.idmapd [-hfvCS] [-p path] [-c path]`: NFSv4 ID/Name mapper.
- `rpcctl {client|switch|xprt}`: SunRPC connection info.
- `rpcdebug [-v] [-m module] [-s flags|-c flags]`: Kernel debug flags.
- `sm-notify [-dfq] [-m mins] [-p port] [-P path] [-v host]`: Reboot notifications.

### Server Tools (nfs-kernel-server)

#### exportfs
Maintain table of exported NFS file systems.
- `-a`: Export or unexport all directories.
- `-r`: Re-export all directories (syncs `/etc/exports`).
- `-u`: Unexport.
- `-f`: Flush export table.
- `-v`: Verbose.
- `-i`: Ignore `/etc/exports`.
- `-o <options>`: Specify export options.

#### rpc.nfsd
NFS server process.
- `-H <host>`: Specify hostname.
- `-p, -P <port>`: Port to listen on.
- `-N, -V <version>`: Disable/Enable specific NFS version.
- `-t, -T`: Enable/Disable TCP.
- `-u, -U`: Enable/Disable UDP.
- `-r, --rdma`: Enable RDMA.
- `-G <secs>`: Grace time.
- `-L <secs>`: Lease time.
- `<nrservs>`: Number of server threads.

#### rpc.mountd
NFS mount daemon.
- `-F, --foreground`: Foreground mode.
- `-d <kind>`: Debugging.
- `-l, --log-auth`: Log authentication.
- `-i, --cache-use-ipaddr`: Use IP addresses in cache.
- `-T, --ttl <ttl>`: Cache TTL.
- `-p <port>`: Port to listen on.
- `-V, -N <version>`: Enable/Disable NFS versions.
- `-r, --reverse-lookup`: Perform reverse DNS lookups.
- `-g, --manage-gids`: Manage group IDs.

#### nfsdclnts
Print NFS client information for server.
- `-t <type>`: type (open, lock, deleg, layout, all).
- `--clientinfo`: Output client info.
- `--hostname`: Print hostnames instead of IPs.

#### nfsdctl
Control program for kernel NFS server.
- `pool-mode`: Get/set host pool mode.
- `listener`: Get/set listener info.
- `version`: Get/set supported versions.
- `threads`: Get/set thread settings.
- `status`: Get RPC processing info.
- `autostart`: Start with `/etc/nfs.conf` settings.

#### nfsdcld / nfsdclddb
- `nfsdcld [-hFd] [-p pipe] [-s store]`: Client tracking daemon.
- `nfsdclddb [-p path] {fix-table-names, downgrade-schema, print}`: SQLite DB manipulation.

#### nfsref
Manage NFS referrals.
- `add`: Add junction.
- `remove`: Remove junction.
- `lookup`: Enumerate junction.

## Notes
- NFSv3 often requires the `nolock` option if the `statd` service is not running or blocked by a firewall.
- Use `showmount -e` as a primary reconnaissance step when encountering port 2049 (NFS) or 111 (RPCBind).
- The `/etc/exports` file on the server defines which clients can access which directories and with what permissions (e.g., `rw`, `ro`, `no_root_squash`).