---
name: gss-ntlmssp
description: A GSSAPI mechanism plugin that implements the NTLMSSP protocol, supporting NTLM and NTLMv2 challenge-response variants. Use when integrating NTLM authentication into GSSAPI-aware applications, performing security testing on NTLM-based authentication flows, or enabling NTLM support for MIT Kerberos environments.
---

# gss-ntlmssp

## Overview
GSS-NTLMSSP is a loadable GSSAPI mechanism plugin that implements the NTLMSSP (NT LAN Manager Security Support Provider) protocol. It supports NTLM and NTLMv2, including various security variants for key exchange documented by Microsoft. It is primarily used to allow GSSAPI-aware applications (like those using MIT Kerberos) to authenticate via NTLM. Category: Sniffing & Spoofing / Exploitation.

## Installation (if not already installed)
Assume the plugin is already installed. If an application fails to find the NTLM mechanism:

```bash
sudo apt install gss-ntlmssp
```

For development headers:
```bash
sudo apt install gss-ntlmssp-dev
```

## Common Workflows

### Enabling NTLM for GSSAPI Applications
GSS-NTLMSSP is typically used transparently by applications that call the GSSAPI library. To ensure it is available, verify the presence of the config file:
```bash
cat /etc/gss/mech.d/ntlmssp.conf
```
The file should contain an entry mapping the NTLMSSP OID to `mech_ntlmssp.so`.

### Using NTLM with GSSAPI-aware tools
When using tools like `curl` or `ssh` that support GSSAPI, you can force the use of NTLM by specifying the mechanism if the tool supports it, or by configuring the environment to prefer NTLMSSP over Kerberos.

### Development Integration
Include the headers in a C project to explicitly call NTLMSSP-specific GSSAPI extensions:
```c
#include <gssapi/gssapi_ntlmssp.h>
```

## Complete Command Reference

This tool functions as a shared library plugin (`mech_ntlmssp.so`) rather than a standalone CLI tool. It is configured via GSSAPI mechanism files.

### Configuration Files
| Path | Purpose |
|------|---------|
| `/etc/gss/mech.d/ntlmssp.conf` | System-wide GSSAPI mechanism registration |
| `/usr/lib/x86_64-linux-gnu/gss/mech_ntlmssp.so` | The actual loadable module (path may vary by arch) |

### Supported Protocols/Features
*   **NTLMv1**: Legacy challenge-response.
*   **NTLMv2**: Modern secure challenge-response.
*   **Key Exchange**: Supports various security variants for session key negotiation.
*   **MIT Kerberos Compatibility**: Tested with MIT Kerberos 1.11+.

### Environment Variables
GSSAPI implementations often respect these variables which affect how `gss-ntlmssp` is loaded:
*   `GSS_MECH_CONFIG`: Point to a custom mechanism configuration file.
*   `KRB5_TRACE`: Can be used to debug loading issues in MIT Kerberos environments.

## Notes
*   **Security**: NTLM is generally considered less secure than Kerberos. Use NTLM only when Kerberos/SPNEGO is unavailable.
*   **Mechanism OID**: The NTLMSSP OID is `1.3.6.1.4.1.311.2.2.10`.
*   **Dependencies**: Requires `libgssapi-krb5-2` and `libwbclient0` (from Samba) for certain credential operations.