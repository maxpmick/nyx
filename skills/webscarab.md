---
name: webscarab
description: Analyze and intercept HTTP/HTTPS traffic between a browser and a web server. Use when performing web application security assessments, debugging HTTP requests/responses, identifying vulnerabilities in web application logic, or manually manipulating session data and parameters during penetration testing.
---

# webscarab

## Overview
WebScarab is an OWASP-designed framework for analyzing applications that communicate via HTTP and HTTPS. It functions primarily as an intercepting proxy, allowing security specialists to review and modify requests before they reach the server and responses before they reach the browser. Category: Web Application Testing.

## Installation (if not already installed)
WebScarab is typically pre-installed on Kali Linux. If missing, use the following command:

```bash
sudo apt update && sudo apt install webscarab
```

**Dependencies:**
- default-jre (Java Runtime Environment)

## Common Workflows

### Launching the GUI
WebScarab is primarily a graphical tool. Launch it from the terminal to begin intercepting traffic:
```bash
webscarab
```
Once launched, configure your browser to use `127.0.0.1:8008` as its HTTP/HTTPS proxy.

### Intercepting and Modifying Requests
1. Start WebScarab.
2. Go to the **Proxy** tab and then the **Manual Edit** sub-tab.
3. Check the **Intercept Requests** box.
4. Submit a form or navigate in your browser; WebScarab will pause the request, allowing you to modify headers, cookies, or POST data before clicking "Accept changes".

### Spidering a Website
1. Navigate to the target site through the WebScarab proxy to populate the **Summary** tree.
2. Right-click the target node in the tree and select **Spider** to discover linked resources and hidden paths.

### Fuzzing Parameters
1. Locate a request with parameters in the **Summary** or **Proxy** history.
2. Right-click the request and select **Use as fuzz template**.
3. In the **Fuzzer** tab, define the injection points and select a payload source (e.g., a file or a sequence) to test for vulnerabilities like XSS or SQL injection.

## Complete Command Reference

WebScarab is a Java-based application. While it is usually invoked via the `webscarab` wrapper script, it supports standard Java options if called directly.

### CLI Usage
```bash
webscarab [options]
```

| Option | Description |
|--------|-------------|
| `-h`, `--help` | Display help information. |
| (No flags) | Launches the main Graphical User Interface (GUI). |

### Key Functional Modules (GUI-based)

| Module | Description |
|--------|-------------|
| **Summary** | Displays a tree view of all URLs visited and the details of each request/response. |
| **Proxy** | The core intercepting engine. Includes "Manual Edit" for on-the-fly modification and "Log" for history. |
| **Spider** | Automatically crawls the target site to identify all links and forms. |
| **Fuzzer** | Automated testing of parameters using lists of payloads to find injection vulnerabilities. |
| **Compare** | Tool to identify differences between two or more HTTP responses. |
| **Session ID Analysis** | Collects and analyzes session tokens to test for predictability and randomness. |
| **Scripting** | Allows writing BeanShell scripts to automate complex interactions or data transformations. |
| **Fragments** | Extracts and displays specific parts of HTML pages (scripts, comments, etc.). |

## Notes
- **Proxy Configuration**: By default, WebScarab listens on `localhost:8008`. You must configure your browser's proxy settings to match this.
- **HTTPS/SSL**: To intercept HTTPS traffic without browser warnings, you must import the WebScarab CA certificate into your browser's trusted root store.
- **Legacy Status**: WebScarab is an older tool. While powerful for manual analysis, for modern web applications involving WebSockets or complex JavaScript, tools like OWASP ZAP or Burp Suite may offer more updated feature sets.