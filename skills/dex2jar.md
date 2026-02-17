---
name: dex2jar
description: Convert Android Dalvik Executable (.dex/.odex) files to Java class files (.jar) and vice versa. Use when performing Android application reverse engineering, malware analysis, or deobfuscating APK contents to inspect Java source code.
---

# dex2jar

## Overview
dex2jar is a suite of tools designed to work with Android `.dex` and Java `.class` files. It facilitates the conversion of Dalvik bytecode to standard Java bytecode, allowing security researchers to use standard Java decompiler tools (like JD-GUI or Jadx) on Android binaries. Category: Reverse Engineering.

## Installation (if not already installed)
Assume dex2jar is already installed. If missing:
```bash
sudo apt install dex2jar
```

## Common Workflows

### Convert APK/DEX to JAR
The most common use case for inspecting Android application logic.
```bash
d2j-dex2jar classes.dex
# Or directly on an APK
d2j-dex2jar app.apk
```

### Disassemble DEX to Smali
Useful for modifying app logic and rebuilding.
```bash
d2j-baksmali classes.dex -o smali_out/
```

### Sign an APK
Quickly sign a modified APK with a test certificate for side-loading.
```bash
d2j-apk-sign modified.apk
```

### Deobfuscate and Remap
Generate a config and rename obfuscated members in a JAR.
```bash
d2j-init-deobf classes-dex2jar.jar -o deobf.cfg
d2j-jar-remap -c deobf.cfg classes-dex2jar.jar
```

## Complete Command Reference

### d2j-dex2jar
Converts `.dex` or `.apk` files to `.jar`.
- `--skip-exceptions`: Skip exceptions during translation.
- `-d, --debug-info`: Translate debug info.
- `-e, --exception-file <file>`: Detail exception file (default: `[file]-error.zip`).
- `-f, --force`: Force overwrite.
- `-h, --help`: Print help.
- `-n, --not-handle-exception`: Do not handle any exceptions thrown by dex2jar.
- `-nc, --no-code`: Do not include code in output.
- `-o, --output <out-jar>`: Output file (default: `[file]-dex2jar.jar`).
- `-os, --optmize-synchronized`: Optimize synchronized blocks.
- `-p, --print-ir`: Print IR to System.out.
- `-r, --reuse-reg`: Reuse register while generating Java `.class` files.
- `-s, -ts, --topological-sort`: Sort blocks by topological order (default: enabled).

### d2j-baksmali / d2j-dex2smali
Disassembles DEX files into Smali code.
- `-b, --no-debug-info`: Don't write out debug info.
- `-f, --force`: Force overwrite.
- `-h, --help`: Print help.
- `-l, --use-locals`: Output `.locals` directive instead of `.register`.
- `-o, --output <out>`: Output directory (default: `[jar-name]-out/`).
- `-p, --no-parameter-registers`: Use `v<n>` syntax instead of `p<n>` for parameters.

### d2j-smali
Assembles Smali files into a DEX file.
- `--`: Read smali from stdin.
- `-a, --api-level <API>`: Numeric API level (default: 14).
- `-h, --help`: Print help.
- `-o, --output <FILE>`: Output DEX file (default: `out.dex`).
- `-v, --version`: Print version.
- `-x, --allow-odex-instructions`: Allow odex instructions.

### d2j-apk-sign
Signs an APK using a test certificate.
- `-f, --force`: Force overwrite.
- `-h, --help`: Print help.
- `-o, --output <out>`: Output file (default: `[apk]-signed.apk`).
- `-t, --tiny`: Use tiny sign.

### d2j-jar2dex
Converts JAR files to DEX.
- `-f, --force`: Force overwrite.
- `-h, --help`: Print help.
- `-o, --output <out>`: Output DEX file.

### d2j-decrypt-string
Decrypts strings within class files.
- `-cp, --classpath <cp>`: Add extra lib to classpath.
- `-d, --delete`: Delete the decryption method.
- `-da, --deep-analyze`: Use IR to find more values like `byte[]`.
- `-f, --force`: Force overwrite.
- `-m, --methods <cfg>`: File containing list of methods to target.
- `-mn, --decrypt-method-name <name>`: Name of the decryption method.
- `-mo, --decrypt-method-owner <owner>`: Owner class of the decryption method.
- `-o, --output <out>`: Output JAR.
- `-pd, --parameters-descriptor <type>`: Descriptor for the method.
- `-t, --arg-types <type>`: Comma-separated list of types.
- `-v, --verbose`: Show more output.

### d2j-jar-access
Modifies access flags (public/private/etc) in a JAR.
- `-ac, --add-class-access <ACC>`: Add class access.
- `-af, --add-field-access <ACC>`: Add field access.
- `-am, --add-method-access <ACC>`: Add method access.
- `-rc, --remove-class-access <ACC>`: Remove class access.
- `-rd, --remove-debug`: Remove debug info.
- `-rf, --remove-field-access <ACC>`: Remove field access.
- `-rm, --remove-method-access <ACC>`: Remove method access.

### d2j-init-deobf
Generates an initial config file for deobfuscation.
- `-f, --force`: Force overwrite.
- `-max, --max-length <MAX>`: Rename if length > MAX (default: 40).
- `-min, --min-length <MIN>`: Rename if length < MIN (default: 2).
- `-o, --output <out>`: Output config file.

### d2j-jar-remap
Renames packages, classes, methods, or fields in a JAR.
- `-c, --config <config>`: Config file for remap (**REQUIRED**).
- `-f, --force`: Force overwrite.
- `-o, --output <out>`: Output JAR.

### d2j-asm-verify
Verifies `.class` files in a JAR.
- `-d, --detail`: Print detail error message.
- `-h, --help`: Print help.

### d2j-dex-recompute-checksum
Recomputes CRC and SHA1 of a DEX file.
- `-f, --force`: Force overwrite.
- `-o, --output <out>`: Output DEX file.

### d2j-jar2jasmin / d2j-jasmin2jar
Disassembles JAR to Jasmin files or assembles Jasmin to JAR.
- `-cv, --class-version <arg>`: Default class version (1-9, default 6).
- `-d, --debug`: Disassemble/include debug info.
- `-e, --encoding <enc>`: Encoding (default: UTF-8).
- `-g, --autogenerate-linenumbers`: Auto-generate line numbers.

### d2j-std-apk
Cleans up an APK to a standard ZIP format.
- `-o, --output <out>`: Output file.

### d2j-dex-weaver / d2j-jar-weaver
Replaces invokes in DEX/JAR files based on a config.
- `-c, --config <config>`: Config file.
- `-s, --stub-dex/--stub-jar <stub>`: Stub file.

### d2j-class-version-switch
`Usage: clz-version-switch version old.jar new.jar`

### d2j-dex-dump
`Usage: d2j-dex-dump in.dexORapk out.dump.jar`

## Notes
- The command `dex2jar` is deprecated; use `d2j-dex2jar` instead.
- For complex obfuscation, `d2j-decrypt-string` and `d2j-jar-remap` are powerful but require manual configuration files.
- Ensure `default-jre` is installed as the tool runs on the Java Virtual Machine.