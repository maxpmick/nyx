---
name: python
description: Execute Python scripts, manage environments, debug code, and access documentation. Use when running exploit scripts, developing custom security tools, automating tasks, or debugging Python-based malware and utilities during penetration testing and security analysis.
---

# python

## Overview
Python is an interpreted, high-level, object-oriented programming language widely used in security for automation, exploit development, and data analysis. This skill covers the Python interpreter, the `pdb` debugger, `pydoc` documentation tool, and `python-config` for build options. Category: General Utility / Development.

## Installation (if not already installed)
Python is pre-installed on Kali Linux. If symlinks are missing:

```bash
sudo apt install python-is-python3
sudo apt install python-dev-is-python3
```

## Common Workflows

### Run a script and enter interactive mode
```bash
python -i exploit.py
```
Useful for inspecting variables after a script finishes execution.

### Debug a script with pdb
```bash
pdb -c continue malicious_script.py
```
Runs the script under the debugger until an exception occurs or a breakpoint is hit.

### Search documentation for a module
```bash
pydoc -k requests
```
Searches for the "requests" keyword in all available module synopses.

### Check build flags for C extensions
```bash
python-config --cflags --ldflags
```

## Complete Command Reference

### python (Interpreter)
```
python [option] ... [-c cmd | -m mod | file | -] [arg] ...
```

| Flag | Description |
|------|-------------|
| `-b` | Issue warnings about converting bytes/bytearray to str and comparing bytes/bytearray with str or bytes with int. (`-bb` for errors) |
| `-B` | Don't write .pyc files on import |
| `-c cmd` | Program passed in as string (terminates option list) |
| `-d` | Turn on parser debugging output (debug builds only) |
| `-E` | Ignore PYTHON* environment variables (such as PYTHONPATH) |
| `-h`, `-?`, `--help` | Print help message and exit |
| `-i` | Inspect interactively after running script |
| `-I` | Isolate Python from the user's environment (implies -E, -P and -s) |
| `-m mod` | Run library module as a script (terminates option list) |
| `-O` | Remove assert and __debug__-dependent statements |
| `-OO` | Do -O changes and also discard docstrings |
| `-P` | Don't prepend a potentially unsafe path to sys.path |
| `-q` | Don't print version and copyright messages on startup |
| `-s` | Don't add user site directory to sys.path |
| `-S` | Don't imply 'import site' on initialization |
| `-u` | Force stdout and stderr streams to be unbuffered |
| `-v` | Verbose (trace import statements); use multiple times for more detail |
| `-V`, `--version` | Print version number (twice for build info) |
| `-W arg` | Warning control (action:message:category:module:lineno) |
| `-x` | Skip first line of source (for non-Unix #!cmd) |
| `-X opt` | Set implementation-specific option |
| `--check-hash-based-pycs <val>` | Control .pyc invalidation (always\|default\|never) |
| `--help-env` | Print help about Python environment variables |
| `--help-xoptions` | Print help about implementation-specific -X options |
| `--help-all` | Print complete help information |

### pdb (Debugger)
```
pdb [-h] [-c command] (-m module | pyfile) [args ...]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-c command` | pdb commands to execute (as if in .pdbrc) |
| `-m module` | Name of an executable module or package to debug |

### pydoc (Documentation)
```
pydoc <option> [name]
```

| Usage | Description |
|-------|-------------|
| `pydoc <name>` | Show text documentation for a keyword, topic, function, or module |
| `pydoc -k <keyword>` | Search for keyword in synopsis lines of all modules |
| `pydoc -n <hostname>` | Start HTTP server with given hostname (default: localhost) |
| `pydoc -p <port>` | Start HTTP server on given port (0 for arbitrary) |
| `pydoc -b` | Start HTTP server and open a web browser |
| `pydoc -w <name>` | Write out HTML documentation for a module to a file |

### python-config (Build Configuration)
```
python-config [option]
```

| Flag | Description |
|------|-------------|
| `--prefix` | Print the prefix of the python installation |
| `--exec-prefix` | Print the executable prefix |
| `--includes` | Print the include flags for C/C++ compiler |
| `--libs` | Print the libraries to link against |
| `--cflags` | Print the C compiler flags |
| `--ldflags` | Print the flags to pass to the linker |
| `--extension-suffix` | Print the suffix used for extension modules |
| `--abiflags` | Print the ABI flags used by the interpreter |
| `--configdir` | Print the configuration directory |
| `--embed` | Print flags for embedding python in an application |

## Notes
- On modern Kali systems, `python` is a symlink to `python3`.
- Use `python -m http.server <port>` for a quick way to host files during a pentest.
- The `-u` flag is often necessary when piping output from a Python script to ensure real-time logging.