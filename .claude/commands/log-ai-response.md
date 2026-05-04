Log the most recent user prompt and AI response into today's session log file.

## Steps

1. Determine today's date in YYYY-MM-DD format (use the current date).

2. Build the target file path:
   `docs/YYYY-MM-DD_conversational-ai.md`
   (replace YYYY-MM-DD with today's actual date, e.g. `docs/2026-05-02_conversational-ai.md`)

3. Check if that file exists using Glob: `docs/YYYY-MM-DD_conversational-ai.md`

4. If the file does NOT exist:
   - Read `_templates/template-md-with-metadata-conversational-ai-essential.md`
   - Write that content to the target path
   - Then edit the new file's YAML frontmatter fields to replace placeholder values:
     - `title` → `"Conversational AI Session Log"`
     - `author` → `"Steven Paradise"`
     - `filename` → the new filename (e.g. `2026-05-02_conversational-ai.md`)
     - `date` → today's date in `"YYYY-MM-DD"` format
     - `lastmod` → today's date in `"YYYY-MM-DD"` format
     - `model` → `"claude-sonnet-4-6"`
     - `session_id` → `"sess-YYYYMMDD-HHMM-local"` using today's date and current time (e.g. `"sess-20260502-1430-local"`)

5. Read the target file.

6. Scan the file to find the first `### 🤖 AI Response` section whose `<details>` block still contains this exact placeholder content:
   `<!-- AI Response HERE: include **Markdown**, code blocks, lists, images -->`

7. Identify the slot number (e.g. 01, 02) from that heading and find the matching `### 🗣️ Prompt NN` block immediately above it.

8. Replace everything inside the `### 🗣️ Prompt NN` `<details>` block:
   - Replace the full contents between the opening `<details>` and `</details>` tags (including any existing text, prep notes, or placeholders)
   - The new `<summary>` text should be a 3–15 word summary of the actual prompt (replacing "Write your prompt here (click to expand)" or whatever was there)
   - The body after `</summary>` should be the most recent user prompt from this conversation (verbatim)

9. Replace the AI response placeholder inside the `### 🤖 AI Response NN` `<details>` block:
   - Find: `<!-- AI Response HERE: include **Markdown**, code blocks, lists, images -->`
   - Replace with: the most recent AI response from this conversation (full Markdown preserved)

10. After writing the response, rename the heading of that slot from `### 🤖 AI Response NN` to `### 🤖 Claude AI-Responded NN` (replace "AI Response" with "Claude AI-Responded", keeping the emoji and slot number).

11. Confirm to the user with a short message:
    `Logged to [filename] — Prompt NN / Claude AI-Responded NN.`
