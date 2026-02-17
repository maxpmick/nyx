---
name: php-defaults
description: Manage PHP environments, execute scripts, and handle PHP archives (PHAR). Use when developing or testing web exploits, running server-side scripts, managing PHP modules, or analyzing PHP-based applications during web application testing and exploitation.
---

# php-defaults

## Overview
A collection of dependency packages that provide the latest stable PHP version and its associated tools (CLI, CGI, FPM, PHAR, and various modules). It is essential for web application testing, exploitation, and development. Categories: Exploitation, Web Application Testing, Social Engineering, Digital Forensics.

## Installation (if not already installed)
Assume PHP is installed. If specific components are missing:
```bash
sudo apt install php-cli php-common php-cgi php-fpm phar-utils
```

## Common Workflows

### Start a Quick Web Server
```bash
php -S 127.0.0.1:8080 -t /var/www/html
```

### Execute a One-Liner
```bash
php -r 'echo base64_decode("SGVsbG8gV29ybGQ=");'
```

### Extract a PHAR Archive
```bash
phar extract -f application.phar ./extracted_dir
```

### Enable/Disable PHP Modules
```bash
sudo phpenmod curl
sudo phpdismod xdebug
```

## Complete Command Reference

### php (CLI)
```
php [options] [-f] <file> [--] [args...]
php [options] -r <code> [--] [args...]
php [options] [-B <begin_code>] -R <code> [-E <end_code>] [--] [args...]
php [options] [-B <begin_code>] -F <file> [-E <end_code>] [--] [args...]
php [options] -S <addr>:<port> [-t docroot] [router]
```

| Flag | Description |
|------|-------------|
| `-a` | Run as interactive shell |
| `-c <path\|file>` | Look for php.ini file in this directory |
| `-n` | No configuration (ini) files will be used |
| `-d foo[=bar]` | Define INI entry foo with value 'bar' |
| `-e` | Generate extended information for debugger/profiler |
| `-f <file>` | Parse and execute `<file>` |
| `-h` | Display help |
| `-i` | PHP information |
| `-l` | Syntax check only (lint) |
| `-m` | Show compiled-in modules |
| `-r <code>` | Run PHP `<code>` without using script tags |
| `-B <begin_code>` | Run PHP `<begin_code>` before processing input lines |
| `-R <code>` | Run PHP `<code>` for every input line |
| `-F <file>` | Parse and execute `<file>` for every input line |
| `-E <end_code>` | Run PHP `<end_code>` after processing all input lines |
| `-H` | Hide any passed arguments from external tools |
| `-S <addr>:<port>` | Run with built-in web server |
| `-t <docroot>` | Specify document root for built-in web server |
| `-s` | Output HTML syntax highlighted source |
| `-v` | Version number |
| `-w` | Output source with stripped comments and whitespace |
| `-z <file>` | Load Zend extension `<file>` |
| `--ini` | Show configuration file names |
| `--rf <name>` | Show information about function `<name>` |
| `--rc <name>` | Show information about class `<name>` |
| `--re <name>` | Show information about extension `<name>` |
| `--rz <name>` | Show information about Zend extension `<name>` |
| `--ri <name>` | Show configuration for extension `<name>` |

### phar
```
phar <command> [options] ...
```

**Commands:** `add`, `compress`, `delete`, `extract`, `help`, `help-list`, `info`, `list`, `meta-del`, `meta-get`, `meta-set`, `pack`, `sign`, `stub-get`, `stub-set`, `tree`, `version`.

**Common PHAR Arguments:**
- `-f file`: Specifies the phar file to work on.
- `-a alias`: Provide an alias name for the phar file.
- `-c algo`: Compression algorithm (`0`, `none`, `auto`, `gz`, `gzip`, `bz2`, `bzip2`).
- `-i regex`: Regular expression for input files.
- `-x regex`: Regular expression for input files to exclude.
- `-e entry`: Name of entry to work on.
- `-k index`: Subscription index to work on.
- `-h hash`: Selects hash algorithm (`md5`, `sha1`, `sha256`, `sha512`, `openssl`, `openssl_sha256`, `openssl_sha512`).
- `-y key`: Private key for OpenSSL signing.

### php-cgi
```
php-cgi [-q] [-h] [-s] [-v] [-i] [-f <file>]
```
- `-b <address:port>`: Bind Path for external FASTCGI Server mode.
- `-q`: Quiet-mode. Suppress HTTP Header output.
- `-T <count>`: Measure execution time of script repeated `<count>` times.

### php-common Utilities
- `phpenmod [-v version] [-s sapi] module`: Enable a module.
- `phpdismod [-v version] [-s sapi] module`: Disable a module.
- `phpquery -v version -s sapi [-m module]`: Query PHP configuration status.

### php-config
- `--prefix`: Show PHP prefix.
- `--includes`: Show include paths for compiling.
- `--extension-dir`: Show extension directory.
- `--php-binary`: Show path to the PHP binary.
- `--configure-options`: Show options used during PHP compilation.

### phpdbg
Interactive debugger supporting commands: `list`, `info`, `print`, `frame`, `back`, `run`, `step`, `continue`, `break`, `watch`, `ev`.

## Notes
- Use `php -l <file>` to check for syntax errors before executing untrusted code.
- The built-in web server (`-S`) is for development/testing only and is not secure for production.
- PHAR files can be used for "PHAR Deserialization" attacks; use `phar info -f <file>` to inspect them.