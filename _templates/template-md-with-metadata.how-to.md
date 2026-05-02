---
title:          "How to: project installation and configuration documentation"
description:    "Longer description of the documentation"
author:         "Your Name"
schema_version: "1.0.0"
version:        "0.3.0"
filename:       "template-md-with-metadata-how-to.md"
date:           "YYYY-MM-DD"
lastmod:        "YYYY-MM-DD"
---

<!-- ============================================================
METADATA
  filename:      template-md-with-metadata-how-to.md
  version:       0.3.0
============================================================ -->

<!-- ============================================================
CHANGELOG
  - version: "0.3.0"
    date: 2026-04-27
    author: Steven Paradise
    changes:
      - IMP: Added Environment table (OS/Platform, Hardware, Software, Network)
      - IMP: Added Quick Info table (Status, Estimated Time, Skill Level)
      - IMP: Added Key Paths and References table with Docker Compose row
      - IMP: Added structured Steps section with code block, warning, and expected result placeholders
      - IMP: Added Verification section with expected output block
      - IMP: Added Troubleshooting table
      - IMP: Added Rollback / Undo section
      - IMP: Added Related Documents section
      - IMP: Added Conventions reference table
      - IMP: Added one-line summary blockquote under H1
      - CHG: Replaced bare Content/Example/Configuration/Data Examples sections with home-user-focused scaffold
  - version: "0.2.0"
    date: 2026-04-26
    author: Steven Paradise
    changes:
      - CHG: Renamed authorname to author, created to date, last_updated to lastmod
      - IMP: Added schema_version field at required position 4
      - FIX: Corrected frontmatter field order to match required_order
      - FIX: Removed non-spec change history field from YAML frontmatter
      - IMP: Added METADATA and CHANGELOG HTML comment blocks for dual-location version sync
      - FIX: Quoted version placeholder value in frontmatter
      - FIX: Corrected field names in body Metadata section to canonical names
      - IMP: Expanded Instructions block with schema_version and version bump guidance
  - version: "0.1.0"
    date: YYYY-MM-DD
    author: Your Name
    changes:
      - IMP: Initial how-to template created with metadata
============================================================ -->

# HOW-TO: [Task Title]

> **Summary:** [One-line description of what this guide helps you accomplish]

---

## Quick Info

| Field              | Value                                          |
|--------------------|------------------------------------------------|
| **Status**         | Draft · Published · Outdated                   |
| **Estimated Time** | ~XX minutes                                    |
| **Skill Level**    | Beginner · Intermediate · Advanced             |

---

## Environment

| Component         | Detail                                              |
|-------------------|-----------------------------------------------------|
| **OS / Platform** | [e.g., DSM 7.2, Windows 11, Ubuntu 24.04]           |
| **Hardware**      | [e.g., Synology DS920+, Raspberry Pi 5, ASUS Router] |
| **Software**      | [e.g., Docker Compose 2.x, Container Manager 24.0]  |
| **Network**       | [e.g., LAN only · Reverse proxy via Nginx · VPN]    |

---

## Introduction

<!-- 2–4 sentences. What problem does this solve? When would you reach for this guide?
     Keep it concrete: "This guide walks you through X so that Y." -->

---

## Prerequisites

- [ ] [Software / hardware / access requirement]
- [ ] [Specific version or configuration needed]
- [ ] [Network access, credentials, or port forwarding required]
- [ ] [Backup or snapshot completed (if applicable)]

---

## Key Paths & References

| Item                | Value                              |
|---------------------|------------------------------------|
| **Config file**     | `/path/to/config`                  |
| **Data directory**  | `/path/to/data/`                   |
| **Web UI**          | `http://<HOST_IP>:<PORT>`          |
| **Logs**            | `<command or UI path to view logs>`|
| **Docker Compose**  | `/path/to/docker-compose.yml`      |

---

## Steps

### Step 1: [Action Title]

[Explain what to do and why.]

```bash
# example command
some-command --flag <PLACEHOLDER>
```

> ⚠️ **Warning:** [Describe any destructive or irreversible action here — delete this line if not applicable]

**Expected result:** [What you should see or what changes after this step.]

---

### Step 2: [Action Title]

[Explain what to do and why.]

**Expected result:** [What you should see.]

---

<!-- Copy and paste a Step block above for each additional step needed -->

---

## Verification

[How to confirm the entire procedure worked end-to-end.]

```bash
# verification command
some-check-command
```

**Expected output:**

```
[Paste or describe what success looks like here]
```

---

## Troubleshooting

| Symptom                      | Likely Cause          | Fix                           |
|------------------------------|-----------------------|-------------------------------|
| [Error message or behavior]  | [Why it happens]      | [What to do]                  |
| [Error message or behavior]  | [Why it happens]      | [What to do]                  |

---

## Rollback / Undo

<!-- How to revert to the previous state if something goes wrong.
     Include specific commands or UI steps. Omit this section if not applicable. -->

---

## Related Documents

- [Related HOW-TO or guide title](link)
- [Vendor / official documentation](link)

---

## Conventions

| Convention         | Meaning                                   |
|--------------------|-------------------------------------------|
| `monospace`        | Commands, file paths, code                |
| `<PLACEHOLDER>`    | Replace with your own value               |
| **Bold**           | UI elements (buttons, menu items)         |
| ⚠️ **Warning**     | Destructive or irreversible action        |
| ℹ️ **Note**        | Supplemental info, not critical           |
| ✅ / ❌            | Expected success / failure indicators     |

---

<!-- ============================================================
  Instructions
  ============================================================
- Copy this file and rename it using the naming convention:
    how-to-[task-name].md  (e.g., how-to-install-portainer.md)
- Update the YAML frontmatter with your details:
    title, description, author, version, filename, date, lastmod
    schema_version tracks the metadata standard version (default: 1.0.0)
- Fill in the Quick Info and Environment tables first — these help
  an AI assistant populate Steps, Verification, and Troubleshooting
- Delete any sections that do not apply (e.g., Docker Compose row
  in Key Paths if not a container task)
- Update the CHANGELOG block with each revision using change codes
    Valid codes: BRK CFG CHG DEL DEP DOC FIX IMP OPS REF SEC TST WIP
    Keep the most recent changelog entries at the top
- Version bump rule: update version in BOTH the YAML frontmatter AND
  the METADATA comment block — they must always match

AI POPULATION HINT:
  Provide this file to an AI assistant with the Environment and
  Prerequisites sections filled in. The AI can research and populate:
    - Steps (installation and configuration commands)
    - Key Paths & References (default paths for the software/device)
    - Verification (standard health-check commands)
    - Troubleshooting (common errors for the platform/software)

============================================================ -->

