---
description: Generate pentest report from engagement data
---
Generate a penetration testing report. Options: $ARGUMENTS

Pull all engagement data using `notes_read`:

- Engagement metadata and scope
- All findings with evidence
- All hosts and their notes
- All credentials discovered
- The full attack path narrative
- Executive summary (if previously updated)
- Command log for the methodology section

## Report Types

If `$ARGUMENTS` contains:
- **"executive"** — short, non-technical, business-impact focused (2-3 pages)
- **"technical"** — full detail with commands, output, and reproduction steps
- **"full"** or nothing specified — both executive and technical sections

## Report Structure

### 1. Executive Summary
Use the `executive_summary` from nyx-memory as the foundation. Expand with:
- Engagement overview: client, scope, dates, type of assessment
- Overall risk rating with brief justification
- Key findings (1-2 sentences each for critical/high only)
- Top 3 strategic recommendations

### 2. Scope & Methodology
- Authorized targets and boundaries
- Testing methodology and phases completed
- Tools used (from command log)
- Limitations, constraints, or scope changes during testing

### 3. Findings Detail
For each finding, ordered by severity (critical → info):
- **Title** and **ID** (from nyx-memory)
- **Severity**: Critical / High / Medium / Low / Info
- **CVSS Score** if assigned
- **Affected Systems**: hosts and services
- **Description**: what the vulnerability is
- **Evidence**: exact commands run, output received, screenshots — pull from `evidence_save` artifacts
- **Impact**: what an attacker could achieve by exploiting this
- **Remediation**: specific, actionable fix with priority

### 4. Attack Narrative
Use `attack_path` from nyx-memory as the foundation. Present as a chronological story:
- Initial access vector
- Each step of escalation and lateral movement
- What was achieved at each stage
- Include evidence references for each step

### 5. Compromised Credentials
Table of all credentials found via `credential_add`:
- Username, type, source, access level
- Recommendations for credential rotation

### 6. Host Summary
Per-host breakdown from host files:
- IP, hostname, OS, services
- Findings affecting this host
- Access level achieved

### 7. Recommendations
Prioritized remediation plan:
- **Immediate** (critical/high findings) — fix within 7 days
- **Short-term** (medium findings) — fix within 30 days
- **Long-term** (low/strategic) — plan for next quarter
- Quick wins vs. architectural changes

### 8. Appendices
- Full tool output references
- Methodology details
- Dead ends (approaches tried that didn't work — from `dead_end_log`)

Write the report as markdown to the engagement directory. Use `evidence_save` to store the final report file.
