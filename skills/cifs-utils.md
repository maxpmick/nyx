---
name: cifs-utils
description: Manage and mount Common Internet File System (CIFS) and SMB network shares. Use when mounting Windows/Samba shares, managing NTLM credentials in the kernel keyring, viewing or modifying NTFS/CIFS ACLs, or retrieving SMB-specific file information and quotas during post-exploitation or lateral movement.
---

# cifs-utils

## Overview
A suite of userspace utilities for the Linux CIFS client. It provides tools for mounting network shares, managing credentials, and interacting with SMB-specific features like ACLs, quotas, and snapshots. Category: Reconnaissance / Information Gathering, Post-Exploitation.

## Installation (if not already installed)
Assume the tool is installed. If not:
```bash
sudo apt install cifs-utils
```

## Common Workflows

### Mount a Windows Share
```bash
sudo mount -t cifs //192.168.1.100/Shared /mnt/cifs -o user=administrator,pass=P@ssword123,domain=CONTOSO
```

### View ACLs of a file on a CIFS mount
```bash
getcifsacl /mnt/cifs/sensitive_data.docx
```

### Add credentials to the kernel keyring
```bash
cifscreds add -u jdoe 192.168.1.100
```

### List volume snapshots (Previous Versions)
```bash
smbinfo list-snapshots /mnt/cifs/project/
```

## Complete Command Reference

### mount.cifs / mount.smb3
Mounts a remote UNC name to a local directory. `mount.smb3` is a symlink to `mount.cifs`.

**Usage:** `mount.cifs <remotetarget> <dir> -o <options>`

| Option | Description |
|------|-------------|
| `user=<arg>` | Username for authentication |
| `pass=<arg>` | Password for authentication |
| `dom=<arg>` | Domain name |
| `credentials=<file>` | File containing username, password, and domain |
| `guest` | Don't prompt for a password; attempt guest login |
| `sec=<mechanism>` | Security mode (ntlm, ntlmi, ntlmv2, ntlmv2i, krb5, krb5i, ntlmssp, ntlmsspi) |
| `vers=<dialect>` | SMB version (1.0, 2.0, 2.1, 3.0, 3.1.1) |
| `ro / rw` | Mount read-only or read-write |
| `uid / gid` | Set local owner/group of the mount |
| `dir_mode / file_mode` | Set default permissions |
| `port=<port>` | Target TCP port (default 445) |
| `ip=<address>` | Target IP address |
| `sign / seal` | Force packet signing or encryption |
| `snapshot=<token>` | Mount a specific snapshot/shadow copy |

### cifscreds
Manage NTLM credentials in the kernel keyring for use with the `multiuser` mount option.

| Command | Description |
|------|-------------|
| `add [-u user] [-d] <host\|domain>` | Add credentials to keyring |
| `clear [-u user] [-d] <host\|domain>` | Remove specific credentials |
| `clearall` | Remove all CIFS credentials from keyring |
| `update [-u user] [-d] <host\|domain>` | Update existing credentials |

### getcifsacl
Display the ACL in a security descriptor of a file/directory.

| Flag | Description |
|------|-------------|
| `-h` | Display help |
| `-v` | Display version |
| `-R` | Recurse into subdirectories |
| `-r` | Display raw values of ACE fields |

### setcifsacl
Alter components of a CIFS/NTFS security descriptor.

| Flag | Description |
|------|-------------|
| `-a <ACE>` | Add ACE(s) to an ACL |
| `-A <ACE>` | Add ACE(s) and reorder |
| `-D <ACE>` | Delete ACE(s) from an ACL |
| `-M <ACE>` | Modify ACE(s) in an ACL |
| `-S <ACE>` | Replace existing ACL with new ACE(s) |
| `-o <SID>` | Set owner using SID or name |
| `-g <SID>` | Set group using SID or name |
| `-U` | Apply actions to Audit ACL (SACL) instead of DACL |

### smbinfo
Display SMB-specific file information using IOCTLs.

**Subcommands:**
- `fileaccessinfo`: Prints FileAccessInfo
- `filealigninfo`: Prints FileAlignInfo
- `fileallinfo`: Prints FileAllInfo
- `filebasicinfo`: Prints FileBasicInfo
- `fileeainfo`: Prints FileEAInfo
- `filefsfullsizeinfo`: Prints FileFsFullSizeInfo
- `fileinternalinfo`: Prints FileInternalInfo
- `filemodeinfo`: Prints FileModeInfo
- `filepositioninfo`: Prints FilePositionInfo
- `filestandardinfo`: Prints FileStandardInfo
- `filestreaminfo`: Prints FileStreamInfo
- `fsctl-getobjid`: Prints objectid and volume GUID
- `getcompression`: Prints compression setting
- `setcompression`: Sets compression level
- `list-snapshots`: List previous versions of the volume
- `quota`: Prints quota for a file
- `secdesc`: Prints security descriptor
- `keys`: Prints decryption info for network traces
- `gettconinfo`: Prints TCON and Session ID

### smb2-quota
Display quota information for the SMB share.

| Flag | Description |
|------|-------------|
| `-t, --tabular` | Print in tabular format |
| `-c, --csv` | Print in CSV format |
| `-l, --list` | Print in list format |

### cifs.upcall
Userspace helper for Kerberos upcalls (usually called by kernel).

| Flag | Description |
|------|-------------|
| `--trust-dns \| -t` | Reverse resolve network address for hostname |
| `--krb5conf=<path> \| -k` | Use alternate krb5.conf |
| `--keytab=<path> \| -K` | Use specific keytab file |
| `--no-env-probe \| -E` | Do not probe $KRB5CCNAME |
| `--legacy-uid \| -l` | Use older `uid=` parameter instead of `creduid=` |
| `--expire \| -e <secs>` | Override default timeout (600s) |

### cifs.idmap
Userspace helper for mapping IDs.

**Usage:** `cifs.idmap [-h] [-v] [-t timeout] key_serial`

## Notes
- Mounting typically requires `sudo` or root privileges.
- For Kerberos authentication, ensure a valid ticket is obtained via `kinit` before mounting.
- The `mount.smb3` command is preferred for modern Windows/Samba environments to ensure SMB3+ protocols are used.