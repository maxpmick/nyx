---
name: zsh
description: Execute commands, run shell scripts, and manage interactive sessions using the Z shell. Use when requiring advanced command-line features like programmable completion, spelling correction, and sophisticated globbing, or when generating reports and automating tasks in Kali Linux environments.
---

# zsh

## Overview
Zsh is a powerful UNIX command interpreter (shell) usable as an interactive login shell and a shell script command processor. It resembles ksh but includes enhancements like command-line editing, built-in spelling correction, and programmable completion. Category: Reporting / Automation.

## Installation (if not already installed)
Assume zsh is already installed. If not:
```bash
sudo apt install zsh
```

## Common Workflows

### Execute a single command string
```bash
zsh -c "ls -la /tmp && whoami"
```

### Run a script with verbose output and execution tracing
```bash
zsh -vx script.sh
```

### Start a restricted shell session
```bash
rzsh
```

### Start zsh without loading startup files (clean environment)
```bash
zsh -f
```

## Complete Command Reference

### Special Options
| Flag | Description |
|------|-------------|
| `--help` | Show help message and exit |
| `--version` | Show zsh version number and exit |
| `-b` | End option processing (like `--`) |
| `-c` | Take first argument as a command to execute |
| `-o OPTION` | Set an option by name |

### Named Options
Options can be turned on via `--OPTION` or `-o OPTION`. Turn off via `--no-OPTION` or `+o OPTION`.

`--aliases`, `--aliasfuncdef`, `--allexport`, `--alwayslastprompt`, `--alwaystoend`, `--appendcreate`, `--appendhistory`, `--autocd`, `--autocontinue`, `--autolist`, `--automenu`, `--autonamedirs`, `--autoparamkeys`, `--autoparamslash`, `--autopushd`, `--autoremoveslash`, `--autoresume`, `--badpattern`, `--banghist`, `--bareglobqual`, `--bashautolist`, `--bashrematch`, `--beep`, `--bgnice`, `--braceccl`, `--bsdecho`, `--caseglob`, `--casematch`, `--casepaths`, `--cbases`, `--cdablevars`, `--cdsilent`, `--chasedots`, `--chaselinks`, `--checkjobs`, `--checkrunningjobs`, `--clobber`, `--clobberempty`, `--combiningchars`, `--completealiases`, `--completeinword`, `--continueonerror`, `--correct`, `--correctall`, `--cprecedences`, `--cshjunkiehistory`, `--cshjunkieloops`, `--cshjunkiequotes`, `--cshnullcmd`, `--cshnullglob`, `--debugbeforecmd`, `--dvorak`, `--emacs`, `--equals`, `--errexit`, `--errreturn`, `--evallineno`, `--exec`, `--extendedglob`, `--extendedhistory`, `--flowcontrol`, `--forcefloat`, `--functionargzero`, `--glob`, `--globalexport`, `--globalrcs`, `--globassign`, `--globcomplete`, `--globdots`, `--globstarshort`, `--globsubst`, `--hashcmds`, `--hashdirs`, `--hashexecutablesonly`, `--hashlistall`, `--histallowclobber`, `--histbeep`, `--histexpiredupsfirst`, `--histfcntllock`, `--histfindnodups`, `--histignorealldups`, `--histignoredups`, `--histignorespace`, `--histlexwords`, `--histnofunctions`, `--histnostore`, `--histreduceblanks`, `--histsavebycopy`, `--histsavenodups`, `--histsubstpattern`, `--histverify`, `--hup`, `--ignorebraces`, `--ignoreclosebraces`, `--ignoreeof`, `--incappendhistory`, `--incappendhistorytime`, `--interactive`, `--interactivecomments`, `--ksharrays`, `--kshautoload`, `--kshglob`, `--kshoptionprint`, `--kshtypeset`, `--kshzerosubscript`, `--listambiguous`, `--listbeep`, `--listpacked`, `--listrowsfirst`, `--listtypes`, `--localloops`, `--localoptions`, `--localpatterns`, `--localtraps`, `--login`, `--longlistjobs`, `--magicequalsubst`, `--mailwarning`, `--markdirs`, `--menucomplete`, `--monitor`, `--multibyte`, `--multifuncdef`, `--multios`, `--nomatch`, `--notify`, `--nullglob`, `--numericglobsort`, `--octalzeroes`, `--overstrike`, `--pathdirs`, `--pathscript`, `--pipefail`, `--posixaliases`, `--posixargzero`, `--posixbuiltins`, `--posixcd`, `--posixidentifiers`, `--posixjobs`, `--posixstrings`, `--posixtraps`, `--printeightbit`, `--printexitvalue`, `--privileged`, `--promptbang`, `--promptcr`, `--promptpercent`, `--promptsp`, `--promptsubst`, `--pushdignoredups`, `--pushdminus`, `--pushdsilent`, `--pushdtohome`, `--rcexpandparam`, `--rcquotes`, `--rcs`, `--recexact`, `--rematchpcre`, `--restricted`, `--rmstarsilent`, `--rmstarwait`, `--sharehistory`, `--shfileexpansion`, `--shglob`, `--shinstdin`, `--shnullcmd`, `--shoptionletters`, `--shortloops`, `--shortrepeat`, `--shwordsplit`, `--singlecommand`, `--singlelinezle`, `--sourcetrace`, `--sunkeyboardhack`, `--transientrprompt`, `--trapsasync`, `--typesetsilent`, `--typesettounset`, `--unset`, `--verbose`, `--vi`, `--warncreateglobal`, `--warnnestedvar`, `--xtrace`, `--zle`.

### Option Aliases
| Alias | Equivalent to |
|-------|---------------|
| `--braceexpand` | `--no-ignorebraces` |
| `--dotglob` | `--globdots` |
| `--hashall` | `--hashcmds` |
| `--histappend` | `--appendcreate` |
| `--histexpand` | `--badpattern` |
| `--log` | `--no-histnofunctions` |
| `--mailwarn` | `--mailwarning` |
| `--onecmd` | `--singlecommand` |
| `--physical` | `--cdsilent` |
| `--promptvars` | `--promptsubst` |
| `--stdin` | `--shinstdin` |
| `--trackall` | `--hashcmds` |

### Option Letters
| Letter | Equivalent to | Letter | Equivalent to |
|--------|---------------|--------|---------------|
| `-0` | `--completeinword` | `-P` | `--rcexpandparam` |
| `-1` | `--printexitvalue` | `-Q` | `--pathdirs` |
| `-2` | `--no-autoresume` | `-R` | `--longlistjobs` |
| `-3` | `--no-nomatch` | `-S` | `--recexact` |
| `-4` | `--globdots` | `-T` | `--cbases` |
| `-5` | `--notify` | `-U` | `--mailwarning` |
| `-6` | `--beep` | `-V` | `--no-promptcr` |
| `-7` | `--ignoreeof` | `-W` | `--autoremoveslash` |
| `-8` | `--markdirs` | `-X` | `--listtypes` |
| `-9` | `--autocontinue` | `-Y` | `--menucomplete` |
| `-B` | `--no-bashrematch` | `-Z` | `--zle` |
| `-C` | `--no-checkjobs` | `-a` | `--allexport` |
| `-D` | `--pushdtohome` | `-d` | `--no-globalrcs` |
| `-E` | `--pushdsilent` | `-e` | `--errexit` |
| `-F` | `--no-glob` | `-f` | `--no-rcs` |
| `-G` | `--nullglob` | `-g` | `--histignorespace` |
| `-H` | `--rmstarsilent` | `-h` | `--histignoredups` |
| `-I` | `--ignorebraces` | `-i` | `--interactive` |
| `-J` | `--appendhistory` | `-k` | `--interactivecomments` |
| `-K` | `--no-badpattern` | `-l` | `--login` |
| `-L` | `--sunkeyboardhack` | `-m` | `--monitor` |
| `-M` | `--singlelinezle` | `-n` | `--no-exec` |
| `-N` | `--autoparamslash` | `-p` | `--privileged` |
| `-O` | `--continueonerror` | `-r` | `--restricted` |
| `-s` | `--shinstdin` | `-t` | `--singlecommand` |
| `-u` | `--no-unset` | `-v` | `--verbose` |
| `-w` | `--cdsilent` | `-x` | `--xtrace` |
| `-y` | `--shwordsplit` | | |

## Notes
- `rzsh` is the restricted version of the Z shell.
- `zsh-static` is a statically-linked version useful for system recovery or when dynamic libraries are broken.
- Use `zsh -f` to bypass `.zshrc` and other startup files for troubleshooting.