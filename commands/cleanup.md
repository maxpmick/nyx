---
description: Post-engagement cleanup checklist
---
Run the post-engagement cleanup procedure.

Engagement data:
!`nyx-memory notes_read hosts 2>/dev/null || echo "No hosts documented"`

Findings (especially persistence):
!`nyx-memory notes_read findings 2>/dev/null || echo "No findings"`

Attack path:
!`nyx-memory notes_read attack_path 2>/dev/null || echo "No attack path"`

## Build Cleanup Checklist

Review the full engagement history — every host accessed, every finding, every step in the attack path — and build a comprehensive cleanup checklist.

### For Each Compromised Host

1. **Persistence mechanisms** — cross-reference findings tagged as persistence:
   - SSH keys added → remove from `authorized_keys`
   - Cron jobs → `crontab -e` or remove from `/etc/cron.d/`
   - Systemd services → `systemctl disable && rm` unit file
   - Scheduled tasks → `schtasks /delete`
   - Registry run keys → delete entries
   - WMI subscriptions → remove
   - Web shells → delete files
   - Any other backdoors documented in findings

2. **Tools and payloads uploaded** — remove all:
   - Enumeration scripts (linpeas, winpeas, etc.)
   - Exploit binaries and payloads
   - Tunneling tools (chisel, ligolo agents)
   - Any custom scripts transferred

3. **Accounts created** — remove or disable:
   - Local user accounts
   - Service accounts
   - Any modified group memberships

4. **Configuration changes** — revert all:
   - Firewall rule modifications
   - Service configuration changes
   - Registry modifications (beyond persistence)
   - Network configuration changes

5. **Files and artifacts** — remove all:
   - Output files from scans/tools on target
   - Temporary files and directories
   - Log entries if possible and authorized
   - Loot/exfiltrated data copies on target

6. **Network** — tear down all:
   - Port forwards and tunnels
   - Proxy configurations
   - VPN connections to target network

### Verify Cleanup

- For each host, confirm services are running normally
- Verify no artifacts remain: check common locations
- Test that persistence mechanisms are actually removed (try to use them)
- Confirm any accounts created are disabled/removed

### Document

- Record what was cleaned up per host using `host_update`
- Note anything that could NOT be reverted and why
- Record client decisions (e.g., "client requested web shell be left for their team to analyze")
- `executive_summary_update` noting engagement completion and cleanup status
- `engagement_close` when everything is confirmed clean

Present the checklist with clear status markers: DONE / PENDING / COULD NOT REVERT / CLIENT DECISION. Walk through each item with me before marking the engagement as closed.
