---
description: Engagement status overview
---
Show the current engagement status overview.

Engagement:
!`nyx-memory status 2>/dev/null || echo "No active engagement — run /engage first"`

Hosts:
!`nyx-memory notes_read hosts 2>/dev/null || echo "None discovered yet"`

Credentials:
!`nyx-memory notes_read credentials 2>/dev/null || echo "None captured yet"`

Findings:
!`nyx-memory notes_read findings 2>/dev/null || echo "None recorded yet"`

Attack path:
!`nyx-memory notes_read attack_path 2>/dev/null || echo "Not started"`

Outstanding TODOs:
!`nyx-memory notes_read todos 2>/dev/null || echo "None"`

Dead ends:
!`nyx-memory notes_read dead_ends 2>/dev/null || echo "None logged"`

Present a concise status dashboard:

## Engagement
- Name, type, scope, start date, current status

## Hosts (count)
Table: IP | Hostname | OS | Services | Access Level

## Credentials (count)
Table: Username | Type (password/hash/token/key) | Source | Verified | Valid On

## Findings (count)
Breakdown by severity: Critical / High / Medium / Low / Info
List the top 3 most significant findings by title

## Attack Progress
- Steps completed in the attack path narrative
- Current position (which hosts compromised, what access level)
- Outstanding TODOs — next actions

## Dead Ends
- Brief list of approaches tried that didn't work (so we don't repeat them)

## Recommended Next Steps
Based on current state, suggest the 2-3 most productive next actions.
