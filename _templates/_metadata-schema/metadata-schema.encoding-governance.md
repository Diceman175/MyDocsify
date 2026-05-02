---
title: "Metadata Schema — Repository File Encoding Governance"
description: "Repository-wide encoding standards, root cause analysis, resolution steps, and long-term governance workflow"
author: "Steven Paradise"
filename: "metadata-schema.encoding-governance.md"
schema_version: "2.0.0"
version: "2.0.0"
date: "2026-04-28"
lastmod: "2026-05-02"
---

# Repository File Encoding Governance

This document defines the encoding standards, root cause analysis, resolution steps,
and long-term governance workflow for file encodings across the
My-Engineering-Cockpit monorepo. It ensures consistent, predictable,
cross-platform-safe encoding for all file types used in the repository.

## Root Cause Analysis

Encoding issues were traced to a combination of editor behavior and missing
repository-level enforcement. Notepad++ and other editors were silently
converting files from UTF-8 to ANSI due to:

- Auto-detect encoding misidentifying ASCII-only files
- Keep original encoding preserving ANSI metadata
- YAML, JSON, and Markdown files containing only ASCII and falling back
- Files originally created as ANSI
- Editors not enforcing UTF-8
- Missing repo-wide encoding governance

This resulted in:

- YAML parsing failures
- Git diffs showing corrupted characters
- CI tools misreading metadata
- PowerShell scripts losing Unicode characters
- Inconsistent behavior across editors

## Resolution Summary

Implemented:

- .editorconfig enforcement for UTF-8 and UTF-8 BOM for PowerShell
- VS Code workspace settings enforcing encoding per file type
- Notepad++ configuration changes to disable ANSI fallback
- config.xml modifications to enforce UTF-8
- PowerShell encoding scanner to detect violations

Planned:

- CI workflow to block invalid encodings
- Pre-commit hook to prevent ANSI commits
- Auto-fix script to normalize encodings

## Implementation Status (as of 2026-05-01)

- CI workflow to block invalid encodings: planned, not yet adopted in this package directory.
- Pre-commit hook to prevent ANSI commits: planned, not yet adopted in this package directory.
- Auto-fix script to normalize encodings: planned, not yet adopted in this package directory.

## Scanner Contract

The scanner script reference is `tools/utilities/check-encodings.ps1`.

Expected scanner behavior contract:

1. Exit code `0` when no violations are found.
2. Exit code `1` when one or more files violate policy.
3. Exit code `2` for invalid input path or runtime preconditions.
4. PowerShell extensions (`.ps1`, `.psm1`, `.psd1`) require UTF-8 BOM.
5. Non-PowerShell text templates require UTF-8 without BOM.

## Encoding Standards Matrix

| File Type | Encoding | Reason |
| --- | --- | --- |
| .ps1, .psm1, .psd1 | UTF-8 with BOM | PowerShell compatibility on Windows |
| .yaml, .yml | UTF-8 (no BOM) | YAML spec and CI compatibility |
| .json, .jsonc | UTF-8 (no BOM) | JSON spec |
| .md | UTF-8 (no BOM) | GitHub standard |
| .tf | UTF-8 (no BOM) | Terraform standard |
| .sh | UTF-8 (no BOM) | Shell standard |
| .py | UTF-8 (no BOM) | PEP 8 |
| .ts, .tsx, .js | UTF-8 (no BOM) | Node and TypeScript standard |
| .txt | UTF-8 (no BOM) | Universal |

## Enforcement Locations

| Purpose | File |
| --- | --- |
| Editor-agnostic enforcement | .editorconfig |
| VS Code enforcement | .vscode/settings.json |
| Notepad++ enforcement | %AppData%/Notepad++/config.xml |
| Repo-wide scanning | tools/utilities/check-encodings.ps1 |

## Notepad++ Permanent Fix

Step 1: Disable auto-detect encoding in Settings > Preferences > MISC:

- Disable autodetect character encoding
- Disable keep original encoding

Step 2: Set default encoding in Settings > Preferences > New Document:

- UTF-8

Step 3: Update config.xml:

```xml
<GUIConfig name="autodetectEncoding" enabled="no" />
<GUIConfig name="keepOriginalEncoding" enabled="no" />
<GUIConfig name="newDocDefaultSettings" format="0" encoding="4" lang="0" />
```

## Notes

- Narrative governance lives in this file.
- Machine-readable policy lives in metadata-schema.encoding-rules.yaml.
- Template orchestration references are declared in metadata-schema.yaml.
