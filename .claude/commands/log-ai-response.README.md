---
title: "Claude Code Custom Slash Commands README"
description: "Comprehensive guide to creating, managing, and using custom slash commands in Claude Code for VS Code, including the log-ai-response command"
author: "Steven Paradise"
filename: "log-ai-response.README.md"
schema_version: "2.0.0"
version: "0.3.0"
date: "2026-05-02"
lastmod: "2026-05-03"
---

# Claude Code Custom Slash Commands README

> **Summary:** This guide explains what custom slash commands are in Claude Code, how to create them at the project or global level, when and why to use them, and includes a reference implementation — the `log-ai-response` command — that automates session logging.

---

## Changelog

- version: "0.3.0"
  date: 2026-05-03
  author: Steven Paradise
  changes:
    - DOC: Updated step table — target filename drops `-claude` suffix; now `YYYY-MM-DD_conversational-ai.md`
    - DOC: Updated slot detection placeholder to match new command: `<!-- AI Response HERE: include **Markdown**, code blocks, lists, images -->`
    - DOC: Updated post-write heading rename to `Claude AI-Responded NN` (was `AI-Responded NN`)
    - DOC: Updated step 8 to document full `<details>` block replacement with 3–15 word prompt summary
    - DOC: Updated output file naming table — removed `-claude` suffix row
    - DOC: Updated usage examples to reflect `Claude AI-Responded` heading convention

- version: "0.2.0"
  date: 2026-05-02
  author: Steven Paradise
  changes:
    - UPD: Updated log-ai-response reference — added step 10 (heading rename AI Response → AI-Responded) and step 11 (updated confirmation message)
    - UPD: Updated step table, slot detection section, and usage examples to reflect AI-Responded heading convention

- version: "0.1.0"
  date: 2026-05-02
  author: Steven Paradise
  changes:
    - IMP: Initial document creation covering custom slash commands for Claude Code in VS Code

---

## Quick Info

| Field              | Value                                    |
|--------------------|------------------------------------------|
| **Status**         | Draft                                    |
| **Estimated Time** | 30–60 minutes to read and implement      |
| **Skill Level**    | Beginner to Intermediate (new to Claude) |

---

## Environment

| Component       | Detail                                                                         |
|-----------------|--------------------------------------------------------------------------------|
| **Platform**    | Claude Code CLI / VS Code Extension                                            |
| **Config File** | `.md` files in `.claude/commands/` (project) or `~/.claude/commands/` (global) |
| **Tooling**     | Any text editor; VS Code recommended                                           |
| **Audience**    | Technical engineers new to Claude Code                                         |

---

## Introduction

Claude Code supports **custom slash commands** — reusable, named instructions you type directly into the chat prompt. Instead of re-typing a complex multi-step instruction every session, you write it once as a Markdown file and invoke it with a short `/command-name` shortcut.

This guide covers the full lifecycle: what they are, where to put them, when to use them, why they matter, and how to build and maintain them — anchored with a concrete working example (`/log-ai-response`) built for this project.

---

## Prerequisites

- [ ] Claude Code installed (CLI or VS Code extension)
- [ ] A working project directory (git repository recommended)
- [ ] Basic familiarity with Markdown syntax
- [ ] VS Code or any text editor

---

## Key Paths & References

| Item                        | Path                                                                  |
|-----------------------------|-----------------------------------------------------------------------|
| **Project commands folder** | `<project-root>/.claude/commands/`                                    |
| **Global commands folder**  | `~/.claude/commands/` (Windows: `C:\Users\<you>\.claude\commands\`)   |
| **Project settings**        | `<project-root>/.claude/settings.json`                                |
| **Global settings**         | `~/.claude/settings.json`                                             |
| **log-ai-response command** | `.claude/commands/log-ai-response.md`                                 |
| **Session log template**    | `_templates/template-md-with-metadata-conversational-ai-essential.md` |

---

## 5W1H Overview

### WHO — Who creates, manages, and consumes custom slash commands?

- **Creators:** Developers, technical writers, and power users who identify repetitive workflows they want to automate.
- **Managers:** Project leads or platform owners who define team-wide commands checked into the repository.
- **Consumers:** Any team member or individual who types `/command-name` in a Claude Code session.
- **Audience for this guide:** Engineers who are new to Claude Code and want to build their first custom command.

---

### WHAT — What is a custom slash command?

A **custom slash command** is a plain Markdown (`.md`) file stored in a specific folder that Claude Code recognizes. When you type `/filename` in the Claude Code prompt, Claude reads that file's contents and executes the instructions written inside it — exactly as if you had typed those instructions yourself.

**Key characteristics:**

- **Name = filename.** A file named `log-ai-response.md` creates the `/log-ai-response` command.
- **Content = natural language instructions.** The file contains plain English (or structured Markdown) instructions telling Claude what to do step by step.
- **No code required.** You do not write scripts, functions, or configuration syntax — just prose instructions.
- **Reusable.** Run the same command any number of times across sessions.
- **Composable.** Commands can reference other files, templates, or patterns in your project.

**Anatomy of a command file:**

```markdown
<!-- .claude/commands/my-command.md -->

Brief one-line description of what this command does.

## Steps

1. First action Claude should take.
2. Second action, referencing `path/to/file.md` if needed.
3. Confirm result to the user.
```

The file has no required structure — Claude reads the whole file as its instruction. Headings and numbered lists are recommended for clarity and reliability.

---

### WHERE — Where are commands defined and managed?

There are two scopes for custom slash commands. Understanding the difference determines where your file should live.

#### Project-Scoped Commands (Recommended for team use)

**Location:** `<project-root>/.claude/commands/`

**Behavior:**
- Available only when Claude Code is opened in that project directory.
- Checked into version control alongside your code.
- Shared automatically with every team member who clones the repository.
- Ideal for project-specific workflows (generating Jira tickets, logging sessions, scaffolding files).

**Example — creating a project command:**

```
my-project/
├── .claude/
│   └── commands/
│       └── log-ai-response.md   ← project-scoped command
├── docs/
├── src/
└── ...
```

#### Global Commands (Personal, cross-project use)

**Location:**
- **macOS / Linux:** `~/.claude/commands/`
- **Windows:** `C:\Users\<YourName>\.claude\commands\`

**Behavior:**
- Available in every project you open with Claude Code.
- Not checked into any repository — personal to your machine.
- Ideal for personal productivity commands that apply regardless of project (e.g., formatting preferences, personal note-taking).

**Example — creating a global command on Windows:**

```
C:\Users\steve\.claude\
└── commands\
    └── my-global-command.md   ← global command
```

#### Choosing Between Project and Global

| Criterion                         | Project-Scoped | Global                      |
|-----------------------------------|----------------|-----------------------------|
| Shared with teammates             | Yes (via git)  | No                          |
| Available in all projects         | No             | Yes                         |
| References project-specific files | Yes            | Risky (paths may not exist) |
| Checked into version control      | Yes            | No                          |
| Best for                          | Team workflows | Personal productivity       |

> **Rule of thumb:** If the command references files or conventions specific to one repository, make it project-scoped. If it is a personal habit with no project dependencies, make it global.

---

### WHEN — When should custom slash commands be used?

**Use custom slash commands when:**

- You find yourself typing the same multi-step instruction more than twice.
- A workflow requires Claude to follow a precise sequence (check → create → edit → confirm).
- You want consistent, repeatable behavior across sessions without relying on memory.
- A team workflow should be version-controlled alongside the code it supports.
- You need to encode organizational conventions (naming patterns, template paths, metadata fields).

**Lifecycle considerations:**

- Commands are read fresh each time they are invoked — edit the `.md` file and the next invocation picks up the change immediately. No restart required.
- Version your command files alongside your project using SemVer conventions in the file's frontmatter or changelog if the command is part of a governed workflow.
- Deprecate commands by removing the file or renaming it with a `_deprecated` suffix.

**When NOT to use custom slash commands:**

- For one-off instructions you will never repeat — just type them directly.
- When the instruction requires real-time dynamic data that cannot be derived from the conversation context or the filesystem (e.g., live API calls). Hooks are more appropriate for those cases.
- When you need the instruction to run automatically without a human trigger — consider a Claude Code hook instead.

---

### WHY — Why use custom slash commands?

**Efficiency:** Reduce a 10-step instruction set to a single `/command` invocation. The time saved compounds across a team over weeks.

**Consistency:** Every invocation follows the same steps in the same order. There is no drift from person to person or session to session.

**Documentation as code:** The command file itself documents the workflow. A new team member can read `.claude/commands/log-ai-response.md` and immediately understand the session logging process — it is executable documentation.

**Governance:** Project-scoped commands checked into version control are subject to the same review process as code. Changes are tracked, reviewable, and reversible.

**Lower barrier to automation:** Unlike hooks (which require shell scripting) or MCP servers (which require running a service), slash commands require only a Markdown file. Any team member who can write a numbered list can create one.

---

### HOW — How are custom slash commands created and maintained?

#### Step-by-Step: Creating Your First Command

**1. Decide the scope** — project or global (see WHERE section above).

**2. Create the commands folder if it does not exist.**

For project-scoped (PowerShell):
```powershell
New-Item -ItemType Directory -Path ".claude\commands" -Force
```

For global (PowerShell):
```powershell
New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude\commands" -Force
```

**3. Create the command file.**

Name it exactly what you want to type after the `/`. A file named `log-ai-response.md` creates `/log-ai-response`.

```powershell
New-Item -ItemType File -Path ".claude\commands\log-ai-response.md"
```

**4. Write the instructions** inside the file using plain Markdown. Be specific. Use numbered steps for sequential actions. Reference file paths relative to the project root.

**5. Test the command** by opening Claude Code in the project and typing `/log-ai-response`. Claude will read the file and execute the steps.

**6. Iterate.** Edit the `.md` file, run the command again. No restart required.

#### Best Practices

- **Be explicit about file paths.** Relative paths (`docs/`, `_templates/`) are more portable than absolute paths.
- **Number your steps.** Claude follows numbered lists reliably.
- **Include a confirmation step.** End commands with an instruction to confirm what was done (e.g., "Tell the user which file was written and which slot was filled").
- **Keep one command per file.** Do not combine unrelated workflows in one file.
- **Add a one-line description at the top.** It helps you remember what the command does when you list your commands folder.

---

## `log-ai-response` Command Reference

### Purpose

The `/log-ai-response` command automates session logging for Claude Code conversations. It captures the most recent user prompt and AI response from the current conversation and writes both into a structured, collapsible Markdown log file — creating that file from a template if it does not already exist.

### Location

```
<project-root>/.claude/commands/log-ai-response.md
```

This is a **project-scoped** command. It references project-specific paths (`docs/`, `_templates/`) that would not exist in other repositories.

### Trigger

Type `/log-ai-response` in any Claude Code session within this project.

### What It Does — Step by Step

| Step | Action |
| ---- | ------ |
| 1 | Determine today's date in `YYYY-MM-DD` format |
| 2 | Build target path: `docs/YYYY-MM-DD_conversational-ai.md` |
| 3 | Check whether that file exists |
| 4a | If file **does not exist**: copy from `_templates/template-md-with-metadata-conversational-ai-essential.md`, then update frontmatter (author, date, lastmod, model, session_id, filename) |
| 4b | If file **exists**: proceed directly to step 5 |
| 5 | Read the target file |
| 6 | Find the first `### 🤖 AI Response NN` block whose `<details>` still contains the placeholder `<!-- AI Response HERE: include **Markdown**, code blocks, lists, images -->` |
| 7 | Identify the matching `### 🗣️ Prompt NN` block above it |
| 8 | Replace the full `<details>` block for the prompt — new `<summary>` is a 3–15 word summary of the actual prompt; body is the verbatim prompt text |
| 9 | Replace the response placeholder with the most recent AI response (full Markdown preserved) |
| 10 | Rename the filled slot heading from `### 🤖 AI Response NN` → `### 🤖 Claude AI-Responded NN` |
| 11 | Confirm: `Logged to [filename] — Prompt NN / Claude AI-Responded NN.` |

### Output File Naming Convention

| Component        | Value                                    |
|------------------|------------------------------------------|
| **Prefix**       | `YYYY-MM-DD` (today's date)              |
| **Middle**       | `_conversational-ai`              |
| **Extension**    | `.md`                             |
| **Full example** | `2026-05-02_conversational-ai.md` |

### Slot Detection Logic

The command identifies an **empty slot** by scanning for this exact placeholder content inside a `<details>` block. Empty slots carry the heading `### 🤖 AI Response NN`. Once written, the heading is renamed to `### 🤖 Claude AI-Responded NN` — making it easy to scan the file and distinguish filled entries from empty ones at a glance.

```html
<!-- AI Response HERE: include **Markdown**, code blocks, lists, images -->
```

If this content is present, the slot is considered empty and available. Slots that have already been filled (because the placeholder was replaced with real content) are skipped. This ensures the command always advances to the next unfilled pair — it never overwrites a logged entry.

### Frontmatter Auto-Population (New Files Only)

When creating a new log file, the command sets the following frontmatter fields:

| Field        | Value                                                        |
|--------------|--------------------------------------------------------------|
| `title`      | `"Conversational AI Session Log"`                            |
| `author`     | `"Steven Paradise"`                                          |
| `filename`   | New filename (e.g. `2026-05-02_conversational-ai-claude.md`) |
| `date`       | Today's date (`YYYY-MM-DD`)                                  |
| `lastmod`    | Today's date (`YYYY-MM-DD`)                                  |
| `model`      | `"claude-sonnet-4-6"`                                        |
| `session_id` | `"sess-YYYYMMDD-HHMM-local"`                                 |

### Usage Example

```
User: /log-ai-response

Claude: Logged to 2026-05-02_conversational-ai.md — Prompt 01 / Claude AI-Responded 01.
```

On a second invocation in the same session:

```
User: /log-ai-response

Claude: Logged to 2026-05-02_conversational-ai.md — Prompt 02 / Claude AI-Responded 02.
```

---

## Analysis & Assessment

### Benefits

- **Zero friction logging.** One command captures both sides of a conversation into a structured, versioned file — no copy-paste, no formatting work.
- **Persistent audit trail.** Every session log is a dated Markdown file in the repository, readable without tooling.
- **Template-driven consistency.** All log files share the same structure, making them easy to scan, search, and compare.
- **Self-documenting.** The command file itself explains the workflow; onboarding a new team member requires only reading `.claude/commands/log-ai-response.md`.
- **No external dependencies.** No scripts, no services, no CI configuration — just a Markdown file.

### Limitations & Risks

- **Manual trigger required.** The command only runs when you type `/log-ai-response`. It will not capture responses you forget to log. If fully automatic capture is required, a Claude Code `Stop` hook combined with a script is a more appropriate pattern — though significantly more complex.
- **Session context dependency.** The command relies on Claude's access to the current conversation context to identify "the most recent prompt and response." If the conversation has been compacted or the context window rolled over, the captured content may be truncated or incomplete.
- **Single-file scope per day.** One log file per calendar day. High-volume sessions may result in large files. If you need per-session isolation, the naming convention would need to include a time component.
- **Placeholder pattern dependency.** If the template file is modified and the placeholder comment strings change, the slot detection logic in the command will fail silently (it will not find an empty slot). The placeholder strings must remain stable.
- **No validation.** The command does not verify that the written content matches what was expected. A post-write review step is advisable for audit-critical logging.

### Governance Implications

- The command file should be treated as governed documentation. Changes to `.claude/commands/log-ai-response.md` should go through a pull request review if the logging behavior is relied upon for audit trails.
- The session log files produced (`docs/YYYY-MM-DD_conversational-ai.md`) should be committed to version control at the end of each working session to preserve the audit trail.

### Adoption Considerations

- New team members need only read the command file to understand what `/log-ai-response` does — the instructions are human-readable prose.
- The pattern generalizes easily. Once a team is comfortable with `/log-ai-response`, authoring additional commands for other repetitive workflows (ticket generation, runbook scaffolding, review summaries) follows the same pattern.
- Consider adding a brief note in the project `CLAUDE.md` (if one exists) that `/log-ai-response` is available and what it does, so team members discover it without having to browse `.claude/commands/`.

---

## Troubleshooting

| Symptom                                  | Likely Cause                                                 | Fix                                                                                                                                                         |
|------------------------------------------|--------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `/log-ai-response` not recognized        | Command was created during current session & not recognized  | `Ctrl+Shift+P` to bring up the command pallet select `Developer: Reload Window`                                                                             |
| `/log-ai-response` not recognized        | Command file not in `.claude/commands/` or filename mismatch | Verify file exists at `.claude/commands/log-ai-response.md`                                                                                                 |
| "No empty slot found" or no action taken | All slots in today's file are already filled                 | The log file has no remaining placeholder slots — the template only contains 19 pairs; extend the file manually using the copy-paste template at the bottom |
| Wrong file created / wrong date          | System date mismatch or timezone offset                      | Verify system date; the command uses the local system clock                                                                                                 |
| Frontmatter not updated in new file      | Template frontmatter format changed                          | Ensure the template's frontmatter field names match what the command expects (`title`, `author`, `filename`, `date`, `lastmod`, `model`, `session_id`)      |
| Response content missing or truncated    | Conversation context was compacted before logging            | Log responses immediately after receiving them, before context compaction occurs                                                                            |

---

## Rollback / Undo

- **Undo a logged entry:** Open the log file, find the filled slot, and replace the content with the original placeholder comments manually.
- **Revert command behavior:** Restore the previous version of `.claude/commands/log-ai-response.md` from git history (`git checkout HEAD~1 -- .claude/commands/log-ai-response.md`).
- **Remove the command entirely:** Delete `.claude/commands/log-ai-response.md`. The `/log-ai-response` command will no longer be available immediately.

---

## References

- Claude Code documentation — Custom slash commands: `https://docs.anthropic.com/en/docs/claude-code/slash-commands`
- Claude Code documentation — Settings and configuration: `https://docs.anthropic.com/en/docs/claude-code/settings`
- Claude Code documentation — Hooks: `https://docs.anthropic.com/en/docs/claude-code/hooks`
- CommonMark Markdown specification: `https://spec.commonmark.org/`
- GitHub Flavored Markdown specification: `https://github.github.com/gfm/`
- SemVer 2.0.0: `https://semver.org/`
- HTML `<details>` / `<summary>` element (MDN): `https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details`
- Project template: `_templates/template-md-with-metadata-conversational-ai-essential.md`
- Project command file: `.claude/commands/log-ai-response.md`
