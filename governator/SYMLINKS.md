---
title: Governance Symlinks
description: Manifest of governance symlinks
author: Steven Paradise
filename: SYMLINKS.md
schema: "2.1"
version: "2.3.0"
date: 2026-06-12
lastmod: 2026-06-12
type: reference
tags:
  - governance/workspace
---

# Governance Symlinks

Fourteen symbolic links bridge this repository to diceman175-governator using **relative paths** for portability: eight directory links under `governator/` and six file links at the repo root.

## Directory links (under governator/)

Target prefix `../../diceman175-governator/` (two levels up from the link):

| Symlink | Relative Path | Purpose |
|---------|---------------|---------|
| governator/audit | ../../diceman175-governator/audit | Governance audit logs, reports, and workspace-audit artifacts |
| governator/orchestrate | ../../diceman175-governator/orchestrate | Orchestration entry points for multi-step governance workflows |
| governator/permissions | ../../diceman175-governator/permissions | AI automation and CI/CD policies |
| governator/procedures | ../../diceman175-governator/procedures | Operational runbooks, workflows, and standard operating procedures |
| governator/schemas | ../../diceman175-governator/schemas | Metadata field definitions and tag vocabularies |
| governator/scripts | ../../diceman175-governator/scripts | Validation, remediation, and automation tooling |
| governator/standards | ../../diceman175-governator/standards | Naming conventions, linting rules, and style guidelines |
| governator/templates | ../../diceman175-governator/templates | File templates for all supported languages |

## File links (repo root)

Target prefix `../diceman175-governator/` (one level up from the link):

| Symlink | Relative Path | Purpose |
|---------|---------------|---------|
| metadata-tags.yaml | ../diceman175-governator/schemas/metadata-tags/metadata-tags.yaml | Controlled tag vocabulary (canonical) |
| metadata-fields.yaml | ../diceman175-governator/schemas/metadata-fields/metadata-fields.yaml | Metadata frontmatter schema (canonical) |
| AI-AUTOMATION-PERMISSIONS.md | ../diceman175-governator/permissions/ai-automation/AI-AUTOMATION-PERMISSIONS.md | AI automation permission policy |
| WORKSPACE-NAMING-STANDARD.md | ../diceman175-governator/standards/workspace/naming/WORKSPACE-NAMING-STANDARD.md | Workspace naming standard |
| WORKSPACE-ENCODING-STANDARD.md | ../diceman175-governator/standards/workspace/encoding/WORKSPACE-ENCODING-STANDARD.md | Workspace encoding standard (UTF-8, line endings) |
| WORKSPACE-VERSION-STANDARD.md | ../diceman175-governator/standards/workspace/version/WORKSPACE-VERSION-STANDARD.md | Folder-level .version governance standard |

## Symlink Architecture

These symlinks use **relative paths** instead of absolute paths:

- **Directory links:** ../../diceman175-governator/{subfolder} (from governator/, two levels up)
- **Root file links:** ../diceman175-governator/{path} (from the repo root, one level up)
- **Portable:** Workspace can relocate without breaking links
- **Consistent:** All repos use the same pattern

Example: Moving the workspace from C:\Data\GitHub\Diceman175\ to D:\Projects\Diceman175\ requires no symlink updates.

All symlinks ensure synchronization with the centralized governance source (diceman175-governator).
