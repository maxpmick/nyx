---
name: fwbuilder
description: Design, compile, and manage firewall policies for multiple platforms including iptables, Cisco ASA/PIX/IOS, OpenBSD PF, and ipfilter. Use when creating complex firewall configurations, managing object-oriented security policies, or automating the compilation of rulesets for various network devices during infrastructure hardening.
---

# fwbuilder

## Overview
Firewall Builder (fwbuilder) is an object-oriented firewall configuration and management system. It features a GUI for drag-and-drop policy editing and a suite of compilers that translate abstract security policies into platform-specific code for Linux (iptables), BSD (pf, ipfw, ipf), and Cisco devices. Category: Protect / Network Security.

## Installation (if not already installed)
Assume fwbuilder is installed. If commands are missing:
```bash
sudo apt install fwbuilder
```

## Common Workflows

### Batch Compile All Firewalls
Compile all firewall objects defined in a specific XML data file:
```bash
fwb_compile_all -f network_policy.xml -a -v
```

### Compile for Specific Platform (iptables)
Generate an iptables script for a specific firewall object:
```bash
fwb_ipt -f my_policies.xml -d ./output_dir -4 MyLinuxFirewall
```

### Command Line Object Editing
List objects in a data file without opening the GUI:
```bash
fwbedit list -f my_policies.xml
```

### Import Existing Configuration
Import an existing iptables-save file into a Firewall Builder XML file:
```bash
fwbedit import -f new_database.xml -c old_iptables.txt -t iptables
```

## Complete Command Reference

### fwbuilder (GUI)
The main graphical interface.
```
fwbuilder [-f file.fwb] [-d] [-h] [-o file] [-P object_name] [-r] [-v]
```
| Flag | Description |
|------|-------------|
| `-f FILE` | Load specific file on startup |
| `-r` | Open RCS head revision if file is in RCS |
| `-d` | Enable debug mode (verbose stderr) |
| `-h` | Print help |
| `-o file` | Output file for printing (used with -P) |
| `-P name` | Print rules/objects for "name" and exit |
| `-v` | Verbose output |

### fwb_compile_all
Wrapper to compile multiple firewall objects.
```
fwb_compile_all -f file.xml [-d wdir] [-av] [obj [obj ...]]
```
| Flag | Description |
|------|-------------|
| `-a` | Process all objects in "/Firewalls" subtree |
| `-d wdir` | Specify working directory for output |
| `-f FILE` | Data file to process |
| `-v` | Verbose diagnostic messages |

### fwb_iosacl
Compiler for Cisco IOS ACL.
```
fwb_iosacl [-vV] [-d wdir] [-4] [-6] [-i] -f data_file.xml object_name
```
| Flag | Description |
|------|-------------|
| `-4` | Generate IPv4 part (exclusive with -6) |
| `-6` | Generate IPv6 part (exclusive with -4) |
| `-f FILE` | Data file to process |
| `-d wdir` | Working directory for .fw output |
| `-v` | Verbose output |
| `-V` | Print version and quit |
| `-i` | Treat last argument as object ID instead of name |

### fwb_ipt
Compiler for Linux iptables.
```
fwb_ipt [-x level] [-v] [-V] [-q] [-f filename.xml] [-d destdir] [-D datadir] [-m] [-4|-6] firewall_object_name
```
| Flag | Description |
|------|-------------|
| `-x level` | Debug level |
| `-v` | Verbose |
| `-V` | Version |
| `-q` | Quiet mode |
| `-f FILE` | Input XML file |
| `-d DIR` | Destination directory |
| `-D DIR` | Data directory |
| `-m` | Master password prompt |
| `-4 / -6` | Force IPv4 or IPv6 |

### fwb_pf / fwb_ipf / fwb_ipfw
Compilers for OpenBSD PF, ipfilter, and ipfw.
```
fwb_pf [-x] [-v] [-V] [-f file.xml] [-o out.fw] [-d dest] [-D data] [-m] [-4|-6] name
fwb_ipf [-x] [-v] [-V] [-f file.xml] [-o out.fw] [-d dest] [-m] name
fwb_ipfw [-x] [-v] [-V] [-f file.xml] [-o out.fw] [-d dest] [-m] name
```
| Flag | Description |
|------|-------------|
| `-o file` | Specify explicit output filename |
| *(Other flags)* | Same as `fwb_ipt` |

### fwb_pix / fwb_procurve_acl
Compilers for Cisco PIX/FWSM and HP ProCurve.
```
fwb_pix [-tvV] [-f file.xml] [-d dest] [-o out.fw] name
fwb_procurve_acl [-tvV] [-f file.xml] [-d dest] [-o out.fw] name
```
| Flag | Description |
|------|-------------|
| `-t` | Test mode |

### fwbedit
CLI tool for tree editing and maintenance.
```
fwbedit <command> [options]
```
**Commands:**
- `new`: Create new object
- `delete`: Delete object
- `modify`: Modify object attributes
- `list`: Print object details
- `add`: Add object to a group
- `remove`: Remove object from a group
- `upgrade`: Upgrade data file version
- `checktree`: Repair object tree
- `merge`: Merge two XML data files
- `import`: Import external configs (iptables, IOS, PIX, ASA, FWSM)

## Notes
- Generated files usually have a `.fw` extension.
- For Cisco devices, the output can be uploaded via the GUI or manually applied to the CLI.
- Ensure the "Enable IPv6 support" setting is checked in the GUI if you intend to use the `-6` flag during compilation.