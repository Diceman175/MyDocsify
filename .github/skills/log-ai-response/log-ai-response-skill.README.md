---
title: "log-ai-response Skill README"
description: "Comprehensive guide to the log-ai-response VS Code agent skill — purpose, architecture, invocation, and slot detection logic"
author: "Steven Paradise"
filename: "log-ai-response-skill.README.md"
schema_version: "2.0.0"
version: "0.3.0"
date: "2026-05-03"
lastmod: "2026-05-03"
---

# log-ai-response Skill README

> **Summary:** This guide explains the `log-ai-response` VS Code agent skill — what it does, how it works, when to invoke it, and how slot detection works.

---

## Changelog

- version: "0.3.0"
  date: 2026-05-03
  author: Steven Paradise
  changes:
    - CHG: Bumped version to align with skill 0.3.0 release
    - CHG: Updated description to remove stale prompt file reference
    - CHG: Removed "Skill vs. Prompt File" comparison table (prompt file deleted)
    - CHG: Updated WHY section to reflect skill as sole canonical implementation
    - CHG: Updated all filename, placeholder, and heading references throughout

- version: "0.2.0"
  date: 2026-05-03
  author: Steven Paradise
  changes:
    - CHG: Updated all filename references from `conversational-ai-copilot.md` to `conversational-ai.md`
    - CHG: Updated slot detection placeholder to single-line `<!-- AI Response HERE: include **Markdown**, code blocks, lists, images -->`
    - CHG: Updated heading rename target to `🤖 GitHub Copilot AI-Responded NN`
    - CHG: Updated prompt block description — now overwrites all content including `<summary>` with 3–15 word summary
    - DEL: Removed references to companion prompt file (`.github/prompts/log-ai-response.md` deleted)

- version: "0.3.0"
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
| **Output Target**   | `docs/YYYY-MM-DD_conversational-ai.md`                                                  |
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
| **Session log template**    | `_templates/template-md-with-metadata-conversational-ai-essential.md`            |
| **Output folder**           | `docs/`                                                                           |
| **Output naming pattern**   | `docs/YYYY-MM-DD_conversational-ai.md`                                            |

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
2. Locates or creates the session log file for today (`docs/YYYY-MM-DD_conversational-ai.md`).
   3. If the file is new, creates it from the project template and populates the YAML frontmatter.
   4. Scans the file for the first unfilled prompt/response slot pair.
   5. Writes the most recent user prompt into the `### 🗣️ Prompt NN` block, replacing all content including the `<summary>` with a 3–15 word summary.
   6. Writes the most recent Copilot response into the `### 🤖 AI Response NN` block.
   7. Renames the filled heading to `### 🤖 GitHub Copilot AI-Responded NN`.
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
└── 2026-05-03_conversational-ai.md
```

The naming convention:

| Component  | Value                               |
|------------|-------------------------------------|
| Prefix     | `YYYY-MM-DD` (today's ISO date)     |
| Suffix     | `_conversational-ai`                |
| Extension  | `.md`                               |
| Example    | `2026-05-03_conversational-ai.md`   |

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

The `log-ai-response` skill is the canonical implementation. The original companion prompt file (`.github/prompts/log-ai-response.md`) has been removed now that the skill is fully established.

| Aspect                    | Skill (`SKILL.md`)                                            |
|---------------------------|---------------------------------------------------------------|
| **Invocation**            | `/log-ai-response` (slash command in agent mode)              |
| **Auto-loading**          | Yes — Copilot may load the skill automatically when relevant  |
| **Discovery**             | Via `description` field — keyword matching                    |
| **Mode requirement**      | Agent mode (skill always runs in agent context)               |
| **Tool restriction**      | All agent tools available by default                          |
| **Bundled assets**        | Can include `references/` and `assets/` sub-folders           |
| **Best for**              | Repeatable multi-step workflows with possible asset needs     |

---

### HOW — How is the skill invoked and what happens step by step?

#### Invocation

Type `/log-ai-response` in the Copilot Chat panel while in agent mode. The skill body loads automatically and Copilot executes the steps.

Alternatively, if Copilot recognizes a logging intent from your natural language ("log this", "save this conversation", "record the response"), it may auto-load the skill from its description without an explicit `/` command.

#### Step-by-step execution

| Step | Action |
|------|--------|
| 1 | Determine today's date in `YYYY-MM-DD` format from conversation context |
| 2 | Build target path: `docs/YYYY-MM-DD_conversational-ai.md` |
| 3 | Check whether that file exists (`file_search`) |
| 4a | **File not found:** Read template → create file → update 7 frontmatter fields |
| 4b | **File found:** Proceed to step 5 |
| 5 | Read the target file |
| 6 | Scan for the first `### 🤖 AI Response NN` block with unfilled placeholder |
| 7 | Identify matching `### 🗣️ Prompt NN` block immediately above |
| 8 | Replace ALL content in prompt block; set `<summary>` to 3–15 word summary; write user prompt verbatim as body |
| 9 | Replace response placeholder with most recent Copilot response (full Markdown) |
| 10 | Rename heading: `AI Response NN` → `GitHub Copilot AI-Responded NN` |
| 11 | Confirm: `Logged to [filename] — Prompt NN / GitHub Copilot AI-Responded NN.` |

#### Slot detection logic

The skill identifies an empty slot by scanning for this exact line inside a `<details>` element:

```html
<!-- AI Response HERE: include **Markdown**, code blocks, lists, images -->
```

Empty slots have the heading `### 🤖 AI Response NN`. After writing, the heading becomes `### 🤖 GitHub Copilot AI-Responded NN`. This naming convention makes it trivial to scan a log file and distinguish filled entries from empty ones — and ensures the skill never overwrites a previously logged entry.

#### Frontmatter fields populated on new file creation

| Field        | Value written                                         |
|--------------|-------------------------------------------------------|
| `title`      | `"Conversational AI Session Log"`                     |
| `author`     | `"Steven Paradise"`                                   |
| `filename`   | e.g. `"2026-05-03_conversational-ai.md"`              |
| `date`       | today's date, e.g. `"2026-05-03"`                     |
| `lastmod`    | today's date, e.g. `"2026-05-03"`                     |
| `model`      | `"claude-sonnet-4-6"`                                 |
| `session_id` | e.g. `"sess-20260503-1430-local"`                     |

---

---

## Analysis & Assessment

### Benefits

- **Zero-friction logging.** One `/log-ai-response` invocation captures both sides of a conversation into a structured, dated Markdown file. No copy-paste, no manual formatting.
- **Persistent audit trail.** Every session log is a plain Markdown file in the `docs/` folder, committed to the repository — searchable with standard grep and readable without special tooling.
- **Template-driven consistency.** All log files share the same collapsible structure, making them easy to scan, compare, and review across sessions.
- **Auto-discovery.** The skill can be auto-loaded by Copilot based on intent keywords in the `description` field — no need to remember the exact invocation.
- **Executable documentation.** The `SKILL.md` body is the documentation for the workflow. Any team member can read it and immediately understand what the skill does.
- **No external dependencies.** No scripts, no services, no CI pipeline changes required.
- **Version-controlled governance.** The skill file lives in `.github/skills/`, subject to the same pull request review process as any code change.

### Limitations & Risks

- **Manual trigger required.** The skill only runs when invoked (or when Copilot auto-loads it from intent matching). Exchanges you forget to log will not be captured.
- **Context window dependency.** Copilot identifies "the most recent prompt and response" from its active conversation context. In very long conversations, earlier context may have been evicted. **Best practice: invoke immediately after the exchange you want to log.**
- **One file per calendar day.** All exchanges in a single day write into one file. High-volume sessions may produce large files. If per-session isolation is needed, the naming convention would need a time component.
- **Placeholder pattern dependency.** Slot detection relies on the exact single-line placeholder comment `<!-- AI Response HERE: include **Markdown**, code blocks, lists, images -->` remaining unchanged in the template. If the template is edited and the placeholder text changes, the skill will not find empty slots. The placeholder string must remain stable across template versions.
- **19-slot limit per day.** The template ships with 19 prompt/response pairs. If a session exceeds 19 exchanges, manually copy the `xx` template block at the bottom of the log file before invoking again.
- **No post-write validation.** The skill does not verify that written content matches expectations. For audit-critical use, a human review of the log file is advisable.

### Adoption Considerations

- New team members need only read `SKILL.md` to understand what `/log-ai-response` does. The instructions are human-readable numbered prose — no prerequisite beyond basic Markdown familiarity.
- The pattern generalizes. Once comfortable with `log-ai-response`, authoring new skills for other repeatable workflows (adding work item types, scaffolding TSDF products) follows the same structure.
- Consider adding a note to `CHANGELOG.md` or `README.md` that `/log-ai-response` is available, so team members discover it without browsing `.github/skills/`.

---

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| `/log-ai-response` not recognized | Skill not yet discovered | Reload VS Code window: `Ctrl+Shift+P` → **Developer: Reload Window** |
| Skill invokes but writes to wrong file | Date derived incorrectly | Verify the current date in context and confirm the file path matches |
| No empty slot found / nothing written | All 19 slots in today's file are already filled | Copy the `xx` template block at the bottom of the log file to add more slots, then retry |
| Slot overwritten (existing content replaced) | Placeholder comment line was partially edited but not fully removed | Ensure filled slots have no placeholder comment line remaining — the detector requires the exact single-line placeholder |
| File not created in `docs/` | `docs/` folder does not exist | Run `New-Item -ItemType Directory -Path "docs" -Force`, then retry |
| Frontmatter not updated on new file | Template frontmatter field names changed | Verify the template file's frontmatter uses: `title`, `author`, `filename`, `date`, `lastmod`, `model`, `session_id` |
| Response content missing or truncated | Conversation context exceeded before logging | Log exchanges immediately after receiving them, before the conversation grows longer |
| Copilot logs the wrong exchange | Invoked too late in a long conversation | Scroll up to verify which exchange will be captured; consider logging after each significant exchange |

---

## Rollback / Undo

- **Undo a logged entry:** Open the log file, find the filled slot, restore the original placeholder line `<!-- AI Response HERE: include **Markdown**, code blocks, lists, images -->` manually, and rename the heading back from `GitHub Copilot AI-Responded NN` to `AI Response NN`.
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
- Project session log template: `_templates/template-md-with-metadata-conversational-ai-essential.md`
- Original prompt file (archived): `My-Engineering-Cockpit/Projects/Conversational-AI-Copilot.ARCHIVE/conversational-ai-copilot_0.1.0_(2026-05-02)/log-ai-response.prompt.md`
