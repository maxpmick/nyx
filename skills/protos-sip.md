---
name: protos-sip
description: Evaluate the implementation-level security and robustness of Session Initiation Protocol (SIP) implementations by injecting malformed test cases. Use when performing vulnerability analysis, fuzzing SIP-based VoIP infrastructure, or testing the resilience of SIP proxies, registrars, and user agents against protocol-specific attacks.
---

# protos-sip

## Overview
The PROTOS SIP test suite is a specialized tool designed to identify vulnerabilities and robustness issues in Session Initiation Protocol (SIP) implementations. It functions by sending a series of malformed or unexpected SIP packets to a target to trigger crashes, memory leaks, or other security flaws. Category: Vulnerability Analysis / VoIP.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install protos-sip
```

**Dependencies:**
- default-jre
- java-wrappers

## Common Workflows

### Basic robustness test against a target URI
```bash
protos-sip -touri user@192.168.1.100
```

### Targeted fuzzing of a specific port with packet inspection
```bash
protos-sip -touri user@192.168.1.100 -dport 5061 -showsent -showreply
```

### Testing a specific range of test cases with health checks
```bash
protos-sip -touri user@192.168.1.100 -start 100 -stop 200 -validcase
```
The `-validcase` flag sends a standard SIP packet after each malformed one to verify if the service is still alive.

### High-latency environment testing
```bash
protos-sip -touri user@192.168.1.100 -delay 500 -replywait 1000
```

## Complete Command Reference

```
protos-sip [OPTIONS] | -touri <SIP-URI>
```

### Options

| Flag | Description |
|------|-------------|
| `-touri <addr>` | Recipient of the request (e.g., `you@there.com`) |
| `-fromuri <addr>` | Initiator of the request (Default: `user@kali`) |
| `-sendto <domain>` | Send packets to `<domain>` instead of the domain name in `-touri` |
| `-callid <callid>` | Call ID to start test-case call IDs from (Default: `0`) |
| `-dport <port>` | Destination port number to send packets to (Default: `5060`) |
| `-lport <port>` | Local port number to send packets from (Default: `5060`) |
| `-delay <ms>` | Time to wait before sending a new test-case (Default: `100 ms`) |
| `-replywait <ms>` | Maximum time to wait for the host to reply (Default: `100 ms`) |
| `-file <file>` | Send a specific file instead of generated test-cases |
| `-help` | Display the help message |
| `-jarfile <file>` | Get data from an alternate bugcat JAR-file |
| `-showreply` | Show received packets in the terminal |
| `-showsent` | Show sent packets in the terminal |
| `-teardown` | Send CANCEL/ACK after requests |
| `-single <index>` | Inject only a single specific test-case index |
| `-start <index>` | Start injecting test-cases from this index |
| `-stop <index>` | Stop injecting test-cases at this index |
| `-maxpdusize <int>` | Maximum PDU size (Default: `65507` bytes) |
| `-validcase` | Send a valid case (case #0) after each test-case and wait for a response to check target availability |

## Notes
- This tool is highly intrusive and can crash SIP services or hardware (IP phones, PBXs). Use only in authorized testing environments.
- If the target stops responding, the `-validcase` option is essential for identifying exactly which test-case caused the failure.
- Ensure your local firewall allows traffic on the `-lport` (default 5060) to receive replies from the target.