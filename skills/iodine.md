---
name: iodine
description: Tunnel IPv4 data through a DNS server to bypass firewalls where DNS queries are permitted but other traffic is blocked. Use during post-exploitation, data exfiltration, or to establish command-and-control (C2) channels in highly restricted network environments.
---

# iodine

## Overview
iodine allows you to tunnel IPv4 traffic through DNS. It consists of a client (`iodine`) and a server (`iodined`). It is particularly useful when internet access is firewalled but recursive DNS queries are allowed. Category: Post-Exploitation / Sniffing & Spoofing.

## Installation (if not already installed)
Assume iodine is already installed. If the command is missing:

```bash
sudo apt install iodine
```

## Common Workflows

### Basic Server Setup
Run the server on a machine with a public IP and a delegated domain.
```bash
sudo iodined -f -P mypassword 10.0.0.1 tunnel.example.com
```
*`10.0.0.1` is the internal tunnel IP; `tunnel.example.com` is the delegated domain.*

### Basic Client Connection
Connect to the iodine server from a restricted network.
```bash
sudo iodine -f -P mypassword 1.2.3.4 tunnel.example.com
```
*`1.2.3.4` is the IP of the iodine server (optional if DNS is working correctly).*

### Automated Client Start
Using the helper script with environment variables:
```bash
sudo env subdomain=tunnel.example.com passwd=mypassword iodine-client-start
```

## Complete Command Reference

### iodine (Client)
```
iodine [-v] [-h] [-f] [-r] [-u user] [-t chrootdir] [-d device] [-P password] [-m maxfragsize] [-M maxlen] [-T type] [-O enc] [-L 0|1] [-I sec] [-z context] [-F pidfile] [nameserver] topdomain
```

| Flag | Description |
|------|-------------|
| `-T <type>` | Force DNS type: NULL, PRIVATE, TXT, SRV, MX, CNAME, A (default: autodetect) |
| `-O <enc>` | Force downstream encoding (for -T other than NULL): Base32, Base64, Base64u, Base128, or Raw (TXT only) |
| `-I <sec>` | Max interval between requests (default 4 sec) to prevent DNS timeouts |
| `-L <0\|1>` | 1: use lazy mode for low-latency (default). 0: don't (implies -I1) |
| `-m <size>` | Max size of downstream fragments (default: autodetect) |
| `-M <len>` | Max size of upstream hostnames (~100-255, default: 255) |
| `-r` | Skip raw UDP mode attempt (force DNS tunneling only) |
| `-P <pass>` | Password used for authentication (max 32 chars) |
| `-v` | Print version info and exit |
| `-h` | Print help and exit |
| `-f` | Keep running in foreground |
| `-u <name>` | Drop privileges and run as user 'name' |
| `-t <dir>` | chroot to directory `dir` |
| `-d <dev>` | Set tunnel device name (e.g. dns0) |
| `-z <ctx>` | Apply specified SELinux context after initialization |
| `-F <file>` | Write PID to a file |

### iodined (Server)
```
iodined [-v] [-h] [-c] [-s] [-f] [-D] [-u user] [-t chrootdir] [-d device] [-m mtu] [-z context] [-l ip] [-p port] [-n ext_ip] [-b dnsport] [-P password] [-F pidfile] tunnel_ip[/netmask] topdomain
```

| Flag | Description |
|------|-------------|
| `-v` | Print version info and exit |
| `-h` | Print help and exit |
| `-c` | Disable check of client IP/port on each request |
| `-s` | Skip creating/configuring tun device (must be done manually) |
| `-f` | Keep running in foreground |
| `-D` | Increase debug level (use -DD for more) |
| `-u <name>` | Drop privileges and run as user 'name' |
| `-t <dir>` | chroot to directory `dir` |
| `-d <dev>` | Set tunnel device name |
| `-m <mtu>` | Set tunnel device MTU |
| `-z <ctx>` | Apply SELinux context after initialization |
| `-l <ip>` | IP address to listen on for incoming DNS (default 0.0.0.0) |
| `-p <port>` | Port to listen on for incoming DNS (default 53) |
| `-n <ip>` | IP to respond with to NS queries |
| `-b <port>` | Forward normal DNS queries to this port on localhost |
| `-P <pass>` | Password for authentication (max 32 chars) |
| `-F <file>` | Write PID to a file |
| `-i <time>` | Maximum idle time before shutting down |

### iodine-client-start (Helper Script)
Invoking without options uses `/etc/default/iodine-client`.

**Configuration Variables (Environment or File):**
- `subdomain`: The FQDN delegated to the tunnel.
- `passwd`: Tunnel password.
- `testhost`: Hostname to ping to test network (default: slashdot.org).
- `bounce_localnet`: Reset local network before starting (default: false).
- `test_ping_localnet`: Ping gateway to test local net (default: true).
- `test_ping_tunnel`: Ping tunnel endpoint after setup (default: true).
- `test_ping_final`: Ping external host after setup (default: true).
- `default_router`: Manual IP for local router.
- `interface`: Manual interface selection (e.g., eth0).
- `mtu`: Manual MTU setting (default 1024; use 220 for restricted DNS).
- `skip_raw_udp_mode`: Sets `-r` flag (default: true).
- `continue_on_error`: Continue if a command fails.

## Notes
- **Permissions**: Both client and server usually require root privileges to create the `tun` interface.
- **DNS Delegation**: For the tunnel to work over the internet, you must delegate a subdomain (via NS record) to the IP address of the `iodined` server.
- **Performance**: DNS tunneling is inherently slow and has high latency. Use `-L 1` (lazy mode) for better responsiveness.
- **MTU**: If the connection is unstable, try lowering the MTU (e.g., 220) to fit within DNS packet limits.