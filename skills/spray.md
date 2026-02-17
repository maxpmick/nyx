---
name: spray
description: Password spraying tool for Active Directory credentials, OWA, Lync, and Cisco Web VPNs. It automates the process of testing a single password against many accounts over a specified period to avoid account lockouts based on the target's password policy. Use during internal penetration testing or external reconnaissance when attempting to gain initial access via credential stuffing or password spraying.
---

# spray

## Overview
Spray is a password spraying tool designed to test Active Directory credentials across various services (SMB, OWA, Lync, Cisco VPN) while strictly adhering to account lockout policies. It includes utilities for generating username lists and updating password lists with current years or company names. Category: Password Attacks / Exploitation.

## Installation (if not already installed)
Assume spray is already installed. If the command is missing:

```bash
sudo apt install spray
```
Dependencies: `curl`, `smbclient`.

## Common Workflows

### SMB Password Spraying
Spray an internal domain controller while respecting a policy of 1 attempt every 35 minutes to avoid lockout.
```bash
spray -smb 192.168.1.10 users.txt passwords.txt 1 35 INTERNAL
```

### OWA (Outlook Web Access) Spraying
Requires a template file of the HTTP POST request where the username is replaced with `sprayuser@domain.com` and the password with `spraypassword`.
```bash
spray -owa 192.168.1.20 usernames.txt passwords.txt 1 45 post-request.txt
```

### Generating a Username List
Create a list of potential usernames using first and last name lists with a specific format (e.g., first initial + last name).
```bash
spray -genusers firstnames.txt lastnames.txt "<fi><ln>"
```

### Updating Password Lists
Update a provided password list to include the current year and an optional company name.
```bash
spray -passupdate passwords.txt MyCompany
```

## Complete Command Reference

### SMB Spraying
Used for spraying Active Directory credentials over SMB.
```bash
spray -smb <targetIP> <usernameList> <passwordList> <AttemptsPerLockoutPeriod> <LockoutPeriodInMinutes> <Domain>
```

### OWA Spraying
Used for spraying Outlook Web Access portals.
```bash
spray -owa <targetIP> <usernameList> <passwordList> <AttemptsPerLockoutPeriod> <LockoutPeriodInMinutes> <RequestFile>
```
*Note: The `RequestFile` must contain the POST request with `sprayuser@domain.com` and `spraypassword` as placeholders.*

### Lync / Skype for Business Spraying
Used for spraying Lync services via Autodiscover URLs or URLs returning `www-authenticate` headers.
```bash
spray -lync <lyncDiscoverOrAutodiscoverUrl> <emailAddressList> <passwordList> <AttemptsPerLockoutPeriod> <LockoutPeriodInMinutes>
```

### Cisco Web VPN Spraying
Used for spraying Cisco Web VPN portals.
```bash
spray -cisco <targetURL> <usernameList> <passwordList> <AttemptsPerLockoutPeriod> <LockoutPeriodInMinutes>
```

### Password List Management
Update existing password lists with current temporal data or organization-specific strings.
```bash
spray -passupdate <passwordList> [CompanyName]
```

### Username Generation
Generate a list of usernames based on common naming conventions.
```bash
spray -genusers <firstnames> <lastnames> "<format>"
```
**Format Placeholders:**
- `<fi>`: First initial
- `<li>`: Last initial
- `<fn>`: Full first name
- `<ln>`: Full last name

## Notes
- **Lockout Safety**: Always verify the target's actual Account Lockout Policy (Lockout threshold and Reset account lockout counter after) before starting to prevent mass account lockouts.
- **Language Support**: The package includes hand-crafted password files for multiple languages in `/usr/share/spray/` (or the installation directory) that meet common complexity requirements (1 Upper, 1 Lower, 1 Digit).
- **Lync Discovery**: For `-lync`, you can often use the `lyncdiscover.domain.com` endpoint or the specific OAuth provider endpoint.