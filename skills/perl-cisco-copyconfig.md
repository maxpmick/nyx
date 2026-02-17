---
name: perl-cisco-copyconfig
description: Manipulate Cisco device configurations via SNMP-directed TFTP. Use this tool to upload or download running-configs from Cisco IOS devices without SSH/Telnet access. Ideal for automated backups, bulk configuration changes, and vulnerability assessment of SNMP-enabled networking hardware during penetration testing.
---

# perl-cisco-copyconfig

## Overview
Cisco::CopyConfig is a Perl module and utility set that provides methods for manipulating the running-config of Cisco devices running IOS via SNMP-directed TFTP. It allows for remote configuration management without interactive login sessions. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume the tool is installed. If the module is missing, install via:

```bash
sudo apt install perl-cisco-copyconfig
```

Dependencies: `libnet-snmp-perl`, `libsnmp-perl`.

## Common Workflows

### Basic Configuration Download
To download a running configuration from a Cisco device to a TFTP server:
```perl
use Cisco::CopyConfig;

my $config = Cisco::CopyConfig->new(
    Host => '192.168.1.1',
    Comm => 'private'
);

if ($config->copy('192.168.1.100', 'running-config.txt')) {
    print "Config successfully copied to TFTP server\n";
} else {
    print "Error: " . $config->error() . "\n";
}
```

### Uploading a New Configuration
To push a configuration file from a TFTP server to the running-config of a device:
```perl
$config->copy('192.168.1.100', 'new-config.txt', 'running-config');
```

## Complete Command Reference

The tool is primarily used as a Perl object-oriented interface.

### Constructor: `new()`
Creates a new Cisco::CopyConfig object.

| Argument | Description |
|----------|-------------|
| `Host` | The IP address or hostname of the Cisco device. |
| `Comm` | The SNMP Read/Write community string (default: `private`). |
| `Retry` | Number of retries for SNMP packets (default: 5). |
| `Timer` | Timeout for SNMP packets in microseconds (default: 2,000,000 / 2 seconds). |

### Method: `copy()`
Triggers the SNMP-directed TFTP copy process.

```perl
$config->copy($tftp_ip, $filename, [$target]);
```

| Parameter | Description |
|-----------|-------------|
| `$tftp_ip` | The IP address of the TFTP server where the file will be sent to or pulled from. |
| `$filename` | The name of the file on the TFTP server. |
| `$target` | (Optional) The target of the copy. Defaults to `running-config`. If specified, the tool performs a TFTP -> Device upload. |

### Method: `error()`
Returns a string containing the last error message if a method fails.

## Notes
- **SNMP Requirements**: This tool requires **Read/Write (RW)** SNMP community strings to function. Read-only (RO) strings will not work.
- **TFTP Server**: You must have a TFTP server (like `atftpd` or `tftpd-hpa`) running and reachable by the Cisco device.
- **Security**: SNMP v1/v2c community strings are sent in plaintext. Ensure you are authorized to perform these actions as they can completely overwrite device configurations.
- **IOS Support**: Designed specifically for Cisco IOS; may not work on Nexus (NX-OS) or other operating systems without modification.