---
description: Privilege escalation methodology
---
Perform privilege escalation. Context: $ARGUMENTS

Current access and credentials:
!`nyx-memory notes_read credentials 2>/dev/null || echo "No credentials documented"`

Determine the target OS and apply the appropriate methodology. Wrap all commands with `nyx-log` for logging.

## Linux Privilege Escalation

1. **Situational awareness**:
   ```
   id && uname -a && cat /etc/os-release
   ip addr && ip route && ss -tlnp
   ```

2. **Automated enumeration** (pick one):
   ```
   nyx-log ./linpeas.sh -a 2>&1 | tee linpeas.txt
   nyx-log ./linux-exploit-suggester.sh | tee les.txt
   ```

3. **Systematic manual checks** — work through each vector:
   - **Sudo**: `sudo -l` — check GTFOBins for any allowed binaries
   - **SUID/SGID**: `find / -perm -4000 -type f 2>/dev/null` — cross-ref GTFOBins
   - **Capabilities**: `getcap -r / 2>/dev/null`
   - **Cron jobs**: `/etc/crontab`, `/etc/cron.d/`, `/var/spool/cron/` — writable scripts?
   - **Writable paths**: sensitive locations, PATH directories, library paths
   - **Kernel exploits**: match `uname -r` against known exploits
   - **Internal services**: services running as root on localhost
   - **Credentials in files**: `.bash_history`, config files, `.env`, `/etc/shadow` readable?
   - **Container escape**: docker/lxc group membership, mounted sockets
   - **NFS**: `showmount -e` — no_root_squash shares
   - **PATH hijacking**: writable directories in cron/service PATH

## Windows Privilege Escalation

1. **Situational awareness**:
   ```
   whoami /all && systeminfo && ipconfig /all && netstat -ano
   ```

2. **Automated enumeration**:
   ```
   nyx-log ./winPEASx64.exe | tee winpeas.txt
   nyx-log powershell -ep bypass -c "Import-Module .\PowerUp.ps1; Invoke-AllChecks"
   ```

3. **Systematic manual checks**:
   - **Token privileges**: SeImpersonate → Potato attacks, SeAssignPrimaryToken
   - **Services**: unquoted paths, writable binaries, weak permissions
   - **Scheduled tasks**: writable executables or scripts
   - **Registry**: AlwaysInstallElevated, AutoRuns with weak perms
   - **Stored creds**: `cmdkey /list`, Credential Manager, SAM/SYSTEM backup files
   - **Unpatched CVEs**: compare `systeminfo` against exploit suggester
   - **DLL hijacking**: missing DLLs in writable PATH locations
   - **Group memberships**: Backup Operators, DNS Admins, etc.

## Documentation

- `finding_add` for each escalation vector discovered (even if not exploited)
- `credential_add` for any new credentials obtained during escalation
- `host_update` in the post-exploitation section with the escalation path taken
- `evidence_save` for enumeration output (linpeas, winpeas, etc.)
- `attack_path_update` to record the escalation step in the narrative
- `dead_end_log` for escalation paths that were investigated but didn't work
- `todo_complete` the privesc task when finished
