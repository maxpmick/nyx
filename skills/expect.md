---
name: expect
description: Automate interactive applications by scripting dialogues with programs that require user input. Use when automating SSH/FTP logins, password changes, or any CLI tool that expects real-time interaction. Includes utilities for session recording (autoexpect), multi-user collaboration (kibitz), and mass password management (passmass).
---

# expect

## Overview
Expect is a tool for automating interactive applications according to a script. It follows a dialogue, knowing what to expect from a program and providing the correct response. It is widely used for automation, testing, and wrapping interactive tools in scripts. Category: Exploitation / Post-Exploitation / Administration.

## Installation (if not already installed)
Assume expect is already installed. If missing:

```bash
sudo apt install expect
```

## Common Workflows

### Record an interactive session to a script
```bash
autoexpect -f my_script.exp ftp ftp.example.com
```
Watches your interaction and generates an Expect script named `my_script.exp`.

### Run an Expect script
```bash
expect my_script.exp
```

### Change passwords on multiple hosts
```bash
passmass host1 host2 host3 -user admin
```

### Collaborate on a single shell (kibitz)
```bash
kibitz user2
```
Allows `user2` to see and interact with your current shell session.

## Complete Command Reference

### expect
The main interpreter for Expect scripts.
```
expect [-div] [-c cmds] [[-f] cmdfile] [args]
```
| Flag | Description |
|------|-------------|
| `-d` | Enable debugger/diagnostic output |
| `-i` | Interactive mode |
| `-v` | Print version and exit |
| `-c` | Execute commands before any script file |
| `-f` | Specify the script file to execute |

### autoexpect
Generates an Expect script by watching a session.
```
autoexpect [args] [program args...]
```
| Flag | Description |
|------|-------------|
| `-f <file>` | Write the generated script to this file (default: script.exp) |
| `-c` | Conservative mode: adds pauses before sending characters to avoid timing issues |
| `-C <char>` | Define a key to toggle conservative mode during recording |
| `-p` | Prompt mode: only looks for the last line of output (usually the prompt) |
| `-P <char>` | Define a key to toggle prompt mode during recording |
| `-Q <char>` | Define a quote character to enter toggles literally |
| `-quiet` | Disable informational messages |

### kibitz
Allows two or more people to interact with one shell.
```
kibitz [args] user[@host] [program program-args...]
```
| Flag | Description |
|------|-------------|
| `-noproc` | Run with no process underneath (connects two kibitz instances) |
| `-noescape` | Disable the escape character |
| `-escape <char>`| Set the escape character (default: `^]`) |
| `-silent` | Turn off informational messages |
| `-tty <tty>` | Define the tty to which the invitation should be sent |
| `-proxy <user>` | Use a specific username for remote rlogin |

### passmass
Change passwords on multiple machines.
```
passmass [host1 host2 ...]
```
| Flag | Description |
|------|-------------|
| `-user` | User whose password will be changed (default: current user) |
| `-rlogin` | Use rlogin to access host (default) |
| `-slogin` | Use slogin to access host |
| `-ssh` | Use ssh to access host |
| `-telnet` | Use telnet to access host |
| `-program` | Program to run to set password (default: `passwd`) |
| `-prompt` | Next argument is a prompt suffix pattern |
| `-timeout` | Seconds to wait for responses (default: 30) |
| `-su <1\|0>` | If 1, prompts for root password to `su` after login |

### multixterm
Drive multiple xterms separately or together.
```
multixterm [args]
```
| Flag | Description |
|------|-------------|
| `-xa` | Arguments to pass to xterm |
| `-xc` | Command to run in each xterm (e.g., `"ssh %n"`) |
| `-xd` | Directory to search for Files menu items |
| `-xf` | File to read at startup |
| `-xn` | Name for each xterm (substitutes `%n` in `-xc`) |
| `-xv` | Verbose mode |

### tknewsbiff
Pop up a window when news appears.
```
tknewsbiff [server or config-file]
```
| Config Command | Description |
|----------------|-------------|
| `watch <group>`| Newsgroup pattern to watch |
| `ignore <group>`| Newsgroup pattern to ignore |
| `-threshold <n>`| Minimum unread articles before reporting |
| `-new <cmd>` | Command to run when news first arrives |
| `-display <cmd>`| Command to run every time news is reported |

### Other Included Utilities
- **unbuffer**: Disables the output buffering that occurs when redirecting or piping output.
- **dislocate**: Allows disconnecting and reconnecting to processes.
- **mkpasswd**: Generates a new password and can optionally apply it to a user.
- **cryptdir / decryptdir**: Encrypts or decrypts all files in a directory (requires `mcrypt`).
- **rftp**: Recursive FTP transfer utility.
- **rlogin-cwd**: rlogin with current working directory propagation.

## Notes
- **Security**: Using `passmass` or automated scripts with hardcoded passwords carries risk. Ensure scripts are protected with appropriate permissions.
- **Timing**: If an `autoexpect` script hangs, it is often a timing issue. Use the `-c` flag or manually add `sleep` commands.
- **Environment**: `EXPECT_PROMPT` can be set as a regex to help `kibitz` or `passmass` recognize unusual shell prompts.