---
title: "Conversational AI Session Log"    # Human‑readable title
description: "Unified template for capturing prompts, responses, transcript details, metadata, and evaluation"
author: "Your Name"                       # Display name of author or owner
filename: "template-md-with-metadata-conversational-ai-comprehensive.md"  # Source filename (optional)
schema_version: "2.0.0"
version: "0.7.3"                          # Semantic version for the template or document
date: "2026-04-24"                        # Creation or publish date (ISO‑8601)
lastmod: "2026-04-25"                     # Last modified date (ISO‑8601)
session_id: "sess-20260424-1239-EDT"      # Unique session id (recommended pattern: sess-YYYYMMDD-HHMM-ENV)
conversation: null                        # Optional human-friendly conversation title
session_type: "prompt-engineering"        # enum: brainstorming | debugging | analysis | documentation
persona: "ddi-engineer"                   # Persona or instruction set applied
context: null                             # Short description of prior context loaded
context_depth: 3                          # Integer: number of prior turns intentionally loaded
interaction: null                         # Optional interaction id or type (e.g., live | batch | replay)
categories: ["session-log", "conversational-ai"]   # Structured array for categories
tags: ["conversational-ai", "metadata", "template", "session-log"]  # Array of tags for search/indexing
machine_metadata: null                    # Reserved for small machine metadata (null = omitted)
workflow: null                            # Workflow stage (e.g., draft | review | published)
security_level: "internal"                # Classification: public | private | internal
visibility: "private"                     # Publishing visibility: public | private | internal
tooling: ["chat"]                         # Tools/modes used: chat | browser | code | analysis
tool_platform:
  - "Anything-llm"
  - "ChatGPT"
  - "Claude Code"
  - "Claude"
  - "Copilot Microsoft 365 Personal"
  - "Gemini"
  - "GitHub"
  - "LM Studio"
  - "Microsoft 365 Copilot Diceman6459"
  - "Microsoft 365 Copilot MTB"
  - "Ollama"
model: "copilot-latest"                   # Model or engine label used for the session
evaluation_details:                        # Optional structured evaluation object
  score: null                              # numeric 0.0 - 1.0 (programmatic score)
  rubric: null                             # rubric id or name (string)
  reviewer: null                           # reviewer identity (string)
  notes: null                              # freeform notes (string)
metrics: {}                                # object of named numeric metrics, e.g., {accuracy: 0.9, latency_ms: 120}
confidence: "high"                         # human-friendly enum: low | medium | high
confidence_score: null                     # numeric 0.0 - 1.0 (programmatic confidence)
---

# Conversational AI Session Log with Comprehensive Metadata <!-- omit in toc -->

<!-- this should be fine here below the yaml frontmatter, just validate / update the metadata -->
A unified template combining structured session metadata, prompt/response logging, transcript analysis, and evaluation.

---

## Changelog
<!-- there is no reason to keep this section it is here to track changes to the template itself-->
- version: 0.7.3 (2026-04-25) Steven Paradise  
  - IMP: Added comprehensive project README (`template-md-with-metadata-conversational-ai.README.md`) covering all files, processes, GitHub Actions, and all switch examples  
  - DOC: Version bump; lastmod updated to 2026-04-25
- version: 0.7.1 (2026-04-24) Steven Paradise  
  - FIX: Common frontmatter_schema.json
- version: 0.7.0 (2026-04-24) Steven Paradise  
  - CHG: Add collapsible section to prompt
- version: 0.6.0 (2026-04-24) Steven Paradise  
  - CHG: Removed yaml # as it conflicts with markdown syntax
- version: 0.5.0 (2026-04-24) Steven Paradise  
  - CHG: Modified conversational AI Log to include comprehensive metadata, created JSON schema to match
- version: 0.4.0 (2026-04-24) Steven Paradise  
  - CHG: Minimized the metadata to capture, added placeholder comments
- version: 0.3.0 (2026-04-24) Steven Paradise  
  - IMP: Unified all transcript and metadata sections into a single template  
  - IMP: Added persona tracking, prompt deltas, multi-model comparison, and token/latency metrics  
  - CHG: Aligned structure with prompt-session template while preserving collapsible transcript blocks  
- version: 0.2.0 (2026-04-24) Steven Paradise  
  - IMP: Added full transcript taxonomy including system messages, tool calls, memory references, and safety events  
- version: 0.1.0 (2026-04-24) Steven Paradise  
  - IMP: Initial version

---

## Notes & limitations
- **Standard Markdown does not include collapsible sections**, so this relies on HTML — but GitHub and most modern renderers fully support it. 
- Some engines (like Stack Overflow’s renderer) **do not support nested collapsibles**, but GitHub and VS Code do. 
- Indentation matters when nesting `<details>` blocks — closing tags must align correctly. 
- The `<strong>` tag keeps the summary bold even in renderers that strip Markdown inside `<summary>`.
- The horizontal rules (`---`) create clean printable boundaries.
- The internal headings remain indexable by search engines and MkDocs search.

---

## 💬 Collapsible *Conversational AI Prompt + Response Capture*

This version is designed for documenting your AI interactions:  
**prompt visible**, **response collapsible**, and **clean separation** for auditing or training future prompts.

### 🗣️ Prompt 01
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🤖 AI Response 01
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 02
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧠 AI Response 02
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 03
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🌀 AI Response 03
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 04
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧬 AI Response 04
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 05
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧮 AI Response 05
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 06
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🤖 AI Response 06
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 07
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧠 AI Response 07
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 08
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🌀 AI Response 08
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 09
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧬 AI Response 09
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 10
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧮 AI Response 10
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 11
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🤖 AI Response 11
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 12
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧠 AI Response 12
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 13
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🌀 AI Response 13
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 14
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧬 AI Response 14
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 15
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧮 AI Response 15
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 16
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🤖 AI Response 16
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->

</details>

---

### 🗣️ Prompt 17
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧠 AI Response 17
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 18
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🌀 AI Response 18
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

### 🗣️ Prompt 19
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧬 AI Response 19
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>

---

<!-- Use the below as a copy-paste template for longer chats -->

### 🗣️ Prompt xx
<details>
<summary>Write your prompt here (click to expand)</summary>
<!-- Keep it verbatim for reproducibility.-->
</details>

### 🧮 AI Response xx
<details>
<summary>Answer (click to expand)</summary>
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
</details>
