---
name: swaks
description: Swiss Army Knife SMTP (swaks) is a feature-rich, scriptable, transaction-oriented SMTP test tool. Use it to test SMTP setups, verify mail server configurations, perform reconnaissance on mail servers, test for open relays, or simulate phishing/email delivery. It supports STARTTLS, SMTP AUTH, and multiple transport methods including UNIX sockets and pipes.
---

# swaks

## Overview
Swaks is a command-line tool for testing SMTP transactions. It supports various SMTP extensions (TLS, AUTH, Pipelining), multiple protocols (SMTP, ESMTP, LMTP), and various transport methods. It is essential for verifying mail server security, testing virus/spam scanners, and performing information gathering on mail infrastructure. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume swaks is already installed. If not:
```bash
sudo apt install swaks
```

## Common Workflows

### Basic Mail Delivery Test
```bash
swaks --to user@example.com --server mail.example.net
```

### Authenticated Phishing Simulation
```bash
swaks --to target@example.com --from "CEO <ceo@example.com>" --auth LOGIN --auth-user ceo@example.com --header-X-Mailer "Microsoft Outlook" --body "Please review the attached invoice."
```

### Test for Open Relay (Quit after RCPT)
```bash
swaks --to external-user@gmail.com --server mail.target.com --quit-after RCPT
```

### Test Virus Scanner with EICAR
```bash
swaks -t user@example.com --attach - --server mail.example.com --suppress-data < /path/to/eicar.txt
```

## Complete Command Reference

### Transport Options

| Flag | Description |
|------|-------------|
| `-s, --server [<target>[:<port>]]` | Connect via network socket to hostname/IP. Default port 25. |
| `-p, --port [<port>]` | Specify TCP port (number or service name). |
| `-li, --local-interface [<int>[:<port>]]` | Use specific local interface for outgoing connection. |
| `-lp, --local-port [<port>]` | Specify outgoing local port. |
| `--copy-routing <domain>` | Use MX records of the specified domain to find the target server. |
| `-4, -6` | Force IPv4 or IPv6. |
| `--socket [<socket-file>]` | Connect via UNIX-domain socket file. |
| `--pipe [<command>]` | Spawn a process and communicate via pipes (STDIN/STDOUT). |

### Protocol Options

| Flag | Description |
|------|-------------|
| `-t, --to <address>` | Envelope-recipient address (comma-separated for multiple). |
| `--cc <address>` | Envelope-recipient; also populates Cc: header in default DATA. |
| `--bcc <address>` | Envelope-recipient; not included in default DATA headers. |
| `-f, --from <address>` | Envelope-sender address. Use `<>` for null sender. |
| `--ehlo, --lhlo, -h, --helo <str>` | String for HELO/EHLO/LHLO command. |
| `-q, --quit-after <point>` | Stop and QUIT after: `PROXY`, `BANNER`, `FIRST-HELO`, `XCLIENT`, `XCLIENT-HELO`, `TLS`, `HELO`, `AUTH`, `MAIL`, `RCPT`. |
| `--da, --drop-after <point>` | Same as quit-after but drops connection without QUIT. Adds `DATA`, `DOT`. |
| `--das, --drop-after-send <point>` | Drop connection immediately after sending the specified command. |
| `--timeout <time>` | Transaction timeout (e.g., 30s, 3m, 1h). 0 for no timeout. |
| `--protocol <proto>` | Set protocol: `SMTP`, `SSMTP`, `SSMTPA`, `SMTPS`, `ESMTP`, `ESMTPA`, `ESMTPS`, `ESMTPSA`, `LMTP`, `LMTPA`, `LMTPS`, `LMTPSA`. |
| `--pipeline` | Attempt SMTP PIPELINING (RFC 2920). |
| `--prdr` | Attempt Per-Recipient Data Response (PRDR). |
| `--force-getpwuid` | Use system-default method for local username discovery. |

### TLS / Encryption Options

| Flag | Description |
|------|-------------|
| `-tls` | Require STARTTLS. Exit if unavailable. |
| `-tlso, --tls-optional` | Attempt STARTTLS, continue as plaintext if failed. |
| `-tlsos, --tls-optional-strict` | Attempt STARTTLS; fail if advertised but negotiation fails. |
| `-tlsc, --tls-on-connect` | Initiate TLS immediately (default port 465). |
| `-tlsp, --tls-protocol <spec>` | Specify/exclude protocols (e.g., `tlsv1_2,tlsv1_3` or `no_sslv3`). |
| `--tls-cipher <str>` | Set OpenSSL cipher list. |
| `--tls-verify` | Verify server CA and Hostname. |
| `--tls-verify-ca` | Verify server certificate is signed by known CA. |
| `--tls-verify-host` | Verify target matches SAN/CN in certificate. |
| `--tls-verify-target <str>` | Override hostname used for host verification. |
| `--tls-ca-path <path>` | Path to custom CA file/directory. |
| `--tls-cert <file>` | Path to local PEM certificate. |
| `--tls-key <file>` | Path to local PEM private key. |
| `--tls-chain <file>` | Path to local PEM certificate chain. |
| `--tls-get-peer-cert [<file>]` | Save/display peer certificate. |
| `--tls-get-peer-chain [<file>]` | Save/display peer certificate chain. |
| `--tls-sni <string>` | Specify Server Name Indication (SNI). |

### Authentication Options

| Flag | Description |
|------|-------------|
| `-a, --auth [<types>]` | Require AUTH. Types: `LOGIN`, `PLAIN`, `CRAM-MD5`, `DIGEST-MD5`, `CRAM-SHA1`, `NTLM`, `SPA`, `MSN`. |
| `-ao, --auth-optional` | Attempt AUTH if available, continue if not. |
| `-aos, --auth-optional-strict` | Continue if AUTH not advertised; fail if advertised but fails. |
| `-au, --auth-user <user>` | Username for authentication. |
| `-ap, --auth-password <pass>` | Password for authentication. |
| `-ae, --auth-extra <K=V>` | Extra parameters (e.g., `realm`, `domain`, `dmd5-host`). |
| `-am, --auth-map <K=V>` | Map alternate names to base auth types. |
| `-apt, --auth-plaintext` | Display AUTH strings in plaintext in output. |
| `-ahp, --auth-hide-password` | Replace passwords in output with a dummy string. |

### DATA and MIME Options

| Flag | Description |
|------|-------------|
| `-d, --data <portion>` | Set entire DATA contents. Use `-` for STDIN, `@file` for file. |
| `--body <text>` | Set message body. |
| `--attach <spec>` | Add a MIME attachment (can be used multiple times). |
| `--attach-body <spec>` | Add a MIME part as the body (supports multipart/alternative). |
| `--attach-type <type>` | Set MIME type for subsequent attachments. |
| `--attach-name <name>` | Set filename for the next attachment. |
| `-ah, --add-header <hdr>` | Add a header to the DATA. |
| `--header <hdr>, --h-<name> <val>` | Replace or add a specific header. |
| `--no-data-fixup` | Disable all automatic DATA modifications/token replacement. |
| `--no-strip-from` | Do not strip "From " lines from DATA. |
| `-n, --suppress-data` | Do not print the DATA portion in the transcript. |

### XCLIENT and PROXY Options

| Flag | Description |
|------|-------------|
| `--xclient-<attr> <val>` | Set XCLIENT attributes: `addr`, `name`, `port`, `proto`, `destaddr`, `destport`, `helo`, `login`, `reverse-name`. |
| `--xclient-delim` | Send subsequent XCLIENT attributes in a new command. |
| `--xclient <string>` | Send raw, unvalidated XCLIENT string. |
| `--xclient-no-verify` | Send attributes even if not advertised by server. |
| `--xclient-before-starttls` | Attempt XCLIENT before STARTTLS negotiation. |
| `--proxy-version [1\|2]` | Set Proxy protocol version (default 1). |
| `--proxy <string>` | Send raw Proxy protocol string (supports `base64:` or `@file`). |
| `--proxy-family <str>` | Set proxy address family (e.g., `TCP4`, `AF_INET`). |
| `--proxy-source <addr>` | Set proxied source address. |
| `--proxy-source-port <p>` | Set proxied source port. |
| `--proxy-dest <addr>` | Set proxied destination address. |
| `--proxy-dest-port <p>` | Set proxied destination port. |

### Output and Debugging

| Flag | Description |
|------|-------------|
| `-stl, --show-time-lapse [i]` | Show timing between send/receive. |
| `-nih, -nsh, -nrh, -nth` | Suppress hints (info, send, receive, or all). |
| `-raw, --show-raw-text` | Show hex dump of raw network traffic. |
| `--output-file <path>` | Redirect output to a file. |
| `-pp, --protect-prompt` | Mask sensitive input (passwords) during prompts. |
| `-hr, -hs, -hi, -ha` | Hide receive, send, info, or all output. |
| `-S, --silent [1\|2\|3]` | 1: errors only; 2: only errors; 3: no output. |
| `--support` | Show compiled-in capabilities and missing modules. |
| `--dump-mail` | Print the generated message to STDOUT and exit. |
| `--dump [<section>]` | Dump internal state for debugging. |

## Notes
- **Tokens**: Use `%DATE%`, `%FROM_ADDRESS%`, `%TO_ADDRESS%`, and `%MESSAGEID%` in custom DATA/headers for automatic replacement.
- **Security**: Be careful when using `--auth-password` in command history; use environment variables or prompts with `-pp` instead.
- **Files**: Arguments starting with `@` are treated as file paths. Use `@@` to escape a literal `@`.