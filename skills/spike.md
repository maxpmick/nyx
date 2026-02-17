---
name: spike
description: A professional-grade network protocol fuzzer used to analyze protocols for buffer overflows and security weaknesses. Use when performing vulnerability analysis, protocol fuzzing, or stress testing against web servers, MSRPC, RPC, and various network services during penetration testing.
---

# spike

## Overview
SPIKE is a comprehensive network protocol fuzzing framework. It allows researchers to create custom fuzzer scripts (.spk) to identify vulnerabilities in both documented and undocumented protocols. It includes specialized tools for web servers, MSRPC, SunRPC, and various game protocols. Category: Vulnerability Analysis / Fuzzing.

## Installation (if not already installed)
Assume SPIKE is already installed. If you get a "command not found" error:

```bash
sudo apt install spike
```

## Common Workflows

### Fuzzing a TCP service with a SPIKE script
```bash
generic_send_tcp 192.168.1.100 8080 my_protocol.spk 0 0
```
Sends fuzzed data defined in `my_protocol.spk` to the target, starting from the first variable and first fuzz string.

### Fuzzing a Web Server for common extensions
```bash
closed_source_web_server_fuzz 192.168.1.50 80 GET /index .php 0 0
```
Tests a web server using the GET method against the `/index` path with the `.php` extension.

### MSRPC Fuzzing
```bash
msrpcfuzz 10.25.25.15 135 e1af8308-5d1f-11c9-91a4-08002b14a0fa 3 0 2 10 3
```
Fuzzes an MSRPC interface using its GUID and version information.

## Complete Command Reference

### TCP/UDP Generic Fuzzers

| Command | Usage |
|---------|-------|
| `generic_send_tcp` | `generic_send_tcp host port spike_script SKIPVAR SKIPSTR` |
| `generic_send_udp` | `gsu target port file.spk startvariable startfuzzstring startvariable startstring totaltosend` |
| `generic_listen_tcp` | `generic_listen_tcp port spike_script` |
| `line_send_tcp` | `line_send_tcp host port spike_script SKIPVAR SKIPSTR` |

### Web Fuzzing Tools

| Command | Usage |
|---------|-------|
| `closed_source_web_server_fuzz` | `closed target port METHOD path extension skipvar skipstr` |
| `generic_web_server_fuzz` | `generic_web_server_fuzz target port file.spk skipvariables skipfuzzstring` |
| `generic_web_server_fuzz2` | `generic_web_server_fuzz target port file.spk skipvariables skipfuzzstring` |
| `generic_chunked` | `generic_chunked target port file.spk skipvariables skipfuzzstring` |
| `post_fuzz` | `post_fuzz target port file` |
| `post_spike` | `post_spike target port` |
| `do_post` | `post_spike target port optional` |
| `ntlm_brute` / `ntlm2` | `ntlm_brute target port username[@domain] password url` |

### RPC and MSRPC Tools

| Command | Usage |
|---------|-------|
| `msrpcfuzz` | `msrpcfuzz target port GUID Version VersionMinor function_number number_of_tries max_random_items [OBJECT UUID]` |
| `msrpcfuzz_udp` | `msrpcfuzz_udp target port GUID Version VersionMinor function_number number_of_tries max_random_items [OBJECT UUID]` |
| `dceoversmb` | `dceoversmb target pipe GUID Version VersionMinor function_number number_of_tries max_random_items [login password]` |
| `sendmsrpc` | `sendmsrpc target port function` |
| `sunrpcfuzz` | `sunrpcfuzz -h <target host> <-s and/or -a> [optional args]` |

**SunRPC Options:**
- `-s <n>`: Test a specific RPC program 'n' (requires -v and -p)
- `-a`: Test all registered RPC programs
- `-v <version>`: Program version
- `-p <proto>`: Protocol number (17 for UDP, 6 for TCP)
- `-i <n>`: Do 'n' fuzzed messages per procedure
- `-l <n>`: Last procedure to test
- `-f <n>`: First procedure to test
- `-r <n>`: Push 'n' random XDR items onto the SPIKE

### Specialized Protocol Fuzzers

| Command | Usage |
|---------|-------|
| `citrix` | `citrix target port` |
| `halflife` | `halflife target port` |
| `quake` | `quake target port` |
| `quakeserver` | `quakeserver clienthost port` |
| `x11_spike` | `x11_spike target` |
| `statd_spike` | `statd_spike target` |

## Notes
- **Web Fuzzing**: Common methods include `OPTIONS`, `TRACE`, `GET`, `HEAD`, `DELETE`, `PUT`, `POST`, `COPY`, `MOVE`, `MKCOL`, `PROPFIND`, `PROPPATCH`, `LOCK`, `UNLOCK`, `SEARCH`, `BROWSE`.
- **MSRPC**: It is recommended to wrap `msrpcfuzz` in a `while [ 1 ]; do ...; done` loop to ensure continuous testing.
- **Safety**: Avoid running `sunrpcfuzz` with `-a` against localhost as it may register numerous bogus RPC programs with the local portmapper.
- **Indicators**: HTTP 500 errors or "Error caught while processing query" often indicate potential overflows or serious bugs in the target.