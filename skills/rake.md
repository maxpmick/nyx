---
name: rake
description: Execute Ruby-based build tasks and automation scripts. Use when encountering Rakefiles in Ruby projects to identify available tasks, build software, run test suites, or execute administrative scripts during post-exploitation and web application testing.
---

# rake

## Overview
Rake is a software task management and build automation tool for the Ruby programming language. It allows users to specify tasks and describe dependencies in standard Ruby syntax. In a security context, it is often used to explore the functionality of a Ruby-on-Rails application, run database migrations, or execute custom maintenance scripts.

## Installation (if not already installed)
Assume rake is already installed. If you get a "command not found" error:

```bash
sudo apt install rake
```

## Common Workflows

### List available tasks
List all documented tasks defined in the Rakefile to understand available functionality.
```bash
rake -T
```

### List all tasks (including undocumented)
Show every task defined, even those without descriptions.
```bash
rake -AT
```

### Run a specific task
Execute a task by name (e.g., a database migration or a test suite).
```bash
rake db:migrate
```

### Dry run
See what tasks and dependencies would be executed without actually running them.
```bash
rake --dry-run task_name
```

### Execute arbitrary Ruby code
Quickly execute Ruby code within the Rake environment.
```bash
rake -e 'puts Dir.pwd'
```

## Complete Command Reference

```
rake [-f rakefile] {options} targets...
```

### Options

| Flag | Description |
|------|-------------|
| `--backtrace=[OUT]` | Enable full backtrace. OUT can be `stderr` (default) or `stdout`. |
| `--comments` | Show commented tasks only. |
| `--job-stats [LEVEL]` | Display job statistics. `LEVEL=history` displays a complete job list. |
| `--rules` | Trace the rules resolution. |
| `--suppress-backtrace PATTERN` | Suppress backtrace lines matching regexp PATTERN. Ignored if `--trace` is on. |
| `-A`, `--all` | Show all tasks, even uncommented ones (in combination with `-T` or `-D`). |
| `-B`, `--build-all` | Build all prerequisites, including those which are up-to-date. |
| `-C`, `--directory [DIR]` | Change to DIRECTORY before doing anything. |
| `-D`, `--describe [PATTERN]` | Describe the tasks (matching optional PATTERN), then exit. |
| `-e`, `--execute CODE` | Execute some Ruby code and exit. |
| `-E`, `--execute-continue CODE` | Execute some Ruby code, then continue with normal task processing. |
| `-f`, `--rakefile [FILE]` | Use FILENAME as the rakefile to search for. |
| `-G`, `--no-system` | Use standard project Rakefile search paths, ignore system wide rakefiles. |
| `-g`, `--system` | Using system wide (global) rakefiles (usually `~/.rake/*.rake`). |
| `-I`, `--libdir LIBDIR` | Include LIBDIR in the search path for required modules. |
| `-j`, `--jobs [NUMBER]` | Max number of tasks to execute in parallel (default: CPU cores + 4). |
| `-m`, `--multitask` | Treat all tasks as multitasks. |
| `-n`, `--dry-run` | Do a dry run without executing actions. |
| `-N`, `--no-search` | Do not search parent directories for the Rakefile. |
| `-P`, `--prereqs` | Display the tasks and dependencies, then exit. |
| `-p`, `--execute-print CODE` | Execute some Ruby code, print the result, then exit. |
| `-q`, `--quiet` | Do not log messages to standard output. |
| `-r`, `--require MODULE` | Require MODULE before executing rakefile. |
| `-R`, `--rakelibdir DIR` | Auto-import any .rake files in RAKELIBDIR (default: 'rakelib'). |
| `--rakelib` | Same as `--rakelibdir`. |
| `-s`, `--silent` | Like `--quiet`, but also suppresses the 'in directory' announcement. |
| `-t`, `--trace=[OUT]` | Turn on invoke/execute tracing, enable full backtrace. OUT: `stderr` or `stdout`. |
| `-T`, `--tasks [PATTERN]` | Display tasks (matching PATTERN) with descriptions, then exit. |
| `-v`, `--verbose` | Log message to standard output. |
| `-V`, `--version` | Display the program version. |
| `-W`, `--where [PATTERN]` | Describe the tasks (matching optional PATTERN), then exit. |
| `-X`, `--no-deprecation-warnings` | Disable the deprecation warnings. |
| `-h`, `-H`, `--help` | Display the help message. |

## Notes
- Rakefiles are written in Ruby; if you have write access to a Rakefile, you can achieve Arbitrary Code Execution (ACE).
- When running Rake in the context of a Bundler project, you may need to use `bundle exec rake`.
- Use `-T` frequently when exploring a new Ruby project to find hidden administrative or debug tasks.