---
name: pyinstaller
description: Bundle Python applications into standalone executables for Windows, macOS, and Linux. Use when creating portable tools, distributing malware/exploits in a single package, or analyzing PyInstaller-packed executables during digital forensics and reverse engineering.
---

# pyinstaller

## Overview
PyInstaller bundles a Python application and all its dependencies into a single package. It analyzes scripts to find required modules and libraries, collecting them into a single folder or a standalone executable. Category: Post-Exploitation / Reverse Engineering.

## Installation (if not already installed)
Assume it is installed. If missing:
```bash
sudo apt install pyinstaller
```

## Common Workflows

### Create a single-file executable
```bash
pyinstaller --onefile myscript.py
```

### Create a windowed app with a custom icon
```bash
pyinstaller --onefile --windowed --icon=app.ico myscript.py
```

### Inspect a packed executable's contents
```bash
pyi-archive_viewer packed_app.exe
```

### Generate a spec file for advanced configuration
```bash
pyi-makespec --onefile --name="MyTool" myscript.py
```

## Complete Command Reference

### pyinstaller
Main utility to bundle applications.

**General Options:**
- `-h, --help`: Show help.
- `-v, --version`: Show version.
- `--distpath DIR`: Where to put the bundled app (default: `./dist`).
- `--workpath WORKPATH`: Where to put temporary work files (default: `./build`).
- `-y, --noconfirm`: Replace output directory without asking.
- `--upx-dir UPX_DIR`: Path to UPX utility.
- `--clean`: Clean cache and remove temporary files before building.
- `--log-level LEVEL`: Detail level (TRACE, DEBUG, INFO, WARN, ERROR, etc.).

**Generation Options:**
- `-D, --onedir`: Create a one-folder bundle (default).
- `-F, --onefile`: Create a one-file bundled executable.
- `--specpath DIR`: Folder to store the generated spec file.
- `-n, --name NAME`: Name for the bundled app and spec file.
- `--contents-directory DIR`: For onedir, directory for supporting files.

**Bundling & Search Options:**
- `--add-data SOURCE:DEST`: Add non-binary data files.
- `--add-binary SOURCE:DEST`: Add binary files.
- `-p, --paths DIR`: Path to search for imports (like PYTHONPATH).
- `--hidden-import MODULENAME`: Name an import not visible in code.
- `--collect-submodules MODULENAME`: Collect all submodules from a package.
- `--collect-data MODULENAME`: Collect all data from a package.
- `--collect-binaries MODULENAME`: Collect all binaries from a package.
- `--collect-all MODULENAME`: Collect submodules, data, and binaries.
- `--copy-metadata PACKAGENAME`: Copy metadata for a package.
- `--recursive-copy-metadata PACKAGENAME`: Copy metadata for package and dependencies.
- `--additional-hooks-dir HOOKSPATH`: Path to search for hooks.
- `--runtime-hook RUNTIME_HOOKS`: Path to custom runtime hook file.
- `--exclude-module EXCLUDES`: Ignore specific module/package.
- `--splash IMAGE_FILE`: Add a splash screen.

**How to Generate:**
- `-d, --debug {all,imports,bootloader,noarchive}`: Debugging assistance.
- `--optimize LEVEL`: Bytecode optimization level.
- `--python-option OPTION`: Pass option to Python interpreter at runtime.
- `-s, --strip`: Apply symbol-table strip (not for Windows).
- `--noupx`: Do not use UPX.
- `--upx-exclude FILE`: Prevent a binary from being compressed by UPX.

**Windows/macOS Options:**
- `-c, --console, --nowindowed`: Open a console window (default).
- `-w, --windowed, --noconsole`: No console window.
- `--hide-console {minimize-early,hide-early,minimize-late,hide-late}`: (Windows) Auto-hide console.
- `-i, --icon <FILE>`: Apply icon (.ico, .exe,ID, .icns).
- `--disable-windowed-traceback`: Disable traceback in windowed mode.

**Windows Specific:**
- `--version-file FILE`: Add version resource from file.
- `--manifest <FILE or XML>`: Add manifest.
- `-m <FILE or XML>`: Deprecated shorthand for manifest.
- `-r, --resource RESOURCE`: Add/update Windows resource (FILE[,TYPE[,NAME[,LANG]]]).
- `--uac-admin`: Request elevation on start.
- `--uac-uiaccess`: Allow elevated app to work with Remote Desktop.

**macOS Specific:**
- `--argv-emulation`: Enable argv emulation for app bundles.
- `--osx-bundle-identifier ID`: Bundle identifier.
- `--target-architecture ARCH`: Target arch (x86_64, arm64, universal2).
- `--codesign-identity IDENTITY`: Code signing identity.
- `--osx-entitlements-file FILE`: Entitlements file for signing.

---

### pyi-archive_viewer
View and extract contents of PyInstaller archives.

- `-l, --list`: List archive contents.
- `-r, --recursive`: Recursively print archive log.
- `-b, --brief`: Show only filenames.
- `--log-level LEVEL`: Detail level.

---

### pyi-makespec
Create a `.spec` file without building the executable. Supports all `pyinstaller` bundling and generation flags listed above.

---

### pyi-bindepend
Show binary dependencies for executables or dynamic libraries.

- `--log-level LEVEL`: Detail level.

---

### pyi-grab_version
Extract version resource from a Windows executable.

- `exe-file`: Path to Windows EXE.
- `out-filename`: Output file for version info.

---

### pyi-set_version
Apply a version resource to a Windows executable.

- `info-file`: Text file with version info.
- `exe-file`: Path to Windows EXE.

## Notes
- PyInstaller is not a cross-compiler. To create a Windows EXE, you must run PyInstaller on Windows (or via Wine).
- Packed executables are often flagged by AV/EDR solutions as suspicious.
- Use `pyi-archive_viewer` to extract compiled `.pyc` files from a suspected malicious dropper for further decompression and disassembly.