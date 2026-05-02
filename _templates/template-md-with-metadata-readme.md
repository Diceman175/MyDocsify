---
title: "Template for Markdown-README.md Files"    # Human-readable title
description: "This template is used as a base for any README.md files"
author: "Steven Paradise"                         # Display name of author or owner
filename: "template-md-with-metadata-readme.md"   # Source filename
schema_version: "2.0.0"                           # Version of the metadata standard
version: "0.2.0"                                  # Semantic version for the template or document
date: "2026-04-24"                                # Creation or publish date (ISO-8601)
lastmod: "2026-04-26"                             # Last modified date (ISO-8601)
---

# Template for Markdown-README.md Files
This template is used to align any README files that are created.

---

## Instructions

- Copy this file and rename it to your project filename
- Update the metadata section (YAML frontmatter at top) with your project details
- Replace placeholder sections with your actual content
- Update changelog with each release using the change codes
- Keep the most recent changelog entries at the top

---

## Changelog

<!--
 ============================================================
	The Most recent change entries are on top
  Reference change codes from rules-change-codes.jsonc for semantic versioning.
  Copy and paste this block above the previous most recent entry.
  ============================================================
-->

- version: "0.2.0"
  date: 2026-04-26
  author: Steven Paradise
  changes:
    - FIX: Added required schema_version field to frontmatter
    - FIX: Reformatted changelog entry to canonical changelog_entry_template structure
    - FIX: Wrapped changelog separator and instruction lines in HTML comment block
    - FIX: Replaced non-conformant hidden changelog entry template with canonical format
    - CHG: Renamed special case suffix from README to readme per lowercase naming convention
    - FIX: Added pre-commit-only caveat to WIP entry in hidden change codes reference
    - FIX: Removed (optional) annotation from filename field — filename is a required field

- version: "0.1.0"
  date: 2026-04-24
  author: Steven Paradise
  changes:
    - IMP: Initial file creation

<!--
## Semantic Change Codes and Versioning

change_codes:
  - code: BRK
    meaning: Breaking changes
    semantic_version_bump: major
  - code: CFG
    meaning: Configuration changes
    semantic_version_bump: minor
  - code: CHG
    meaning: Improvements or refactoring
    semantic_version_bump: minor
  - code: DEL
    meaning: File or feature removed
    semantic_version_bump: minor
  - code: DEP
    meaning: Dependency updates
    semantic_version_bump: patch
  - code: DOC
    meaning: Documentation updates
    semantic_version_bump: patch
  - code: FIX
    meaning: Bug fixes
    semantic_version_bump: patch
  - code: IMP
    meaning: New features
    semantic_version_bump: minor
  - code: OPS
    meaning: Operational or deployment changes
    semantic_version_bump: patch
  - code: REF
    meaning: Documentation or references
    semantic_version_bump: patch
  - code: SEC
    meaning: Security fixes
    semantic_version_bump: patch
  - code: TST
    meaning: Tests or CI updates
    semantic_version_bump: patch
  - code: WIP
    meaning: Work in progress — pre-commit only — do not use in committed changelog entries
    semantic_version_bump: none

---

## Changelog Entry Template

 ============================================================
	The Most recent change entries are on top
  Reference change codes from rules-change-codes.jsonc for semantic versioning.
  Copy and paste this block above the previous most recent entry.
  ============================================================

- version: "X.Y.Z"
  date: YYYY-MM-DD
  author: Your Name
  changes:
    - CODE: Short summary of what changed
    - CODE: Another summary of what else changed

-->

