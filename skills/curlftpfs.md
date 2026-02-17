---
name: curlftpfs
description: Mount remote FTP hosts as local directories using FUSE and cURL. Use when you need to interact with FTP server contents using standard filesystem tools, perform file transfers via GUI file managers, or automate scripts that require local path access to remote FTP data. Supports SSL/TLS, HTTP proxies, and automatic reconnection.
---

# curlftpfs

## Overview
CurlFtpFS is a filesystem client based on FUSE and libcurl for accessing FTP hosts. It maps a remote FTP directory structure to a local mount point, allowing standard shell commands (ls, cp, grep) to work directly on remote files. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume curlftpfs is already installed. If the command is missing:

```bash
sudo apt install curlftpfs
```

## Common Workflows

### Basic Anonymous Mount
```bash
mkdir /mnt/ftp_server
curlftpfs ftp.example.com /mnt/ftp_server
```

### Authenticated Mount with SSL/TLS
```bash
curlftpfs -o user=username:password,ssl,no_verify_peer ftp.example.com /mnt/remote_disk
```

### Mounting through an HTTP Proxy
```bash
curlftpfs -o proxy=http://10.10.10.1:8080,proxy_user=admin:pass ftp.example.com /mnt/proxy_ftp
```

### Unmounting the Filesystem
```bash
fusermount -u /mnt/ftp_server
```

## Complete Command Reference

```bash
curlftpfs <ftphost> <mountpoint> [options]
```

### General Options
| Flag | Description |
|------|-------------|
| `-o opt,[opt...]` | Specify FTP or FUSE options |
| `-v`, `--verbose` | Make libcurl print verbose debug information |
| `-h`, `--help` | Print help message |
| `-V`, `--version` | Print version |

### FTP Options (used with -o)
| Option | Description |
|--------|-------------|
| `ftpfs_debug` | Print debugging information |
| `transform_symlinks` | Prepend mountpoint to absolute symlink targets |
| `disable_epsv` | Use PASV without trying EPSV first (default) |
| `enable_epsv` | Try EPSV before reverting to PASV |
| `skip_pasv_ip` | Skip the IP address for PASV |
| `ftp_port=STR` | Use PORT with specified address instead of PASV |
| `disable_eprt` | Use PORT without trying EPRT first |
| `ftp_method=[multicwd\|singlecwd]` | Control CWD usage |
| `custom_list=STR` | Command used to list files (Defaults to "LIST -a") |
| `tcp_nodelay` | Use the TCP_NODELAY option |
| `connect_timeout=N` | Maximum time allowed for connection in seconds |
| `ssl` | Enable SSL/TLS for both control and data connections |
| `ssl_control` | Enable SSL/TLS only for control connection |
| `ssl_try` | Try SSL/TLS first but connect anyway if it fails |
| `no_verify_hostname` | Do not verify the hostname (SSL) |
| `no_verify_peer` | Do not verify the peer (SSL) |
| `cert=STR` | Client certificate file (SSL) |
| `cert_type=STR` | Certificate file type (DER/PEM/ENG) (SSL) |
| `key=STR` | Private key file name (SSL) |
| `key_type=STR` | Private key file type (DER/PEM/ENG) (SSL) |
| `pass=STR` | Pass phrase for the private key (SSL) |
| `engine=STR` | Crypto engine to use (SSL) |
| `cacert=STR` | File with CA certificates to verify the peer (SSL) |
| `capath=STR` | CA directory to verify peer against (SSL) |
| `ciphers=STR` | SSL ciphers to use (SSL) |
| `interface=STR` | Specify network interface/address to use |
| `krb4=STR` | Enable krb4 with specified security level |
| `proxy=STR` | Use host:port HTTP proxy |
| `proxytunnel` | Operate through a HTTP proxy tunnel (using CONNECT) |
| `proxy_anyauth` | Pick "any" proxy authentication method |
| `proxy_basic` | Use Basic authentication on the proxy |
| `proxy_digest` | Use Digest authentication on the proxy |
| `proxy_ntlm` | Use NTLM authentication on the proxy |
| `httpproxy` | Use a HTTP proxy (default) |
| `socks4` | Use a SOCKS4 proxy |
| `socks5` | Use a SOCKS5 proxy |
| `user=STR` | Set server user and password (format: `user:pass`) |
| `proxy_user=STR` | Set proxy user and password |
| `tlsv1` | Use TLSv1 (SSL) |
| `sslv3` | Use SSLv3 (SSL) |
| `ipv4` | Resolve name to IPv4 address |
| `ipv6` | Resolve name to IPv6 address |
| `utf8` | Try to transfer file list with utf-8 encoding |
| `codepage=STR` | Set the codepage the server uses |
| `iocharset=STR` | Set the charset used by the client |

### Cache Options (used with -o)
| Option | Description |
|--------|-------------|
| `cache=yes\|no` | Enable/disable cache (default: yes) |
| `cache_timeout=SECS` | Set timeout for stat, dir, link at once (default: 10s) |
| `cache_stat_timeout=SECS` | Set stat timeout |
| `cache_dir_timeout=SECS` | Set dir timeout |
| `cache_link_timeout=SECS` | Set link timeout |

### FUSE Options
| Flag / Option | Description |
|---------------|-------------|
| `-d`, `-o debug` | Enable debug output (implies -f) |
| `-f` | Foreground operation |
| `-s` | Disable multi-threaded operation |
| `-o allow_other` | Allow access to other users |
| `-o allow_root` | Allow access to root |
| `-o auto_unmount` | Auto unmount on process termination |
| `-o nonempty` | Allow mounts over non-empty file/dir |
| `-o default_permissions` | Enable permission checking by kernel |
| `-o fsname=NAME` | Set filesystem name |
| `-o subtype=NAME` | Set filesystem type |
| `-o large_read` | Issue large read requests (2.4 only) |
| `-o max_read=N` | Set maximum size of read requests |
| `-o hard_remove` | Immediate removal (don't hide files) |
| `-o use_ino` | Let filesystem set inode numbers |
| `-o readdir_ino` | Try to fill in d_ino in readdir |
| `-o direct_io` | Use direct I/O |
| `-o kernel_cache` | Cache files in kernel |
| `-o [no]auto_cache` | Enable caching based on modification times (off) |
| `-o umask=M` | Set file permissions (octal) |
| `-o uid=N` | Set file owner |
| `-o gid=N` | Set file group |
| `-o entry_timeout=T` | Cache timeout for names (1.0s) |
| `-o negative_timeout=T` | Cache timeout for deleted names (0.0s) |
| `-o attr_timeout=T` | Cache timeout for attributes (1.0s) |
| `-o ac_attr_timeout=T` | Auto cache timeout for attributes |
| `-o noforget` | Never forget cached inodes |
| `-o remember=T` | Remember cached inodes for T seconds (0s) |
| `-o nopath` | Don't supply path if not necessary |
| `-o intr` | Allow requests to be interrupted |
| `-o intr_signal=NUM` | Signal to send on interrupt (10) |
| `-o modules=M1[:M2...]` | Names of modules to push onto filesystem stack |
| `-o max_write=N` | Set maximum size of write requests |
| `-o max_readahead=N` | Set maximum readahead |
| `-o max_background=N` | Set number of maximum background requests |
| `-o congestion_threshold=N` | Set kernel's congestion threshold |
| `-o async_read` | Perform reads asynchronously (default) |
| `-o sync_read` | Perform reads synchronously |
| `-o atomic_o_trunc` | Enable atomic open+truncate support |
| `-o big_writes` | Enable larger than 4kB writes |
| `-o no_remote_lock` | Disable remote file locking |
| `-o no_remote_flock` | Disable remote file locking (BSD) |
| `-o no_remote_posix_lock` | Disable remove file locking (POSIX) |
| `-o [no_]splice_write` | Use splice to write to the fuse device |
| `-o [no_]splice_move` | Move data while splicing to the fuse device |
| `-o [no_]splice_read` | Use splice to read from the fuse device |

### Module Options

**[iconv]**
| Option | Description |
|--------|-------------|
| `-o from_code=CHARSET` | Original encoding of file names (default: UTF-8) |
| `-o to_code=CHARSET` | New encoding of the file names (default: ANSI_X3.4-1968) |

**[subdir]**
| Option | Description |
|--------|-------------|
| `-o subdir=DIR` | Prepend this directory to all paths (mandatory) |
| `-o [no]rellinks` | Transform absolute symlinks to relative |

## Notes
- To unmount, use `fusermount -u <mountpoint>`.
- If you encounter permission issues, try `-o allow_other` (requires `/etc/fuse.conf` configuration).
- For security, avoid putting passwords in the command line; use a `.netrc` file or environment variables if supported by the underlying libcurl.