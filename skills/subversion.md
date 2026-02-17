---
name: subversion
description: Centralized version control system (SVN) used to manage source code and files. Use when interacting with SVN repositories, performing information gathering on exposed .svn directories, managing repository backups, or automating code checkouts and commits during penetration testing or development.
---

# subversion

## Overview
Apache Subversion (SVN) is a centralized version control system. It includes a command-line client (`svn`), repository administration tools (`svnadmin`, `svnlook`), and a network server (`svnserve`). Category: Reconnaissance / Information Gathering, Password Attacks, Web Application Testing.

## Installation (if not already installed)
Assume subversion is already installed. If you get a "command not found" error:

```bash
sudo apt install subversion subversion-tools
```

## Common Workflows

### Checkout a remote repository
```bash
svn checkout http://svn.example.com/repos/trunk local-dir
```

### Information gathering on a local working copy
```bash
svn info
svn log -l 5
```

### Search for unversioned files (potential sensitive data)
```bash
svn status | grep '?'
# Or using subversion-tools:
svn-clean -p
```

### Export a clean directory tree (without .svn metadata)
```bash
svn export http://svn.example.com/repos/trunk ./clean-files
```

## Complete Command Reference

### svn (Client Tool)
Usage: `svn <subcommand> [options] [args]`

| Subcommand | Description |
|------------|-------------|
| `add` | Put files/directories under version control |
| `auth` | Manage cached authentication credentials |
| `blame` | Show revision and author information in-line for a file |
| `cat` | Output the content of specified files or URLs |
| `changelist` | Associate (or deassociate) local paths with a changelist |
| `checkout` | Check out a working copy from a repository |
| `cleanup` | Recursively clean up the working copy |
| `commit` | Send changes from your working copy to the repository |
| `copy` | Duplicate something in working copy or repository |
| `delete` | Remove files/directories from version control |
| `diff` | Display the differences between two paths |
| `export` | Create an unversioned copy of a tree |
| `help` | Describe the usage of this program or its subcommands |
| `import` | Commit an unversioned file or tree into the repository |
| `info` | Display information about a local or remote item |
| `list` | List directory entries in the repository |
| `lock` | Lock patterns in a repository |
| `log` | Show the log messages for a set of revisions and/or files |
| `merge` | Apply the differences between two sources to a working copy path |
| `mergeinfo` | Display information related to merges |
| `mkdir` | Create a new directory under version control |
| `move` | Move and/or rename something in working copy or repository |
| `patch` | Apply a patch to a working copy |
| `propdel` | Remove a property from files, dirs, or revisions |
| `propedit` | Edit a property with an external editor |
| `propget` | Print the value of a property |
| `proplist` | List all properties |
| `propset` | Set the value of a property |
| `relocate` | Relocate the working copy to point to a different repository root |
| `resolve` | Resolve conflicts on working copy files or directories |
| `resolved` | Remove 'conflicted' state on working copy files or directories |
| `revert` | Restore pristine working copy file (undo local changes) |
| `status` | Print the status of working copy files and directories |
| `switch` | Update the working copy to a different URL |
| `unlock` | Unlock patterns in a repository |
| `update` | Bring changes from the repository into the working copy |
| `upgrade` | Upgrade the metadata storage format for a working copy |

### svnadmin (Admin Tool)
Usage: `svnadmin SUBCOMMAND REPOS_PATH [ARGS & OPTIONS ...]`

Subcommands: `build-repcache`, `crashtest`, `create`, `delrevprop`, `deltify`, `dump`, `dump-revprops`, `freeze`, `help`, `hotcopy`, `info`, `list-dblogs`, `list-unused-dblogs`, `load`, `load-revprops`, `lock`, `lslocks`, `lstxns`, `pack`, `recover`, `rev-size`, `rmlocks`, `rmtxns`, `setlog`, `setrevprop`, `setuuid`, `unlock`, `upgrade`, `verify`.

### svnserve (Server)
Usage: `svnserve [-d | -i | -t | -X] [options]`

| Flag | Description |
|------|-------------|
| `-d`, `--daemon` | Daemon mode |
| `-i`, `--inetd` | Inetd mode |
| `-t`, `--tunnel` | Tunnel mode |
| `-X`, `--listen-once` | Listen-once mode (debugging) |
| `-r`, `--root` ARG | Root of directory to serve |
| `-R`, `--read-only` | Force read only |
| `--config-file` ARG | Read configuration from file |
| `--listen-port` ARG | Listen port (default 3690) |
| `--listen-host` ARG | Listen hostname or IP address |
| `-6`, `--prefer-ipv6` | Prefer IPv6 |
| `-c`, `--compression` ARG | Compression level (0-9) |
| `-M`, `--memory-cache-size` ARG | Extra in-memory cache size in MB |
| `-T`, `--threads` | Use threads instead of fork |
| `--foreground` | Run in foreground |
| `--log-file` ARG | Log file path |
| `--pid-file` ARG | Write process ID to file |

### svnmucc (Multiple URL Command Client)
Usage: `svnmucc ACTION...`

**Actions:** `cp`, `mkdir`, `mv`, `rm`, `put`, `propset`, `propsetf`, `propdel`.
**Options:** `-m` (message), `-F` (file), `-u` (username), `-p` (password), `--password-from-stdin`, `-U` (root-url), `-r` (revision), `--non-interactive`, `--trust-server-cert-failures` ARG.

### svn-clean (Subversion Tools)
Usage: `svn-clean [options] [directory or file ...]`

| Flag | Description |
|------|-------------|
| `-e`, `--exclude` | Regex for filenames to be excluded |
| `-f`, `--force` | Delete files without write access |
| `-N`, `--non-recursive` | Do not search recursively |
| `-q`, `--quiet` | Do not print progress |
| `-p`, `--print` | Dry run: print what would be deleted |

### svn-backup-dumps
Usage: `svn-backup-dumps.py [options] repospath dumpdir`

Options: `-b` (bzip2), `-i` (incremental), `--deltas`, `-c CNT` (revs per file), `-o` (overwrite), `-r REV` (single rev), `-z` (gzip).

### svnversion
Usage: `svnversion [OPTIONS] [WC_PATH [TRAIL_URL]]`

Options: `-n` (no newline), `-c` (committed revisions), `-q` (quiet).

## Notes
- **Security**: Exposed `.svn` directories on web servers are a common vulnerability. They can be used to leak source code and internal paths.
- **Authentication**: SVN often caches credentials in `~/.subversion/auth/`.
- **svnserve**: Default port is 3690. It does not provide encryption by default unless used over a tunnel (SSH).