---
name: openssl
description: A robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols. Use for generating certificates, CSRs, private keys, calculating message digests, encrypting/decrypting files, and testing SSL/TLS connections or server configurations during penetration testing and security audits.
---

# openssl

## Overview
OpenSSL is a general-purpose cryptographic utility for SSL/TLS protocols. It supports a wide range of cryptographic functions including RSA, DH, and DSA key handling, X.509 certificate creation, message digests, and symmetric encryption. Category: Cryptography / Exploitation / Information Gathering.

## Installation (if not already installed)
Assume openssl is already installed. If missing:
```bash
sudo apt install openssl libssl-dev
```

## Common Workflows

### Generate a new RSA Private Key and CSR
```bash
openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr
```

### Check a Remote SSL/TLS Service
```bash
openssl s_client -connect example.com:443 -showcerts
```

### Encrypt a file using AES-256-CBC
```bash
openssl enc -aes-256-cbc -salt -in secret.txt -out secret.txt.enc
```

### Extract Public Key from Private Key
```bash
openssl rsa -in private.key -pubout -out public.key
```

### Verify a Certificate against a CA
```bash
openssl verify -CAfile ca-cert.pem user-cert.pem
```

## Complete Command Reference

### Standard Commands
| Command | Description |
|---------|-------------|
| `asn1parse` | Parse an ASN.1 sequence |
| `ca` | Sample minimal CA application |
| `ciphers` | Cipher suite description determinations |
| `cmp` | Certificate Management Protocol |
| `cms` | Cryptographic Message Syntax utilities |
| `crl` | Certificate Revocation List (CRL) utility |
| `crl2pkcs7` | CRL to PKCS#7 conversion |
| `dgst` | Message digest calculation |
| `dhparam` | DH parameter generation and management |
| `dsa` | DSA key processing |
| `dsaparam` | DSA parameter generation and management |
| `ec` | EC key processing |
| `ecparam` | EC parameter generation and management |
| `enc` | Symmetric cipher routines |
| `engine` | Engine (loadable module) information and control |
| `errstr` | Look up error codes from numbers |
| `fipsinstall` | FIPS module installation tool |
| `gendsa` | Generate a DSA private key from parameters |
| `genpkey` | Generate a private key or parameters |
| `genrsa` | Generate an RSA private key |
| `info` | Display OpenSSL built-in information |
| `kdf` | Key Derivation Functions |
| `list` | List algorithms and features |
| `mac` | Message Authentication Code calculation |
| `nseq` | Create or examine a Netscape certificate sequence |
| `ocsp` | Online Certificate Status Protocol utility |
| `passwd` | Compute password hashes |
| `pkcs12` | PKCS#12 file utility |
| `pkcs7` | PKCS#7 file utility |
| `pkcs8` | PKCS#8 format private key conversion tool |
| `pkey` | Public or private key processing tool |
| `pkeyparam` | Public key algorithm parameter processing tool |
| `pkeyutl` | Public key algorithm cryptographic operation tool |
| `prime` | Compute prime numbers |
| `rand` | Generate pseudo-random bytes |
| `rehash` | Create symbolic links to certificates by hash value |
| `req` | PKCS#10 X.509 Certificate Signing Request (CSR) management |
| `rsa` | RSA key processing tool |
| `rsautl` | RSA utility for signing, verification, encryption, and decryption |
| `s_client` | SSL/TLS client program |
| `s_server` | SSL/TLS server program |
| `s_time` | SSL/TLS performance testing tool |
| `sess_id` | SSL/TLS session ID tool |
| `skeyutl` | Secure Key utility |
| `smime` | S/MIME mail processing |
| `speed` | Algorithm speed measurement |
| `spkac` | SPKAC printing and generating tool |
| `srp` | SRP (Secure Remote Password) tool |
| `storeutl` | Directory and file storage utility |
| `ts` | Time Stamping Authority tool |
| `verify` | X.509 certificate verification |
| `version` | OpenSSL version information |
| `x509` | X.509 certificate data management |

### Message Digest Commands
Use via `openssl dgst -[digest]` or directly:
`blake2b512`, `blake2s256`, `md4`, `md5`, `rmd160`, `sha1`, `sha224`, `sha256`, `sha3-224`, `sha3-256`, `sha3-384`, `sha3-512`, `sha384`, `sha512`, `sha512-224`, `sha512-256`, `shake128`, `shake256`, `sm3`.

### Cipher Commands
Use via `openssl enc -[cipher]` or directly:
`aes-128-cbc`, `aes-128-ecb`, `aes-192-cbc`, `aes-192-ecb`, `aes-256-cbc`, `aes-256-ecb`, `aria-128-cbc`, `aria-128-cfb`, `aria-128-cfb1`, `aria-128-cfb8`, `aria-128-ctr`, `aria-128-ecb`, `aria-128-ofb`, `aria-192-cbc`, `aria-192-cfb`, `aria-192-cfb1`, `aria-192-cfb8`, `aria-192-ctr`, `aria-192-ecb`, `aria-192-ofb`, `aria-256-cbc`, `aria-256-cfb`, `aria-256-cfb1`, `aria-256-cfb8`, `aria-256-ctr`, `aria-256-ecb`, `aria-256-ofb`, `base64`, `bf`, `bf-cbc`, `bf-cfb`, `bf-ecb`, `bf-ofb`, `camellia-128-cbc`, `camellia-128-ecb`, `camellia-192-cbc`, `camellia-192-ecb`, `camellia-256-cbc`, `camellia-256-ecb`, `cast`, `cast-cbc`, `cast5-cbc`, `cast5-cfb`, `cast5-ecb`, `cast5-ofb`, `des`, `des-cbc`, `des-cfb`, `des-ecb`, `des-ede`, `des-ede-cbc`, `des-ede-cfb`, `des-ede-ofb`, `des-ede3`, `des-ede3-cbc`, `des-ede3-cfb`, `des-ede3-ofb`, `des-ofb`, `des3`, `desx`, `rc2`, `rc2-40-cbc`, `rc2-64-cbc`, `rc2-cbc`, `rc2-cfb`, `rc2-ecb`, `rc2-ofb`, `rc4`, `rc4-40`, `seed`, `seed-cbc`, `seed-cfb`, `seed-ecb`, `seed-ofb`, `sm4-cbc`, `sm4-cfb`, `sm4-ctr`, `sm4-ecb`, `sm4-ofb`, `zlib`, `zstd`.

### Helper: c_rehash
Creates symbolic links to files named by the hash values.
```bash
c_rehash [-old] [-h] [-help] [-v] [dirs...]
```
- `-old`: Use old-style digest
- `-h`, `-help`: Print help
- `-v`: Verbose; print files removed and linked

## Notes
- OpenSSL 3.x introduces a provider-based architecture (e.g., `legacy` for older algorithms like MD4 or RC4).
- When testing SSL/TLS, `s_client` is invaluable for identifying supported protocols and ciphers.
- Always use `-nodes` (no DES) when generating keys if you do not want to protect the private key with a password.