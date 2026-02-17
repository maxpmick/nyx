---
name: jsp-file-browser
description: A Java Server Page (JSP) based file browser used for remote web-based file access and manipulation. Use this tool during the exploitation or post-exploitation phases when you have the ability to upload or execute JSP files on a target web server (e.g., Apache Tomcat, Jetty, Resin) to gain a graphical interface for file management, command execution, and data exfiltration.
---

# jsp-file-browser

## Overview
jsp-file-browser is a single-file JSP application that provides a web-based interface for managing files on a remote server. It belongs to the Exploitation and Post-Exploitation domains, acting as a specialized web shell for JSP-compatible environments. It allows for file manipulation, command execution, and archive management through a browser.

## Installation (if not already installed)
The package contains the JSP file and an example CSS. Assume it is installed at `/usr/share/jsp-file-browser/`.

```bash
sudo apt install jsp-file-browser
```

## Common Workflows

### Deployment
Locate the JSP file on your Kali machine and upload it to the target's web root or a directory accessible by the application server (e.g., Tomcat's `webapps/ROOT/` or a specific application folder).

```bash
# Locate the file
ls -l /usr/share/jsp-file-browser/Browser.jsp

# Example: Uploading via curl if a PUT method is enabled (rare) or via an existing exploit
curl -T /usr/share/jsp-file-browser/Browser.jsp http://target.com/manager/html/Browser.jsp
```

### Accessing the Shell
Once uploaded, navigate to the URL in a web browser:
`http://<target-ip>:<port>/Browser.jsp`

### Executing Commands
Use the built-in "Execute" feature within the web interface to run native OS commands like `ls -la`, `whoami`, or `ifconfig`.

### Data Exfiltration
Select multiple files or folders within the interface and use the "Download as Zip" feature to compress and download them in a single request.

## Complete Command Reference

The tool itself is a web application contained in a `.jsp` file. There are no command-line flags for execution; instead, its functionality is accessed via the web interface.

### Files Included in Package
| Path | Description |
|------|-------------|
| `/usr/share/jsp-file-browser/Browser.jsp` | The main application file to be uploaded to the target. |
| `/usr/share/jsp-file-browser/example-css.css` | Optional CSS file for layout customization. |

### Features Available via Web Interface
| Feature | Description |
|---------|-------------|
| **File Management** | Create, copy, move, rename, and delete files and directories. |
| **File Viewing** | View pictures, movies, PDF, and HTML files directly in the browser. |
| **Text Editing** | Built-in editor for modifying text files on the server. |
| **Upload/Download** | Upload files to the server (with upload monitor) or download files to the local machine. |
| **Archiving** | Download groups of files/folders as a single ZIP; view/unpack ZIP, JAR, WAR, and GZ files on the server. |
| **Command Execution** | Execute native system commands (e.g., `ls`, `tar`, `chmod`). |
| **Filtering** | Javascript-based filename filtering for quick navigation. |
| **Access Control** | Supports blacklists/whitelists and read-only modes (configured within the JSP source). |

## Notes
- **Compatibility**: Requires a JSP 1.1 compatible server. Confirmed to work on Tomcat (3.0 through 5.5+), Resin 2.1.7, and Jetty.
- **Security**: This tool provides full file system access to the user context running the web server. It does not have built-in authentication by default; it is highly recommended to add password protection or restrict access if leaving it on a target for persistence.
- **Customization**: The layout can be customized by editing the `example-css.css` or modifying the CSS definitions within the `Browser.jsp` file.