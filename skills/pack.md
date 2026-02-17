---
name: pack
description: Analyze password datasets to generate optimized attack masks, rules, and statistics for tools like Hashcat. Use when performing password cracking preparation, analyzing password complexity patterns in a leaked database, or generating custom mask files based on specific organizational password policies.
---

# pack

## Overview
The Password Analysis and Cracking Kit (PACK) is a collection of utilities designed to aid "better than brute-force" password attacks. It analyzes how people create passwords and uses those statistics to generate highly effective attack masks and rules for tools like Hashcat. Category: Password Attacks.

## Installation (if not already installed)
Assume PACK is already installed. If you get a "command not found" error:

```bash
sudo apt install pack
```

## Common Workflows

### Analyze a wordlist for mask generation
```bash
statsgen --minlength=8 --maxlength=12 rockyou.txt -o my_masks.masks
```
Analyzes the wordlist and saves the resulting mask statistics.

### Generate masks based on a specific policy
```bash
policygen --minlength=8 --minupper=1 --mindigit=1 -o policy_compliant.hcmask
```
Generates masks that specifically target passwords meeting a 1-uppercase, 1-digit, 8-character policy.

### Filter masks by target cracking time
```bash
maskgen my_masks.masks --targettime=86400 -o daily_attack.hcmask
```
Selects the most probable masks from a stats file that can be exhausted within 24 hours (86400 seconds).

### Generate rules from a password list
```bash
rulegen --basename=custom_rules passwords.txt
```
Analyzes how passwords were transformed from base words to create custom Hashcat rules.

## Complete Command Reference

### statsgen
Analyzes a password list to generate statistics and masks.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message |
| `-o, --output <file>` | Save masks and stats to a file |
| `--hiderare` | Hide statistics covering less than 1% of the sample |
| `-q, --quiet` | Don't show headers |
| `--minlength <N>` | Minimum password length to analyze |
| `--maxlength <N>` | Maximum password length to analyze |
| `--charset <list>` | Password charset filter (e.g., `loweralpha,numeric`) |
| `--simplemask <list>` | Password mask filter (e.g., `stringdigit,allspecial`) |

### maskgen
Generates attack masks from statistics files.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message |
| `-t, --targettime <sec>` | Target time of all masks in seconds (default: 86400) |
| `-o, --outputmasks <file>` | Save masks to a file (.hcmask) |
| `--showmasks` | Show matching masks in terminal |
| `--minlength <N>` | Minimum password length |
| `--maxlength <N>` | Maximum password length |
| `--mintime <sec>` | Minimum mask runtime |
| `--maxtime <sec>` | Maximum mask runtime |
| `--mincomplexity <N>` | Minimum complexity |
| `--maxcomplexity <N>` | Maximum complexity |
| `--minoccurrence <N>` | Minimum occurrence |
| `--maxoccurrence <N>` | Maximum occurrence |
| `--optindex` | Sort by mask optindex (default) |
| `--occurrence` | Sort by mask occurrence |
| `--complexity` | Sort by mask complexity |
| `--checkmasks <masks>` | Check coverage of specific masks (comma separated) |
| `--checkmasksfile <file>` | Check mask coverage in a file |
| `--pps <N>` | Passwords per Second for time calculations (default: 10^9) |
| `-q, --quiet` | Don't show headers |

### policygen
Generates masks based on a defined password policy.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message |
| `-o, --outputmasks <file>` | Save masks to a file |
| `--pps <N>` | Passwords per Second (default: 10^9) |
| `--showmasks` | Show matching masks |
| `--noncompliant` | Generate masks for noncompliant passwords |
| `-q, --quiet` | Don't show headers |
| `--minlength <N>` | Minimum password length |
| `--maxlength <N>` | Maximum password length |
| `--mindigit <N>` | Minimum number of digits |
| `--minlower <N>` | Minimum number of lower-case characters |
| `--minupper <N>` | Minimum number of upper-case characters |
| `--minspecial <N>` | Minimum number of special characters |
| `--maxdigit <N>` | Maximum number of digits |
| `--maxlower <N>` | Maximum number of lower-case characters |
| `--maxupper <N>` | Maximum number of upper-case characters |
| `--maxspecial <N>` | Maximum number of special characters |

### rulegen
Generates cracking rules by comparing passwords against a dictionary.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message |
| `-b, --basename <name>` | Output base name for .words, .rules, and .stats files |
| `-w, --wordlist <file>` | Use a custom wordlist for rule analysis |
| `-q, --quiet` | Don't show headers |
| `--threads <N>` | Parallel threads to use |
| `--maxworddist <N>` | Maximum word edit distance (Levenshtein) |
| `--maxwords <N>` | Maximum number of source word candidates to consider |
| `--morewords` | Consider suboptimal source word candidates |
| `--simplewords` | Generate simple source words for given passwords |
| `--maxrulelen <N>` | Maximum number of operations in a single rule |
| `--maxrules <N>` | Maximum number of rules to consider |
| `--morerules` | Generate suboptimal rules |
| `--simplerules` | Generate simple rules (insert, delete, replace) |
| `--bruterules` | Bruteforce reversal and rotation rules (slow) |
| `--providers <list>` | Comma-separated spell checker engines (aspell, myspell) |
| `-v, --verbose` | Show verbose information |
| `-d, --debug` | Debug rules |
| `--password` | Process the last argument as a password string, not a file |
| `--word <string>` | Use a custom word for rule analysis |
| `--hashcat` | Test generated rules with hashcat-cli |

### jpackage
Tool for packaging self-contained Java applications.

| Flag | Description |
|------|-------------|
| `-t, --type <type>` | Package type: `app-image`, `rpm`, `deb` |
| `--app-version <v>` | Version of the application |
| `--copyright <str>` | Copyright string |
| `--description <str>` | Description string |
| `-h, --help` | Print usage text |
| `--icon <path>` | Path to icon file |
| `-n, --name <name>` | Name of the application |
| `-d, --dest <path>` | Destination path for output |
| `--temp <path>` | Path for temporary files |
| `--vendor <str>` | Vendor string |
| `--verbose` | Enable verbose output |
| `--version` | Print product version |
| `--add-modules <list>` | Comma-separated list of modules to add |
| `-p, --module-path <p>` | Colon-separated list of module paths |
| `--jlink-options <opt>` | Options to pass to jlink |
| `--runtime-image <path>` | Path of predefined runtime image |
| `-i, --input <path>` | Path of input directory to package |
| `--app-content <list>` | Additional content to add to payload |
| `--add-launcher <n>=<p>` | Add an alternative launcher via properties file |
| `--arguments <args>` | Default command line arguments for main class |
| `--java-options <opts>` | Options for the Java runtime |
| `--main-class <class>` | Main class to execute (requires --main-jar) |
| `--main-jar <jar>` | Main JAR file relative to input path |
| `-m, --module <mod>` | Main module and optionally main class |
| `--about-url <url>` | URL of application home page |
| `--app-image <path>` | Predefined app image to build package from |
| `--file-associations <p>` | Properties file for file associations |
| `--install-dir <path>` | Absolute installation directory |
| `--license-file <path>` | Path to license file |
| `--resource-dir <path>` | Path to override jpackage resources |
| `--launcher-as-service` | Register launcher as a background service |
| `--linux-package-name` | Name for Linux package |
| `--linux-deb-maintainer`| Maintainer email for .deb |
| `--linux-menu-group` | Menu group for the application |
| `--linux-package-deps` | Required packages/capabilities |
| `--linux-rpm-license` | License type for RPM spec |
| `--linux-app-release` | Release/Revision value |
| `--linux-app-category` | RPM Group or DEB Section |
| `--linux-shortcut` | Create application shortcut |

### pack200 / unpack200
JAR compression and decompression tools (Deprecated).

**pack200 Options:**
| Flag | Description |
|------|-------------|
| `-r, --repack` | Normalize JAR for signing |
| `-g, --no-gzip` | Output plain pack file (no gzip) |
| `--gzip` | (Default) Compress output with gzip |
| `-G, --strip-debug` | Remove debugging attributes |
| `-O, --no-keep-file-order`| Do not transmit file ordering |
| `-S{N}` | Segment limit |
| `-E{N}` | Packing effort (0-9) |
| `-H{h}` | Deflate hint (true, false, keep) |
| `-m{V}` | Modification time (latest, keep) |
| `-P{F}` | Pass file unchanged |
| `-U{a}` | Unknown attribute action (error, strip, pass) |
| `-f{F}` | Read config file for properties |
| `-J{X}` | Pass option X to Java VM |

**unpack200 Options:**
| Flag | Description |
|------|-------------|
| `-H{h}` | Override deflate hint |
| `-r, --remove-pack-file` | Remove input after unpacking |

## Notes
- `dictstat` is deprecated; use `statsgen` instead.
- `pack200` and `unpack200` are deprecated and scheduled for removal in future JDK releases.
- PACK does not crack passwords itself; it generates the logic (masks/rules) used by high-performance crackers like Hashcat or John the Ripper.
- When using `maskgen`, the `--pps` (passwords per second) value significantly impacts the estimated time; adjust it based on your actual hardware performance.