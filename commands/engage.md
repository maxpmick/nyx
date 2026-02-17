---
description: Start or resume a pentest engagement
---
Initialize or resume a penetration testing engagement.

Input: $ARGUMENTS

## If Starting New

Use `engagement_create` with:
- A descriptive engagement name
- Scope and target information

Then confirm the following with me:
1. **Scope** — targets, networks, domains that are in-scope and explicitly out-of-scope
2. **Type** — external, internal, web app, wireless, social engineering, red team
3. **Rules of engagement** — testing windows, restricted hosts, emergency contacts, limitations
4. **Objectives** — what does success look like

After confirmation, use `todo_add` to create initial task list based on the engagement type:
- Passive reconnaissance
- Active reconnaissance
- Vulnerability scanning
- Exploitation (if authorized)
- Post-exploitation / privilege escalation
- Lateral movement (if applicable)
- Reporting

Use `executive_summary_update` to record the initial engagement parameters.

## If Resuming

Use `engagement_list` to show available engagements, then `engagement_resume` to switch to the chosen one. Use `engagement_status` and `notes_read` to review where we left off. Summarize current progress and outstanding TODOs.

## If No Details Provided

Ask me for:
- Engagement name
- Target(s) and scope boundaries
- Type of assessment
- Any constraints or rules of engagement
