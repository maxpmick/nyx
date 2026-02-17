---
name: openssh
description: Securely access remote machines, transfer files, and manage cryptographic keys using the SSH protocol. Use for remote administration, secure file copying (SCP/SFTP), port forwarding, tunneling, and generating SSH key pairs during penetration testing or system maintenance.
---

# openssh

## Overview
OpenSSH is a comprehensive suite of networking utilities based on the Secure Shell (SSH) protocol. It provides encrypted communication for logging into remote systems, executing commands, and transferring files. It is the industry standard for secure remote access and includes tools for key management and authentication. Category: Connectivity / Remote Access.

## Installation (if not already installed)
OpenSSH is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt install openssh-client openssh-server
```

## Common Workflows

### Remote Access and Command Execution
```bash
ssh user@192.168.1.100
ssh user@192.168.1.100 "ls -la /var/www"
```

### Secure File Transfer
```bash
# Copy local file to remote
scp local_file.txt user@remote_host:/path/to/destination/
# Download directory from remote
scp -r user@remote_host:/var/logs ./local_logs
```

### Key Generation and Deployment
```bash
# Generate a modern Ed25519 key pair
ssh-keygen -t ed25519 -C "admin@kali"
# Copy public key to remote server for passwordless login
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@remote_host
```

### Port Forwarding (Tunneling)
```bash
# Local port forwarding: Access remote database on local port 8080
ssh -L 8080:localhost:3306 user@remote_host
```

## Complete Command Reference

### ssh (Remote Login Client)
```
ssh [-46AaCfGgKkMNnqsTtVvXxYy] [-B bind_interface] [-b bind_address]
    [-c cipher_spec] [-D [bind_address:]port] [-E log_file]
    [-e escape_char] [-F configfile] [-I pkcs11] [-i identity_file]
    [-J destination] [-L address] [-l login_name] [-m mac_spec]
    [-O ctl_cmd] [-o option] [-P tag] [-p port] [-R address]
    [-S ctl_path] [-W host:port] [-w local_tun[:remote_tun]]
    destination [command [argument ...]]
ssh [-Q query_option]
```

### scp (Secure File Copy)
```
scp [-346ABCOpqRrsTv] [-c cipher] [-D sftp_server_path] [-F ssh_config]
    [-i identity_file] [-J destination] [-l limit] [-o ssh_option]
    [-P port] [-S program] [-X sftp_option] source ... target
```

### sftp (Secure File Transfer)
```
sftp [-46AaCfNpqrv] [-B buffer_size] [-b batchfile] [-c cipher]
     [-D sftp_server_command] [-F ssh_config] [-i identity_file]
     [-J destination] [-l limit] [-o ssh_option] [-P port]
     [-R num_requests] [-S program] [-s subsystem | sftp_server]
     [-X sftp_option] destination
```

### ssh-keygen (Key Utility)
| Flag | Description |
|------|-------------|
| `-a rounds` | Number of KDF rounds |
| `-b bits` | Number of bits in the key |
| `-C comment` | Provide a new comment |
| `-f filename` | Filename of the key file |
| `-t type` | Specify type of key to create (`rsa`, `ecdsa`, `ed25519`, etc.) |
| `-N new_passphrase` | Provide new passphrase |
| `-P passphrase` | Provide old passphrase |
| `-p` | Change passphrase of an existing private key |
| `-i` | Import a foreign SSH key |
| `-e` | Export a key to a foreign format |
| `-y` | Read private key and print public key |
| `-l` | Show fingerprint of specified public key file |
| `-F hostname` | Search for hostname in `known_hosts` |
| `-R hostname` | Remove all keys belonging to hostname from `known_hosts` |
| `-L` | Print the contents of a certificate |
| `-A` | Generate host keys of all types (used by init scripts) |

### ssh-add (Authentication Agent Tool)
| Flag | Description |
|------|-------------|
| `-D` | Delete all identities from the agent |
| `-d` | Remove specific identities from the agent |
| `-L` | List public key parameters of all identities |
| `-l` | List fingerprints of all identities |
| `-t life` | Set maximum lifetime for identities |
| `-x` | Lock the agent with a password |
| `-X` | Unlock the agent |
| `-c` | Require confirmation before using identities |
| `-E hash` | Specify fingerprint hash algorithm (`md5`, `sha256`) |
| `-K` | Load resident keys from a FIDO authenticator |

### ssh-copy-id (Install Public Keys)
| Flag | Description |
|------|-------------|
| `-i file` | Use specific identity file (public key) |
| `-f` | Force mode (copy even if already present) |
| `-n` | Dry run (no keys actually copied) |
| `-s` | Use SFTP instead of remote command execution |
| `-p port` | Specify remote SSH port |

### ssh-keyscan (Gather Public Keys)
| Flag | Description |
|------|-------------|
| `-4` / `-6` | Force IPv4 or IPv6 |
| `-H` | Hash all hostnames and addresses in output |
| `-p port` | Port to connect to |
| `-T timeout` | Set timeout for connection attempts |
| `-t type` | Specify key types to fetch (rsa, dsa, ecdsa, ed25519) |

### sshd (SSH Daemon)
```
sshd [-46DdeGiqTtV] [-C connection_spec] [-c host_cert_file]
     [-E log_file] [-f config_file] [-g login_grace_time]
     [-h host_key_file] [-o option] [-p port] [-u len]
```

## Notes
- **Security**: Always use strong passphrases for private keys. Prefer `ed25519` keys over `rsa` where supported.
- **Permissions**: SSH is strict about file permissions. Private keys should be `600` (`-rw-------`) and the `.ssh` directory should be `700` (`-rwx------`).
- **Agent Forwarding**: Use `ssh -A` with caution; if the remote host is compromised, the attacker can access your local agent.