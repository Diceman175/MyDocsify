---
title: "Metadata Schema — Repository File Naming Governance"
description: "Repository-wide naming standards for governed file families that use canonical base-name sidecar structures"
author: "Steven Paradise"
filename: "metadata-schema.naming-governance.md"
schema_version: "2.0.0"
version: "2.0.0"
date: "2026-05-01"
lastmod: "2026-05-02"
---

# Repository File Naming Governance

This document defines the naming standard for governed file families that use a
canonical base-name with dotted sidecar descriptors.

The standard exists to keep related policy, schema, documentation, and automation
files grouped together by filename while still making each file's purpose obvious.

## Canonical Pattern

Governed file families follow one of these patterns:

- Primary file: `<base-name>.<ext>`
- Sidecar file: `<base-name>.<descriptor>.<ext>`

Examples:

- `metadata-schema.yaml`
- `metadata-schema.readme.md`
- `metadata-schema.changelog-rules.schema.json`
- `metadata-schema.encoding-rules.yaml`
- `metadata-schema-encoding-governance.check-encodings.template.ps1`
- `metadata-schema-encoding-governance.encoding-governance.workflow.yml`

## Rules

1. Every governed file family has one canonical `base-name`.
2. Every sidecar in that family starts with the exact `base-name`.
3. Descriptors are lowercase and separated with dots.
4. Hyphens are allowed inside a descriptor token, but descriptors themselves are not separated by hyphens.
5. The last segment is always the real file extension.
6. A family may mix single and multi-part descriptors, such as `.readme.md` and `.check-governed-filenames.template.ps1`.
7. Once a family adopts the dotted sidecar strategy, hyphenated alternates such as `metadata-schema-README.md` are not allowed.

## Scope

This governance is intended for named documentation, schema, and governance
packages such as:

- `metadata-schema`
- `metadata-schema-encoding-governance`
- `metadata-schema-naming-governance`

It is not intended to replace the general template naming rules for ordinary
template files such as `template-ps1-with-metadata.ps1`.

## Enforcement Model

The policy is enforced by:

1. The machine-readable sidecar `metadata-schema.naming-rules.yaml`
2. Local validation scripts in consuming repositories
3. CI workflows that run filename validation checks
4. Code review expectations for new governed file families

## Design Goals

- Keep related files visually grouped in file explorers and search results
- Keep descriptors explicit without inventing custom folder nesting
- Make automation predictable with a simple filename grammar
- Prevent mixed naming strategies inside the same governed family

## Notes

- Governance sidecars should be added to the owning family rather than creating duplicate parallel families.
- When a new governed family is introduced, add it to `metadata-schema.naming-rules.yaml` before creating additional sidecars.
- The naming rules sidecar is the source of truth for validator templates and CI automation.
