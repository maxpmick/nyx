---
name: cadaver
description: Command-line WebDAV client for interacting with WebDAV-enabled web servers. Supports file upload, download, in-place editing, namespace operations (move/copy), collection management, and resource locking. Use when performing web application testing, exploiting misconfigured WebDAV instances, or managing remote files over HTTP/HTTPS.
---

# cadaver

## Overview
cadaver is a command-line WebDAV client for Unix-like systems. It provides an interface similar to a standard FTP client, allowing users to interact with WebDAV collections to upload, download, and manipulate files and properties on a remote web server. Category: Web Application Testing.

## Installation (if not already installed)
Assume cadaver is already installed. If you get a "command not found" error:

```bash
sudo apt install cadaver
```

## Common Workflows

### Connect to a WebDAV server
```bash
cadaver http://example.com/dav/
```

### Upload a local file to the server
```bash
cadaver http://example.com/dav/
dav:/dav/> put shell.php
```

### Download a file and edit it locally
```bash
cadaver http://example.com/dav/
dav:/dav/> get index.html
dav:/dav/> edit index.html
```

### Create a new collection (directory)
```bash
cadaver http://example.com/dav/
dav:/dav/> mkcol new_folder
```

## Complete Command Reference

### Global Options
```
cadaver [OPTIONS] URL
```

| Flag | Description |
|------|-------------|
| `-t`, `--tolerant` | Allow `cd` or `open` into a non-WebDAV enabled collection. |
| `-r`, `--rcfile=FILE` | Read script/commands from `FILE` instead of the default `~/.cadaverrc`. |
| `-p`, `--proxy=PROXY[:PORT]` | Use proxy host `PROXY` and optional proxy port `PORT`. |
| `-V`, `--version` | Display version information. |
| `-h`, `--help` | Display the help message. |

### Internal Commands
Once connected to a WebDAV server, the following commands are available within the cadaver shell:

| Command | Description |
|---------|-------------|
| `ls [path]` | List contents of current or specified collection. |
| `cd path` | Change to specified collection. |
| `pwd` | Print name of current remote collection. |
| `put local [remote]` | Upload a local file. |
| `get remote [local]` | Download a remote resource. |
| `mget remote...` | Download multiple remote resources. |
| `mput local...` | Upload multiple local files. |
| `edit resource` | Edit a remote resource (downloads, opens editor, re-uploads). |
| `mkdir name` | Create a new collection (alias for `mkcol`). |
| `mkcol name` | Create a new collection. |
| `rm resource...` | Delete remote resource(s). |
| `rmcol coll...` | Delete remote collection(s). |
| `move src dest` | Move/rename a remote resource. |
| `copy src dest` | Copy a remote resource. |
| `lock resource` | Lock a resource. |
| `unlock resource` | Unlock a resource. |
| `discover path` | Discover WebDAV properties of a path. |
| `propget path [prop]` | Get properties of a resource. |
| `propset path prop val` | Set a property on a resource. |
| `open URL` | Open a connection to a different WebDAV server. |
| `close` | Close the current connection. |
| `quit` / `exit` | Exit cadaver. |
| `help [command]` | Display help for a specific command. |

## Notes
- The URL must be an absolute URI using the `http:` or `https:` scheme.
- cadaver supports GnuTLS for secure HTTPS connections.
- If the server requires authentication, cadaver will prompt for a username and password.
- The `.cadaverrc` file can be used to automate tasks or set default behaviors upon startup.