---
name: zim
description: A graphical text editor and desktop wiki used to maintain collections of wiki pages, organize notes, and manage tasks. Use when documenting penetration testing findings, organizing reconnaissance data, maintaining a local knowledge base, or drafting reports in a structured, linkable plain-text format.
---

# zim

## Overview
Zim is a graphical text editor based on wiki technologies. It stores data in a folder structure of plain text files with wiki formatting. It is ideal for information gathering, brainstorming, and maintaining structured notes during security engagements. Category: Information Gathering / Reporting.

## Installation (if not already installed)
Assume zim is already installed. If you encounter a "command not found" error:

```bash
sudo apt install zim
```

## Common Workflows

### Open a specific notebook and page
```bash
zim /path/to/notes "PenTest_Project:Findings"
```

### Export a notebook to HTML for reporting
```bash
zim --export --format=html --output=./report_html /path/to/notes
```

### Run a local web server to share notes
```bash
zim --server --port 8080 --private /path/to/notes
```

### Search for a keyword across a notebook
```bash
zim --search /path/to/notes "vulnerability"
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `--gui` | Run the editor (default behavior) |
| `--server` | Run the web server |
| `--export` | Export to a different format |
| `--import` | Import one or more files into a notebook |
| `--search` | Run a search query on a notebook |
| `--index` | Build an index for a notebook |
| `--plugin` | Call a specific plugin function |
| `--manual` | Open the user manual |
| `-V, --verbose` | Print information to terminal |
| `-D, --debug` | Print debug messages |
| `-v, --version` | Print version and exit |
| `-h, --help` | Print help text |

### GUI Options
| Flag | Description |
|------|-------------|
| `--list` | Show the list of notebooks instead of opening the default |
| `--geometry` | Window size and position as `WxH+X+Y` |
| `--fullscreen` | Start in fullscreen mode |
| `--non-unique` | Start a new process, do not connect to an existing process |
| `--standalone` | Start a new process per notebook (implies `--non-unique`) |

### Server Options
| Flag | Description |
|------|-------------|
| `--port` | Port to use (defaults to 8080) |
| `--template` | Name or filepath of the template to use |
| `--private` | Serve only to localhost |
| `--gui` | Run the GUI wrapper for the server |

### Export Options
| Flag | Description |
|------|-------------|
| `-o, --output` | Output directory (mandatory) |
| `--format` | Format to use (defaults to 'html') |
| `--template` | Name or filepath of the template to use |
| `--root-url` | URL to use for the document root |
| `--index-page` | Index page name |
| `-r, --recursive` | When exporting a page, also export sub-pages |
| `-s, --singlefile` | Export all pages to a single output file |
| `-O, --overwrite` | Force overwriting existing file(s) |

### Import Options
| Flag | Description |
|------|-------------|
| `--format` | Format to read (defaults to 'wiki') |
| `--assubpage` | Import files as sub-pages of PATH (implicit if PATH ends with ":" or multiple files given) |

### Search Options
| Flag | Description |
|------|-------------|
| `-s, --with-scores` | Print score for each page and sort by score |

### Index Options
| Flag | Description |
|------|-------------|
| `-f, --flush` | Flush the index first and force re-building |

## Notes
- Zim uses plain text files, making it highly compatible with version control systems like Git.
- Use `zim --manual` to access the full documentation stored as a zim notebook.
- Page links use a colon-separated syntax (e.g., `Notebook:Namespace:Page`).