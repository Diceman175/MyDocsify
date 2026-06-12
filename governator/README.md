---
title: Workspace Governance
description: Relative symlinks to centralized governance (diceman175-governator)
author: Steven Paradise
filename: README.md
schema: "2.1"
version: "2.3.0"
date: 2026-06-12
lastmod: 2026-06-12
type: reference
tags:
  - governance/workspace
---

# Workspace Governance

Symbolic links (using **relative paths**) to the centralized governance repository (diceman175-governator).

## governator/ directory links

- **audit** - Governance audit logs, reports, and workspace-audit artifacts
- **orchestrate** - Orchestration entry points for multi-step governance workflows
- **permissions** - AI automation and CI/CD policies
- **procedures** - Operational runbooks, workflows, and standard operating procedures
- **schemas** - Metadata field definitions and tag vocabularies
- **scripts** - Validation, remediation, and automation tools
- **standards** - Naming conventions and linting rules
- **templates** - File templates for all languages

## Repo-root file links

- **metadata-tags.yaml** - Controlled tag vocabulary (canonical)
- **metadata-fields.yaml** - Metadata frontmatter schema (canonical)
- **AI-AUTOMATION-PERMISSIONS.md** - AI automation permission policy
- **WORKSPACE-NAMING-STANDARD.md** - Workspace naming standard
- **WORKSPACE-ENCODING-STANDARD.md** - Workspace encoding standard (UTF-8, line endings)
- **WORKSPACE-VERSION-STANDARD.md** - Folder-level .version governance standard

## Symlink Details

Directory links use `../../diceman175-governator/{subfolder}` (two levels up, from `governator/`).
Root file links use `../diceman175-governator/{path}` (one level up, from the repo root).
All targets are relative for portability across machines and directory relocations.

See [SYMLINKS.md](./SYMLINKS.md) for the detailed manifest.
