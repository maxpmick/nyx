---
name: jadx
description: Decompile Dalvik bytecode to Java source code from APK, DEX, AAR, JAR, and ZIP files. Use when performing Android application reverse engineering, malware analysis, or security auditing of mobile binaries to recover source code and resources like AndroidManifest.xml.
---

# jadx

## Overview
Jadx is a Dex to Java decompiler that produces Java source code from Android Dex and Apk files. It includes both a command-line tool and a GUI for viewing decompiled code with syntax highlighting, jump-to-declaration, and full-text search. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume jadx is already installed. If not:
```bash
sudo apt install jadx
```
Requires `default-jre`.

## Common Workflows

### Basic Decompilation
Decompile an APK into a specific output directory:
```bash
jadx -d out_dir app.apk
```

### Deobfuscation and Error Reduction
Decompile with deobfuscation enabled and show inconsistent code that failed standard decompilation:
```bash
jadx --deobf --show-bad-code app.apk
```

### Export as Gradle Project
Convert an APK into a format that can be opened directly in Android Studio:
```bash
jadx -e --export-gradle-type android-app app.apk
```

### Single Class Extraction
Decompile only a specific class to save time:
```bash
jadx --single-class com.example.app.MainActivity app.apk
```

## Complete Command Reference

### Usage
```bash
jadx [command] [options] <input files>
```
**Supported Inputs:** .apk, .dex, .jar, .class, .smali, .zip, .aar, .arsc, .aab, .xapk, .apkm, .jadx.kts

### Commands
| Command | Description |
|---------|-------------|
| `plugins` | Manage jadx plugins |

### General Options
| Flag | Description |
|------|-------------|
| `-d, --output-dir` | Output directory |
| `-ds, --output-dir-src` | Output directory for sources |
| `-dr, --output-dir-res` | Output directory for resources |
| `-r, --no-res` | Do not decode resources |
| `-s, --no-src` | Do not decompile source code |
| `-j, --threads-count` | Processing threads count (default: 3) |
| `--single-class` | Decompile a single class (full name, raw or alias) |
| `--single-class-output` | File or dir for write if decompile a single class |
| `--output-format` | 'java' or 'json' (default: java) |
| `-e, --export-gradle` | Save as gradle project (sets type to 'auto') |
| `--export-gradle-type` | Template: `auto`, `android-app`, `android-library`, `simple-java` |
| `-m, --decompilation-mode` | `auto` (default), `restructure`, `simple`, `fallback` |
| `--show-bad-code` | Show inconsistent code (incorrectly decompiled) |
| `--no-xml-pretty-print` | Do not prettify XML |
| `--no-imports` | Disable imports, always write entire package name |
| `--no-debug-info` | Disable debug info parsing |
| `--add-debug-lines` | Add comments with debug line numbers |
| `--no-inline-anonymous` | Disable anonymous classes inline |
| `--no-inline-methods` | Disable methods inline |
| `--no-move-inner-classes`| Disable move inner classes into parent |
| `--no-inline-kotlin-lambda`| Disable inline for Kotlin lambdas |
| `--no-finally` | Don't extract finally block |
| `--no-restore-switch-over-string` | Don't restore switch over string |
| `--no-replace-consts` | Don't replace constant value with matching field |
| `--escape-unicode` | Escape non-latin characters in strings (with \u) |
| `--respect-bytecode-access-modifiers` | Don't change original access modifiers |
| `--integer-format` | `auto` (default), `decimal`, `hexadecimal` |
| `--fs-case-sensitive` | Treat filesystem as case sensitive (default: false) |
| `--cfg` | Save methods control flow graph to dot file |
| `--raw-cfg` | Save methods control flow graph (raw instructions) |
| `-f, --fallback` | Set decompilation mode to fallback (deprecated) |
| `--use-dx` | Use dx/d8 to convert java bytecode |
| `--comments-level` | `error`, `warn`, `info`, `debug`, `user-only`, `none` (default: info) |
| `--log-level` | `quiet`, `progress`, `error`, `warn`, `info`, `debug` (default: progress) |
| `-v, --verbose` | Verbose output (DEBUG level) |
| `-q, --quiet` | Turn off output (QUIET level) |
| `--disable-plugins` | Comma separated list of plugin ids to disable |
| `--version` | Print version |
| `-h, --help` | Print help |

### Deobfuscation Options
| Flag | Description |
|------|-------------|
| `--deobf` | Activate deobfuscation |
| `--deobf-min` | Min length of name to rename (default: 3) |
| `--deobf-max` | Max length of name to rename (default: 64) |
| `--deobf-whitelist` | Classes/packages to exclude (e.g., `android.support.*`) |
| `--deobf-cfg-file` | Mapping file for auto-generated names (default: .jobf) |
| `--deobf-cfg-file-mode` | `read`, `read-or-save`, `overwrite`, `ignore` |
| `--deobf-res-name-source`| Name source for resources: `auto`, `resources`, `code` |
| `--mappings-path` | Path to Tiny, Tiny v2, or Enigma mapping files |
| `--mappings-mode` | `read`, `read-and-autosave-every-change`, `read-and-autosave-before-closing`, `ignore` |
| `--use-source-name-as-class-name-alias` | `always`, `if-better`, `never` |
| `--source-name-repeat-limit` | Limit for source name usage (default: 10) |
| `--rename-flags` | Comma-separated: `case`, `valid`, `printable`, `none`, `all` |

### Plugin Options (`-P<name>=<value>`)
- **dex-input.verify-checksum**: `yes`/`no` (default: yes)
- **java-convert.mode**: `dx`, `d8`, `both` (default: both)
- **java-convert.d8-desugar**: `yes`/`no` (default: no)
- **kotlin-metadata.[class-alias|method-args|fields|companion|data-class|to-string|getters]**: `yes`/`no`
- **smali-input.api-level**: Android API level (default: 27)

### Environment Variables
- `JADX_DISABLE_XML_SECURITY`: Set 'true' to disable XML security checks.
- `JADX_DISABLE_ZIP_SECURITY`: Set 'true' to disable ZIP security checks.
- `JADX_ZIP_MAX_ENTRIES_COUNT`: Max entries in zip (default: 100,000).
- `JADX_CONFIG_DIR`, `JADX_CACHE_DIR`, `JADX_TMP_DIR`: Custom directory paths.

## jadx-gui
The GUI version supports the same options as the CLI, with the addition of:
- `-sc, --select-class`: Open the selected class and show decompiled code immediately.

## Notes
- Use `--deobf` when dealing with obfuscated production APKs to make the code readable.
- The `--fallback` mode is useful when the high-level decompilation fails or produces nonsensical code.
- For large APKs, increasing `--threads-count` can speed up processing if the system has sufficient CPU/RAM.