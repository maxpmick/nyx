---
name: paros
description: A lightweight Java-based HTTP/HTTPS proxy for assessing web application vulnerability. Use it to intercept and modify HTTP/HTTPS data between the browser and the server, crawl websites using a spider, and perform automated vulnerability scans. Ideal for web application security testing, manual request manipulation, and session analysis.
---

# paros

## Overview
Paros is a Java-based web application security assessment tool. It functions as a man-in-the-middle proxy, allowing for the inspection and modification of HTTP/HTTPS traffic. It includes features for spidering (crawling) sites and running automated vulnerability scans based on predefined policies. Category: Web Application Testing.

## Installation (if not already installed)
Assume paros is already installed. If you encounter errors, ensure Java is available:

```bash
sudo apt update
sudo apt install paros
```
Dependencies: `default-jre`, `java-wrappers`.

## Common Workflows

### Launching the GUI
Most users interact with Paros via its graphical interface to configure proxy settings (defaulting to localhost:8080) and intercept traffic.
```bash
paros
```

### Automated Spidering via Command Line
To crawl a website and identify its structure without opening the GUI:
```bash
paros -spider -seed http://example.com http://example.com/api/
```

### Vulnerability Scanning and Reporting
Run a scan based on the last saved policy and export the results to a report:
```bash
paros -scan -last_scan_report /tmp/vulnerability_report.html
```

### Starting a New Session
Initialize a specific session file for a new engagement:
```bash
paros -newsession /home/kali/work/client_alpha.session
```

## Complete Command Reference

Paros can be launched as a standalone command or via the Java archive.

### Execution Syntax
```bash
paros [options]
# OR
java -jar /usr/share/paros/paros.jar [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `-help` | Show the help message and exit. |
| `-newsession <session_file_path>` | Create and use a new session file at the specified path. |

### Spider and Scan Options

| Flag | Description |
|------|-------------|
| `-spider` | Run the spider/crawler. Requires seeds or a previous session. |
| `-seed <URL1> <URL2> ...` | Add one or more seed URLs to the spider for crawling. |
| `-scan` | Run a vulnerability scan. This uses the previously saved scan policy. |
| `-last_scan_report [file_path]` | Generate the 'Last Scan Report' and save it to the provided file path. |

## Notes
- **Java Dependency**: Paros requires a Java Runtime Environment (JRE). If the GUI fails to launch, verify your `JAVA_HOME` or default java version.
- **Proxy Configuration**: To intercept traffic, you must configure your web browser to use Paros as its proxy (typically `127.0.0.1:8080`).
- **SSL/TLS**: For HTTPS interception, you may need to import the Paros Root CA certificate into your browser's trust store.
- **Legacy Tool**: Paros is a legacy tool; for more modern features, users often migrate to OWASP ZAP or Burp Suite, though Paros remains useful for lightweight tasks.