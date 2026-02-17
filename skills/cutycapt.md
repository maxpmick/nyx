---
name: cutycapt
description: Capture WebKit's rendering of a web page into various vector and bitmap formats. Use when performing web application reconnaissance, documenting visual evidence of vulnerabilities, creating website screenshots for reporting, or capturing the state of a page during information gathering.
---

# cutycapt

## Overview
CutyCapt is a small cross-platform command-line utility that captures a web page's rendering using the WebKit engine. It supports multiple output formats including PNG, JPEG, PDF, SVG, TIFF, GIF, and BMP. Category: Reconnaissance / Information Gathering, Web Application Testing, Vulnerability Analysis.

## Installation (if not already installed)
Assume cutycapt is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install cutycapt
```

Note: On headless servers, you may need to run this under `xvfb-run` to provide a virtual X server.

## Common Workflows

### Basic Screenshot
Capture a website and save it as a PNG image:
```bash
cutycapt --url=http://www.kali.org --out=kali.png
```

### High-Resolution Capture
Capture a page with a specific minimum resolution and a delay to ensure all elements load:
```bash
cutycapt --url=https://example.com --out=example.png --min-width=1920 --min-height=1080 --delay=2000
```

### Export to PDF
Save the rendered page as a PDF document including backgrounds:
```bash
cutycapt --url=https://example.com --out=report.pdf --print-backgrounds=on
```

### Using a Proxy and Custom User-Agent
Capture a page through an HTTP proxy while mimicking a specific browser:
```bash
cutycapt --url=http://internal-site.local --out=internal.png --http-proxy=http://127.0.0.1:8080 --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
```

## Complete Command Reference

```
cutycapt [options] --url=<url> --out=<path>
```

### Required Options

| Flag | Description |
|------|-------------|
| `--url=<url>` | The URL to capture (e.g., http://..., file:///...) |
| `--out=<path>` | The target file path (extension determines format: .png, .pdf, .ps, .svg, .jpeg, etc.) |

### Rendering Options

| Flag | Description |
|------|-------------|
| `--out-format=<f>` | Overrides the heuristic extension check in `--out` |
| `--min-width=<int>` | Minimal width for the image (default: 800) |
| `--min-height=<int>` | Minimal height for the image (default: 600) |
| `--max-wait=<ms>` | Don't wait more than this time (default: 90000, infinite: 0) |
| `--delay=<ms>` | Wait this many milliseconds after successful load before capturing (default: 0) |
| `--zoom-factor=<float>` | Page zoom factor (e.g., 1.5 for 150%) |
| `--zoom-text-only=<on\|off>` | Whether to zoom only the text (default: off) |
| `--print-backgrounds=<on\|off>` | Include backgrounds in PDF/PS output (default: off) |

### Request Options

| Flag | Description |
|------|-------------|
| `--method=<get\|post\|put>` | Specifies the request method (default: get) |
| `--header=<name>:<value>` | Add a custom request header (repeatable) |
| `--body-string=<string>` | Unencoded request body (default: none) |
| `--body-base64=<base64>` | Base64-encoded request body (default: none) |
| `--user-agent=<string>` | Override the User-Agent header |
| `--app-name=<name>` | Application name used in User-Agent |
| `--app-version=<v>` | Application version used in User-Agent |
| `--http-proxy=<url>` | Address for HTTP proxy server (default: none) |

### Web Feature Options

| Flag | Description |
|------|-------------|
| `--javascript=<on\|off>` | Enable/disable JavaScript execution (default: on) |
| `--java=<on\|off>` | Enable/disable Java execution (default: unknown) |
| `--plugins=<on\|off>` | Enable/disable Plugin execution (default: unknown) |
| `--private-browsing=<on\|off>` | Enable/disable Private browsing (default: unknown) |
| `--auto-load-images=<on\|off>` | Automatic image loading (default: on) |
| `--js-can-open-windows=<on\|off>` | Allow scripts to open windows (default: unknown) |
| `--js-can-access-clipboard=<on\|off>` | Script clipboard privileges (default: unknown) |

### Styling Options

| Flag | Description |
|------|-------------|
| `--user-style-path=<path>` | Location of user style sheet file |
| `--user-style-string=<css>` | User style rules specified as raw CSS text |

### General Options

| Flag | Description |
|------|-------------|
| `--help` | Show summary of options |

## Notes
- **Headless Environments**: If running on a CLI-only system without a display, use `xvfb-run cutycapt --url=... --out=...`.
- **Format Support**: The output format is automatically detected from the file extension of the `--out` parameter unless `--out-format` is specified.
- **Timeouts**: For heavy pages with lots of external resources, increasing `--max-wait` and `--delay` is recommended to ensure the page is fully rendered.