---
name: requests
description: Send HTTP/1.1 requests using an elegant and simple Python library. Use when automating web interactions, performing web application testing, scraping data, interacting with REST APIs, or developing exploitation scripts that require custom headers, cookie persistence, or multipart file uploads.
---

# requests

## Overview
Requests is a powerful, human-friendly HTTP library for Python. It simplifies sending HTTP/1.1 requests by handling connection pooling, keep-alive, SSL verification, and cookie persistence automatically. Category: Web Application Testing / Exploitation / Information Gathering.

## Installation (if not already installed)

Assume requests is already installed as it is a core Kali component. If missing:

```bash
sudo apt update && sudo apt install python3-requests
```

## Common Workflows

### Basic GET Request with Parameters
```python
import requests

params = {'id': '1', 'type': 'admin'}
r = requests.get('https://httpbin.org/get', params=params)
print(r.status_code)
print(r.json())
```

### POST Request with Form Data and Custom Headers
```python
import requests

url = 'https://httpbin.org/post'
headers = {'User-Agent': 'Mozilla/5.0 (Kali)'}
data = {'username': 'admin', 'password': 'password123'}

r = requests.post(url, data=data, headers=headers)
print(r.text)
```

### Session Object for Cookie Persistence
Useful for maintaining a logged-in state across multiple requests.
```python
import requests

s = requests.Session()
s.post('https://example.com/login', data={'user': 'admin', 'pass': 'secret'})
# Cookies are now stored in the session 's'
r = s.get('https://example.com/dashboard')
print(r.text)
```

### Handling JSON Responses and Timeouts
```python
import requests

try:
    r = requests.get('https://api.github.com/events', timeout=5)
    r.raise_for_status() # Raises exception for 4xx or 5xx errors
    data = r.json()
except requests.exceptions.RequestException as e:
    print(f"Error: {e}")
```

## Complete Library Reference

### Main Methods
| Method | Description |
|--------|-------------|
| `requests.get(url, **kwargs)` | Sends a GET request |
| `requests.post(url, data=None, json=None, **kwargs)` | Sends a POST request |
| `requests.put(url, data=None, **kwargs)` | Sends a PUT request |
| `requests.patch(url, data=None, **kwargs)` | Sends a PATCH request |
| `requests.delete(url, **kwargs)` | Sends a DELETE request |
| `requests.head(url, **kwargs)` | Sends a HEAD request |
| `requests.options(url, **kwargs)` | Sends an OPTIONS request |
| `requests.request(method, url, **kwargs)` | Constructs and sends a Request |

### Common Keyword Arguments (`**kwargs`)
| Argument | Type | Description |
|----------|------|-------------|
| `params` | Dict/Bytes | Dictionary or bytes to be sent in the query string |
| `data` | Dict/List/Bytes | Dictionary, list of tuples, or bytes to send in the body |
| `json` | Dict | A JSON serializable Python object to send in the body |
| `headers` | Dict | Dictionary of HTTP Headers to send |
| `cookies` | Dict/CookieJar | Dict or CookieJar object to send |
| `files` | Dict | Dictionary of `'name': file-like-objects` for multipart encoding |
| `auth` | Tuple | Auth tuple to enable Basic/Digest/Custom HTTP Auth |
| `timeout` | Float/Tuple | How many seconds to wait for the server to send data |
| `allow_redirects` | Bool | Boolean. Enable/disable GET/OPTIONS/POST/PUT/PATCH/DELETE/HEAD redirection |
| `proxies` | Dict | Dictionary mapping protocol to the URL of the proxy |
| `verify` | Bool/String | Either a boolean (SSL verify) or a string (path to CA bundle) |
| `stream` | Bool | If False, the response content will be immediately downloaded |
| `cert` | String/Tuple | SSL certificate file (.pem) or ('cert', 'key') pair |

### Response Object Attributes
| Attribute | Description |
|-----------|-------------|
| `r.status_code` | Integer code of responded HTTP Status (e.g., 200, 404) |
| `r.text` | Content of the response in unicode |
| `r.content` | Content of the response in bytes |
| `r.json()` | Returns the json-encoded content of a response |
| `r.headers` | Case-insensitive dictionary of response headers |
| `r.cookies` | A CookieJar of Cookies the server sent back |
| `r.url` | The final URL of the response (useful for tracking redirects) |
| `r.history` | A list of Response objects from the history of the request (redirects) |
| `r.raise_for_status()` | Raises `HTTPError` if the status code was not 200 |

## Notes
- **SSL Verification**: By default, `requests` verifies SSL certificates. Set `verify=False` to ignore SSL errors (common in internal lab environments), but be aware this triggers a `InsecureRequestWarning`.
- **Performance**: Use `requests.Session()` for multiple requests to the same host to benefit from connection pooling (keep-alive).
- **Timeouts**: Always specify a `timeout` in production scripts to prevent the hang of the execution if the server is unresponsive.