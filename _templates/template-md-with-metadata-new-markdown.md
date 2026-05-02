---
title:          "New Markdown Document"
description:    "A righ-click documentation template with UTF-8 encoding"
author:         "Steven Paradise"
filename:       "template-md-with-metadata-new-markdown.md"
schema_version: "2.0.0"
version:        "0.1.0"
date:           "YYYY-MM-DD"
lastmod:        "YYYY-MM-DD"
---


# New Markdown Document (Machine + Human Readable) <!-- omit from toc -->
The document serves as a quick documentation template with UTF-8 encoding for  
right-click `New` > `Markdown Document`, based on `C:\Windows\ShellNew\template.md` or `%appdata%\Microsoft\Windows\Template\template.md`.

## Quick Start
<!-- You can delete this section if you are not concerned with a quick start. -->
1. Right-click and select `New`, then `Markdown Document`
2. Rename it to your `filename.md`
3. Fill in the YAML frontmatter metadata fields: `title`, `description`, `author`, `filename`, `version`, `date`, and `lastmod`.
4. Set `version` to `x.y.z` in metadata and add a matching `x.y.z` entry in the changelog whenever the file is incremented.

### Tips
💡 Press Ctrl+Space to open IntelliSense suggestions.
<!-- This is a good section to keep as a reminder, I will add more in the future -->
- `ps-turn` will insert a **`Prompt - AI Response`** collapsible section HTML block.

---

## Changelog
<!-- You can delete this section if you are not concerned with tracking changes to the file. -->
<!-- Reference change codes from `rules-change-codes.jsonc` for semantic versioning.  -->
> The most recent change entries are at the top.  
> Reference change codes from `rules-change-codes.jsonc` for semantic versioning.  
> Copy and paste this block above the previous most recent entry.
- version: 0.4.0 (2026-04-26) Steven Paradise
  - FIX: Corrected formatting of the YAML frontmatter section
  - CFG: Recreated the file framework
- version: 0.3.0 (2026-04-13) Steven Paradise
  - CFG: Added YAML frontmatter metadata
- version: 0.2.0 (2026-04-13) Steven Paradise
  - CFG: Removed some metadata fields
- version: 0.1.0 (2026-04-02) Steven Paradise
  - IMP: Initial file creation

---
