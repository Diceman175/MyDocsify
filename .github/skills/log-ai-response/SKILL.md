---
name: log-ai-response
description: 'Log the most recent user prompt and Copilot response into today''s session log file. Use when: logging a conversation, capturing session, recording AI response, session log, log prompt, log response, save conversation, document exchange, save chat.'
argument-hint: 'Optional: description of what exchange to log (defaults to most recent)'
---

# Log AI Response

Captures the most recent user prompt and Copilot response from the current conversation and writes both into a structured, collapsible Markdown log file — creating that file from a template if it does not already exist.

## Output File

```
docs/YYYY-MM-DD_conversational-ai-copilot.md
```

Today's date is substituted for `YYYY-MM-DD` (e.g., `docs/2026-05-03_conversational-ai-copilot.md`).

## Steps

1. Determine today's date in `YYYY-MM-DD` format (use the current date from context).

2. Build the target file path:
   `docs/YYYY-MM-DD_conversational-ai-copilot.md`

3. Check if that file exists using file_search for the exact path.

4. If the file does **NOT** exist:
   - Read `_templates/template-md-with-metadata-conversational-ai-essential.md`
   - Create the new file at the target path with that exact template content
   - Then edit the new file's YAML frontmatter fields to replace placeholder values:
     - `title` → `"Conversational AI Session Log"`
     - `author` → `"Steven Paradise"`
     - `filename` → the new filename (e.g. `2026-05-03_conversational-ai-copilot.md`)
     - `date` → today's date in `"YYYY-MM-DD"` format
     - `lastmod` → today's date in `"YYYY-MM-DD"` format
     - `model` → `"claude-sonnet-4-6"`
     - `session_id` → `"sess-YYYYMMDD-HHMM-local"` using today's date and current time (e.g. `"sess-20260503-1430-local"`)

5. Read the current contents of the target file.

6. Scan the file to find the first `### 🤖 AI Response` section whose `<details>` block still contains this exact placeholder content:
   ```
   <!-- Paste the response here -->
   <!-- You can include **Markdown**, code blocks, lists, images — anything. -->
   ```

7. Identify the slot number (e.g. 01, 02, 03) from that heading. Find the matching `### 🗣️ Prompt NN` block immediately above it.

8. Identify the most recent user prompt from this conversation — the user message that triggered this skill invocation (the one immediately before the `/log-ai-response` call). Use that text verbatim.

9. Identify the most recent Copilot response from this conversation — the AI reply that came immediately before this invocation. Capture the full response with Markdown preserved.

10. Replace the prompt placeholder inside the `### 🗣️ Prompt NN` `<details>` block:
    - Find: `<!-- Keep it verbatim for reproducibility.-->`
    - Replace with: the most recent user prompt (verbatim)

11. Replace the AI response placeholder inside the `### 🤖 AI Response NN` `<details>` block:
    - Find these two lines:
      ```
      <!-- Paste the response here -->
      <!-- You can include **Markdown**, code blocks, lists, images — anything. -->
      ```
    - Replace with: the most recent Copilot response (full Markdown preserved)

12. Rename the heading of the filled slot from `### 🤖 AI Response NN` to `### 🤖 AI-Responded NN`
    (change "Response" to "AI-Responded"; keep the emoji and slot number unchanged).

13. Confirm to the user with this exact format:
    `Logged to [filename] — Prompt NN / AI-Responded NN.`

## Slot Detection Logic

An empty slot is identified by this exact two-line placeholder inside a `<details>` block:

```html
<!-- Paste the response here -->
<!-- You can include **Markdown**, code blocks, lists, images — anything. -->
```

After writing, the heading changes from `### 🤖 AI Response NN` → `### 🤖 AI-Responded NN`. This makes filled slots visually distinct from empty ones. The skill always advances to the next unfilled pair and never overwrites an already-logged entry.

## Important Notes

- **Invoke immediately** after the exchange you want to log. If the conversation has grown long, later invocations may capture a different exchange.
- The template contains 19 slot pairs. If all 19 are filled, manually copy the `xx` template block at the bottom of the log file to add more.
- The placeholder comment strings in the template must remain unchanged — the slot detection depends on exact string matching.
