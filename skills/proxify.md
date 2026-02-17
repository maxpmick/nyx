---
name: proxify
description: Swiss Army knife proxy tool for HTTP/HTTPS/TCP/UDP traffic capture, manipulation, and replay. Use when intercepting traffic from thick clients, performing MITM attacks, debugging web requests, or replaying captured traffic into tools like Burp Suite. It supports DSL-based filtering and matching, upstream proxying, and includes an embedded DNS server for invisible proxying.
---

# proxify

## Overview
Proxify is a versatile proxy tool designed for rapid deployment and deep traffic analysis. It supports HTTP/HTTPS and non-HTTP protocols, TLS MITM with custom certificates, and traffic manipulation via a Domain Specific Language (DSL). It is particularly effective for "invisible" proxying where the client cannot be configured with a standard proxy. Category: Sniffing & Spoofing / Web Application Testing.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install proxify
```

## Common Workflows

### Basic HTTP/HTTPS Interception
Start a proxy on the default port (8888) and save all traffic to the `logs` directory:
```bash
proxify -o logs
```

### Invisible Proxying with DNS Mapping
Force a specific domain to resolve to a local IP for interception, useful for thick clients:
```bash
proxify -dm "example.com:1.2.3.4" -da ":53"
```

### Traffic Manipulation with DSL
Replace "admin=false" with "admin=true" in all outgoing requests:
```bash
proxify -req-mrd "replace(all, 'admin=false', 'admin=true')"
```

### Replaying Captured Traffic to Burp
Import previously dumped logs into Burp Suite by replaying them through Burp's proxy:
```bash
replay-proxify -output logs/ -burp-addr http://127.0.0.1:8080
```

## Complete Command Reference

### proxify
The main proxy engine for HTTP/HTTPS traffic.

**Output Options**
| Flag | Description |
|------|-------------|
| `-o`, `-output string` | Output Directory to store HTTP proxy logs (default "logs") |
| `-dump-req` | Dump only HTTP requests to output file |
| `-dump-resp` | Dump only HTTP responses to output file |

**Filter Options (DSL)**
| Flag | Description |
|------|-------------|
| `-req-fd`, `-request-dsl string` | Request Filter DSL |
| `-resp-fd`, `-response-dsl string` | Response Filter DSL |
| `-req-mrd`, `-request-match-replace-dsl string` | Request Match-Replace DSL |
| `-resp-mrd`, `-response-match-replace-dsl string` | Response Match-Replace DSL |

**Network Options**
| Flag | Description |
|------|-------------|
| `-ha`, `-http-addr string` | Listening HTTP IP and Port address (default "127.0.0.1:8888") |
| `-sa`, `-socks-addr string` | Listening SOCKS IP and Port address (default "127.0.0.1:10080") |
| `-da`, `-dns-addr string` | Listening DNS IP and Port address |
| `-dm`, `-dns-mapping string` | Domain to IP DNS mapping (eg domain:ip,domain:ip,..) |
| `-r`, `-resolver string` | Custom DNS resolvers to use (ip:port) |

**Proxy Options**
| Flag | Description |
|------|-------------|
| `-hp`, `-http-proxy string` | Upstream HTTP Proxies (eg http://proxy-ip:proxy-port) |
| `-sp`, `-socks5-proxy string` | Upstream SOCKS5 Proxies (eg socks5://proxy-ip:proxy-port) |
| `-c int` | Number of requests before switching to the next upstream proxy (default 1) |

**Export Options (Elasticsearch/Kafka)**
| Flag | Description |
|------|-------------|
| `-elastic-address string` | Elasticsearch address (ip:port) |
| `-elastic-ssl` | Enable elasticsearch ssl |
| `-elastic-ssl-verification` | Enable elasticsearch ssl verification |
| `-elastic-username string` | Elasticsearch username |
| `-elastic-password string` | Elasticsearch password |
| `-elastic-index string` | Elasticsearch index name (default "proxify") |
| `-kafka-address string` | Address of kafka broker (ip:port) |
| `-kafka-topic string` | Kafka topic to publish messages on (default "proxify") |

**Configuration & Debug**
| Flag | Description |
|------|-------------|
| `-config string` | Directory for storing program information (default "/root/.config/proxify") |
| `-cert-cache-size int` | Number of certificates to cache (default 256) |
| `-allow string` | Allowed list of IP/CIDR's to be proxied |
| `-deny string` | Denied list of IP/CIDR's to be proxied |
| `-silent` | Silent mode |
| `-nc`, `-no-color` | Disable color output (default true) |
| `-version` | Show version |
| `-v`, `-verbose` | Verbose output |

---

### mitmrelay
Utility for relaying and intercepting raw TCP/UDP traffic.

| Flag | Description |
|------|-------------|
| `-client-cert string` | Relay => Server Cert File |
| `-client-key string` | Relay => Server Key File |
| `-dns-addr string` | Listen DNS Ip and port (default ":5353") |
| `-dns-mapping string` | DNS A mapping (eg domain:ip,domain:ip,..) |
| `-http-addr string` | HTTP Server Listen Address (default "127.0.0.1:49999") |
| `-output string` | Output Folder (default "logs/") |
| `-protocol string` | tcp or udp (default "tcp") |
| `-proxy-addr string` | HTTP Proxy Address |
| `-relay value` | listen_ip:listen_port => destination_ip:destination_port |
| `-request-match-replace-dsl string` | Request Match-Replace DSL |
| `-resolver-addr string` | Listen DNS Ip and port |
| `-response-match-replace-dsl string` | Response Match-Replace DSL |
| `-server-cert string` | Client => Relay Cert File |
| `-server-key string` | Client => Relay Key File |
| `-timeout int` | Connection Timeout In Seconds (default 180) |
| `-tls-client` | Relay => Server should use tls |
| `-tls-server` | Client => Relay should use tls |

---

### replay-proxify
Utility to replay dumped traffic into other tools.

| Flag | Description |
|------|-------------|
| `-burp-addr string` | Burp HTTP Address (default "http://127.0.0.1:8080") |
| `-dns-addr string` | DNS UDP Server Listen Address (default ":10000") |
| `-http-addr string` | HTTP Server Listen Address (default ":80") |
| `-output string` | Output Folder containing logs (default "db/") |
| `-proxy-addr string` | HTTP Proxy Server Listen Address (default ":8081") |

## Notes
- To intercept HTTPS traffic, you must install the `proxify` CA certificate on the client device.
- The DSL language allows for complex filtering; use `-v` to debug if your filters are not matching as expected.
- When using `mitmrelay` for DNS mapping, ensure no other service is binding to the DNS port (usually 53).