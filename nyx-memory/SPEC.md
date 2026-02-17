# nyx-memory — MCP Server Specification

## 1. Purpose

Nyx is an autonomous penetration testing agent. During engagements it must continuously document findings, track hosts, harvest credentials, log evidence, and maintain an attack narrative. The current approach embeds a manual notes system directly in the system prompt: the agent creates directories with `mkdir`, initializes markdown templates by hand, and edits tables in-place using shell commands. This is fragile — one malformed edit corrupts a table, there is no session isolation between engagements, and the agent spends context window on file management instead of security testing.

`nyx-memory` is an MCP (Model Context Protocol) server that replaces the manual notes system with structured tool calls. The agent calls `finding_add` instead of editing a markdown table. It calls `engagement_create` instead of running `mkdir -p` and initializing templates. The server manages all storage, formatting, timestamps, and session isolation internally. The output is still human-readable markdown — generated automatically from structured data.

### Design Goals

1. **Session isolation.** Each engagement is a self-contained unit with its own findings, hosts, credentials, evidence, and narrative. Engagements never bleed into each other.
2. **Structured operations.** The agent interacts through typed tool calls with validated inputs, not freeform file edits.
3. **Automatic markdown rendering.** Every mutation to structured data triggers a re-render of the relevant markdown files. The rendered output matches the existing FINDINGS.md and per-host templates.
4. **Reduced prompt footprint.** The ~130 lines of memory rules, templates, and file format documentation in the system prompt are replaced by ~15 lines telling the agent to use the memory tools.
5. **Cross-engagement search.** Past engagements are queryable — hosts, credentials, and findings can be searched across all history.
6. **Reliability.** Timestamps, finding IDs, deduplication, and cross-references are handled by code, not by LLM instruction-following.

---

## 2. Architecture Overview

`nyx-memory` exposes **two interfaces** from the same codebase and shared storage engine:

1. **MCP mode** (`nyx-memory serve`): stdio transport for OpenCode. The agent calls structured tools like `finding_add`, `host_discover`, etc. This is the primary interface during an engagement.
2. **CLI mode** (`nyx-memory <subcommand>`): direct shell commands for piping tool output, ingesting structured scan results, and scripting. Used by the `nyx-log` wrapper and available for ad-hoc use.

Both interfaces read and write the same `metadata.json` and rendered markdown files.

```
┌─────────────────────────────────────────────────────────────────┐
│                      Nyx Agent (OpenCode)                       │
│                                                                 │
│  MCP tool calls                    Shell commands               │
│  "finding_add(host=10.0.0.1)"     "nyx-log nmap -sV 10.0.0.1" │
└──────────┬─────────────────────────────────┬────────────────────┘
           │ MCP (stdio)                     │ subprocess
           ▼                                 ▼
┌────────────────────────┐    ┌──────────────────────────────────┐
│  nyx-memory serve      │    │  nyx-log (bash wrapper)          │
│  (MCP Server)          │    │  - runs command, tees output     │
│                        │    │  - captures timing + exit code   │
│  ┌──────────────────┐  │    │  - pipes to nyx-memory log       │
│  │  MCP Tool        │  │    │  - triggers nyx-memory ingest    │
│  │  Handlers        │  │    └──────────┬───────────────────────┘
│  └────────┬─────────┘  │               │ CLI
│           │             │               ▼
│           │             │    ┌──────────────────────────────────┐
│           │             │    │  nyx-memory log / ingest / ...   │
│           │             │    │  (CLI subcommands)               │
│           │             │    └──────────┬───────────────────────┘
│           │             │               │
│  ┌────────▼─────────────▼───────────────▼──┐
│  │          Storage Engine                  │
│  │          (shared, file-lock protected)   │
│  ├──────────────────┬───────────────────────┤
│  │  Markdown        │  Tool Output          │
│  │  Renderer        │  Parsers              │
│  │  (templates)     │  (nmap, masscan, ...) │
│  └──────────────────┴───────────────────────┘
└──────────────────────────┬──────────────────┘
                           │ filesystem
                           ▼
┌─────────────────────────────────────────────┐
│  ./engagements/                             │
│    state.json                               │
│    index.json                               │
│    2026-02-17-acme-corp/                    │
│      metadata.json                          │
│      FINDINGS.md                            │
│      hosts/10.0.0.1.md                      │
│      evidence/nmap-full-tcp-10.0.0.1.txt    │
│      evidence/nmap-20260217T104500.xml      │
└─────────────────────────────────────────────┘
```

### Technology

- **Language:** TypeScript (Node.js 20+)
- **MCP SDK:** `@modelcontextprotocol/sdk` (official TypeScript SDK)
- **Transport:** stdio (MCP mode, launched as a subprocess by OpenCode)
- **CLI framework:** `commander` (for the `nyx-memory` command and subcommands)
- **Storage:** JSON files on disk (no database dependency), lockfile-protected for CLI+MCP concurrency
- **Markdown rendering:** tagged template literals (zero-dependency, no template engine needed)
- **XML parsing:** `fast-xml-parser` (for nmap/masscan XML ingestion)
- **Tool output parsing:** pluggable parsers for nmap XML, masscan, gobuster, etc.
- **Shell wrapper:** `nyx-log` — lightweight bash script, installed to `$PATH`
- **Packaging:** npm package, installable via `npm install -g nyx-memory` or `npx`

---

## 3. Storage Layout

All data lives under a configurable root directory, defaulting to `./engagements/` relative to the OpenCode workspace (i.e., `/home/kali/pentest/engagements/` in the standard Nyx VM setup). This keeps engagement data inside the workspace where the agent can also read the rendered markdown files directly.

The `NYX_DATA_DIR` environment variable overrides the default. Both the MCP server and the CLI read the same variable to locate the data directory.

```
./engagements/                              # NYX_DATA_DIR (workspace-relative)
├── config.json                             # Global configuration
├── state.json                              # Server state (current engagement ID)
├── index.json                              # Global index of all engagements
├── 2026-02-17-acme-corp/
│   ├── metadata.json                       # Structured data (source of truth)
│   ├── FINDINGS.md                         # Auto-rendered from metadata.json
│   ├── hosts/
│   │   ├── 10.0.0.1.md                    # Auto-rendered per-host file
│   │   └── 10.0.0.2.md
│   └── evidence/
│       ├── nmap-full-tcp-10.0.0.1.txt
│       ├── nmap-20260217T104500.xml        # Structured output (parseable)
│       └── sqli-users-table-webapp.txt
└── 2026-02-10-initech/
    ├── metadata.json
    ├── FINDINGS.md
    ├── hosts/
    └── evidence/
```

### 3.1 `config.json`

Global server configuration.

```json
{
  "data_dir": "./engagements",
  "auto_timestamp": true,
  "finding_id_prefix": "F",
  "todo_id_prefix": "T"
}
```

### 3.2 `state.json`

Tracks which engagement is currently active. This persists across server restarts so the agent can resume without explicitly calling `engagement_resume`.

```json
{
  "current_engagement_id": "2026-02-17-acme-corp"
}
```

### 3.3 `index.json`

Global index of all engagements for fast listing without reading every `metadata.json`.

```json
{
  "engagements": [
    {
      "id": "2026-02-17-acme-corp",
      "target": "Acme Corp (10.0.0.0/24, acme.com)",
      "status": "active",
      "created_at": "2026-02-17T10:00:00Z",
      "updated_at": "2026-02-17T14:30:00Z",
      "finding_count": 7,
      "host_count": 4,
      "credential_count": 2,
      "command_count": 3
    }
  ]
}
```

### 3.4 `metadata.json`

The single source of truth for an engagement. Every tool call that mutates data writes to this file, then triggers a markdown re-render. The full schema follows.

```json
{
  "id": "2026-02-17-acme-corp",
  "target": "Acme Corp",
  "scope": [
    "10.0.0.0/24",
    "acme.com",
    "*.acme.com"
  ],
  "rules_of_engagement": "Authorized by John Smith, CTO. Testing window: 2026-02-17 to 2026-02-21. No DoS. Production database is off-limits.",
  "status": "active",
  "created_at": "2026-02-17T10:00:00Z",
  "updated_at": "2026-02-17T14:30:00Z",
  "executive_summary": "Initial reconnaissance complete. Identified 4 live hosts...",

  "attack_path": [
    {
      "step": 1,
      "timestamp": "2026-02-17T10:15:00Z",
      "description": "Passive recon identified 3 subdomains via certificate transparency logs."
    },
    {
      "step": 2,
      "timestamp": "2026-02-17T10:45:00Z",
      "description": "Full TCP scan of 10.0.0.0/24 revealed 4 live hosts with web services on 80/443."
    }
  ],

  "findings": [
    {
      "id": "F-001",
      "host": "10.0.0.1",
      "vulnerability": "SQL injection in login form (POST /api/auth, parameter: username)",
      "severity": "critical",
      "cvss": 9.8,
      "status": "exploited",
      "evidence_file": "sqli-users-table-webapp.txt",
      "notes": "Error-based SQLi. Extracted full users table.",
      "created_at": "2026-02-17T11:30:00Z",
      "updated_at": "2026-02-17T12:00:00Z"
    }
  ],

  "hosts": [
    {
      "ip": "10.0.0.1",
      "hostname": "web01.acme.com",
      "os": "Ubuntu 22.04",
      "first_seen": "2026-02-17T10:45:00Z",
      "updated_at": "2026-02-17T12:00:00Z",
      "services": [
        {
          "port": 22,
          "proto": "tcp",
          "service": "ssh",
          "version": "OpenSSH 8.9p1",
          "notes": ""
        },
        {
          "port": 80,
          "proto": "tcp",
          "service": "http",
          "version": "nginx 1.18.0",
          "notes": "Redirects to HTTPS"
        },
        {
          "port": 443,
          "proto": "tcp",
          "service": "https",
          "version": "nginx 1.18.0",
          "notes": "Hosts main web application"
        }
      ],
      "enumeration": "Directory brute-force revealed /admin (403), /api (200), /backup (404 but slow response)...",
      "vulnerabilities": "SQLi in /api/auth confirmed (F-001). XSS in search parameter under investigation.",
      "exploitation": "Exploited F-001 to extract users table. See evidence/sqli-users-table-webapp.txt.",
      "post_exploitation": "",
      "credentials": "admin:$2b$12$LJ3... (bcrypt hash from users table)",
      "key_commands": "sqlmap -u 'https://10.0.0.1/api/auth' --data='username=test&password=test' -p username --dump"
    }
  ],

  "credentials": [
    {
      "id": "C-001",
      "source": "10.0.0.1 (users table via SQLi F-001)",
      "username": "admin",
      "password_or_hash": "$2b$12$LJ3m8fKhR...",
      "cred_type": "hash",
      "access_level": "application admin",
      "verified": false,
      "created_at": "2026-02-17T12:00:00Z"
    }
  ],

  "dead_ends": [
    {
      "timestamp": "2026-02-17T11:00:00Z",
      "technique": "Anonymous FTP login",
      "target": "10.0.0.3:21",
      "reason": "FTP requires authentication. Tried anonymous/anonymous, ftp/ftp — all rejected."
    }
  ],

  "todos": [
    {
      "id": "T-001",
      "description": "Crack admin bcrypt hash from web01",
      "priority": "high",
      "status": "pending",
      "created_at": "2026-02-17T12:00:00Z",
      "completed_at": null
    }
  ],

  "evidence_index": [
    {
      "filename": "nmap-full-tcp-10.0.0.1.txt",
      "description": "Full TCP port scan of 10.0.0.1",
      "related_finding_id": null,
      "created_at": "2026-02-17T10:50:00Z"
    },
    {
      "filename": "sqli-users-table-webapp.txt",
      "description": "SQLi output — full users table dump from web01",
      "related_finding_id": "F-001",
      "created_at": "2026-02-17T12:00:00Z"
    }
  ],

  "command_log": [
    {
      "id": "CMD-001",
      "command": "nmap -sV -p- -oX /tmp/nmap-10.0.0.1.xml 10.0.0.1",
      "tool": "nmap",
      "target": "10.0.0.1",
      "started_at": "2026-02-17T10:45:00Z",
      "finished_at": "2026-02-17T10:52:30Z",
      "duration_seconds": 450,
      "exit_code": 0,
      "evidence_file": "nmap-20260217T104500-sV-p-10.0.0.1.txt",
      "parsed": true,
      "source": "nyx-log"
    },
    {
      "id": "CMD-002",
      "command": "gobuster dir -u https://10.0.0.1 -w /usr/share/seclists/Discovery/Web-Content/common.txt",
      "tool": "gobuster",
      "target": "10.0.0.1",
      "started_at": "2026-02-17T11:00:00Z",
      "finished_at": "2026-02-17T11:05:12Z",
      "duration_seconds": 312,
      "exit_code": 0,
      "evidence_file": "gobuster-20260217T110000-dir-10.0.0.1.txt",
      "parsed": false,
      "source": "nyx-log"
    },
    {
      "id": "CMD-003",
      "command": "sqlmap -u 'https://10.0.0.1/api/auth' --data='username=test&password=test' -p username --dump",
      "tool": "sqlmap",
      "target": "10.0.0.1",
      "started_at": "2026-02-17T11:25:00Z",
      "finished_at": "2026-02-17T11:28:45Z",
      "duration_seconds": 225,
      "exit_code": 0,
      "evidence_file": null,
      "parsed": false,
      "source": "agent"
    }
  ]
}
```

---

## 4. MCP Tools

All tools return JSON objects. Every mutating tool (everything except `engagement_list`, `engagement_status`, and `notes_read`) writes to `metadata.json` and triggers a re-render of affected markdown files.

Timestamps are always UTC in ISO 8601 format (`YYYY-MM-DDTHH:MM:SSZ`). They are generated automatically by the server — the agent never provides them.

Finding IDs are auto-incremented per engagement: `F-001`, `F-002`, etc.
Credential IDs are auto-incremented per engagement: `C-001`, `C-002`, etc.
TODO IDs are auto-incremented per engagement: `T-001`, `T-002`, etc.
Command IDs are auto-incremented per engagement: `CMD-001`, `CMD-002`, etc.

### 4.1 Engagement Management

#### `engagement_create`

Start a new penetration testing engagement. Creates the directory structure, initializes `metadata.json`, and renders the initial `FINDINGS.md`. Automatically sets this as the current active engagement.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `target` | string | yes | Name or description of the target organization/system |
| `scope` | string[] | yes | List of in-scope targets (IP ranges, domains, URLs) |
| `rules_of_engagement` | string | no | Authorization details, constraints, testing windows, exclusions |
| `name` | string | no | Custom slug for the engagement directory. Auto-generated from date + target if omitted |

**Output:**

```json
{
  "engagement_id": "2026-02-17-acme-corp",
  "path": "./engagements/2026-02-17-acme-corp",
  "status": "created",
  "message": "Engagement initialized. FINDINGS.md created. You are now working on this engagement."
}
```

**Behavior:**
1. Generate engagement ID: `YYYY-MM-DD-<slug>` where slug is derived from `name` or sanitized from `target` (lowercase, hyphens, max 48 chars).
2. Create directory: `<data_dir>/<id>/`, `hosts/`, `evidence/`.
3. Initialize `metadata.json` with provided fields, empty arrays for all collections (including empty `command_log`), timestamps set to now.
4. Render initial `FINDINGS.md`.
5. Update `index.json` with the new engagement.
6. Update `state.json` to set this as the current engagement.

**Errors:**
- Engagement with the same ID already exists: return error suggesting `engagement_resume` or a different `name`.

---

#### `engagement_list`

List all engagements with summary information.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `status` | string | no | Filter by status: `"active"`, `"completed"`, `"paused"`. Omit for all. |

**Output:**

```json
{
  "engagements": [
    {
      "id": "2026-02-17-acme-corp",
      "target": "Acme Corp",
      "status": "active",
      "created_at": "2026-02-17T10:00:00Z",
      "updated_at": "2026-02-17T14:30:00Z",
      "finding_count": 7,
      "host_count": 4,
      "credential_count": 2,
      "is_current": true
    }
  ],
  "total": 1
}
```

**Behavior:**
1. Read `index.json`.
2. Filter by status if provided.
3. Mark whichever engagement matches `state.json` current ID with `is_current: true`.

---

#### `engagement_resume`

Set an existing engagement as the current active engagement and return its status summary. Use this to switch between engagements or to resume work after a new conversation.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `engagement_id` | string | yes | ID of the engagement to resume |

**Output:**

```json
{
  "engagement_id": "2026-02-17-acme-corp",
  "target": "Acme Corp",
  "status": "active",
  "executive_summary": "Initial reconnaissance complete. Identified 4 live hosts...",
  "finding_count": 7,
  "host_count": 4,
  "credential_count": 2,
  "open_todos": ["T-003: Check for password reuse on web02", "T-004: Test SSRF on /api/fetch"],
  "last_attack_path_step": "Exploited SQLi on web01 to dump credentials. Attempting lateral movement.",
  "message": "Resumed engagement. Review open TODOs and continue."
}
```

**Behavior:**
1. Verify the engagement directory and `metadata.json` exist.
2. Update `state.json` to set this as the current engagement.
3. Read `metadata.json` and return a summary.

**Errors:**
- Engagement ID not found: return error with available engagement IDs.

---

#### `engagement_status`

Get a detailed overview of the current engagement's progress. This is what the agent calls before starting a new phase to review its own notes.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| — | — | — | No parameters. Operates on the current engagement. |

**Output:**

```json
{
  "engagement_id": "2026-02-17-acme-corp",
  "target": "Acme Corp",
  "scope": ["10.0.0.0/24", "acme.com", "*.acme.com"],
  "status": "active",
  "created_at": "2026-02-17T10:00:00Z",
  "updated_at": "2026-02-17T14:30:00Z",
  "executive_summary": "...",
  "stats": {
    "findings": { "critical": 1, "high": 2, "medium": 3, "low": 1, "info": 0, "total": 7 },
    "hosts": 4,
    "credentials": 2,
    "evidence_files": 5,
    "commands_logged": 12,
    "dead_ends": 3,
    "todos": { "pending": 2, "completed": 5, "total": 7 }
  },
  "recent_attack_path": [
    { "step": 5, "description": "Exploited SQLi on web01..." },
    { "step": 6, "description": "Cracked admin hash, gained app admin..." }
  ],
  "open_todos": [
    { "id": "T-006", "description": "Test for password reuse on web02", "priority": "high" },
    { "id": "T-007", "description": "Check SSRF on /api/fetch endpoint", "priority": "medium" }
  ]
}
```

**Errors:**
- No active engagement: return error suggesting `engagement_create` or `engagement_resume`.

---

#### `engagement_close`

Mark the current engagement as completed. Triggers a final re-render of all markdown files. The engagement can still be resumed later if needed.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `summary` | string | no | Final executive summary to replace the current one. If omitted, the existing summary is kept. |
| `status` | string | no | Status to set: `"completed"` (default) or `"paused"`. |

**Output:**

```json
{
  "engagement_id": "2026-02-17-acme-corp",
  "status": "completed",
  "final_stats": { "findings": 7, "hosts": 4, "credentials": 2 },
  "path": "./engagements/2026-02-17-acme-corp",
  "message": "Engagement closed. Final FINDINGS.md rendered at ./engagements/2026-02-17-acme-corp/FINDINGS.md"
}
```

**Behavior:**
1. Update `metadata.json` status and optionally the executive summary.
2. Re-render all markdown files.
3. Update `index.json`.
4. Clear `state.json` current engagement (set to `null`).

---

### 4.2 Findings

#### `finding_add`

Record a new vulnerability finding. Automatically assigns an incremental ID, timestamps the entry, adds it to the findings list, and updates FINDINGS.md.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `host` | string | yes | IP address or hostname where the vulnerability was found |
| `vulnerability` | string | yes | Description of the vulnerability. Be specific: include the endpoint, parameter, or component. |
| `severity` | string | yes | One of: `"critical"`, `"high"`, `"medium"`, `"low"`, `"info"` |
| `cvss` | number | no | CVSS 3.1 score (0.0–10.0). Omit if unknown. |
| `status` | string | no | One of: `"confirmed"`, `"potential"`, `"exploited"`. Default: `"confirmed"` |
| `evidence_file` | string | no | Filename of evidence in the evidence directory (must already exist, or use `evidence_save` first) |
| `notes` | string | no | Additional context, reproduction steps, or analysis |

**Output:**

```json
{
  "finding_id": "F-003",
  "message": "Finding F-003 added: critical SQLi on 10.0.0.1"
}
```

**Behavior:**
1. Validate severity is one of the allowed values.
2. Validate CVSS is in range if provided.
3. Auto-generate next finding ID (`F-NNN`).
4. Add to `metadata.json` findings array with current timestamp.
5. Update `metadata.json` `updated_at`.
6. Re-render FINDINGS.md (both the "All Findings" and optionally "Critical & High Findings" tables).
7. Update `index.json` finding count.

---

#### `finding_update`

Update an existing finding. Use this to change status (e.g., from `"confirmed"` to `"exploited"`), add notes, attach evidence, or correct details.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `finding_id` | string | yes | The finding ID to update (e.g., `"F-001"`) |
| `status` | string | no | New status |
| `severity` | string | no | Revised severity |
| `cvss` | number | no | Revised CVSS score |
| `evidence_file` | string | no | Attach or change evidence file |
| `notes` | string | no | Append to existing notes (does not replace) |
| `vulnerability` | string | no | Revise the vulnerability description |

**Output:**

```json
{
  "finding_id": "F-001",
  "message": "Finding F-001 updated: status changed to exploited"
}
```

**Behavior:**
1. Find the finding by ID. Return error if not found.
2. Update only the provided fields. For `notes`, append to existing (separated by newline) rather than replace.
3. Update the finding's `updated_at` timestamp.
4. Re-render FINDINGS.md.

---

### 4.3 Hosts

#### `host_discover`

Register a new host or update an existing one. This is called when the agent first identifies a host during scanning, and again as more details are discovered. The server merges new data into existing records rather than overwriting.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ip` | string | yes | IP address of the host |
| `hostname` | string | no | Hostname or FQDN |
| `os` | string | no | Operating system and version |
| `services` | object[] | no | Array of discovered services (see below) |
| `notes` | string | no | General notes about the host |

**Service object:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `port` | number | yes | Port number |
| `proto` | string | no | Protocol: `"tcp"` (default) or `"udp"` |
| `service` | string | yes | Service name (e.g., `"http"`, `"ssh"`, `"smb"`) |
| `version` | string | no | Version string |
| `notes` | string | no | Notes about this service |

**Output:**

```json
{
  "host": "10.0.0.1",
  "action": "updated",
  "services_added": 3,
  "message": "Host 10.0.0.1 updated with 3 services. Per-host file rendered."
}
```

**Behavior:**
1. Check if a host with this IP already exists in `metadata.json`.
2. If **new**: create a full host entry with `first_seen` set to now. Set all text sections to empty strings.
3. If **existing**: merge — update `hostname` and `os` only if provided and currently empty or explicitly being revised. For `services`, add new port/proto combinations; update version/notes on existing ones (never remove services).
4. Update `metadata.json` and the host's `updated_at`.
5. Render/re-render the per-host markdown file at `hosts/<ip>.md`.
6. Re-render FINDINGS.md (Live Hosts and Attack Surface Map tables).
7. Update `index.json` host count.

---

#### `host_update`

Append detailed content to a specific section of a host's notes. Use this for adding enumeration results, vulnerability writeups, exploitation logs, and post-exploitation findings. Unlike `host_discover` which handles structured data (services, OS), this is for freeform narrative content within a host file.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ip` | string | yes | IP address of the host |
| `section` | string | yes | One of: `"enumeration"`, `"vulnerabilities"`, `"exploitation"`, `"post_exploitation"`, `"credentials"`, `"key_commands"` |
| `content` | string | yes | Content to append to the section |

**Output:**

```json
{
  "host": "10.0.0.1",
  "section": "enumeration",
  "message": "Appended to enumeration section for 10.0.0.1"
}
```

**Behavior:**
1. Find the host by IP. Return error if not found (agent should call `host_discover` first).
2. Append `content` to the specified section field, separated by `\n\n` from existing content.
3. Re-render the per-host markdown file.

---

### 4.4 Credentials

#### `credential_add`

Record a harvested credential. Automatically assigns a credential ID and timestamps the entry.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `source` | string | yes | Where the credential was found (e.g., `"10.0.0.1 users table via SQLi F-001"`) |
| `username` | string | yes | The username or account identifier |
| `password_or_hash` | string | yes | The password, hash, token, or key material |
| `cred_type` | string | yes | One of: `"password"`, `"hash"`, `"token"`, `"key"`, `"cookie"`, `"other"` |
| `access_level` | string | no | What this credential grants access to (e.g., `"domain admin"`, `"application user"`) |
| `verified` | boolean | no | Whether the credential has been verified to work. Default: `false` |

**Output:**

```json
{
  "credential_id": "C-002",
  "message": "Credential C-002 added: admin@10.0.0.1 (hash)"
}
```

**Behavior:**
1. Auto-generate next credential ID (`C-NNN`).
2. Add to `metadata.json` credentials array with timestamp.
3. Re-render FINDINGS.md (Credentials Harvested table).
4. Update `index.json` credential count.

---

### 4.5 Evidence

#### `evidence_save`

Save a raw evidence artifact to the engagement's evidence directory. Use this for scan output, exploit proof, screenshots, configuration dumps, and any other raw data that supports findings.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `filename` | string | yes | Descriptive filename (e.g., `"nmap-full-tcp-10.0.0.1.txt"`). Must not contain path separators. |
| `content` | string | yes | The raw content to save |
| `description` | string | no | Brief description of what this evidence contains |
| `related_finding_id` | string | no | Finding ID this evidence supports (e.g., `"F-001"`) |

**Output:**

```json
{
  "filename": "nmap-full-tcp-10.0.0.1.txt",
  "path": "./engagements/2026-02-17-acme-corp/evidence/nmap-full-tcp-10.0.0.1.txt",
  "message": "Evidence saved: nmap-full-tcp-10.0.0.1.txt (linked to F-001)"
}
```

**Behavior:**
1. Validate filename does not contain path separators (`/`, `\`).
2. Write content to `evidence/<filename>`.
3. Add entry to `metadata.json` `evidence_index` with timestamp and optional finding link.
4. If `related_finding_id` is provided and the finding exists, update that finding's `evidence_file` if it is currently empty.
5. Re-render FINDINGS.md (Loot & Evidence Index section).

**Errors:**
- File already exists: overwrite and log a warning in the output message.
- Related finding ID not found: save the file anyway, warn in the output message.

---

### 4.6 Narrative

#### `attack_path_update`

Append a step to the attack path narrative. This builds the ordered story of how the engagement unfolded — from initial recon to final impact. Each call adds one numbered step.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `description` | string | yes | What happened in this step. Write it as a narrative — what was done, what was found, what it means. |

**Output:**

```json
{
  "step": 7,
  "message": "Attack path step 7 added."
}
```

**Behavior:**
1. Determine next step number (max existing step + 1, or 1 if empty).
2. Add to `metadata.json` `attack_path` array with step number and current timestamp.
3. Re-render FINDINGS.md (Attack Path Narrative section).

---

#### `executive_summary_update`

Replace the executive summary. This should be called after major milestones: initial access achieved, lateral movement successful, domain admin compromised, etc.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `summary` | string | yes | The new executive summary (2-3 sentences covering engagement status and critical findings) |

**Output:**

```json
{
  "message": "Executive summary updated."
}
```

**Behavior:**
1. Replace the `executive_summary` field in `metadata.json`.
2. Re-render FINDINGS.md.

---

### 4.7 Tracking

#### `dead_end_log`

Record a technique or approach that was tried and failed. This is valuable for avoiding repeated work and for the final report.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `technique` | string | yes | What was attempted (e.g., `"Anonymous FTP login"`) |
| `target` | string | yes | What it was attempted against (e.g., `"10.0.0.3:21"`) |
| `reason` | string | yes | Why it failed or was abandoned |

**Output:**

```json
{
  "message": "Dead end logged: Anonymous FTP login on 10.0.0.3:21"
}
```

**Behavior:**
1. Add to `metadata.json` `dead_ends` array with current timestamp.
2. Re-render FINDINGS.md (Dead Ends & Failed Attempts section).

---

#### `todo_add`

Add a task to the engagement's TODO list. Use this to track leads, next steps, and follow-up items.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `description` | string | yes | What needs to be done |
| `priority` | string | no | One of: `"high"`, `"medium"`, `"low"`. Default: `"medium"` |

**Output:**

```json
{
  "todo_id": "T-004",
  "message": "TODO T-004 added: Test SSRF on /api/fetch endpoint"
}
```

**Behavior:**
1. Auto-generate next TODO ID (`T-NNN`).
2. Add to `metadata.json` `todos` array with status `"pending"`, current timestamp, and null `completed_at`.
3. Re-render FINDINGS.md (TODO / Next Steps section).

---

#### `todo_complete`

Mark a TODO item as completed.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `todo_id` | string | yes | The TODO ID to complete (e.g., `"T-001"`) |

**Output:**

```json
{
  "todo_id": "T-001",
  "message": "TODO T-001 completed: Crack admin bcrypt hash from web01"
}
```

**Behavior:**
1. Find the TODO by ID. Return error if not found.
2. Set status to `"completed"` and `completed_at` to current timestamp.
3. Re-render FINDINGS.md.

---

### 4.8 Reading

#### `notes_read`

Read notes from the current engagement. This is how the agent reviews its own documentation. Supports reading the full findings, a specific host file, evidence index, or searching across content.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `what` | string | yes | What to read: `"findings"`, `"host"`, `"evidence_index"`, `"todos"`, `"attack_path"`, `"dead_ends"`, `"credentials"`, `"command_log"`, `"search"` |
| `host_ip` | string | conditional | Required when `what` is `"host"`. The IP of the host to read. |
| `query` | string | conditional | Required when `what` is `"search"`. A substring to search for across all notes. |
| `scope` | string | no | For `"search"` only: `"current"` (default) or `"all"` to search across all engagements. |

**Output (example for `what: "findings"`):**

```json
{
  "engagement_id": "2026-02-17-acme-corp",
  "content": "<rendered FINDINGS.md content>"
}
```

**Output (example for `what: "search"`):**

```json
{
  "results": [
    {
      "engagement_id": "2026-02-17-acme-corp",
      "type": "finding",
      "id": "F-001",
      "match": "SQL injection in login form (POST /api/auth, parameter: username)"
    },
    {
      "engagement_id": "2026-02-10-initech",
      "type": "credential",
      "id": "C-003",
      "match": "admin:Password123 (verified)"
    }
  ],
  "total": 2
}
```

**Behavior:**
- `"findings"`: Return the full rendered FINDINGS.md content.
- `"host"`: Return the rendered per-host markdown for the given IP. Error if host not found.
- `"evidence_index"`: Return the evidence index (filenames, descriptions, linked findings).
- `"todos"`: Return all TODOs grouped by status (pending first, then completed).
- `"attack_path"`: Return the full attack path narrative.
- `"dead_ends"`: Return all dead ends.
- `"credentials"`: Return the credentials table.
- `"search"`: Substring search across findings, hosts, credentials, dead ends, and TODOs. If `scope` is `"all"`, search across every engagement's `metadata.json`.
- `"command_log"`: Return the full command audit trail.

---

### 4.9 Command Logging

#### `command_log`

Record a command that was executed during the engagement. This is primarily used by the `nyx-log` CLI wrapper (see Section 9), but the agent can also call it directly to log commands it ran without `nyx-log`.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `command` | string | yes | The full command string that was executed |
| `tool` | string | no | Name of the tool (e.g., `"nmap"`, `"sqlmap"`, `"gobuster"`). Auto-detected from command if omitted. |
| `target` | string | no | The target host/IP the command was run against |
| `started_at` | string | no | ISO 8601 timestamp when the command started. Defaults to now if omitted. |
| `finished_at` | string | no | ISO 8601 timestamp when the command finished. Defaults to now if omitted. |
| `duration_seconds` | number | no | How long the command ran in seconds |
| `exit_code` | number | no | The command's exit code |
| `evidence_file` | string | no | Filename of the saved output in the evidence directory |
| `source` | string | no | Who logged this: `"nyx-log"`, `"agent"`, or `"manual"`. Default: `"agent"` |

**Output:**

```json
{
  "command_id": "CMD-004",
  "message": "Command logged: nmap -sV 10.0.0.1 (450s, exit 0)"
}
```

**Behavior:**
1. Auto-generate next command ID (`CMD-NNN`).
2. If `tool` is not provided, extract it from the first token of `command`.
3. Add to `metadata.json` `command_log` array.
4. Update `metadata.json` `updated_at`.
5. Re-render FINDINGS.md (Command Log section).
6. Update `index.json` command count.

**Note:** Unlike most other tools, `command_log` accepts optional timestamps from the caller. This is because the `nyx-log` CLI wrapper records precise start/end times during command execution and passes them in after the fact. The MCP server validates that timestamps are valid ISO 8601 but does not override them with server time.

---

### 4.10 Tool Output Ingestion

#### `ingest_tool_output`

Parse structured output from a well-known security tool and automatically extract structured data (hosts, services, findings). This avoids the agent needing to manually parse scan output and make individual `host_discover` / `finding_add` calls. See Section 10 for supported tools and parser details.

**Input Schema:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `tool` | string | yes | The tool that produced the output. One of the supported parsers: `"nmap"`, `"masscan"`, `"gobuster"`, `"ffuf"`, `"feroxbuster"`, `"nikto"` |
| `file_path` | string | yes | Path to the structured output file (absolute, or relative to the engagement's evidence directory) |
| `target` | string | no | Override target host (useful when the output covers multiple hosts) |

**Output:**

```json
{
  "tool": "nmap",
  "file": "nmap-20260217T104500.xml",
  "results": {
    "hosts_discovered": 4,
    "hosts_updated": 0,
    "services_added": 12,
    "findings_added": 0
  },
  "message": "Parsed nmap XML: discovered 4 hosts with 12 services. Host files and FINDINGS.md updated."
}
```

**Behavior:**
1. Validate the tool has a registered parser. Return error `unsupported_tool` if not.
2. Validate the file exists and is readable. Return error `file_not_found` if not.
3. Run the appropriate parser (see Section 10).
4. For each extracted host: call the internal `host_discover` logic (merge services, OS, hostname).
5. For each extracted finding (if the parser produces them): call the internal `finding_add` logic with `status: "potential"`.
6. If the file is not already in the evidence directory, copy it there.
7. Add the file to `evidence_index` if not already present.
8. Re-render all affected markdown files.
9. Return a summary of what was extracted.

**Errors:**
- `unsupported_tool`: The specified tool has no registered parser. The file is still saved as evidence if possible.
- `file_not_found`: The file path does not exist or is not readable.
- `parse_error`: The file exists but could not be parsed (malformed, wrong format, etc.). The file is still saved as evidence; the error message includes details about what went wrong.

---

## 5. Markdown Rendering

Every mutating tool call triggers a re-render of the affected markdown files. The rendered output must match the format and quality of the existing templates defined in the system prompt.

### 5.1 FINDINGS.md Template

The rendered `FINDINGS.md` follows this structure exactly. Empty sections are still rendered with their headers and empty tables (so the structure is always consistent).

```markdown
# Penetration Test Findings
**Target:** {target}
**Scope:** {scope, comma-separated}
**Started:** {created_at}
**Last Updated:** {updated_at}
**Tester:** Nyx (automated agent)
**Status:** {status}

---

## Scope & Rules of Engagement
{rules_of_engagement, or "Not specified." if empty}

## Executive Summary
{executive_summary, or "No findings yet." if empty}

## Attack Path Narrative
{For each step in attack_path, render as a numbered list:}
1. **[{timestamp}]** {description}
2. ...

## Critical & High Findings

| ID | Host | Vulnerability | Severity | CVSS | Exploited | Evidence File |
|----|------|---------------|----------|------|-----------|---------------|
{For each finding where severity is "critical" or "high":}
| {id} | {host} | {vulnerability} | {severity} | {cvss or "—"} | {yes if status is "exploited", no otherwise} | {evidence_file or "—"} |

## All Findings

| ID | Host | Vulnerability | Severity | CVSS | Status | Evidence File |
|----|------|---------------|----------|------|--------|---------------|
{For each finding:}
| {id} | {host} | {vulnerability} | {severity} | {cvss or "—"} | {status} | {evidence_file or "—"} |

## Credentials Harvested

| Source | Username | Password / Hash | Type | Access Level | Verified |
|--------|----------|-----------------|------|--------------|----------|
{For each credential:}
| {source} | {username} | {password_or_hash} | {cred_type} | {access_level or "—"} | {yes/no} |

## Recon Summary

### Live Hosts
| IP | Hostname | OS | Key Services | Notes |
|----|----------|----|--------------|-------|
{For each host:}
| {ip} | {hostname or "—"} | {os or "—"} | {comma-separated service:port list} | {notes or "—"} |

### Attack Surface Map
| Host | Port | Service | Version | Interesting? | Notes |
|------|------|---------|---------|--------------|-------|
{For each host, for each service:}
| {ip} | {port}/{proto} | {service} | {version or "—"} | {yes if any finding references this host+port, else "—"} | {notes or "—"} |

## Loot & Evidence Index
{For each evidence entry:}
- `{filename}` — {description} {" (linked to {related_finding_id})" if linked}

## Dead Ends & Failed Attempts
{For each dead end:}
- **[{timestamp}]** {technique} on {target} — {reason}

## Command Log

| ID | Command | Tool | Target | Duration | Exit | Evidence | Source |
|----|---------|------|--------|----------|------|----------|--------|
{For each command in command_log:}
| {id} | `{command, truncated to 60 chars}` | {tool} | {target or "—"} | {duration_seconds}s | {exit_code} | {evidence_file or "—"} | {source} |

## TODO / Next Steps
{For each todo with status "pending":}
- [ ] **[{priority}]** {description} ({id})
{For each todo with status "completed":}
- [x] ~~{description}~~ ({id}, completed {completed_at})
```

### 5.2 Per-Host File Template

Rendered at `hosts/<ip>.md`. The IP in the filename uses the literal IP address (dots preserved, e.g., `10.0.0.1.md`).

```markdown
# Host: {ip}
**Hostname:** {hostname or "Unknown"}
**OS:** {os or "Unknown"}
**First Seen:** {first_seen}
**Last Updated:** {updated_at}

## Ports & Services
| Port | Proto | Service | Version | Notes |
|------|-------|---------|---------|-------|
{For each service:}
| {port} | {proto} | {service} | {version or "—"} | {notes or "—"} |

## Enumeration
{enumeration text, or "No enumeration data yet."}

## Vulnerabilities
{vulnerabilities text, or "No vulnerabilities documented yet."}

## Exploitation Attempts
{exploitation text, or "No exploitation attempts yet."}

## Post-Exploitation
{post_exploitation text, or "No post-exploitation data yet."}

## Credentials
{credentials text, or "No credentials found for this host."}

## Key Commands & Output
{key_commands text, or "No key commands logged yet."}
```

### 5.3 Rendering Rules

1. **Re-render on every write.** Any tool that modifies `metadata.json` must re-render the affected files before returning.
2. **Atomic writes.** Write to a temporary file first, then rename. This prevents partial writes from corrupting markdown files.
3. **Full re-render for FINDINGS.md.** Because findings, hosts, credentials, evidence, and TODOs all appear in FINDINGS.md, any mutation to any of these triggers a full re-render of the file.
4. **Selective re-render for host files.** Only re-render the host file that was modified.
5. **Empty state handling.** Empty tables are rendered with headers but no data rows. Empty text sections show a placeholder message.

---

## 6. Error Handling

All errors are returned as JSON objects with an `error` field. The agent should interpret these and take corrective action.

### Standard Error Format

```json
{
  "error": "no_active_engagement",
  "message": "No engagement is currently active. Use engagement_create to start a new one or engagement_resume to continue an existing one.",
  "available_engagements": ["2026-02-17-acme-corp", "2026-02-10-initech"]
}
```

### Error Codes

| Code | Returned By | Description |
|------|-------------|-------------|
| `no_active_engagement` | All tools except `engagement_create`, `engagement_list`, `engagement_resume` | No current engagement is set |
| `engagement_not_found` | `engagement_resume` | The requested engagement ID does not exist |
| `engagement_already_exists` | `engagement_create` | An engagement with the generated ID already exists |
| `finding_not_found` | `finding_update` | The specified finding ID does not exist |
| `host_not_found` | `host_update`, `notes_read` (when `what: "host"`) | The specified host IP has no record |
| `todo_not_found` | `todo_complete` | The specified TODO ID does not exist |
| `invalid_severity` | `finding_add`, `finding_update` | Severity is not one of the allowed values |
| `invalid_cvss` | `finding_add`, `finding_update` | CVSS score is outside 0.0–10.0 range |
| `invalid_filename` | `evidence_save` | Filename contains path separators or is empty |
| `invalid_section` | `host_update` | Section name is not one of the allowed values |
| `unsupported_tool` | `ingest_tool_output` | The specified tool has no registered parser |
| `file_not_found` | `ingest_tool_output` | The specified file path does not exist or is not readable |
| `parse_error` | `ingest_tool_output` | The file exists but could not be parsed (malformed, wrong format) |

---

## 7. Integration

### 7.1 MCP Server Registration (OpenCode)

The MCP server is registered in the `opencode.json` configuration file. In the Nyx project, this goes into `templates/opencode.json.template` and is rendered during VM provisioning by `guest.sh`.

**If installed globally** (`npm install -g nyx-memory`):

```json
{
  "mcpServers": {
    "nyx-memory": {
      "command": "nyx-memory",
      "args": ["serve"],
      "env": {
        "NYX_DATA_DIR": "./engagements"
      }
    }
  }
}
```

**If using npx** (no global install needed):

```json
{
  "mcpServers": {
    "nyx-memory": {
      "command": "npx",
      "args": ["-y", "nyx-memory", "serve"],
      "env": {
        "NYX_DATA_DIR": "./engagements"
      }
    }
  }
}
```

This block is merged into the existing `opencode.json.template` alongside the agent, provider, and permission configuration. The `NYX_DATA_DIR` is set relative to the OpenCode workspace (`/home/kali/pentest`), so engagements live at `/home/kali/pentest/engagements/`.

For the Nyx VM setup, global install is preferred (faster startup, no npx overhead on every MCP call).

### 7.2 VM Installation (guest.sh)

The `lib/guest.sh` provisioning script installs both the MCP server and the `nyx-log` wrapper inside the Kali VM:

```bash
# Install Node.js if not present (Kali includes it, but ensure recent version)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs

# Install nyx-memory globally (MCP server + CLI + nyx-log)
sudo npm install -g nyx-memory

# Verify
nyx-memory --version
nyx-log --help
```

The npm package installs two binaries via the `bin` field in `package.json`:

```json
{
  "name": "nyx-memory",
  "bin": {
    "nyx-memory": "./dist/cli.js",
    "nyx-log": "./bin/nyx-log"
  }
}
```

- `nyx-memory` is the compiled TypeScript CLI (handles both `serve` for MCP and all CLI subcommands).
- `nyx-log` is a standalone bash script bundled in the package at `bin/nyx-log`. npm automatically symlinks it to the global bin directory.

For development or running from the Nyx repo directly (without publishing to npm):

```bash
# From the nyx-memory/ directory
npm install
npm run build
npm link  # Makes nyx-memory and nyx-log available globally
```

### 7.3 System Prompt Changes

The entire "Operational Memory — Findings Documentation" section (lines 7–136 of the current `SYSTEM_PROMPT.md`) is replaced with:

```markdown
## Operational Memory

You have a structured memory system via MCP tools. Use it.

- At the start of every engagement, call `engagement_create` with the target and scope.
- When resuming work, call `engagement_list` then `engagement_resume` to pick up where you left off.
- Log findings immediately with `finding_add`. Don't batch — record as you discover.
- Register hosts with `host_discover` as you enumerate them. Add detail with `host_update`.
- Record credentials with `credential_add`, evidence with `evidence_save`.
- Build the attack story with `attack_path_update` after each significant step.
- Log dead ends with `dead_end_log`. Track next steps with `todo_add`, mark done with `todo_complete`.
- Update the executive summary with `executive_summary_update` after major milestones.
- Before starting a new phase, call `engagement_status` to review progress and open TODOs.
- Use `notes_read` to review detailed findings, host files, or search your notes.
- **Prefer `nyx-log <command>` over running tools directly.** This automatically captures output as evidence, logs the command with timing, and triggers auto-parsing for supported tools (nmap XML, etc.). The output still appears in your terminal — `nyx-log` is transparent.
- When a tool produces structured output (e.g., nmap `-oX`), call `ingest_tool_output` to automatically extract hosts and services without manual parsing.
- Your notes are automatically rendered as markdown files in `./engagements/<id>/`.
```

This reduces 130 lines to 16 lines while encoding the same behavioral expectations plus the new CLI integration.

### 7.4 OpenCode Watcher Configuration

The `opencode.json.template` should exclude engagement evidence from the file watcher to avoid noisy change detection on large scan outputs:

```json
{
  "watcher": {
    "ignore": ["engagements/**/evidence/**", ".env"]
  }
}
```

### 7.5 Session Continuity

When the agent starts a new conversation:
1. The server reads `state.json` on startup.
2. If a current engagement is set, the agent can immediately call `engagement_status` to get context.
3. If no engagement is set, the agent should call `engagement_list` and either `engagement_resume` or `engagement_create`.

This eliminates the "re-read your notes before each new phase" instruction — `engagement_status` returns exactly what the agent needs.

---

## 8. Edge Cases and Design Decisions

### No Active Engagement

Any mutating tool called without an active engagement returns the `no_active_engagement` error. The error includes a list of existing engagements to help the agent self-correct. The only tools that work without an active engagement are `engagement_create`, `engagement_list`, and `engagement_resume`.

### Duplicate Findings

The server does **not** automatically deduplicate findings. If the agent calls `finding_add` with the same vulnerability on the same host, both entries are created. This is by design:
- The agent may be recording the same vulnerability class on different endpoints.
- The `finding_update` tool exists to revise existing findings.
- The system prompt instructs the agent to review notes before adding, which is the appropriate deduplication layer.

### Host Merging Strategy

When `host_discover` is called for an existing IP:
- `hostname` and `os`: updated if provided and non-empty. Never cleared.
- `services`: additive. New port/proto combinations are added. Existing services are updated (version, notes) but never removed. This ensures that scan data accumulates over time.
- Freeform text sections (`enumeration`, `vulnerabilities`, etc.) are only modified via `host_update`, never by `host_discover`.

### Concurrent Access (MCP + CLI)

With the dual interface, the MCP server (running as an OpenCode subprocess) and CLI commands (`nyx-log`, `nyx-memory log`, etc.) can write to the same `metadata.json` concurrently. This is handled via a lockfile:

- All writes to `metadata.json` acquire an exclusive lockfile (`metadata.json.lock`) using `proper-lockfile` (or equivalent) before reading, modifying, and writing back.
- The lock is held for the duration of the read-modify-write cycle (typically <50ms).
- CLI commands that write (e.g., `nyx-memory log`) use the same locking mechanism.
- Markdown re-rendering happens after the lock is released — rendering is idempotent, so a slightly stale render is harmless and will be corrected by the next write.
- If a lock cannot be acquired within 5 seconds, the operation fails with an error rather than blocking indefinitely.
- The lockfile approach works cross-platform and is compatible with Node's single-threaded async model — the lock is awaited before proceeding.

### Large Evidence Files

The MCP `evidence_save` tool accepts content as a string parameter, which passes through the LLM context and burns tokens. For large outputs, prefer the CLI path:

- **`nyx-log`** captures output directly to disk via pipe — the LLM never sees the raw bytes.
- **`nyx-memory log --tool nmap`** reads from stdin and writes directly to the evidence directory.
- **`ingest_tool_output`** reads from a file path on disk — no content passes through MCP.

Reserve `evidence_save` (the MCP tool) for small artifacts the agent has already in context: exploit proof snippets, interesting config fragments, etc. For full scan output, always prefer `nyx-log` or direct file saves.

### CLI Without Active Engagement

CLI commands that write to an engagement (`nyx-memory log`, `nyx-memory ingest`) read `state.json` to determine the active engagement. If no engagement is active:
- The command prints an error to stderr: `"No active engagement. Start one with the agent or run: nyx-memory create --target <target> --scope <scope>"`
- Exit code 1.
- No data is written.

Read-only CLI commands (`nyx-memory status`, `nyx-memory list`) work regardless.

### Parser Failures

When `ingest_tool_output` or `nyx-log` auto-ingest encounters a parse error:
- The raw file is **still saved as evidence**. Data is never lost.
- The error is logged to the command log entry (`parsed: false`).
- The MCP tool returns a `parse_error` with details about what went wrong.
- The CLI prints a warning to stderr but exits 0 (the command itself succeeded; only parsing failed).
- The agent can still manually extract data from the evidence file via `notes_read` or by reading the file directly.

### Engagement ID Collisions

If two engagements are started on the same day against the same target, the generated slug would collide. The server handles this by appending a numeric suffix: `2026-02-17-acme-corp`, `2026-02-17-acme-corp-2`, etc.

### Data Migration

The `metadata.json` schema may evolve. The server should check for a `schema_version` field (default `1` if absent) and perform forward-compatible migrations on load. Missing fields are initialized to their default values (empty arrays, empty strings, null).

### Filesystem Safety

- All filenames are sanitized: path separators stripped, whitespace replaced with hyphens, length capped.
- The server never reads or writes outside of the `NYX_DATA_DIR` directory tree.
- Evidence filenames provided by the agent are sanitized before use.
- The `nyx-log` wrapper writes only to the active engagement's evidence directory.
- `ingest_tool_output` accepts file paths but validates they exist and are readable before processing. It copies files into the evidence directory rather than referencing external paths.

---

## 9. CLI Interface

The `nyx-memory` package provides a CLI that shares the same storage engine as the MCP server. This enables two key capabilities:

1. **Piping tool output directly to disk** without passing through the LLM context (saving tokens and handling large outputs).
2. **The `nyx-log` wrapper** that transparently captures command execution, timing, output, and optionally triggers structured parsing.

### 9.1 `nyx-memory` CLI

Installed globally via `npm install -g nyx-memory`. The entrypoint is a single Node.js binary that detects whether to launch MCP mode or execute a CLI subcommand based on the first argument. All subcommands read `NYX_DATA_DIR` (default `./engagements`) and `state.json` to determine the active engagement.

#### `nyx-memory serve`

Start the MCP server (stdio transport). This is what OpenCode launches.

```bash
nyx-memory serve
```

Not intended for direct human use. OpenCode invokes it via the `mcpServers` configuration.

#### `nyx-memory log`

Read from stdin and save as evidence to the active engagement. Also creates a `command_log` entry.

```bash
nmap -sV 10.0.0.1 2>&1 | nyx-memory log --tool nmap --target 10.0.0.1
```

**Flags:**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--tool` | string | no | Tool name (e.g., `nmap`). Auto-detected from context if omitted. |
| `--target` | string | no | Target host/IP. |
| `--command` | string | no | Full command string (for the command log). Usually passed by `nyx-log`. |
| `--started-at` | string | no | ISO 8601 start timestamp. Usually passed by `nyx-log`. |
| `--duration` | number | no | Duration in seconds. Usually passed by `nyx-log`. |
| `--exit-code` | number | no | Command exit code. Usually passed by `nyx-log`. |
| `--filename` | string | no | Override the auto-generated evidence filename. |
| `--no-parse` | flag | no | Skip auto-parsing even if a parser exists for this tool. |

**Behavior:**
1. Read all of stdin into memory (or stream to a temp file if larger than 10MB).
2. Generate evidence filename: `<tool>-<timestamp>-<sanitized-target>.txt` (or use `--filename`).
3. Write content to `<engagement>/evidence/<filename>`.
4. Add entry to `evidence_index` in `metadata.json`.
5. Add entry to `command_log` in `metadata.json` (using provided flags or defaults).
6. Re-render FINDINGS.md.
7. Print the evidence file path to stdout.

**Auto-parsing:** After saving, if the tool has a registered parser and `--no-parse` is not set, check if stdin content or a related file (e.g., nmap `-oX` output) can be parsed. If so, trigger the parser and update hosts/services/findings. See Section 10.

#### `nyx-memory ingest`

Parse a structured output file from a security tool and extract structured data.

```bash
nyx-memory ingest --tool nmap --file /tmp/scan.xml
```

**Flags:**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--tool` | string | yes | Tool name (must have a registered parser). |
| `--file` | string | yes | Path to the structured output file. |
| `--target` | string | no | Override target host. |

**Behavior:**
Equivalent to the `ingest_tool_output` MCP tool (Section 4.10). Reads the file, runs the parser, updates metadata, re-renders markdown. Prints a summary of extracted data to stdout.

#### `nyx-memory status`

Print the current engagement status to the terminal.

```bash
nyx-memory status
```

**Output (human-readable):**

```
Engagement: 2026-02-17-acme-corp (active)
Target:     Acme Corp (10.0.0.0/24, acme.com)
Started:    2026-02-17T10:00:00Z
Updated:    2026-02-17T14:30:00Z

Findings:   1 critical, 2 high, 3 medium, 1 low (7 total)
Hosts:      4 discovered
Credentials: 2 harvested
Commands:   12 logged
Evidence:   5 files

Open TODOs:
  [T-006] [high] Test for password reuse on web02
  [T-007] [medium] Check SSRF on /api/fetch endpoint
```

#### `nyx-memory list`

List all engagements.

```bash
nyx-memory list
nyx-memory list --status active
```

#### `nyx-memory create`

Create a new engagement from the CLI (useful for scripting or when the agent is not running).

```bash
nyx-memory create --target "Acme Corp" --scope "10.0.0.0/24" --scope "acme.com"
```

### 9.2 `nyx-log` Shell Wrapper

`nyx-log` is a lightweight bash script that wraps any command, transparently captures its output, and pipes it to `nyx-memory log`. It is the primary mechanism for automatic evidence capture during an engagement.

#### Usage

```bash
# Basic usage — wraps the command, captures output
nyx-log nmap -sV -p- 10.0.0.1

# With structured output — nyx-log detects the -oX flag and auto-ingests
nyx-log nmap -sV -oX /tmp/scan.xml 10.0.0.1

# Any command works
nyx-log gobuster dir -u https://10.0.0.1 -w /usr/share/seclists/Discovery/Web-Content/common.txt
nyx-log nikto -h 10.0.0.1
nyx-log curl -s https://10.0.0.1/api/users
```

#### Behavior

1. **Record start time.** Capture timestamp before execution.
2. **Execute the command.** Run `"$@"` with stdout and stderr merged.
3. **Tee output.** Output is displayed to the terminal in real-time (the agent sees it normally) AND captured to a temporary file. This is critical — `nyx-log` must be transparent. The agent should see exactly the same output as if it ran the command directly.
4. **Record end time and exit code.** Capture timestamp and `$?` after execution.
5. **Detect tool name.** Extract from `$1` (the first argument / command name).
6. **Detect target.** Heuristic: scan arguments for IP addresses, hostnames, or URLs. Use the last one found (most tools put the target last).
7. **Detect structured output files.** Check for flags that indicate structured output:
   - nmap: `-oX <file>`, `-oA <basename>` (look for `<basename>.xml`)
   - masscan: `-oX <file>`, `-oJ <file>`
   - ffuf: `-o <file>` with `-of json`
   If a structured output file is detected and exists after execution, trigger `nyx-memory ingest --tool <tool> --file <path>`.
8. **Pipe captured output to `nyx-memory log`.** Pass all metadata:
   ```bash
   cat "$TMPFILE" | nyx-memory log \
     --tool "$TOOL" \
     --target "$TARGET" \
     --command "$FULL_COMMAND" \
     --started-at "$START_TS" \
     --duration "$DURATION" \
     --exit-code "$EXIT_CODE"
   ```
9. **Clean up.** Remove the temporary file.
10. **Exit with the original command's exit code.** The agent's flow should not be affected by `nyx-log`'s bookkeeping.

#### Implementation Sketch

```bash
#!/usr/bin/env bash
set -uo pipefail

# Check for active engagement
if ! nyx-memory status --quiet 2>/dev/null; then
    echo "[nyx-log] Warning: no active engagement. Output will not be logged." >&2
    exec "$@"
fi

TOOL="$(basename "$1")"
FULL_COMMAND="$*"
TMPFILE="$(mktemp)"
START_TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
START_EPOCH="$(date +%s)"

# Execute with tee — output is visible to the agent in real-time
"$@" 2>&1 | tee "$TMPFILE"
EXIT_CODE="${PIPESTATUS[0]}"

END_EPOCH="$(date +%s)"
DURATION=$((END_EPOCH - START_EPOCH))

# Detect target (last IP/hostname/URL argument)
TARGET=""
for arg in "$@"; do
    if [[ "$arg" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9] ]] || \
       [[ "$arg" =~ ^https?:// ]] || \
       [[ "$arg" =~ ^[a-zA-Z0-9][-a-zA-Z0-9]*\.[a-zA-Z]{2,} ]]; then
        TARGET="$arg"
    fi
done

# Pipe captured output to nyx-memory
cat "$TMPFILE" | nyx-memory log \
    --tool "$TOOL" \
    --target "$TARGET" \
    --command "$FULL_COMMAND" \
    --started-at "$START_TS" \
    --duration "$DURATION" \
    --exit-code "$EXIT_CODE" 2>/dev/null

# Detect and ingest structured output files
case "$TOOL" in
    nmap)
        for i in $(seq 1 $#); do
            arg="${!i}"
            if [[ "$arg" == "-oX" || "$arg" == "-oA" ]]; then
                next=$((i + 1))
                outfile="${!next}"
                [[ "$arg" == "-oA" ]] && outfile="${outfile}.xml"
                [[ -f "$outfile" ]] && nyx-memory ingest --tool nmap --file "$outfile" 2>/dev/null
                break
            fi
        done
        ;;
    masscan)
        for i in $(seq 1 $#); do
            arg="${!i}"
            if [[ "$arg" == "-oX" || "$arg" == "-oJ" ]]; then
                next=$((i + 1))
                outfile="${!next}"
                [[ -f "$outfile" ]] && nyx-memory ingest --tool masscan --file "$outfile" 2>/dev/null
                break
            fi
        done
        ;;
esac

rm -f "$TMPFILE"
exit "$EXIT_CODE"
```

#### Key Design Decisions

- **Transparency.** `nyx-log` must not change the command's visible behavior. The agent sees the same stdout/stderr, gets the same exit code. The only side effect is evidence capture.
- **Fail-safe.** If `nyx-memory log` or `nyx-memory ingest` fails (e.g., no active engagement, broken pipe), `nyx-log` still exits with the original command's exit code. Errors from the logging side go to stderr with a `[nyx-log]` prefix but do not interrupt the agent's workflow.
- **No active engagement fallback.** If no engagement is active, `nyx-log` prints a warning and runs the command without logging. It does not block execution.
- **`PIPESTATUS` for exit codes.** Uses `PIPESTATUS[0]` to capture the original command's exit code through the `tee` pipe.

---

## 10. Tool Output Parsers

Parsers extract structured data from well-known security tool output formats. They are invoked by `ingest_tool_output` (MCP), `nyx-memory ingest` (CLI), or automatically by `nyx-log` when structured output files are detected.

### 10.1 Parser Interface

Each parser is a TypeScript module that exports a `parse` function conforming to the `ToolParser` interface:

```typescript
interface HostData {
  ip: string;
  hostname?: string;
  os?: string;
  services?: ServiceData[];
}

interface ServiceData {
  port: number;
  proto?: string;   // "tcp" | "udp", default "tcp"
  service: string;
  version?: string;
  notes?: string;
}

interface FindingData {
  host: string;
  vulnerability: string;
  severity: "critical" | "high" | "medium" | "low" | "info";
  cvss?: number;
  notes?: string;
}

interface ParseResult {
  hosts: HostData[];       // Hosts to discover/update
  findings: FindingData[]; // Potential findings to add
  metadata: Record<string, unknown>; // Parser-specific metadata (e.g., scan stats)
}

type ToolParser = (filePath: string, target?: string) => Promise<ParseResult>;
```

Parsers are registered in a `Map<string, ToolParser>` keyed by tool name. Adding a new parser is as simple as writing a function matching the `ToolParser` signature and adding it to the registry:

```typescript
// src/parsers/index.ts
import { parseNmap } from "./nmap.js";
import { parseMasscan } from "./masscan.js";
import { parseGobuster } from "./gobuster.js";
import { parseNikto } from "./nikto.js";

export const parsers = new Map<string, ToolParser>([
  ["nmap", parseNmap],
  ["masscan", parseMasscan],
  ["gobuster", parseGobuster],
  ["ffuf", parseGobuster],       // same format
  ["feroxbuster", parseGobuster], // same format
  ["nikto", parseNikto],
]);
```

### 10.2 Supported Parsers

#### `nmap` (XML format)

**Input:** nmap XML output (produced by `-oX` or `-oA`).

**Extracts:**
- **Hosts:** IP address, hostname (from DNS/reverse DNS), OS (from `<osmatch>`), status (up/down).
- **Services:** port, protocol, service name, version string, state (open/filtered/closed). Only `open` and `open|filtered` services are added.
- **Findings:** None by default. Nmap identifies services, not vulnerabilities. However, if nmap scripts (`--script`) produce output, the parser includes them as `info`-severity findings.

**Example flow:**
```
nyx-log nmap -sV -oX /tmp/scan.xml 10.0.0.0/24
  → nyx-memory log saves raw stdout as evidence
  → nyx-log detects -oX /tmp/scan.xml
  → nyx-memory ingest --tool nmap --file /tmp/scan.xml
    → parser reads XML
    → for each host: host_discover(ip, hostname, os, services)
    → FINDINGS.md and host files updated
```

#### `masscan` (XML or JSON format)

**Input:** masscan XML (`-oX`) or JSON (`-oJ`) output.

**Extracts:**
- **Hosts:** IP address.
- **Services:** port, protocol, state. Masscan does not do service fingerprinting, so `service` is set to `"unknown"` and `version` is empty.
- **Findings:** None.

**Note:** Masscan results are typically followed by targeted nmap scans for service identification. The parser creates host stubs that nmap results will later enrich.

#### `gobuster` / `ffuf` / `feroxbuster` (stdout or JSON)

**Input:** Tool stdout (captured by `nyx-log`) or JSON output (`ffuf -o results.json -of json`).

**Extracts:**
- **Hosts:** None (the target host should already be registered).
- **Services:** None.
- **Findings:** None directly. Instead, the parser extracts discovered paths/endpoints and appends them to the target host's `enumeration` section via the `host_update` logic.

**Extracted data format (appended to host enumeration):**
```
### Directory Brute-Force Results (gobuster, 2026-02-17T11:05:12Z)
| Path | Status | Size | Notes |
|------|--------|------|-------|
| /admin | 403 | 287B | Forbidden — potential admin panel |
| /api | 200 | 1.2KB | API endpoint |
| /backup | 301 | 0B | Redirect — investigate |
```

#### `nikto` (stdout or XML)

**Input:** nikto stdout (captured by `nyx-log`) or XML output (`-Format xml -output results.xml`).

**Extracts:**
- **Hosts:** None (target should already be registered).
- **Services:** None.
- **Findings:** Each nikto finding is added as a `potential` finding with `severity: "info"` or `"low"` depending on the OSVDB/category. The agent should review and upgrade severity for confirmed issues.

### 10.3 Parser Limitations

- Parsers are **best-effort**. Malformed output, interrupted scans, or non-standard formats may produce partial results or parse errors. The raw evidence file is always preserved.
- Parsers **never delete or overwrite** existing data. They only add new hosts, merge services, and append findings/enumeration. This is consistent with the additive-only design of `host_discover`.
- Service version detection varies by tool. Masscan produces no versions, nmap produces detailed versions. The merge logic handles this gracefully — nmap results will fill in versions on hosts initially discovered by masscan.
- Parsers do **not** automatically confirm findings. Everything from automated parsing is added with `status: "potential"`. The agent is responsible for confirmation and severity assessment.

---

## 11. Packaging & Distribution

### 11.1 npm Package

`nyx-memory` is published as an npm package for easy installation and integration with any MCP-compatible host.

**Install globally:**

```bash
npm install -g nyx-memory
```

**Run without installing (npx):**

```bash
# Start the MCP server
npx -y nyx-memory serve

# Use the CLI
npx -y nyx-memory status
```

**Add to any OpenCode project (one-liner):**

Add the following to your `opencode.json` or `.opencode/config.json`:

```json
{
  "mcpServers": {
    "nyx-memory": {
      "command": "npx",
      "args": ["-y", "nyx-memory", "serve"]
    }
  }
}
```

That's it. OpenCode will auto-download and start the MCP server on first use. No pre-installation required.

### 11.2 Package Structure

```
nyx-memory/
├── package.json
├── tsconfig.json
├── bin/
│   └── nyx-log                  # Bash wrapper script (shipped as-is)
├── src/
│   ├── cli.ts                   # CLI entrypoint (commander-based)
│   ├── serve.ts                 # MCP server (stdio transport)
│   ├── storage/
│   │   ├── engine.ts            # Read/write metadata.json with locking
│   │   ├── index.ts             # Global index management
│   │   └── state.ts             # Active engagement state
│   ├── tools/                   # MCP tool handlers (one file per tool group)
│   │   ├── engagement.ts
│   │   ├── findings.ts
│   │   ├── hosts.ts
│   │   ├── credentials.ts
│   │   ├── evidence.ts
│   │   ├── narrative.ts
│   │   ├── tracking.ts
│   │   ├── reading.ts
│   │   ├── commandLog.ts
│   │   └── ingest.ts
│   ├── render/
│   │   ├── findings.ts          # FINDINGS.md renderer
│   │   └── host.ts              # Per-host file renderer
│   ├── parsers/
│   │   ├── index.ts             # Parser registry
│   │   ├── nmap.ts
│   │   ├── masscan.ts
│   │   ├── gobuster.ts
│   │   └── nikto.ts
│   └── types.ts                 # Shared TypeScript interfaces
├── dist/                        # Compiled output (not committed)
│   ├── cli.js                   # Entrypoint for `nyx-memory` bin
│   └── ...
└── README.md
```

### 11.3 `package.json`

```json
{
  "name": "nyx-memory",
  "version": "1.0.0",
  "description": "MCP server for penetration testing engagement memory — structured findings, hosts, credentials, evidence, and attack narratives",
  "type": "module",
  "bin": {
    "nyx-memory": "./dist/cli.js",
    "nyx-log": "./bin/nyx-log"
  },
  "scripts": {
    "build": "tsc",
    "dev": "tsc --watch",
    "start": "node dist/cli.js serve",
    "lint": "eslint src/",
    "test": "vitest"
  },
  "dependencies": {
    "@modelcontextprotocol/sdk": "^1.0.0",
    "commander": "^12.0.0",
    "fast-xml-parser": "^4.0.0",
    "proper-lockfile": "^4.1.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@types/proper-lockfile": "^4.1.0",
    "typescript": "^5.5.0",
    "vitest": "^2.0.0",
    "eslint": "^9.0.0"
  },
  "engines": {
    "node": ">=20.0.0"
  },
  "files": [
    "dist/",
    "bin/"
  ],
  "keywords": [
    "mcp",
    "pentest",
    "security",
    "opencode",
    "nyx",
    "penetration-testing",
    "findings",
    "engagement"
  ],
  "license": "MIT"
}
```

### 11.4 Entrypoint Detection

The single `nyx-memory` binary handles both MCP and CLI modes. Detection is straightforward:

```typescript
// src/cli.ts
#!/usr/bin/env node

import { program } from "commander";
import { startMcpServer } from "./serve.js";
import { logCommand } from "./commands/log.js";
import { ingestCommand } from "./commands/ingest.js";
// ... other commands

program
  .name("nyx-memory")
  .description("Penetration testing engagement memory — MCP server & CLI")
  .version("1.0.0");

program
  .command("serve")
  .description("Start the MCP server (stdio transport)")
  .action(startMcpServer);

program
  .command("log")
  .description("Read stdin and save as evidence to the active engagement")
  .option("--tool <name>", "Tool name")
  .option("--target <host>", "Target host/IP")
  .option("--command <cmd>", "Full command string")
  .option("--started-at <ts>", "ISO 8601 start timestamp")
  .option("--duration <sec>", "Duration in seconds", parseInt)
  .option("--exit-code <code>", "Command exit code", parseInt)
  .option("--filename <name>", "Override evidence filename")
  .option("--no-parse", "Skip auto-parsing")
  .action(logCommand);

program
  .command("ingest")
  .description("Parse structured tool output and extract data")
  .requiredOption("--tool <name>", "Tool name (must have a parser)")
  .requiredOption("--file <path>", "Path to output file")
  .option("--target <host>", "Override target host")
  .action(ingestCommand);

program.command("status").description("Print engagement status").action(/* ... */);
program.command("list").description("List all engagements").action(/* ... */);
program.command("create").description("Create a new engagement").action(/* ... */);

program.parse();
```

When OpenCode calls `nyx-memory serve`, it enters MCP mode and communicates via stdin/stdout JSON-RPC. When the user or `nyx-log` calls `nyx-memory log`, it reads from stdin and writes to disk. Same binary, branching at the top level.

### 11.5 Installation Methods

| Method | Command | Use Case |
|--------|---------|----------|
| **Global install** | `npm install -g nyx-memory` | Nyx VM setup (fastest startup, nyx-log works immediately) |
| **npx (no install)** | `npx -y nyx-memory serve` | Quick trial, adding to any OpenCode project |
| **From source** | `git clone ... && npm install && npm run build && npm link` | Development, customization |
| **In Nyx VM** | Handled by `guest.sh` during `setup.sh` | Automated provisioning (user never runs this manually) |

### 11.6 Why TypeScript

- **MCP-native.** The official MCP SDK is TypeScript-first. The JSON-RPC transport, tool registration, and type system work naturally.
- **Stdio handling.** Node.js handles `process.stdin` streaming cleanly for both MCP mode (JSON-RPC over stdio) and CLI mode (`nyx-memory log` reading piped output).
- **Dual-mode entrypoint.** Trivial to detect `serve` vs. CLI subcommands and branch. No framework overhead.
- **Minimal dependencies.** Markdown rendering is just string concatenation with template literals — no template engine needed. JSON is native. Filesystem ops are built-in.
- **Easy distribution.** `npm install -g` or `npx` works everywhere Node.js is installed. No virtualenvs, no dependency conflicts, no `pip` breakage. Kali Linux ships Node.js.
- **Optional: single binary.** For environments without Node.js, the package can be compiled to a standalone binary using `bun build --compile` or `pkg`. This produces a single `nyx-memory` executable with zero runtime dependencies.
