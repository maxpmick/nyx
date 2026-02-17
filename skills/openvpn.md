---
name: openvpn
description: Securely tunnel IP networks over a single UDP or TCP port using the OpenVPN daemon. Use to establish point-to-point or server-client VPN connections, bypass firewalls, or secure communications during penetration testing and remote access scenarios.
---

# openvpn

## Overview
OpenVPN is a robust application used to create secure point-to-point or site-to-site connections in routed or bridged configurations and remote access facilities. It uses the OpenSSL library for encryption, authentication, and certification. Category: Sniffing & Spoofing / Network Utilities.

## Installation (if not already installed)
Assume openvpn is already installed. If not:
```bash
sudo apt install openvpn
```

## Common Workflows

### Connect to a VPN using a config file
```bash
sudo openvpn --config client.ovpn
```

### Create a simple point-to-point tunnel (Static Key)
On Server:
```bash
openvpn --dev tun --ifconfig 10.8.0.1 10.8.0.2 --secret static.key
```
On Client:
```bash
openvpn --remote server_ip --dev tun --ifconfig 10.8.0.2 10.8.0.1 --secret static.key
```

### Start a server with specific parameters
```bash
openvpn --port 1194 --proto udp --dev tun --server 10.8.0.0 255.255.255.0 --ca ca.crt --cert server.crt --key server.key --dh dh2048.pem
```

### Generate a pre-shared secret key
```bash
openvpn --genkey tls-auth static.key
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `--config file` | Read configuration options from file |
| `--help` | Show options |
| `--version` | Show copyright and version information |

### Tunnel Options
| Flag | Description |
|------|-------------|
| `--local host\|* [port]` | Local host name/IP and port for bind |
| `--remote host [port]` | Remote host name or IP address |
| `--remote-random` | Choose one remote randomly from multiple options |
| `--remote-random-hostname` | Add random string to remote DNS name |
| `--mode m` | Major mode: `p2p` (default) or `server` |
| `--proto p` | Use protocol: `udp`, `tcp-server`, `tcp-client`, `udp4`, `tcp4-server`, `tcp4-client`, `udp6`, `tcp6-server`, `tcp6-client` |
| `--proto-force p` | Only consider protocol `p` (udp or tcp) |
| `--connect-retry n [m]` | Seconds to wait between retries (default 1, max m=300) |
| `--connect-retry-max n` | Maximum connection attempt retries |
| `--http-proxy s p [up] [auth]` | Connect through HTTP proxy at address `s` and port `p` |
| `--http-proxy s p 'auto[-nct]'` | Automatically determine HTTP proxy auth method |
| `--http-proxy-option type [parm]` | Set extended HTTP proxy options (VERSION, AGENT) |
| `--socks-proxy s [p] [up]` | Connect through Socks5 proxy at address `s` and port `p` |
| `--socks-proxy-retry` | Retry indefinitely on Socks proxy errors |
| `--resolv-retry n` | Retry hostname resolve for `n` seconds |
| `--float` | Allow remote to change its IP address/port |
| `--ipchange cmd` | Run command on remote IP address change |
| `--port port` | TCP/UDP port for both local and remote |
| `--lport port` | Local TCP/UDP port (default 1194) |
| `--rport port` | Remote TCP/UDP port (default 1194) |
| `--bind` | Bind to local address and port |
| `--nobind` | Do not bind to local address and port |
| `--dev tunX\|tapX` | tun/tap device (e.g., tun0) |
| `--dev-type dt` | Device type: `tun` or `tap` |
| `--dev-node node` | Explicitly set the device node |
| `--disable-dco` | Do not attempt using Data Channel Offload |
| `--lladdr hw` | Set the link layer address of the tap device |
| `--topology t` | Set tun topology: `net30`, `p2p`, or `subnet` |
| `--ifconfig l rn` | Configure IP address `l` (local) and `rn` (remote/mask) |
| `--ifconfig-ipv6 l r` | Configure IPv6 address `l` (local) and `r` (remote) |
| `--ifconfig-noexec` | Pass ifconfig parms to scripts via env instead of executing |
| `--ifconfig-nowarn` | Don't warn if ifconfig options don't match remote |
| `--route-table table_id` | Specify a custom routing table |
| `--route net [mask] [gw] [met]` | Add route after connection |
| `--route-ipv6 net/bits [gw] [met]` | Add IPv6 route after connection |
| `--route-gateway gw\|'dhcp'` | Specify default gateway for routes |
| `--route-ipv6-gateway gw` | Specify default IPv6 gateway |
| `--route-metric m` | Specify default metric for routes |
| `--route-delay n [w]` | Delay `n` seconds before adding routes |
| `--route-up cmd` | Run command after routes are added |
| `--route-pre-down cmd` | Run command before routes are removed |
| `--route-noexec` | Don't add routes automatically; use env in script |
| `--route-nopull` | Accept pushed options EXCEPT routes, dns, dhcp |
| `--allow-pull-fqdn` | Allow pulling DNS names for ifconfig/route |
| `--redirect-gateway [flags]` | Redirect all outgoing traffic through VPN (flags: local, def1, bypass-dhcp, bypass-dns) |
| `--redirect-private [flags]` | Like redirect-gateway but omit changing default gateway |
| `--block-ipv6` | Generate ICMPv6 unreachable messages for IPv6 |
| `--client-nat snat\|dnat net mask alias` | Add 1-to-1 NAT rule |
| `--push-peer-info` | Push client info to server |
| `--setenv name value` | Set custom environmental variable |
| `--ignore-unknown-option opt` | Ignore specific unknown options |
| `--script-security level` | Script execution level (0-3) |
| `--shaper n` | Restrict output to `n` bytes per second |
| `--keepalive n m` | Ping every `n` seconds, restart if no response for `m` |
| `--inactive n [bytes]` | Exit after `n` seconds if traffic < `bytes` |
| `--session-timeout n` | Limit connection time to `n` seconds |
| `--ping-exit n` | Exit if `n` seconds pass without remote ping |
| `--ping-restart n` | Restart if `n` seconds pass without remote ping |
| `--ping n` | Ping remote every `n` seconds |
| `--multihome` | Configure multi-homed UDP server |
| `--fast-io` | Optimize TUN/TAP/UDP writes |
| `--persist-tun` | Keep tun/tap device open across restarts |
| `--persist-remote-ip` | Keep remote IP across restarts |
| `--persist-local-ip` | Keep local IP across restarts |
| `--tun-mtu n` | Set tun/tap device MTU (default 1500) |
| `--mtu-test` | Empirically measure and report MTU |
| `--fragment max` | Enable internal datagram fragmentation |
| `--mssfix [n]` | Set upper bound on TCP MSS |
| `--user user` | Set UID to user after initialization |
| `--group group` | Set GID to group after initialization |
| `--chroot dir` | Chroot to directory after initialization |
| `--daemon [name]` | Become a daemon after initialization |
| `--verb n` | Set output verbosity (0-11) |

### Multi-Client Server Options
| Flag | Description |
|------|-------------|
| `--server net mask` | Helper for server mode configuration |
| `--server-ipv6 net/bits` | Configure IPv6 server mode |
| `--push "option"` | Push config option to peer |
| `--ifconfig-pool s e [m]` | Set aside pool of subnets for clients |
| `--client-to-client` | Internally route client-to-client traffic |
| `--duplicate-cn` | Allow multiple clients with same Common Name |
| `--max-clients n` | Allow max `n` simultaneous clients |

### Client Options
| Flag | Description |
|------|-------------|
| `--client` | Helper for client mode configuration |
| `--auth-user-pass [up]` | Authenticate with username/password |
| `--pull` | Accept config options from peer |
| `--dns server <n> <opt> <val>` | Configure DNS server options |

### Encryption & TLS Options
| Flag | Description |
|------|-------------|
| `--auth alg` | HMAC digest algorithm (default SHA1) |
| `--cipher alg` | Encrypt packets with cipher `alg` |
| `--data-ciphers list` | List of allowed ciphers for negotiation |
| `--tls-server` | Assume TLS server role |
| `--tls-client` | Assume TLS client role |
| `--ca file` | Root CA certificate file |
| `--cert file` | Local certificate file |
| `--key file` | Local private key file |
| `--dh file` | Diffie Hellman parameters (server only) |
| `--tls-auth f [d]` | Add additional layer of HMAC authentication |
| `--tls-crypt key` | Add layer of authenticated encryption |
| `--genkey type file` | Generate a new random key (tls-auth, etc.) |

### Standalone & Info Options
| Flag | Description |
|------|-------------|
| `--show-ciphers` | Show available cipher algorithms |
| `--show-digests` | Show available message digest algorithms |
| `--show-tls` | Show supported TLS ciphers |
| `--mktun` | Create a persistent tunnel |
| `--rmtun` | Remove a persistent tunnel |
| `--show-gateway` | Show info about system gateway |

## Notes
- **Privileges**: Running OpenVPN usually requires root privileges to create tun/tap interfaces and modify routing tables.
- **Security**: Use `--script-security 2` if your configuration relies on custom up/down scripts.
- **Compatibility**: Ensure `--cipher`, `--auth`, and compression settings match on both ends of the tunnel.
- **Data Channel Offload (DCO)**: Modern versions support DCO for performance; use `--disable-dco` if encountering kernel compatibility issues.