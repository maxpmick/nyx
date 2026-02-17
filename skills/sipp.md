---
name: sipp
description: Traffic generator and testing tool for the SIP protocol. It can simulate multiple calls using built-in or custom XML scenarios (UAC/UAS) and supports various transport modes including UDP, TCP, TLS, and SCTP. Use when performing VoIP security assessments, stress testing SIP infrastructure, simulating SIP traffic, or testing SIP firewall/IDS rules.
---

# sipp

## Overview
SIPp is an Open Source test tool and traffic generator for the SIP protocol. It includes basic SipStone user agent scenarios and can execute complex call flows defined in XML. It features dynamic statistics, adjustable call rates, and support for multiple transport protocols. Category: VoIP / Vulnerability Analysis.

## Installation (if not already installed)
Assume sipp is already installed. If you get a "command not found" error:

```bash
sudo apt install sipp
```

## Common Workflows

### Run a default UAS (Server) responder
```bash
sipp -sn uas
```
Listens for incoming SIP calls using the built-in server scenario.

### Run a default UAC (Client) to a remote host
```bash
sipp -sn uac 192.168.1.100
```
Initiates calls to the target IP using the standard SipStone client scenario.

### Stress test with specific call rate and limit
```bash
sipp -sn uac -r 50 -rp 1000 -m 1000 192.168.1.100
```
Starts 50 calls per second (`-r 50`) every 1000ms (`-rp 1000`) until 1000 calls are processed (`-m 1000`).

### Use a custom XML scenario and CSV data injection
```bash
sipp -sf my_scenario.xml -inf users.csv -i 192.168.1.5 192.168.1.100
```
Loads a custom scenario file and injects values (like usernames/passwords) from a CSV file.

## Complete Command Reference

```
sipp remote_host[:remote_port] [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `-v` | Display version and copyright information |
| `-bg` | Launch SIPp in background mode |
| `-p <port>` | Set the local port number (default: random free port) |
| `-i <ip>` | Set local IP for 'Contact:', 'Via:', and 'From:' headers |
| `-bind_local` | Bind socket to local IP address only |
| `-ci <ip>` | Set the local control IP address |
| `-cp <port>` | Set the local control port number (default: 8888) |
| `-timeout <val>` | Global timeout. SIPp quits after N units (e.g., 20s) |
| `-timeout_error` | SIPp fails if global timeout is reached |
| `-sleep <val>` | How long to sleep at startup (default unit: seconds) |
| `-nostdin` | Disable stdin |
| `-skip_rlimit` | Do not perform rlimit tuning of file descriptor limits |

### Scenario & Call Control

| Flag | Description |
|------|-------------|
| `-sn <name>` | Use an embedded scenario: `uac`, `uas`, `regexp`, `branchc`, `branchs`, `3pcc-C-A`, `3pcc-C-B`, `3pcc-A`, `3pcc-B` |
| `-sf <file>` | Load an alternate XML scenario file |
| `-sd` | Dumps a default scenario to stdout |
| `-oocsf <file>` | Load out-of-call scenario |
| `-oocsn <name>` | Load out-of-call scenario by name |
| `-m <calls>` | Stop and exit after N calls are processed |
| `-l <limit>` | Set max simultaneous calls |
| `-r <rate>` | Set call rate (calls per second, default: 10) |
| `-rp <ms>` | Specify the rate period for the call rate (default: 1s) |
| `-rate_increase <n>` | Increase rate by N every `-fd` units |
| `-rate_max <n>` | Max rate to reach when using `-rate_increase` |
| `-no_rate_quit` | Do not quit after reaching `-rate_max` |
| `-users <n>` | Start N calls at startup and keep the number constant |
| `-d <ms>` | Controls length of 'pause' instructions in scenario |
| `-aa` | Enable automatic 200 OK for INFO, UPDATE, and NOTIFY |
| `-nd` | No Default: Disable all default SIPp behaviors (BYE on timeout, etc.) |
| `-default_behaviors <val>` | Set behaviors: `all`, `none`, `bye`, `abortunexp`, `pingreply` |

### Authentication & URI Options

| Flag | Description |
|------|-------------|
| `-s <user>` | Set the username part of the request URI (default: 'service') |
| `-au <user>` | Set authorization username for challenges (default: `-s` value) |
| `-ap <pass>` | Set password for challenges (default: 'password') |
| `-auth_uri <uri>` | Force the URI value for authentication |

### Injection & Variables

| Flag | Description |
|------|-------------|
| `-inf <file>` | Inject values from an external CSV file |
| `-infindex <f> <idx>` | Create an index of file using specific field |
| `-ip_field <idx>` | Field in CSV containing the source IP (use with `-t ui`) |
| `-key <k> <v>` | Set generic parameter "keyword" to "value" |
| `-set <var> <v>` | Set global variable "variable" to "value" |
| `-base_cseq <n>` | Start value of [cseq] for each call |

### Transport & Network Options

| Flag | Description |
|------|-------------|
| `-t <mode>` | Transport mode: `u1` (UDP 1-sock), `un` (UDP sock/call), `ui` (UDP sock/IP), `t1` (TCP 1-sock), `tn` (TCP sock/call), `l1` (TLS 1-sock), `ln` (TLS sock/call), `s1` (SCTP 1-sock), `sn` (SCTP sock/call) |
| `-rsa <host:port>` | Set remote sending address for messages |
| `-buff_size <n>` | Set send and receive buffer size |
| `-max_socket <n>` | Max number of sockets to open (default: 50000) |
| `-max_reconnect <n>` | Max number of reconnections |
| `-reconnect_close` | Close calls on reconnect |
| `-reconnect_sleep <ms>` | Sleep between close and reconnect |
| `-nr` | Disable retransmission in UDP mode |
| `-max_retrans <n>` | Max UDP retransmissions (default: 5 INVITE, 7 others) |
| `-max_invite_retrans` | Max UDP retransmissions for INVITE |
| `-max_non_invite_retrans`| Max UDP retransmissions for non-INVITE |
| `-rtcheck <mode>` | Retransmission detection: `full` (default) or `loose` |
| `-lost <n>` | Number of packets to lose by default |

### Media (RTP) Options

| Flag | Description |
|------|-------------|
| `-mi <ip>` | Set local media IP address |
| `-mp <port>` | Set local RTP echo port (default: 6000) |
| `-rtp_echo` | Enable RTP echo on port `-mp` and `-mp + 2` |
| `-mb <n>` | Set RTP echo buffer size (default: 2048) |

### Logging & Tracing

| Flag | Description |
|------|-------------|
| `-trace_msg` | Log sent/received SIP messages to file |
| `-trace_shortmsg` | Log SIP messages as CSV |
| `-trace_screen` | Dump stats screens to log on exit |
| `-trace_err` | Trace unexpected messages to error log |
| `-trace_stat` | Dump all statistics to CSV |
| `-trace_calldebug` | Log debug info for aborted calls |
| `-trace_rtt` | Trace response times to CSV |
| `-trace_logs` | Trace `<log>` actions from scenario |
| `-f <sec>` | Screen stats refresh frequency (default: 1s) |
| `-fd <sec>` | Stats dump log frequency (default: 60s) |
| `-max_log_size <n>` | Limit for log file sizes |
| `-ringbuffer_files <n>` | Number of files to keep after rotation |
| `-ringbuffer_size <n>` | Rotation size for log files |

### Advanced & 3PCC

| Flag | Description |
|------|-------------|
| `-3pcc <ip>` | Launch in Third Party Call Control mode |
| `-master <n>` | 3pcc extended mode: master number |
| `-slave <n>` | 3pcc extended mode: slave number |
| `-slave_cfg <file>` | 3pcc extended mode: master/slave address file |
| `-tdmmap <map>` | Handle TDM circuits (e.g., `{0-3}{99}{5-8}{1-31}`) |
| `-timer_resol <ms>` | Timer resolution (default: 10ms) |

## Notes
- **Signals**: Use `kill -SIGUSR1 <pid>` for a soft exit (finish ongoing calls) or `kill -SIGUSR2 <pid>` to dump stats to the screen log.
- **Exit Codes**: `0` (Success), `1` (At least one call failed), `97` (Internal command exit), `99` (Normal exit, no calls), `-1` (Fatal error).
- **Performance**: For high traffic, increase `-max_recv_loops` and `-max_sched_loops` (default 1000).
- **Custom Scenarios**: Use `sipp -sd uac > scenario.xml` to get a template for creating custom call flows.