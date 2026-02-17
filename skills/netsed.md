---
name: netsed
description: Alter the contents of network packets in real-time for both TCP and UDP streams. Use when performing black-box protocol auditing, fuzzing, integrity testing, or deceptive transfers by intercepting and modifying traffic between a client and a server.
---

# netsed

## Overview
NetSED is a network packet-altering stream editor designed to modify the contents of packets forwarded through a network in real-time. It is primarily used for protocol auditing, stability testing, and data manipulation. Category: Sniffing & Spoofing / Vulnerability Analysis.

## Installation (if not already installed)
Assume netsed is already installed. If you get a "command not found" error:

```bash
sudo apt install netsed
```

## Common Workflows

### Basic TCP Proxy with String Replacement
Intercept TCP traffic on local port 8080 and forward it to a web server on port 80, replacing "admin" with "guest":
```bash
netsed tcp 8080 web-server.com 80 's/admin/guest'
```

### Protocol Fuzzing (Single Substitution)
Replace only the first occurrence of a specific handshake string to test application error handling:
```bash
netsed tcp 1234 target-app.local 1234 's/AUTH_OK/AUTH_ERR/1'
```

### Directional Modification
Ensure the server always sees "mike" instead of "andrew" (outgoing from client perspective), while keeping incoming traffic unchanged:
```bash
netsed tcp 8888 server.local 8888 's/andrew/mike/o'
```

### Hex-Encoded Binary Manipulation
Replace a 4-byte sequence with a null-padded string using hex escape sequences:
```bash
netsed udp 53 8.8.8.8 53 's/%01%02%03%04/mike%00%00'
```

## Complete Command Reference

```bash
netsed [option] proto lport rhost rport rule1 [ rule2 ... ]
```

### Options

| Flag | Description |
|------|-------------|
| `--ipv4`, `-4` | Force address resolution in IPv4 |
| `--ipv6`, `-6` | Force address resolution in IPv6 |
| `--ipany` | Resolve the address in either IPv4 or IPv6 |
| `--help`, `-h` | Display usage information |

### Arguments

| Argument | Description |
|----------|-------------|
| `proto` | Protocol specification: `tcp` or `udp` |
| `lport` | Local port to listen on |
| `rhost` | Destination host to forward to (0 = use destination address of incoming connection) |
| `rport` | Destination port (0 = use destination port of incoming connection) |
| `ruleN` | Replacement rules (see Rule Syntax below) |

### Rule Syntax
General syntax: `s/pat1/pat2[/expire]`

*   **pat1**: Pattern to match.
*   **pat2**: String to replace it with.
*   **expire**: Optional parameter of the form `[CHAR][NUM]`.
    *   **CHAR**: Restricts rule to specific directions from the client's perspective:
        *   `i` or `I`: Incoming packets only.
        *   `o` or `O`: Outgoing packets only.
    *   **NUM**: Expire the rule after `NUM` successful substitutions during a connection.

### Special Characters
*   **Hex Escapes**: Use HTTP-like hex sequences for 8-bit characters (e.g., `%0a%0d` for CRLF, `%00` for NULL).
*   **Literal Percent**: Use `%%` to match a literal `%` character.

## Notes
*   **Packet Boundaries**: Rules are not active across packet boundaries; a pattern split across two packets will not be matched.
*   **Rule Order**: Rules are evaluated from first to last as stated on the command line.
*   **Transparent Interception**: Setting `rhost` and `rport` to `0` allows for transparent interception on systems where traffic is redirected to the local port via firewall rules (like iptables REDIRECT).
*   **Padding**: If the replacement string is shorter than the original, you may need to manually pad with null bytes (`%00`) or spaces to maintain protocol alignment if the protocol is length-sensitive.