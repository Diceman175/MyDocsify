---
title: Your Project Title
description: A brief description of what this file contains and its purpose in your project
author: Your Name
filename: your-project-file.md
schema_version: "2.0.0"
version: 0.1.0
date: 2026-04-20
lastmod: 2026-04-20
---

# Your Project Title

```yaml
Description: A brief description of what this file contains and its purpose in your project
```

## Changelog

```yaml
# Most recent entries first. Reference change codes from rules-change-codes.jsonc for semantic versioning.
latest_entry:
  version: 0.1.0
  date: 2026-04-20
  author: Your Name
  changes:
    - code: IMP
      note: Initial project setup with metadata template
```

---

## Content Section

```yaml
# Add your project content, documentation, and data below this line.
```

### Example Section

```yaml
# This is where your main content goes. You can organize it however makes sense for your project.
key_features:
  - Feature one
  - Feature two
  - Feature three
```

### Configuration

```yaml
project_config:
  name: Example Project
  enabled: true
  settings:
    timeout: 30
    retries: 3
    debug_mode: false
```

### Data Examples

```yaml
data_examples:
  - id: 1
    name: Item One
    status: active
  - id: 2
    name: Item Two
    status: inactive
```

---

## Usage Notes

### Version Numbering

```yaml
version_numbering:
  major: Breaking changes (BRK code)
  minor: New features (IMP, CHG, CFG codes)
  patch: Fixes and documentation (FIX, SEC, DOC, REF, TST, DEP, OPS codes)
```

### Changelog Entry Template

```yaml
version: X.Y.Z
date: YYYY-MM-DD
author: Your Name
changes:
  - code: IMP
    note: Short summary of what changed
  - code: FIX
    note: Short summary of the fix
```

### Change Codes

```yaml
change_codes:
  - code: FIX
    meaning: Bug fixes
    semantic_version_bump: patch
  - code: IMP
    meaning: New features
    semantic_version_bump: minor
  - code: CHG
    meaning: Improvements or refactoring
    semantic_version_bump: minor
  - code: REF
    meaning: Documentation or references
    semantic_version_bump: patch
  - code: BRK
    meaning: Breaking changes
    semantic_version_bump: major
  - code: SEC
    meaning: Security fixes
    semantic_version_bump: patch
  - code: TST
    meaning: Tests or CI updates
    semantic_version_bump: patch
  - code: DOC
    meaning: Documentation updates
    semantic_version_bump: patch
  - code: CFG
    meaning: Configuration changes
    semantic_version_bump: minor
  - code: DEP
    meaning: Dependency updates
    semantic_version_bump: patch
  - code: OPS
    meaning: Operational or deployment changes
    semantic_version_bump: patch
  - code: WIP
    meaning: Work in progress
    semantic_version_bump: none
```

```yaml
# For full code definitions, see rules-change-codes.jsonc
```

---

## Instructions

```yaml
instructions:
  - Copy this file and rename it to your project filename
  - Update the metadata section (YAML frontmatter at top) with your project details
  - Replace placeholder sections with your actual content
  - Update changelog with each release using the change codes
  - Keep the most recent changelog entries at the top
```
