---
name: openssh-ssh1
description: Access legacy systems using the obsolete SSH1 protocol. This toolset includes ssh1, scp1, and ssh-keygen1, specifically built to support the insecure SSHv1 protocol. Use when performing penetration testing on legacy infrastructure, industrial control systems (ICS), or outdated network appliances that do not support SSHv2.
---

# openssh-ssh1

## Overview
OpenSSH-SSH1 is a portable version of the OpenSSH suite specifically compiled to maintain support for the legacy SSH1 protocol. It provides a secure channel over an insecure network for logging into remote machines, executing commands, and transferring files on systems that have not been updated to modern standards. Category: Exploitation / Connectivity.

## Installation (if not already installed)
The tool is typically available in Kali Linux metapackages but can be installed manually if missing:

```bash
sudo apt update
sudo apt install openssh-client-ssh1
```

## Common Workflows

### Connecting to a legacy SSH1 server
```bash
ssh1 -1 user@legacy-server.local
```

### Copying files from a legacy host
```bash
scp1 user@legacy-host:/etc/config.backup ./config.backup
```

### Generating an RSA1 key for legacy authentication
```bash
ssh-keygen1 -t rsa1 -b 1024 -f ~/.ssh/id_rsa1
```

### Port forwarding through a legacy gateway
```bash
ssh1 -L 8080:internal-web:80 user@legacy-gateway
```

## Complete Command Reference

### ssh1
The SSH client for remote login and command execution.

**Usage:** `ssh1 [-1246AaCfGgKkMNnqsTtVvXxYy] [-b bind_address] [-c cipher_spec] [-D [bind_address:]port] [-E log_file] [-e escape_char] [-F configfile] [-I pkcs11] [-i identity_file] [-J [user@]host[:port]] [-L address] [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port] [-Q query_option] [-R address] [-S ctl_path] [-W host:port] [-w local_tun[:remote_tun]] [user@]hostname [command]`

| Flag | Description |
|------|-------------|
| `-1` | Force use of protocol version 1 |
| `-2` | Force use of protocol version 2 |
| `-4` | Use IPv4 addresses only |
| `-6` | Use IPv6 addresses only |
| `-A` | Enable forwarding of the authentication agent connection |
| `-a` | Disable forwarding of the authentication agent connection |
| `-C` | Requests compression of all data |
| `-f` | Go to background just before command execution |
| `-G` | Causes ssh to print its configuration after evaluating Host and Match blocks |
| `-g` | Allows remote hosts to connect to local forwarded ports |
| `-K` | Enables GSSAPI-based authentication and forwarding |
| `-k` | Disables forwarding of GSSAPI credentials |
| `-M` | Places the ssh client into "master" mode for connection sharing |
| `-N` | Do not execute a remote command (useful for port forwarding) |
| `-n` | Redirects stdin from /dev/null |
| `-q` | Quiet mode (suppresses warnings and diagnostic messages) |
| `-s` | May be used to request invocation of a subsystem on the remote system |
| `-T` | Disable pseudo-terminal allocation |
| `-t` | Force pseudo-terminal allocation |
| `-V` | Display the version number |
| `-v` | Verbose mode (multiple -v increase verbosity) |
| `-X` | Enables X11 forwarding |
| `-x` | Disables X11 forwarding |
| `-Y` | Enables trusted X11 forwarding |
| `-y` | Send logging information using the syslog module |
| `-b bind_address` | Use bind_address on the local machine as the source address of the connection |
| `-c cipher_spec` | Selects the cipher to use for encrypting the session |
| `-D port` | Dynamic application-level port forwarding (SOCKS) |
| `-E log_file` | Append debug logs to log_file instead of standard error |
| `-e escape_char` | Sets the escape character for sessions with a pty (default: '~') |
| `-F configfile` | Specifies an alternative per-user configuration file |
| `-I pkcs11` | Specify the PKCS#11 shared library ssh should use to communicate with a PKCS#11 token |
| `-i identity_file` | Selects a file from which the identity (private key) for public key authentication is read |
| `-J destination` | Connect to the target host by first making an ssh connection to a jump host |
| `-L address` | Local port forwarding |
| `-l login_name` | Specifies the user to log in as on the remote machine |
| `-m mac_spec` | A comma-separated list of MAC algorithms specified in order of preference |
| `-O ctl_cmd` | Control an active connection multiplexing master process |
| `-o option` | Can be used to give options in the format used in the configuration file |
| `-p port` | Port to connect to on the remote host |
| `-Q query_option` | Queries ssh for the algorithms supported for the specified version |
| `-R address` | Remote port forwarding |
| `-S ctl_path` | Specifies the location of a control socket for connection sharing |
| `-W host:port` | Requests that standard input and output on the client be forwarded to host on port |
| `-w local_tun[:remote_tun]` | Requests tunnel device forwarding with the specified tun devices |

### scp1
Secure copy (remote file copy program) using SSH1.

**Usage:** `scp [-12346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file] [-l limit] [-o ssh_option] [-P port] [-S program] [[user@]host1:]file1 ... [[user@]host2:]file2`

| Flag | Description |
|------|-------------|
| `-1` | Forces scp to use protocol 1 |
| `-2` | Forces scp to use protocol 2 |
| `-3` | Copies between two remote hosts are transferred through the local host |
| `-4` | Forces scp to use IPv4 addresses only |
| `-6` | Forces scp to use IPv6 addresses only |
| `-B` | Selects batch mode (prevents asking for passwords) |
| `-C` | Compression enabled |
| `-p` | Preserves modification times, access times, and modes from the original file |
| `-q` | Quiet mode |
| `-r` | Recursively copy entire directories |
| `-v` | Verbose mode |
| `-c cipher` | Selects the cipher to use for encrypting the data transfer |
| `-F ssh_config` | Specifies an alternative per-user configuration file for ssh |
| `-i identity_file` | Selects the file from which the identity (private key) for public key authentication is read |
| `-l limit` | Limits the used bandwidth, specified in Kbit/s |
| `-o ssh_option` | Can be used to pass options to ssh in the format used in ssh_config |
| `-P port` | Specifies the port to connect to on the remote host |
| `-S program` | Name of the program to use for the encrypted connection |

### ssh-keygen1
Authentication key generation, management, and conversion.

**Usage:**
- Generate/Manage: `ssh-keygen [-q] [-b bits] [-t dsa | ecdsa | ed25519 | rsa | rsa1] [-N new_passphrase] [-C comment] [-f output_keyfile]`
- Change Passphrase: `ssh-keygen -p [-P old_passphrase] [-N new_passphrase] [-f keyfile]`
- Import/Export: `ssh-keygen -i [-m key_format] [-f input_keyfile]` / `ssh-keygen -e [-m key_format] [-f input_keyfile]`
- Fingerprint/Verify: `ssh-keygen -y [-f input_keyfile]` / `ssh-keygen -l [-v] [-E fingerprint_hash] [-f input_keyfile]`

| Flag | Description |
|------|-------------|
| `-A` | For each key type, generate host keys if they do not exist |
| `-a rounds` | Specifies the number of KDF rounds |
| `-B` | Show the bubblebabble digest of specified private or public key file |
| `-b bits` | Specifies the number of bits in the key to create |
| `-C comment` | Provides a new comment |
| `-c` | Requests changing the comment in the private and public key files |
| `-D pkcs11` | Download the PKCS#11 public keys provided by the shared library |
| `-E hash` | Specifies the hash algorithm used when displaying fingerprints |
| `-e` | Read a private or public OpenSSH key file and print it in a specified format |
| `-F hostname` | Search for hostname in a known_hosts file |
| `-f filename` | Specifies the filename of the key file |
| `-G file` | Generate candidate primes for Diffie-Hellman group exchange |
| `-g` | Use generic DNS resource record format when printing fingerprint resource records |
| `-H` | Hash a known_hosts file |
| `-h` | When signing a key, create a host certificate instead of a user certificate |
| `-I cert_id` | Specify the key identity when signing a public key |
| `-i` | Read an unencrypted private (or public) key file and print an OpenSSH compatible key |
| `-J num_lines` | Exit after screening the specified number of lines when testing primes |
| `-j start_line` | Start screening at the specified line number when testing primes |
| `-K checkpt` | Write the last line processed to checkpt file when testing primes |
| `-k` | Generate a KRL (Key Revocation List) file |
| `-L` | Prints the contents of one or more certificates |
| `-l` | Show fingerprint of specified public key file |
| `-M memory` | Specify the amount of memory to use when generating candidate primes |
| `-m format` | Specify a key format for -i or -e options |
| `-N new_phrase` | Provides the new passphrase |
| `-n principals` | Specify one or more principals (user or host names) to be included in a certificate |
| `-O option` | Specify a certificate option when signing a key |
| `-P passphrase` | Provides the (old) passphrase |
| `-p` | Requests changing the passphrase of a private key file |
| `-Q` | Test whether keys have been revoked in a KRL |
| `-q` | Silence ssh-keygen |
| `-R hostname` | Removes all keys belonging to hostname from a known_hosts file |
| `-r hostname` | Print the SSHFP fingerprint resource record for the named public key file |
| `-S start` | Specify the start point when generating candidate primes |
| `-s ca_key` | Certify (sign) a public key using the specified CA key |
| `-T file` | Test candidate primes (generated by -G) for safety |
| `-t type` | Specifies the type of key to create (use `rsa1` for SSH1) |
| `-u` | Update a KRL (used with -k) |
| `-V validity` | Specify a validity interval when signing a certificate |
| `-v` | Verbose mode |
| `-W generator` | Specify the generator to use when testing candidate primes |
| `-y` | Read a private OpenSSH format file and print an OpenSSH public key to stdout |
| `-z serial` | Specifies a serial number to be embedded in the certificate |

## Notes
- **Security Warning**: SSH1 is cryptographically broken and vulnerable to man-in-the-middle attacks (insertion attacks). Only use this tool when absolutely necessary for legacy compatibility.
- The `rsa1` key type is specific to the SSH1 protocol.
- Most modern OpenSSH servers disable SSH1 by default; you may need to enable `Protocol 1` in the server's `sshd_config` if you are testing your own legacy setup.