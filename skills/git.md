---
name: git
description: Fast, scalable, distributed revision control system used for tracking changes in source code. Use when performing source code analysis, cloning repositories for exploitation, managing local toolsets, performing digital forensics on version history, or identifying sensitive information (secrets) leaked in commit logs.
---

# git

## Overview
Git is a distributed source code management tool. Every Git working directory is a full-fledged repository with full revision tracking capabilities, not dependent on network access or a central server. It is essential for reconnaissance, exploitation (cloning payloads/tools), and forensics (analyzing history).

## Installation (if not already installed)
Assume git is already installed. If you get a "command not found" error:

```bash
sudo apt install git
```

For full functionality including GUI and SVN/CVS support:
```bash
sudo apt install git-all
```

## Common Workflows

### Clone a repository for analysis
```bash
git clone https://github.com/example/target-repo.git
```

### Search commit history for sensitive keywords
```bash
git log -p | grep -Ei "password|api_key|token|secret"
```

### View changes between two specific commits
```bash
git diff <commit-hash-1> <commit-hash-2>
```

### Restore a deleted file from history
```bash
git restore --source=<commit-hash> <file-path>
```

## Complete Command Reference

### Global Options
```
git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
    [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
    [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
    [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]
    [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]
```

### Common Subcommands

| Command | Description |
|---------|-------------|
| `clone` | Clone a repository into a new directory |
| `init` | Create an empty Git repository or reinitialize an existing one |
| `add` | Add file contents to the index |
| `mv` | Move or rename a file, a directory, or a symlink |
| `restore` | Restore working tree files |
| `rm` | Remove files from the working tree and from the index |
| `bisect` | Use binary search to find the commit that introduced a bug |
| `diff` | Show changes between commits, commit and working tree, etc |
| `grep` | Print lines matching a pattern |
| `log` | Show commit logs |
| `show` | Show various types of objects |
| `status` | Show the working tree status |
| `branch` | List, create, or delete branches |
| `commit` | Record changes to the repository |
| `merge` | Join two or more development histories together |
| `rebase` | Reapply commits on top of another base tip |
| `reset` | Reset current HEAD to the specified state |
| `switch` | Switch branches |
| `tag` | Create, list, delete or verify a tag object signed with GPG |
| `fetch` | Download objects and refs from another repository |
| `pull` | Fetch from and integrate with another repository or a local branch |
| `push` | Update remote refs along with associated objects |
| `backfill`| Download missing objects in a partial clone |

### git-receive-pack
Invoked by `git send-pack` to update the repository with pushed information.

| Option | Description |
|--------|-------------|
| `<git-dir>` | The repository to sync into |
| `--http-backend-info-refs` | Used by git-http-backend to serve info/refs requests |
| `--skip-connectivity-check` | Bypasses connectivity checks (risks corruption) |

### git-upload-archive
Invoked by `git archive --remote` to send a generated archive.

| Option | Description |
|--------|-------------|
| `<repository>` | The repository to get a tar archive from |

### git-upload-pack
Invoked by `git fetch-pack` to send objects back to the requester.

| Option | Description |
|--------|-------------|
| `--[no-]strict` | Do not try `<directory>/.git/` if directory is not a Git directory |
| `--timeout=<n>` | Interrupt transfer after `<n>` seconds of inactivity |
| `--stateless-rpc` | Perform only a single read-write cycle (for HTTP POST) |
| `--http-backend-info-refs` | Serve info/refs requests |
| `<directory>` | The repository to sync from |

### git-cvsserver
CVS server emulator for Git.

| Option | Description |
|--------|-------------|
| `--base-path <path>` | Prepend to requested CVSROOT |
| `--strict-paths` | Don't allow recursing into subdirectories |
| `--export-all` | Don't check for gitcvs.enabled in config |
| `-V`, `--version` | Print version |
| `-h`, `-H` | Print usage |

### gitk
Graphical repository browser.

| Option | Description |
|--------|-------------|
| `--all` | Show all refs (branches, tags, etc.) |
| `--branches[=<pattern>]` | Pretend all branches are listed |
| `--tags[=<pattern>]` | Pretend all tags are listed |
| `--remotes[=<pattern>]` | Pretend all remote branches are listed |
| `--since=<date>` | Show commits more recent than date |
| `--until=<date>` | Show commits older than date |
| `--date-order` | Sort commits by date |
| `--merge` | Show commits related to merge conflicts |
| `--left-right` | Mark which side of a symmetric difference a commit is from |
| `--full-history` | Do not prune history when filtering by path |
| `--simplify-merges` | Remove needless merges from history |
| `--ancestry-path` | Only display commits on the ancestry chain between two points |
| `-L<start>,<end>:<file>` | Trace evolution of a line range |
| `--argscmd=<cmd>` | Command to determine revision range dynamically |
| `--select-commit=<ref>` | Select specific commit after loading |

### scalar
Tool for managing large Git repositories.
- Commands: `clone`, `list`, `register`, `unregister`, `run`, `reconfigure`, `delete`, `help`, `version`, `diagnose`.

## Notes
- **Security**: Avoid running Git in untrusted `.git` directories as configuration options or hooks can execute arbitrary code.
- **Forensics**: Use `git reflog` to see local history even if branches were deleted or commits were amended.
- **Data Leakage**: Check `.gitignore` files to see what developers intended to hide, and check `.git/config` for hardcoded credentials.