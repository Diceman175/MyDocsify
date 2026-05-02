---
title: "Metadata Schema — Change Governance"
description: "Canonical governance policy for semantic change classification, version bump intent, and sidecar rule usage"
author: "Steven Paradise"
filename: "metadata-schema.changelog-governance.md"
schema_version: "2.0.0"
version: "2.0.0"
date: "2026-05-01"
lastmod: "2026-05-02"
---

# Change Governance

This document defines the governance policy for semantic change classification in
the metadata-schema package.

## Purpose

Change governance ensures that:

1. Change labels are applied consistently.
2. Semantic version bump intent is explicit and reviewable.
3. Tooling can validate entries against a machine-readable rule source.

## Canonical Sidecars

The machine-readable rule assets for change governance are:

1. `metadata-schema.changelog-rules.jsonc`
2. `metadata-schema.changelog-rules.yaml`
3. `metadata-schema.changelog-rules.schema.json`

## Policy Rules

1. Every committed change entry must use a valid governed change code.
2. Each change code implies expected semantic version bump behavior.
3. Unknown or custom codes are not allowed unless governance is explicitly updated first.
4. Rule changes must update both JSONC and YAML mirrors in the same change set.
5. Structural rule changes must also update the JSON schema sidecar.

## Changelog Entry Rules

1. A version entry may contain one or more change lines.
2. Every change line should map to exactly one governed change code.
3. `WIP` is allowed only in local drafts and must not appear in committed release changelogs.
4. When multiple change codes are used in one version entry, version bump precedence is:
   - `major` if any code is `BRK`
   - `minor` if any code is one of `IMP`, `CHG`, `CFG`, `DEL`
   - `patch` for all other non-WIP codes
5. If no released change code is present, do not publish a version bump.

## Valid Examples

Single-code entry:

```yaml
- version: "0.8.1"
  date: "2026-05-01"
  author: "Steven Paradise"
  changes:
    - code: FIX
      note: Correct metadata field order validation for markdown frontmatter
```

Multi-code entry (minor bump due to `CHG`):

```yaml
- version: "0.9.0"
  date: "2026-05-01"
  author: "Steven Paradise"
  changes:
    - code: CHG
      note: Refactor schema sidecar references for portability
    - code: DOC
      note: Update README examples for extensionless templates
```

Breaking entry (major bump due to `BRK`):

```yaml
- version: "1.0.0"
  date: "2026-05-01"
  author: "Steven Paradise"
  changes:
    - code: BRK
      note: Rename required metadata key from created to date
    - code: REF
      note: Add migration notes for existing templates
```

## Invalid Examples

```yaml
- version: "0.9.1"
  date: "2026-05-01"
  author: "Steven Paradise"
  changes:
    - code: CUSTOM
      note: Non-governed custom code is not allowed
```

```yaml
- version: "0.9.2"
  date: "2026-05-01"
  author: "Steven Paradise"
  changes:
    - code: WIP
      note: Work in progress must not be committed in release changelogs
```

## Operational Guidance

1. Use the machine-readable sidecars as the source of truth for validation logic.
2. Keep human-facing explanations in sync with sidecar definitions.
3. Treat governance updates as policy changes and track them in the changelog.
4. Run `metadata-schema.validate.ps1` after any change to sidecar refs, schema version policy, or required metadata ordering.
5. If a change touches rule semantics, update JSONC, YAML, and JSON Schema assets in the same commit.
