---
name: padbuster
description: Automate Padding Oracle attacks to decrypt ciphertext, encrypt arbitrary plaintext, and perform automated response analysis to identify vulnerabilities. Use when testing web applications for padding oracle vulnerabilities, typically in CBC mode encryption implementations.
---

# padbuster

## Overview
PadBuster is a Perl script designed to automate Padding Oracle attacks. It can decrypt arbitrary ciphertext without the key, encrypt custom plaintext, and analyze server responses to determine if a request is vulnerable to padding oracle attacks. Category: Web Application Testing.

## Installation (if not already installed)
Assume padbuster is already installed. If you get a "command not found" error:

```bash
sudo apt install padbuster
```

Dependencies: libcompress-raw-zlib-perl, libcrypt-ssleay-perl, libnet-ssleay-perl, libwww-perl, perl.

## Common Workflows

### Decrypt a value
```bash
padbuster http://example.com/page.php?auth=L7I9Q9kyU8 7I9Q9kyU8 8 -cookies "user=guest"
```
Decrypts the `auth` parameter using a block size of 8.

### Encrypt a new value
```bash
padbuster http://example.com/page.php?auth=L7I9Q9kyU8 7I9Q9kyU8 8 -plaintext "admin"
```
Generates a new valid ciphertext for the string "admin".

### Resume a failed session
```bash
padbuster http://example.com/page.php?auth=L7I9Q9kyU8 7I9Q9kyU8 8 -resume 2
```
Resumes the decryption process starting from block number 2.

## Complete Command Reference

```bash
padbuster URL EncryptedSample BlockSize [options]
```

### Required Arguments
| Argument | Description |
|----------|-------------|
| `URL` | The target URL (including query string if applicable) |
| `EncryptedSample` | The encrypted value to test. Must be present in the URL, PostData, or a Cookie |
| `BlockSize` | The block size used by the algorithm (usually 8 or 16) |

### Options

| Flag | Description |
|------|-------------|
| `-auth [user:pass]` | HTTP Basic Authentication credentials |
| `-bruteforce` | Perform brute force against the first block |
| `-ciphertext [Bytes]` | CipherText for Intermediate Bytes (Hex-Encoded) |
| `-cookies [Cookies]` | HTTP Cookies (format: `name1=value1; name2=value2`) |
| `-encoding [0-4]` | Encoding Format of Sample (Default 0):<br>0=Base64, 1=Lower HEX, 2=Upper HEX, 3=.NET UrlToken, 4=WebSafe Base64 |
| `-encodedtext [String]` | Data to Encrypt (Encoded) |
| `-error [Error String]` | Specific Padding Error Message to look for |
| `-headers [Headers]` | Custom Headers (format: `name1::value1; name2::value2`) |
| `-interactive` | Prompt for confirmation on decrypted bytes |
| `-intermediate [Bytes]` | Intermediate Bytes for CipherText (Hex-Encoded) |
| `-log` | Generate log files (creates folder `PadBuster.DDMMYY`) |
| `-noencode` | Do not URL-encode the payload (encoded by default) |
| `-noiv` | Sample does not include IV (decrypt first block) |
| `-plaintext [String]` | Plain-Text to Encrypt |
| `-post [Post Data]` | HTTP Post Data String |
| `-prefix [Prefix]` | Prefix bytes to append to each sample (Encoded) |
| `-proxy [addr:port]` | Use HTTP/S Proxy |
| `-proxyauth [user:pass]`| Proxy Authentication credentials |
| `-resume [Block]` | Resume at this block number |
| `-usebody` | Use response body content for response analysis phase |
| `-verbose` | Be Verbose |
| `-veryverbose` | Be Very Verbose (Debug Only) |

## Notes
- The `EncryptedSample` must be exactly as it appears in the request (e.g., if it is Base64 encoded in a cookie, provide the Base64 string).
- If the tool cannot automatically identify the padding error, it will provide a list of response signatures; you must choose the one that represents a padding error.
- Block size is typically 8 (DES, Blowfish) or 16 (AES).