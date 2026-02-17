---
name: sipsak
description: Perform various tests, diagnostics, and stress tests on SIP (Session Initiation Protocol) servers and user agents. Use when performing SIP reconnaissance, tracerouting SIP hops, testing user location (usrloc) registration, sending SIP MESSAGE bodies, or conducting flood and fuzzing attacks against VoIP infrastructure.
---

# sipsak

## Overview
sipsak (SIP Swiss Army Knife) is a command-line utility for developers and administrators of SIP applications. It supports various modes including diagnostics, registration testing, and security-related stress testing. Category: Vulnerability Analysis / VoIP Testing.

## Installation (if not already installed)
Assume sipsak is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install sipsak
```

## Common Workflows

### SIP Traceroute
Trace the path of SIP proxies to a destination URI:
```bash
sipsak -T -s sip:someone@example.com
```

### User Registration Test (Usrloc)
Test if a SIP server correctly handles registrations (User Location):
```bash
sipsak -U -C sip:myphone@192.168.1.50 -s sip:registrar.example.com
```

### Send a SIP MESSAGE
Send a text message to a SIP URI:
```bash
sipsak -M -B "Hello from the terminal" -s sip:user@example.com
```

### Flood Attack (Stress Testing)
Send a high volume of SIP requests to test server resilience:
```bash
sipsak -F -e 100 -s sip:target.com
```

### Options for Authentication
Many commands require authentication; use `-a` for the password:
```bash
sipsak -U -a mypassword -s sip:user@example.com
```

## Complete Command Reference

### Primary Modes

| Mode | Command Pattern | Description |
|------|-----------------|-------------|
| **Shoot** | `sipsak [-f FILE] [-L] -s SIPURI` | Sends a SIP message from a file or stdin |
| **Trace** | `sipsak -T -s SIPURI` | SIP traceroute mode |
| **Usrloc** | `sipsak -U [-I\|M] [-b NUM] [-e NUM] [-x NUM] [-z NUM] -s SIPURI` | User location/Registration testing |
| **Message** | `sipsak -M [-B STR] [-O STR] [-c SIPURI] -s SIPURI` | Sends a SIP MESSAGE |
| **Flood** | `sipsak -F [-e NUM] -s SIPURI` | Flood the target with requests |
| **Random** | `sipsak -R [-t NUM] -s SIPURI` | Random character fuzzing (dangerous) |

### General Options (Applicable to all modes)

| Flag | Long Option | Description |
|------|-------------|-------------|
| `-a PASSWORD` | `--password` | Password for authentication |
| `-d` | | Ignore redirects |
| `-i` | `--extract-ip` | Extract IP from the warning in reply |
| `-H HOSTNAME` | `--hostname` | Overwrites the local hostname in all headers |
| `-l PORT` | `--local-port` | The local port to use (default: any) |
| `-m NUMBER` | `--max-forwards` | Value for the max-forwards header field |
| `-n` | `--numeric` | Use FQDN instead of IP in the Via-Line |
| `-N` | `--nagios-code` | Returns exit codes Nagios compliant |
| `-r PORT` | `--remote-port` | The remote port to use (default: 5060) |
| `-v` | `--verbose` | Increase verbosity (max 3 `-vvv`) |
| `-V` | `--version` | Prints version string |
| `-w` | | Deactivate the insertion of a Via-Line |

### Detailed Parameter Reference

| Flag | Long Option | Description |
|------|-------------|-------------|
| `-f FILE` | `--filename` | File containing SIP message to send (use `-` for stdin) |
| `-L` | `--no-crlf` | De-activate CR (\r) insertion |
| `-s SIPURI` | `--sip-uri` | Destination server URI: `sip:[user@]server[:port]` |
| `-T` | `--traceroute` | Activates traceroute mode |
| `-U` | `--usrloc-mode` | Activates usrloc mode |
| `-I` | `--invite-mode` | Simulates successful calls with itself |
| `-M` | `--message-mode` | Sends messages to itself (or activates message mode) |
| `-C SIPURI` | `--contact` | Use given URI as Contact in REGISTER |
| `-b NUMBER` | `--appendix-begin` | Starting number appendix to username (default: 0) |
| `-e NUMBER` | `--appendix-end` | Ending number of the appendix to username |
| `-z NUMBER` | `--sleep` | Sleep X ms before sending next request |
| `-x NUMBER` | `--expires` | Expires header field value (default: 15) |
| | `--remove-bindings` | Activates randomly removing of user bindings |
| `-F` | `--flood-mode` | Activates flood mode |
| `-R` | `--random-mode` | Activates random mode (fuzzing) |
| `-t NUMBER` | `--trash-chars` | Max trashed characters in random mode |
| | `--outbound-proxy` | Request target (outbound proxy) |
| | `--processes` | Divide workflow among X number of processes |
| | `--auth-username` | Username for authentication |
| | `--replace-string` | Replacement for a special mark in the message |
| | `--replace` | Activates replacement of variables |
| | `--nagios-warn` | Return Nagios warning if retransmissions > X |
| `-B STRING` | `--message-body` | Send a message with string as body |
| `-O STRING` | `--disposition` | Content-Disposition value |
| | `--search=REGEXP` | Search for RegExp in replies; error on failure |
| | `--timing=NUMBER` | Number of test runs; prints just timings |
| | `--symmetric` | Send and receive on the same port |
| | `--from=SIPURI` | Use given URI as From header in MESSAGE |
| | `--timeout-factor` | Timeout multiplier for INVITE (default: 64) |
| | `--timer-t1` | Timeout T1 in ms (default: 500) |
| | `--transport` | Specify transport (e.g., UDP, TCP, TLS) |
| | `--headers` | Adds additional headers to the request |
| | `--local-ip` | Specify local IP address to be used |
| | `--authhash` | HA1 hash for authentication instead of password |
| | `--syslog` | Log exit message to syslog with given level |
| | `--tls-ca-cert` | File with the cert of the root CA |
| | `--tls-client-cert` | File with the client certificate |
| | `--tls-ignore-cert-failure` | Ignore failures during TLS handshake |

## Notes
- **Safety**: The Random Mode (`-R`) is a fuzzer and can crash poorly implemented SIP stacks. Use with caution.
- **Authentication**: If `--auth-username` is not provided, sipsak typically uses the username from the SIP URI. If password is omitted, it defaults to the username.
- **Traceroute**: SIP traceroute works by incrementing the Max-Forwards header, similar to how IP traceroute uses TTL.