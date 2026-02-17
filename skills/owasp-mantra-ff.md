---
name: owasp-mantra-ff
description: A web application security testing framework built on top of a portable Firefox browser. It includes integrated tools for header modification, cookie editing, proxy switching, and request manipulation. Use when performing manual web application security assessments, solving web-based CTFs, or demonstrating vulnerabilities like XSS, CSRF, and SQL injection within a browser environment.
---

# owasp-mantra-ff

## Overview
OWASP Mantra is a security-focused browser framework designed for web application testing. It integrates numerous extensions and tools directly into the browser interface to facilitate tasks like input manipulation, request replaying, and session management. Category: Web Application Testing.

## Installation (if not already installed)
Assume owasp-mantra-ff is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install owasp-mantra-ff
```

## Common Workflows

### Launching the Security Browser
Simply run the command to open the pre-configured Firefox environment:
```bash
owasp-mantra-ff
```

### Manual Vulnerability Testing
1. Launch `owasp-mantra-ff`.
2. Navigate to the target URL.
3. Use the built-in sidebar or toolbar tools to:
   - Modify HTTP Headers (User-Agent, Referer, etc.).
   - Edit or delete Cookies to test session handling.
   - Intercept and modify GET/POST parameters.
   - Switch between different proxy settings (e.g., routing traffic through Burp Suite or OWASP ZAP).

### CTF and Exploitation
Use the built-in string manipulation tools to encode/decode payloads (Base64, URL encoding, Hex) or generate XSS vectors directly within the browser tabs.

## Complete Command Reference

The tool is a wrapper script that initializes a portable Firefox profile with security extensions.

```bash
owasp-mantra-ff [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display help information and initialization debug info |

*Note: As a browser-based framework, most functionality is accessed via the Graphical User Interface (GUI) once the application has launched.*

## Notes
- **Portable Profile**: The tool runs Firefox in portable mode, using a dedicated profile directory located at `/usr/share/owasp-mantra-ff/Mantra`.
- **Dependencies**: Requires `xterm` to be installed for some initialization processes.
- **Legacy Status**: This tool is based on an older version of Firefox to maintain compatibility with specific security extensions; it should be used for testing purposes and not as a primary web browser for general internet use.
- **Integration**: It is highly effective when used in conjunction with intercepting proxies like Burp Suite or OWASP ZAP by using the built-in proxy switcher.