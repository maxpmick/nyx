---
description: Review current engagement findings
---
Review all findings in the current engagement. Filter: $ARGUMENTS

Current findings:
!`nyx-memory notes_read findings 2>/dev/null || echo "No findings recorded yet."`

Present findings organized by severity:

1. **Critical** — Immediate risk, trivially exploitable, high business impact
2. **High** — Significant risk, exploitable with moderate effort
3. **Medium** — Notable risk, exploitable under specific conditions
4. **Low** — Minor risk or hardening recommendations
5. **Informational** — Observations, no direct risk

For each finding show:
- ID, title, and severity
- Affected host(s) and service(s)
- Status: identified / confirmed / exploited
- CVSS score if assigned
- Linked evidence
- Remediation recommendation (one line)

Then provide:
- Total count by severity
- Attack chains — findings that can be combined for greater impact
- Recommended next steps: what to exploit, investigate, or scan further
- Any findings that should be escalated to `finding_update` with revised severity

If `$ARGUMENTS` contains a filter (severity level, hostname, keyword, or finding ID), narrow the results accordingly.

Use `notes_read` with search queries if I ask about specific findings or want to cross-reference across hosts.
