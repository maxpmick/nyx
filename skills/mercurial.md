---
name: mercurial
description: Manage distributed version control repositories using Mercurial (hg). Use when cloning source code from Mercurial repositories, managing project history, committing changes, or performing forensic analysis of repository metadata and file history during security audits.
---

# mercurial

## Overview
Mercurial is a fast, lightweight distributed Source Control Management (SCM) system. It features high-speed HTTP-based protocols, SHA1-based integrity checking, and a decentralized development model. Category: Information Gathering / Software Development.

## Installation (if not already installed)
Assume Mercurial is already installed. If the `hg` command is missing:

```bash
sudo apt install mercurial
```

## Common Workflows

### Clone a Remote Repository
```bash
hg clone https://www.mercurial-scm.org/repo/hg
```

### Check Repository Status and History
```bash
hg status
hg log -l 5
```

### Create and Commit Changes
```bash
hg add new_script.py
hg commit -m "Add initial reconnaissance script"
```

### Start a Local Web Interface for Browsing
```bash
hg serve -p 8080
```

## Complete Command Reference

### Repository Creation
| Command | Description |
|---------|-------------|
| `clone` | Make a copy of an existing repository |
| `init` | Create a new repository in the given directory |

### Remote Repository Management
| Command | Description |
|---------|-------------|
| `incoming` | Show new changesets found in source |
| `outgoing` | Show changesets not found in the destination |
| `paths` | Show aliases for remote repositories |
| `pull` | Pull changes from the specified source |
| `push` | Push changes to the specified destination |
| `serve` | Start stand-alone webserver |

### Change Creation
| Command | Description |
|---------|-------------|
| `commit` | Commit the specified files or all outstanding changes |

### Change Manipulation
| Command | Description |
|---------|-------------|
| `backout` | Reverse effect of earlier changeset |
| `graft` | Copy changes from other branches onto the current branch |
| `merge` | Merge another revision into working directory |

### Change Organization
| Command | Description |
|---------|-------------|
| `bookmarks` | Create a new bookmark or list existing bookmarks |
| `branch` | Set or show the current branch name |
| `branches` | List repository named branches |
| `phase` | Set or show the current phase name |
| `tag` | Add one or more tags for the current or given revision |
| `tags` | List repository tags |

### File content management
| Command | Description |
|---------|-------------|
| `annotate` | Show changeset information by line for each file |
| `cat` | Output the current or given revision of files |
| `copy` | Mark files as copied for the next commit |
| `diff` | Diff repository (or selected files) |
| `grep` | Search for a pattern in specified files |

### Change Navigation
| Command | Description |
|---------|-------------|
| `bisect` | Subdivision search of changesets |
| `heads` | Show branch heads |
| `identify` | Identify the working directory or specified revision |
| `log` | Show revision history of entire repository or files |

### Working Directory Management
| Command | Description |
|---------|-------------|
| `add` | Add the specified files on the next commit |
| `addremove` | Add all new files, delete all missing files |
| `files` | List tracked files |
| `forget` | Forget the specified files on the next commit |
| `purge` | Removes files not tracked by Mercurial |
| `remove` | Remove the specified files on the next commit |
| `rename` | Rename files; equivalent of copy + remove |
| `resolve` | Redo merges or set/view the merge status of files |
| `revert` | Restore files to their checkout state |
| `root` | Print the root (top) of the current working directory |
| `shelve` | Save and set aside changes from the working directory |
| `status` | Show changed files in the working directory |
| `summary` | Summarize working directory state |
| `unshelve` | Restore a shelved change to the working directory |
| `update` | Update working directory (or switch revisions) |

### Change Import/Export
| Command | Description |
|---------|-------------|
| `archive` | Create an unversioned archive of a repository revision |
| `bundle` | Create a bundle file |
| `export` | Dump the header and diffs for one or more changesets |
| `import` | Import an ordered set of patches |
| `unbundle` | Apply one or more bundle files |

### Repository Maintenance
| Command | Description |
|---------|-------------|
| `admin::verify` | Verify the integrity of the repository |
| `manifest` | Output the current or given revision of the project manifest |
| `recover` | Roll back an interrupted transaction |
| `verify` | Verify the integrity of the repository |

### Help and Configuration
| Command | Description |
|---------|-------------|
| `config` | Show combined config settings from all hgrc files |
| `help` | Show help for a given topic or a help overview |
| `version` | Output version and copyright information |

### Global Options
Use `hg help -v` to see all global options. Common flags include:
- `-R, --repository REPO`: Repository root directory or symbolic path name.
- `--cwd DIR`: Change working directory.
- `-y, --noninteractive`: Do not prompt, assume 'yes' for any required answer.
- `-v, --verbose`: Enable additional output.
- `-q, --quiet`: Suppress output.
- `--debug`: Enable debugging output.

## Notes
- `chg` is a C wrapper for Mercurial that acts as a command-line fast-start server to reduce Python startup overhead. It supports the same commands as `hg`.
- `hg-ssh` is a restricted shell for Mercurial, used to limit SSH users to only Mercurial-related actions.
- Use `hg help <command>` for detailed information on specific subcommand flags.