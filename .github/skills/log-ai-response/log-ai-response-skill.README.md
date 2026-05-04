---
title: "log-ai-response Skill README"
description: "Comprehensive guide to the log-ai-response VS Code agent skill — purpose, architecture, invocation, slot detection logic, comparison with the prompt file version, and troubleshooting"
author: "Steven Paradise"
filename: "log-ai-response-skill.README.md"
schema_version: "2.0.0"
version: "0.1.0"
date: "2026-05-03"
lastmod: "2026-05-03"
---

# log-ai-response Skill README

> **Summary:** This guide explains the `log-ai-response` VS Code agent skill — what it does, how it works, when to invoke it, and how it differs from the companion `.prompt.md` version. The skill captures the most recent user prompt and Copilot response and writes both into a structured, dated Markdown log file.

---

## Changelog

- version: "0.1.0"
  date: 2026-05-03
  author: Steven Paradise
  changes:
    - IMP: Initial document creation for log-ai-response skill

---

## Quick Info

| Field              | Value                                                    |
|--------------------|----------------------------------------------------------|
| **Status**         | Active                                                   |
| **Estimated Time** | 15–30 minutes to read and verify setup                   |
| **Skill Level**    | Beginner (basic familiarity with VS Code Copilot Chat)   |

---

## Environment

| Component           | Detail                                                                                  |
|---------------------|-----------------------------------------------------------------------------------------|
| **Platform**        | GitHub Copilot agent mode in VS Code                                                    |
| **Skill File**      | `.github/skills/log-ai-response/SKILL.md`                                               |
| **Invocation**      | `/log-ai-response` in Copilot Chat (agent mode)                                         |
| **Output Target**   | `docs/YYYY-MM-DD_conversational-ai-copilot.md`                                          |
| **Template Source** | `_templates/template-md-with-metadata-conversational-ai-essential.md`                  |
| **Tooling**         | VS Code with GitHub Copilot Chat extension                                              |
| **Audience**        | Technical engineers using Copilot agent mode for AI-assisted development workflows      |

---

## Prerequisites

- [ ] GitHub Copilot Chat extension installed and active in VS Code
- [ ] VS Code opened at the project root (`My-Jira-Prompt-Builder/`)
- [ ] `_templates/template-md-with-metadata-conversational-ai-essential.md` exists
- [ ] `docs/` folder exists (create with `New-Item -ItemType Directory -Path "docs" -Force` if needed)
- [ ] Copilot agent mode enabled (not restricted by enterprise policy)

---

## Key Paths & References

| Item                        | Path                                                                              |
|-----------------------------|-----------------------------------------------------------------------------------|
| **Skill file**              | `.github/skills/log-ai-response/SKILL.md`                                         |
| **This README**             | `.github/skills/log-ai-response/log-ai-response-skill.README.md`                  |
| **Companion prompt file**   | `.github/prompts/log-ai-response.md`                                              |
| **Session log template**    | `_templates/template-md-with-metadata-conversational-ai-essential.md`            |
| **Output folder**           | `docs/`                                                                           |
| **Output naming pattern**   | `docs/YYYY-MM-DD_conversational-ai-copilot.md`                                    |

---

## 5W1H Overview

---

### WHO — Who uses the log-ai-response skill?

- **Individual developers** working in Copilot agent mode who want to preserve a structured record of their AI-assisted sessions without manual copy-paste.
- **Team leads** who want session logs committed to the repository as part of the project's audit trail.
- **Any team member** who works in this repository and wants to document the AI exchanges that informed a decision, design, or implementation.

---

### WHAT — What is the log-ai-response skill?

The `log-ai-response` skill is a VS Code **agent skill** — a `SKILL.md` file stored in `.github/skills/log-ai-response/` that packages a repeatable, multi-step workflow into a single invocation.

When invoked, it:

1. Determines today's date.
2. Locates or creates the session log file for today (`docs/YYYY-MM-DD_conversational-ai-copilot.md`).
3. If the file is new, creates it from the project template and populates the YAML frontmatter.
4. Scans the file for the first unfilled prompt/response slot pair.
5. Writes the most recent user prompt into the `### 🗣️ Prompt NN` block.
6. Writes the most recent Copilot response into the `### 🤖 AI Response NN` block.
7. Renames the filled heading to `### 🤖 AI-Responded NN`.
8. Confirms with a one-line summary.

#### Anatomy of the SKILL.md file

```
.github/skills/log-ai-response/
├── SKILL.md                          ← Required — skill name must match folder
└── log-ai-response-skill.README.md   ← This file — extended documentation
```

The `SKILL.md` frontmatter:

```yaml
---
name: log-ai-response
description: 'Log the most recent user prompt and Copilot response into today''s session log file. Use when: logging a conversation, capturing session, recording AI response, session log, log prompt, log response, save conversation, document exchange, save chat.'
argument-hint: 'Optional: description of what exchange to log (defaults to most recent)'
---
```

**Key frontmatter fields:**

| Field            | Purpose                                                                                        |
|------------------|------------------------------------------------------------------------------------------------|
| `name`           | Must exactly match the folder name. Used for discovery and `/` slash command registration.     |
| `description`    | The primary discovery surface — Copilot reads this to decide whether the skill is relevant.   |
| `argument-hint`  | Hint text shown when the user types `/log-ai-response` in chat.                               |

---

### WHERE — Where does the skill live and where does it write?

#### Skill location

```
<project-root>/
└── .github/
    └── skills/
        └── log-ai-response/
            ├── SKILL.md
            └── log-ai-response-skill.README.md
```

This is a **project-scoped** skill. It is checked into the repository and available to anyone who opens this project in VS Code with Copilot agent mode.

#### Output location

All session logs are written to the `docs/` folder, one file per calendar day:

```
docs/
└── 2026-05-03_conversational-ai-copilot.md
```

The naming convention:

| Component  | Value                                     |
|------------|-------------------------------------------|
| Prefix     | `YYYY-MM-DD` (today's ISO date)           |
| Middle     | `_conversational-ai`                      |
| Suffix     | `-copilot`                                |
| Extension  | `.md`                                     |
| Example    | `2026-05-03_conversational-ai-copilot.md` |

---

### WHEN — When should the skill be invoked?

**Invoke immediately** after an exchange you want to preserve. The skill captures the most recent prompt and response from the active conversation context. If the conversation has grown long before you invoke, an earlier exchange may be captured instead.

**Use this skill when:**

- You want a permanent, searchable record of a Copilot exchange.
- A conversation informed an architectural decision, implementation choice, or recommendation worth auditing.
- You are building a library of effective prompts and responses for future reference.
- A team member should be able to review what AI-assisted reasoning produced a particular output.

**When NOT to invoke:**

- When the exchange is trivial and not worth preserving.
- When the conversation context is very long and you are unsure which exchange will be captured (scroll up and verify before invoking).
- When all 19 template slots are already filled — manually extend the log file first using the `xx` copy-paste block at the bottom of the file.

---

### WHY — Why use a skill rather than a prompt file?

Both the skill and the companion `.github/prompts/log-ai-response.md` perform the same logging workflow. The difference is *how Copilot discovers and loads them*.

| Aspect                    | Skill (`SKILL.md`)                                        | Prompt file (`.prompt.md`)                                 |
|---------------------------|-----------------------------------------------------------|------------------------------------------------------------|
| **Invocation**            | `/log-ai-response` (slash command in agent mode)          | `#log-ai-response` (file reference in any mode)            |
| **Auto-loading**          | Yes — Copilot may load the skill automatically when relevant | No — explicit reference always required                  |
| **Discovery**             | Via `description` field — keyword matching                | Via file name — exact `#` reference                        |
| **Mode requirement**      | Agent mode (skill always runs in agent context)           | Must specify `mode: agent` in frontmatter                  |
| **Tool restriction**      | All agent tools available by default                      | Restricted to `tools` array in frontmatter                 |
| **Bundled assets**        | Can include `references/` and `assets/` sub-folders       | Single file only                                           |
| **Best for**              | Repeatable multi-step workflows with possible asset needs | Focused single-task invocations                            |

**Why both exist in this project:**

The skill and the prompt file are intentionally parallel. The skill is the canonical implementation; the prompt file provides `#log-ai-response` as a quick fallback for non-agent chat modes and as a reference for users who are more familiar with `#` file references than `/` slash commands.

---

### HOW — How is the skill invoked and what happens step by step?

#### Invocation

Type `/log-ai-response` in the Copilot Chat panel while in agent mode. The skill body loads automatically and Copilot executes the steps.

Alternatively, if Copilot recognizes a logging intent from your natural language ("log this", "save this conversation", "record the response"), it may auto-load the skill from its description without an explicit `/` command.

#### Step-by-step execution

| Step | Action |
|------|--------|
| 1 | Determine today's date in `YYYY-MM-DD` format from conversation context |
| 2 | Build target path: `docs/YYYY-MM-DD_conversational-ai-copilot.md` |
| 3 | Check whether that file exists (`file_search`) |
| 4a | **File not found:** Read template → create file → update 7 frontmatter fields |
| 4b | **File found:** Proceed to step 5 |
| 5 | Read the target file |
| 6 | Scan for the first `### 🤖 AI Response NN` block with unfilled placeholder |
| 7 | Identify matching `### 🗣️ Prompt NN` block immediately above |
| 8 | Replace prompt placeholder with most recent user prompt (verbatim) |
| 9 | Replace response placeholder with most recent Copilot response (full Markdown) |
| 10 | Rename heading: `AI Response NN` → `AI-Responded NN` |
| 11 | Confirm: `Logged to [filename] — Prompt NN / AI-Responded NN.` |

#### Slot detection logic

The skill identifies an empty slot by scanning for this exact two-line block inside a `<details>` element:

```html
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
```

Empty slots have the heading `### 🤖 AI Response NN`. After writing, the heading becomes `### 🤖 AI-Responded NN`. This naming convention makes it trivial to scan a log file and distinguish filled entries from empty ones — and ensures the skill never overwrites a previously logged entry.

#### Frontmatter fields populated on new file creation

| Field        | Value written                                         |
|--------------|-------------------------------------------------------|
| `title`      | `"Conversational AI Session Log"`                     |
| `author`     | `"Steven Paradise"`                                   |
| `filename`   | e.g. `"2026-05-03_conversational-ai-copilot.md"`      |
| `date`       | today's date, e.g. `"2026-05-03"`                     |
| `lastmod`    | today's date, e.g. `"2026-05-03"`                     |
| `model`      | `"claude-sonnet-4-6"`                                 |
| `session_id` | e.g. `"sess-20260503-1430-local"`                     |

---

## Skill vs. Prompt File — Full Comparison

| Aspect                       | Skill (`/log-ai-response`)               | Prompt File (`#log-ai-response`)          |
|------------------------------|------------------------------------------|-------------------------------------------|
| File location                | `.github/skills/log-ai-response/SKILL.md`| `.github/prompts/log-ai-response.md`      |
| Invocation syntax            | `/log-ai-response`                       | `#log-ai-response` or Chat: Run Prompt    |
| Auto-load by model           | Yes (from description keywords)          | No — always explicit                      |
| Mode                         | Agent (inherent)                         | `mode: agent` declared in frontmatter     |
| Tool access                  | All agent tools                          | Restricted to `tools` list in frontmatter |
| Output filename suffix       | `-copilot`                               | `-copilot`                                |
| Window reload on first use   | No                                       | Yes — once after file creation            |
| Can bundle additional assets | Yes (`references/`, `assets/`)           | No — single file                          |

---

## Analysis & Assessment

### Benefits

- **Zero-friction logging.** One `/log-ai-response` invocation captures both sides of a conversation into a structured, dated Markdown file. No copy-paste, no manual formatting.
- **Persistent audit trail.** Every session log is a plain Markdown file in the `docs/` folder, committed to the repository — searchable with standard grep and readable without special tooling.
- **Template-driven consistency.** All log files share the same collapsible structure, making them easy to scan, compare, and review across sessions.
- **Auto-discovery.** Unlike the prompt file, the skill can be auto-loaded by Copilot based on intent keywords in the `description` field — no need to remember the exact invocation.
- **Executable documentation.** The `SKILL.md` body is the documentation for the workflow. Any team member can read it and immediately understand what the skill does.
- **No external dependencies.** No scripts, no services, no CI pipeline changes required.
- **Version-controlled governance.** The skill file lives in `.github/skills/`, subject to the same pull request review process as any code change.

### Limitations & Risks

- **Manual trigger required.** The skill only runs when invoked (or when Copilot auto-loads it from intent matching). Exchanges you forget to log will not be captured.
- **Context window dependency.** Copilot identifies "the most recent prompt and response" from its active conversation context. In very long conversations, earlier context may have been evicted. **Best practice: invoke immediately after the exchange you want to log.**
- **One file per calendar day.** All exchanges in a single day write into one file. High-volume sessions may produce large files. If per-session isolation is needed, the naming convention would need a time component.
- **Placeholder pattern dependency.** Slot detection relies on the exact two-line placeholder comment remaining unchanged in the template. If the template is edited and the placeholder text changes, the skill will not find empty slots. The placeholder strings must remain stable across template versions.
- **19-slot limit per day.** The template ships with 19 prompt/response pairs. If a session exceeds 19 exchanges, manually copy the `xx` template block at the bottom of the log file before invoking again.
- **No post-write validation.** The skill does not verify that written content matches expectations. For audit-critical use, a human review of the log file is advisable.

### Adoption Considerations

- New team members need only read `SKILL.md` to understand what `/log-ai-response` does. The instructions are human-readable numbered prose — no prerequisite beyond basic Markdown familiarity.
- Both the skill and the companion prompt file can coexist. Users who prefer `#` references can use the prompt file; users in agent mode can use `/log-ai-response`.
- The pattern generalizes. Once comfortable with `log-ai-response`, authoring new skills for other repeatable workflows (adding work item types, scaffolding TSDF products) follows the same structure.
- Consider adding a note to `CHANGELOG.md` or `README.md` that `/log-ai-response` is available, so team members discover it without browsing `.github/skills/`.

---

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| `/log-ai-response` not recognized | Skill not yet discovered | Reload VS Code window: `Ctrl+Shift+P` → **Developer: Reload Window** |
| Skill invokes but writes to wrong file | Date derived incorrectly | Verify the current date in context and confirm the file path matches |
| No empty slot found / nothing written | All 19 slots in today's file are already filled | Copy the `xx` template block at the bottom of the log file to add more slots, then retry |
| Slot overwritten (existing content replaced) | Placeholder comment lines were partially edited but not fully removed | Ensure filled slots have no placeholder comment lines remaining — the detector requires both lines exactly |
| File not created in `docs/` | `docs/` folder does not exist | Run `New-Item -ItemType Directory -Path "docs" -Force`, then retry |
| Frontmatter not updated on new file | Template frontmatter field names changed | Verify the template file's frontmatter uses: `title`, `author`, `filename`, `date`, `lastmod`, `model`, `session_id` |
| Response content missing or truncated | Conversation context exceeded before logging | Log exchanges immediately after receiving them, before the conversation grows longer |
| Copilot logs the wrong exchange | Invoked too late in a long conversation | Scroll up to verify which exchange will be captured; consider logging after each significant exchange |

---

## Rollback / Undo

- **Undo a logged entry:** Open the log file, find the filled slot, restore the original two-line placeholder comment block manually, and rename the heading back from `AI-Responded NN` to `AI Response NN`.
- **Revert skill behavior:** Restore the previous version of `SKILL.md` from git history:
  ```powershell
  git checkout HEAD~1 -- .github/skills/log-ai-response/SKILL.md
  ```
- **Disable the skill:** Rename the folder or add `disable-model-invocation: true` to the `SKILL.md` frontmatter to prevent auto-loading while keeping the file available for explicit `/` invocation.
- **Remove the skill entirely:** Delete `.github/skills/log-ai-response/`. The `/log-ai-response` command will no longer be recognized after the next VS Code reload.

---

## References

- VS Code documentation — Agent Skills: `https://code.visualstudio.com/docs/copilot/customization/agent-skills`
- VS Code documentation — Customizing Copilot in VS Code: `https://code.visualstudio.com/docs/copilot/copilot-customization`
- VS Code documentation — Chat modes: `https://code.visualstudio.com/docs/copilot/chat/chat-modes`
- HTML `<details>` / `<summary>` element (MDN): `https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details`
- SemVer 2.0.0: `https://semver.org/`
- Project skill file: `.github/skills/log-ai-response/SKILL.md`
- Companion prompt file: `.github/prompts/log-ai-response.md`
- Project session log template: `_templates/template-md-with-metadata-conversational-ai-essential.md`
- Companion README (prompt file version): `My-Engineering-Cockpit/Projects/Conversational-AI-Copilot/conversational-ai-copilot.README.md`
