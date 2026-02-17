---
description: Establish persistence on a target
---
Establish persistence. Context: $ARGUMENTS

**IMPORTANT**: Only establish persistence if explicitly authorized in the rules of engagement. Confirm with me before deploying any persistence mechanism.

Current access:
!`nyx-memory notes_read hosts 2>/dev/null || echo "No hosts documented"`

## Linux Persistence (in order of preference)

1. **SSH authorized keys** — least intrusive, easily reversible
   ```
   echo "$PUB_KEY" >> ~/.ssh/authorized_keys
   ```
2. **Cron job** — reverse shell or beacon callback
3. **Systemd service** — custom service unit
4. **Bashrc/profile modification** — triggered on login
5. **LD_PRELOAD / shared library** — stealthy but high-risk, confirm first

## Windows Persistence (in order of preference)

1. **Scheduled task** — most common, well-documented for cleanup
   ```
   schtasks /create /tn "TaskName" /tr "$PAYLOAD" /sc onlogon /ru SYSTEM
   ```
2. **Registry run keys** — HKCU or HKLM Run/RunOnce
3. **Service creation** — `sc create` with custom binary
4. **WMI event subscription** — stealthier, harder to detect
5. **Startup folder** — simple, user-level
6. **DLL side-loading** — stealthy but complex, confirm first

## Web Application Persistence

- Web shell in writable web directory
- Modified application file (e.g., added backdoor route)
- Database-stored payload

## For Each Mechanism Deployed

1. Get explicit authorization from me before deploying
2. Implement the mechanism, wrapping commands with `nyx-log`
3. Test that it survives reboot/logoff/session loss
4. Document everything — this is critical for cleanup:
   - `finding_add` with exact details: file paths, registry keys, service names, cron entries, scheduled task names
   - `host_update` in the post-exploitation section noting what persistence was placed
   - `evidence_save` for proof that persistence works
   - `attack_path_update` to record persistence in the narrative

**Always record removal instructions** in the finding. The cleanup phase depends entirely on accurate persistence documentation.
