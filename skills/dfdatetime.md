---
name: dfdatetime
description: A Python library for digital forensics to handle date and time objects with high accuracy and precision. Use when developing forensics scripts, parsing timestamps from various artifacts (Windows FILETIME, POSIX, etc.), or normalizing time data during digital forensics and incident response (DFIR) investigations.
---

# dfdatetime

## Overview
dfDateTime (Digital Forensics date and time) is a Python library designed to provide specialized date and time objects that preserve the accuracy and precision required for forensic analysis. It handles various timestamp formats encountered in different operating systems and file formats. Category: Digital Forensics / Respond.

## Installation (if not already installed)

Assume the library is already installed as part of the `python3-dfdatetime` package. If it is missing:

```bash
sudo apt update
sudo apt install python3-dfdatetime
```

## Common Workflows

As `dfdatetime` is primarily a library, it is used within Python scripts to parse and convert timestamps.

### Parsing a Windows FILETIME
```python
from dfdatetime import filetime

# Example Windows FILETIME (64-bit value)
timestamp = 132539520000000000
dt_object = filetime.Filetime(timestamp=timestamp)

print(dt_object.CopyToDateTimeString())
```

### Parsing a POSIX Timestamp
```python
from dfdatetime import posix_time

# Example POSIX timestamp (seconds since epoch)
timestamp = 1609459200
dt_object = posix_time.PosixTime(timestamp=timestamp)

print(dt_object.CopyToDateTimeString())
```

### Converting to ISO 8601
```python
from dfdatetime import fat_date_time

# Example FAT date and time values
dt_object = fat_date_time.FATDateTime(fat_date_time=0x52214000)
print(dt_object.CopyToDateTimeStringISO8601())
```

## Complete Command Reference

This tool is a library and does not provide a standalone CLI binary. It is implemented as a collection of Python modules. Below are the supported timestamp classes available in the library:

### Supported Timestamp Classes

| Module / Class | Description |
|----------------|-------------|
| `apfs_time` | Apple File System (APFS) timestamps |
| `atp_time` | Apple Training Platform (ATP) timestamps |
| `cocoa_time` | Cocoa (Mac OS X) Core Data timestamps |
| `delphi_date_time` | Delphi TDateTime values |
| `fat_date_time` | FAT (File Allocation Table) date and time values |
| `filetime` | Windows FILETIME (64-bit) values |
| `fsevents_time` | FSEvents (macOS) timestamps |
| `golang_time` | Go (Golang) time values |
| `hfs_time` | HFS/HFS+ (macOS) timestamps |
| `java_time` | Java date and time values |
| `msdn_date_time` | MSDN date and time values |
| `ole_automation_date` | OLE Automation Date values |
| `posix_time` | POSIX (Unix) timestamps (seconds, milliseconds, microseconds, nanoseconds) |
| `precision_time` | High precision timestamps |
| `python_datetime` | Wrapper for Python's native datetime objects |
| `rfc822_date_time` | RFC 822 / RFC 1123 date and time strings |
| `rfc3339_date_time` | RFC 3339 date and time strings |
| `semantic_time` | Semantic time values (e.g., "Not a Time") |
| `systemtime` | Windows SYSTEMTIME structures |
| `uuid_time` | Timestamps extracted from UUIDs (version 1) |
| `webkit_time` | WebKit (Chrome/Safari) timestamps |

### Common Methods (Available across most classes)

| Method | Description |
|--------|-------------|
| `CopyToDateTimeString()` | Returns a human-readable date and time string. |
| `CopyToDateTimeStringISO8601()` | Returns an ISO 8601 formatted string. |
| `GetRelativeTime()` | Returns the relative time (delta). |

## Notes
- This library is a core dependency for `log2timeline` (plaso).
- It is specifically designed to handle "precision loss" issues that occur when using standard Python `datetime` objects for forensics.
- When writing scripts, ensure you handle `None` values or `InvalidTimestamp` exceptions if the input data is corrupted.