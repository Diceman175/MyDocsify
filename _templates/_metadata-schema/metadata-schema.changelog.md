---
title:         "Metadata Schema — Changelog"
description:   "Full development history of metadata-schema.yaml and its sidecar files"
author:        "Steven Paradise"
filename:      "metadata-schema.changelog.md"
schema_version: "2.0.0"
version:       "2.0.0"
date:          "2026-04-24"
lastmod:       "2026-05-02"
---

<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to the `metadata-schema` template schema and its accompanying
documentation guide are recorded in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Canonical Naming Map (Current)

- Governance docs: `metadata-schema.changelog-governance.md`,
  `metadata-schema.encoding-governance.md`, `metadata-schema.naming-governance.md`
- Governance rules: `metadata-schema.changelog-rules.jsonc`,
  `metadata-schema.changelog-rules.yaml`, `metadata-schema.changelog-rules.schema.json`,
  `metadata-schema.encoding-rules.yaml`, `metadata-schema.encoding-rules.schema.json`,
  `metadata-schema.naming-rules.yaml`, `metadata-schema.naming-rules.schema.json`,
  `metadata-schema.existing-templates.schema.json`, `metadata-schema.schema.json`

## Compatibility Policy

- `schema_version` minor updates are backward-compatible clarifications or additive
  rule updates.
- `schema_version` major updates indicate breaking changes to required fields,
  required ordering, or consumer-visible shapes.
- Breaking changes require explicit migration notes in the changelog.

**Files tracked:**

- `metadata-schema.yaml` — Source of truth: schema, naming/folder conventions, lint rules,
  comment/metadata style mappings, template inventory, special case rules, and sidecar references.
- `metadata-schema.schema.json` — JSON schema for validating metadata-schema.yaml structure.
- `metadata-schema.readme.md` — User-facing documentation mirror and operational guidance.
- `metadata-schema.existing-templates.yaml` — Sidecar inventory of existing templates.
- `metadata-schema.changelog-governance.md` — Canonical semantic change-governance policy.
- `metadata-schema.changelog-rules.jsonc` — JSONC machine-readable change-rule matrix.
- `metadata-schema.changelog-rules.yaml` — YAML mirror of machine-readable change rules.
- `metadata-schema.changelog-rules.schema.json` — JSON schema for change-rule metadata validation.
- `metadata-schema.encoding-governance.md` — Repository encoding governance policy.
- `metadata-schema.encoding-rules.yaml` — Machine-readable encoding policy matrix.
- `metadata-schema.encoding-rules.schema.json` — JSON schema for encoding-rules validation.
- `metadata-schema.naming-governance.md` — Canonical naming governance policy.
- `metadata-schema.naming-rules.yaml` — Machine-readable naming policy matrix.
- `metadata-schema.naming-rules.schema.json` — JSON schema for naming-rules validation.
- `metadata-schema.existing-templates.schema.json` — JSON schema for template inventory validation.
- `metadata-schema.validate.ps1` — Baseline validator for sidecars and schema consistency checks.

---

## [Unreleased]

### Added

- Reserved for future changes.

---

## [2.0.0] — 2026-05-02

> **Milestone: Major Schema Upgrade — Unified 2.0.0 Baseline and Hardening Commit**

### Changed

- Bumped `schema_version` to `2.0.0` across metadata-schema governance files and schema sidecars.
- Bumped file `version` fields to `2.0.0` across the metadata-schema package as a coordinated major release.
- Updated `project.current_schema_version` to `2.0.0` as the canonical baseline for all newly governed files.
- Updated release labels in `metadata-schema.readme.md` to reflect `2.0.0 (2026-05-02)`.

### Hardening Pass

- Executed full package hardening validation using `metadata-schema.validate.ps1` after the 2.0.0 migration.
- Confirmed sidecar references and metadata compliance checks pass under the upgraded schema baseline.

---

## [0.13.0] — 2026-05-01

> **Milestone: Governance Hardening — Schema Baseline, Validator Expansion, and Full Sidecar Coverage**

### Added

- Added `project.current_schema_version: "1.1.0"` to define the canonical metadata schema version for all new governed files.
- Added sidecar refs in `metadata-schema.yaml`: `validate_ref`, `encoding_rules_schema_ref`, `naming_rules_schema_ref`, and `existing_templates_schema_ref`.
- Added `metadata-schema.encoding-rules.schema.json` for machine validation of encoding policy files.
- Added `metadata-schema.naming-rules.schema.json` for machine validation of governed family naming policies.
- Added `metadata-schema.existing-templates.schema.json` for machine validation of template inventory sidecars.
- Added `.ps1` lint extension override to document the `.METADATA` comment-help pattern for PowerShell templates.

### Changed

- Promoted prior unreleased governance work into a numbered release and reset `[Unreleased]`.
- Updated package release files to `version: 0.13.0`.
- Standardized schema baseline to `schema_version: 1.1.0` across the metadata-schema package.
- Updated `metadata-schema.changelog-rules.schema.json` to include `DEL` as a valid change code and enforce all 8 required metadata fields.
- Updated `metadata-schema.naming-rules.yaml` governed file list to include `metadata-schema.validate.ps1` and schema sidecar files.
- Updated `metadata-schema.encoding-rules.yaml` coverage to include `bash`, `cmd`, `jsx`, and `rb` and aligned it with declared comment-style ecosystem coverage.
- Updated `metadata-schema.existing-templates.yaml` category mapping by replacing extension-bucket `yml` with ecosystem categories `ansible` and `github-actions`.
- Updated `metadata-schema.readme.md` for portability (`${WORKSPACE_ROOT}` paths), lint override alignment, and `comment_styles.html_comment` parity.
- Updated `metadata-schema.validate.ps1` with module requirements and cross-sidecar checks for metadata fields/order and schema version consistency.
- Clarified `native_yaml` style guidance to explicitly document the approved dual-header governance sidecar pattern.

### Fixed

- Fixed stale tracked-file manifest in this changelog to include current sidecars and validator script.
- Fixed historical wording mismatch in 0.11.0 field migration notes.
- Fixed historical `special_case_rules_md` casing in 0.7.0 notes (`README` -> `readme`).

---

## [0.12.0] — 2026-05-01

> **Milestone: Metadata-Schema Consolidation — Folder Rename and Change-Code Integration**
> This release renames the metadata schema folder, relocates and renames the full
> rules-change-codes package into the schema folder, and incorporates the previous
> rules-change-codes README/changelog guidance into the metadata-schema docs.

### Changed

- **Folder rename**: `_templates/_base-metadata` → `_templates/_metadata-schema`.
- **Core file family renamed**:
  - `base-metadata.yaml` → `metadata-schema.yaml`
  - `base-metadata-README.md` → `metadata-schema.readme.md`
  - `base-metadata-CHANGELOG.md` → `metadata-schema.changelog.md`
  - `base-metadata-existing-templates.yaml` → `metadata-schema.existing-templates.yaml`
- **Rules package relocated and renamed under metadata-schema**:
  - `rules-change-codes.jsonc` → `metadata-schema.changelog-rules.jsonc`
  - `rules-change-codes.yaml` → `metadata-schema.changelog-rules.yaml`
  - `rules-change-codes.schema.json` → `metadata-schema.changelog-rules.schema.json`
- **Schema references updated** (`metadata-schema.yaml` and `metadata-schema.readme.md`):
  sidecar references now point to the relocated change-code assets and renamed files.
- **No compatibility stubs retained**: the original `_templates/rules-change-codes`
  folder and its standalone README/changelog files were removed after consolidation.

### Added

- **Integrated rules-change-codes documentation** in `metadata-schema.readme.md` under
  the `Change Codes Sidecars` section.
- **Integrated legacy rules-change-codes release history summary** in
  `metadata-schema.readme.md` and tracked in this consolidated changelog.

### Legacy Integrated Notes

- `rules-change-codes` legacy release `1.2.0` (2026-04-21): dedicated changelog and
  orchestration notes.
- `rules-change-codes` legacy release `1.1.0` (2026-04-20): metadata additions.
- `rules-change-codes` legacy release `1.0.0` (2026-04-09): initial change-code rule set.

---

## [0.11.0] — 2026-05-01

> **Milestone: Schema Consistency — Sidecars, Canonical Shapes, and Ownership**
> This release consolidates the later minor tweaks from today into a single pre-1.0
> release. The base metadata now uses sidecars for large growing sections, the remaining
> schema inconsistencies are resolved, and inventory ownership is canonicalized.

### Added

- **`base-metadata-existing-templates.yaml`** (new file): The `existing_templates` block
  was moved out of `base-metadata.yaml` into a dedicated sidecar file with its own
  metadata header.
- **`existing_templates_ref` key** (`base-metadata.yaml`): Points consumers to the new
  inventory sidecar file.

### Changed

- **Inline `# CHANGELOG:` comment block removed** (`base-metadata.yaml`): Replaced with a
  short reference to `base-metadata-CHANGELOG.md`, keeping the main YAML focused on
  schema content instead of embedded history.
- **`special_case_rules` normalized to object form** (`base-metadata.yaml`): The general
  special-case rules now use a `rules:` wrapper, matching
  `special_case_rules_extensionless` and `special_case_rules_md`.
- **`lint_rules_common.required_order` deduplicated** (`base-metadata.yaml`): Replaced
  with `required_order_ref: "metadata_fields.required_order"`, making one canonical
  ordering source for consumers.
- **Inventory ownership made canonical** (`base-metadata-existing-templates.yaml`):
  `template-json-with-metadata-package.json` now belongs only to `node`, and
  `template-json-with-metadata-tsconfig.json` belongs only to `typescript`.
- **`base-metadata-CHANGELOG.md` frontmatter updated to canonical field names**:
  `authorname` → `author`, `created` → `date`, `last_updated` → `lastmod`, and
  `filename` corrected to `base-metadata-CHANGELOG.md`.

### Design Decisions

- **Sidecar over inline for inventory and history**: The largest monotonic-growth
  sections were moved out of the main schema file.
- **One shape per concept**: All special-case sections now expose `rules:` at the top
  level.
- **One canonical owner per template file**: Duplicate inventory entries were removed in
  favor of a single owning category for lookup and automation.

---

## [0.10.0] — 2026-05-01

> **Milestone: Standards Alignment — Pre-1.0 Consolidation**
> This release consolidates the earlier changes from today into the first pre-1.0 minor
> version after 0.9.0. It completes the initial review fixes and the follow-on standards
> alignment work without declaring the schema stable yet.

### Added

- **`special_case_rules_extensionless`** block (`base-metadata.yaml`): Adds structured
  rules and known basenames for extension-less templates.
- **Extension-less naming examples** added to `naming_convention.examples`
  (`base-metadata.yaml`).
- **Lint rule for extension-less filename validation** and extension-less special-case
  validation (`base-metadata.yaml`).
- **`lint_extension_overrides` entries** for `editorconfig`, `env`, `node`, and
  `typescript` (`base-metadata.yaml`).

### Changed

- **`naming_convention.pattern` split into `pattern_with_extension` and
  `pattern_extensionless`** (`base-metadata.yaml`): Removes the ambiguity between normal
  and extension-less templates.
- **`project.default_date` replaced with `project.default_created` and
  `project.default_last_updated`** (`base-metadata.yaml`): Aligns project defaults with
  canonical metadata field names.
- **Comment-block METADATA field order corrected** (`base-metadata.yaml`): Reordered to
  match canonical `required_order`.
- **`metadata_fields.filename` and related naming guidance clarified**
  (`base-metadata.yaml`): Updated to reference both naming patterns explicitly.
- **Changelog entry template placeholders aligned** (`base-metadata.yaml`): Date is now
  quoted as `"YYYY-MM-DD"`, and author uses `{authorname}` consistently.
- **`env` added to `comment_styles.hash`** (`base-metadata.yaml`), and lint/date rules,
  rules-change-codes references, and `mdx` override wording were clarified.

### Design Decisions

- **Pre-1.0 minor bumps instead of a premature 1.0.0**: Today’s changes materially
  improved the schema, but they were still iterative cleanup and standards alignment,
  not the final stability point for a 1.0.0 declaration.

---

## [0.9.0] — 2026-05-01

> **Milestone: Naming Convention Split — Extension and Extension-less Patterns**

### Changed

- **`naming_convention.pattern` split into `pattern_with_extension` and
  `pattern_extensionless`** (`base-metadata.yaml`): The single `pattern` key was
  ambiguous for extension-less files (`dockerfile`, `editorconfig`, etc.). Two explicit
  keys now govern the two cases independently, eliminating the contradiction identified
  in the review.
- **Naming rules clarified** (`base-metadata.yaml`): Rules updated to reference the
  correct pattern key for each file type.
- **Author defaults and `initial_changelog_entry.author` value updated**
  (`base-metadata.yaml`): Aligned with `authorname: "Steven Paradise"` throughout.
- **Standards alignment pass** (`base-metadata.yaml`): Metadata ordering, style/profile
  mapping, and cross-reference consistency pass completing review items 1–6.

---

## [0.8.0] — 2026-04-26

> **Milestone: Schema Integrity — Audit-Driven Corrections**
> This release resolves all findings from a comprehensive 15-category cross-file alignment
> audit. Every critical and moderate finding was addressed. Both files now fully comply
> with the metadata schema they define.

### Added

- **`changelog_entry_template` top-level YAML key** (`base-metadata.yaml`): The changelog
  entry template was previously documented only as a `# CHANGELOG ENTRY TEMPLATE` comment
  block. The README referenced it by key name (`changelog_entry_template:`), but no such
  key existed in the YAML. The key is now a proper first-class top-level YAML field,
  eliminating the forward-reference error and making the template discoverable
  programmatically.
- **`schema_version: "1.0.0"` in README frontmatter** (`base-metadata-README.md`): The
  README's own YAML frontmatter was missing the `schema_version` required field defined
  by the schema it documents. The field is now present, bringing the file into compliance
  with its own rules.
- **`special_case_rules_md` block in `## Special Case Decision Rules` H2**
  (`base-metadata-README.md`): The `.md`-specific special case rules existed only in the
  `## Prompts` H3 subsection, making them invisible to readers scanning the rule-reference
  H2 sections. A full `special_case_rules_md` block (using the correct `rules:` sub-key
  structure) is now present in the dedicated H2 section alongside `special_case_rules`.
- **Instructional inline comments** (`base-metadata-README.md`): The README code blocks
  for `project` and `initial_changelog_entry` previously stripped the inline authoring
  instructions present in the YAML source. The following comments are now restored in
  the README code blocks:
  - `project.default_date`: `# Update to today's date when creating a new template`
  - `initial_changelog_entry.date`: `# Replace with today's date`
  - `initial_changelog_entry.author`: `# Replace with author.name`

### Changed

- **README section order corrected — `existing_templates` now precedes
  `special_case_rules`** (`base-metadata-README.md`): The README previously placed
  `## Special Case Decision Rules` (position 17) before `## Existing Templates (YAML Style)`
  (position 18), which is the reverse of the YAML source order. This also inverted the
  logical dependency: a consumer must know which templates already exist *before* deciding
  whether to add a special case suffix. Both sections are now in YAML-source order:
  `existing_templates` → `special_case_rules`.
- **`folder_convention` examples unquoted in README** (`base-metadata-README.md`): The
  folder path examples were quoted strings in the README
  (`- "_templates/powershell/"`) but bare YAML scalars in the source
  (`- _templates/powershell/`). The README code block now uses unquoted values, matching
  the YAML source exactly.
- **README frontmatter field names updated to canonical schema names**
  (`base-metadata-README.md`): The README frontmatter used non-canonical field names that
  would fail a lint pass under the schema it defines. Fields renamed:

  | Old (non-canonical) | New (canonical) |
  | --- | --- |
  | `authorname` | `author` |
  | `created` | `date` |
  | `last_updated` | `lastmod` |

- **Prompts H3 `### Special Case Decision Rules — .md Files` replaced with
  cross-reference** (`base-metadata-README.md`): The H3 code block contained the
  pre-0.7.0 flat-list structure for `special_case_rules_md`, which was YAML-invalid (it
  mixed sequence items and a mapping key at the same indentation level under
  `special_case_rules_md:`). The H3 now contains a single cross-reference sentence
  pointing to the canonical `## Special Case Decision Rules` H2 section where the correct
  structure is fully documented.
- **Version bumped: 0.7.0 → 0.8.0** in all four version locations (YAML comment block
  header, YAML flat `version:` field, README frontmatter `version:`, README
  `current_release_label`).

### Fixed

- **`ini` removed from `comment_styles.hash` group** (both files): `.ini` files use `;`
  as the standard comment character. `ini` was incorrectly listed in both the `hash`
  group and the `semicolon` group simultaneously. Any linter consuming this mapping could
  not determine which style to enforce. `ini` now appears only in `semicolon: ["ini",
  "reg"]`.
- **`special_case_rules_md` structure in Prompts H3 was YAML-invalid**
  (`base-metadata-README.md`): The pre-existing Prompts H3 code block used a flat-list
  format (`- if: ...`) mixed with a mapping key (`known_special_cases:`) at the same
  indentation level under `special_case_rules_md:`. This is a YAML parse error. The
  correct `rules:` sub-key structure (introduced in 0.7.0 to the YAML source) was never
  propagated to the README's Prompts H3. Fixed by replacing the broken code block with
  a cross-reference (see Changed above).

### Design Decisions

- **`changelog_entry_template` added as first-class key rather than comment only**: The
  template existed in a comment block, which is appropriate for human readers. However,
  the README documented it as a named YAML key that an AI consumer could reference. Adding
  it as a top-level key preserves both the comment (for humans) and the addressable key
  (for automated tooling), without changing any existing behavior.
- **README frontmatter compliance**: Because `base-metadata-README.md` is intended to be
  processed by the same linting rules it defines (it is itself a `.md` file subject to
  `yaml_frontmatter` lint profile), its frontmatter must use the canonical field names.
  Using `authorname`, `created`, and `last_updated` was a legacy holdover from before the
  canonical field names were fully established in 0.6.0.
- **`ini` belongs in `semicolon`, not `hash`**: `.ini` files conventionally use `;` for
  comments (per the original INI file specification and Windows Registry convention).
  Listing `ini` in `hash` was an error of inclusion — likely carried forward from a broad
  "config files" grouping — rather than a deliberate dual-style designation like `bat/cmd`
  (which intentionally appear in both `hash` and `rem`).

---

## [0.7.0] — 2026-04-26

> **Milestone: Schema Completeness — Inventory and Decision Rules**
> This release adds the two sections that were documented in the README but absent from
> the YAML: the full existing-template inventory and the special case naming decision
> rules. It also corrects the author placeholder that propagated through the initial draft.

### Added

- **`existing_templates` section** (`base-metadata.yaml` and `base-metadata-README.md`):
  A machine-readable inventory of all known templates, organised by 31 language/type
  categories. Each category lists all associated template filenames. Categories include:
  `autoit`, `batch`, `csharp`, `markdown`, `powershell`, `react`, `yaml`, `yml`, `json`,
  `jsonc`, `html`, `css`, `javascript`, `python`, `perl`, `shell`, `sql`, `terraform`,
  `toml`, `xml`, `wsf`, `vbs`, `ini`, `registry`, `mermaid`, `nushell`, `tcc`,
  `dockerfile`, `git`, `hta`, `node`, `typescript`.
- **`special_case_rules` section** (`base-metadata.yaml` and `base-metadata-README.md`):
  A structured list of three general naming decision rules governing when to add a
  `{special_case}` suffix to any template filename:
  1. First template for an extension → no special case, use base pattern.
  2. Same extension, different purpose → add `{special_case}` suffix.
  3. Purpose duplicates existing template → update the existing template instead.
- **`special_case_rules_md` section** (`base-metadata.yaml` and `base-metadata-README.md`):
  Markdown-specific variant of `special_case_rules`, with the same three decision rules
  scoped to `.md` files, plus an enumerated `known_special_cases` list: `changelog`,
  `conversational-ai`, `how-to`, `new-markdown-document`, `prompt-session`, `readme`,
  `runbook`. The YAML structure uses a `rules:` sub-key to maintain consistent mapping
  semantics (avoids mixing sequence items and mapping keys at the same level).

### Fixed

- **`author.name` corrected from placeholder to actual maintainer**
  (`base-metadata.yaml`): `author.name` was set to the placeholder string `"Your Name"`.
  It now reads `"Steven Paradise"`, matching the `authorname` declared in the README
  frontmatter and the `author` field declared in all changelog entries.

### Design Decisions

- **`special_case_rules_md` uses `rules:` sub-key rather than a flat list**: Using a flat
  sequence directly under `special_case_rules_md:` would have placed `known_special_cases:`
  at the same level as the sequence items, which is a YAML structural ambiguity. The
  `rules:` sub-key cleanly separates the decision logic from the enumeration list,
  making both independently addressable.
- **`existing_templates` ordered by section position, not alphabetically**: The
  categories follow the order in which template families were created / are most commonly
  used (shell languages first, then web, then data, then infrastructure), reflecting
  practical working priority rather than lexicographic sort order.
- **`node` and `typescript` categories overlap with `json`/`react`**: Some template files
  appear in multiple categories by design. `template-json-with-metadata-package.json`
  appears in both `node` and `json` because it is physically a JSON file but semantically
  a Node artefact. `template-json-with-metadata-tsconfig.json` similarly appears in both
  `json` and `typescript`. This is an intentional cross-reference, not a duplication
  error.

---

## [0.6.0] — 2026-04-26

> **Milestone: Linting Framework — Formal Validation Rules**
> This release establishes the full linting framework: canonical field ordering,
> `schema_version` as a required field, and four explicit lint sections covering common
> rules, per-profile rules, extension overrides, and severity tiers.

### Added

- **`metadata_fields.required_order` array** (`base-metadata.yaml` and
  `base-metadata-README.md`): A canonical sequence specifying the order in which all
  8 required metadata fields must appear in any generated template:
  `title` → `description` → `author` → `schema_version` → `version` → `filename` →
  `date` → `lastmod`.
- **`schema_version` as required metadata field** (`base-metadata.yaml` and
  `base-metadata-README.md`): `schema_version` elevated to a required field in
  `metadata_fields.required` and added to `required_order` at position 4 (after `author`,
  before `version`). Purpose: tracks the version of the metadata *standard* used to
  generate the file, independently of the document's own `version`. Initial value
  for all new templates: `"1.0.0"`. The native flat field on `base-metadata.yaml` itself
  is set to `"1.0.0"`.
- **`lint_rules_common` section** (`base-metadata.yaml` and `base-metadata-README.md`):
  Common lint rules applicable to all file types regardless of profile:
  - `required_metadata_fields` list (8 fields)
  - `required_order` list (8 fields, same sequence as `metadata_fields.required_order`)
  - 6 prose rules covering version sync, changelog ordering, date format, filename
    pattern compliance, and folder placement.
- **`lint_profiles` section** (`base-metadata.yaml` and `base-metadata-README.md`):
  8 profile blocks, each with an `applies_to` extension list and 1–2 profile-specific
  rules. Profiles: `yaml_frontmatter`, `native_yaml`, `comment_block`, `json_keys`,
  `jsonc_keys`, `xml_elements`, `hashtable`, `label_block`. These profiles correspond
  1:1 to the 8 `metadata_block_styles` defined in the schema.
- **`lint_extension_overrides` section** (`base-metadata.yaml` and
  `base-metadata-README.md`): Per-extension rules that supplement or override the matched
  profile. Six entries: `md`, `mdx`, `psd1`, `reg`, `dockerfile`, `gitignore`.
- **`lint_severity` section** (`base-metadata.yaml` and `base-metadata-README.md`):
  Three severity tiers with enumerated violation examples:
  - `critical` — Missing required fields, wrong metadata block style, version mismatch,
    malformed changelog.
  - `moderate` — Wrong field order, filename/folder convention violation, unknown change
    code.
  - `minor` — Style inconsistencies that do not break parsing, absent optional fields.

### Changed

- **`native_yaml` description updated** (`base-metadata.yaml` and
  `base-metadata-README.md`): Clarified that `native_yaml` uses top-level YAML keys
  directly in the document, and that a `metadata:` wrapper key should only be used when
  the target format explicitly requires it (previously implied ambiguously).
- **README sections reordered to mirror YAML structure** (`base-metadata-README.md`):
  All documentation sections were reorganised so their H2 sequence exactly follows the
  top-level key order in `base-metadata.yaml`:
  Author → Project → Naming Convention → Folder Convention → Metadata Fields →
  Initial Changelog → CHANGELOG USAGE → Comment Style → Metadata Block Style →
  Lint Rules → Lint Profiles → Lint Overrides → Lint Severity → (new) Special Case Rules.
  The README is intended to be a complete, ordered documentation mirror of the YAML
  source; divergence in section order causes AI consumers to misread the schema hierarchy.

### Design Decisions

- **`schema_version` tracks spec version, not document revision**: The distinction between
  `version` (document iteration) and `schema_version` (metadata specification version) was
  a deliberate design choice to allow the underlying metadata standard to evolve
  independently of individual template files. A template at document `v1.4.0` might still
  use schema `1.0.0` if the metadata specification has not changed.
- **`lint_profiles` mirror `metadata_block_styles` 1:1**: The deliberate correspondence
  between the 8 block styles and the 8 lint profiles means that determining which lint
  rules apply to a file is a single map lookup: find the file extension in
  `metadata_block_styles`, get the style name, look up that name in `lint_profiles`.
  This avoids multiple conditional branches in any linting toolchain.

---

## [0.5.0] — 2026-04-26

> **Milestone: Prompts Section — AI-Assisted Template Creation and Evaluation**
> This release promotes the AI prompt guide to a formal section of the README and adds a
> second base prompt for evaluating existing files. It also introduces
> `.md`-specific special case rules and the `with_tables` flag.

### Added

- **`## Prompts` H2 section** (`base-metadata-README.md`): A dedicated top-level section
  grouping all AI-consumption prompts and worked examples as named H3 subsections. Previous
  prompt content existed at the H2 level and was not clearly grouped.
- **`### Base Prompt — Evaluate an Existing File`** (`base-metadata-README.md`): A
  12-point evaluation checklist for auditing an existing file against the schema. Each
  check is phrased as a `PASS / FAIL / WARN` assertion, covering: naming convention,
  folder placement, metadata style, required fields, field order, version sync, schema
  version, changelog format, change codes, comment style, initial version, and lint
  profile compliance. Results are grouped by `CRITICAL / MODERATE / MINOR` severity.
- **`with_tables` flag in the `.md` example request** (`base-metadata-README.md`):
  The `.md` example request YAML block gains a `with_tables: false` flag (default `false`)
  and explanatory notes. Setting it `true` permits markdown tables in the template body;
  `false` requires YAML-fenced blocks or lists instead. This reflects the lint override
  rule `"Markdown tables are allowed only when explicitly requested"`.
- **`### Special Case Decision Rules — .md Files`** (`base-metadata-README.md`):
  An H3 subsection under `## Prompts` documenting the `.md`-specific naming decision
  rules and the initial enumeration of known Markdown special cases: `changelog`,
  `conversational-ai`, `how-to`, `new-markdown-document`, `prompt-session`, `README`,
  `runbook`. *(Formalised as a YAML data structure in 0.7.0.)*

### Changed

- **`### Base Prompt — Create a New Template` and examples demoted to H3 under
  `## Prompts`** (`base-metadata-README.md`): The create-template prompt and its worked
  examples (`### Example: Create a New .md Template`, `### Example: Create a New .ts
  Template`) were previously at a level that implied they were standalone reference
  material. They are now properly nested as H3 subsections under the `## Prompts` H2,
  making the information hierarchy clearer.

### Fixed

- **README `authorname` corrected to `Steven Paradise`** (`base-metadata-README.md`):
  The README frontmatter `authorname` field had a stale or incorrect value. Corrected to
  `"Steven Paradise"`.
- **README workspace paths corrected** (`base-metadata-README.md`): Snapshot location
  examples and base prompt file path references were updated to reflect the correct
  workspace root: `${WORKSPACE_ROOT}`.
- **Snapshot version labels corrected** (`base-metadata-README.md`): The
  `current_release_label` and `previous_release_label` fields in `## Current Status` were
  updated to reflect the current versioning state.

### Design Decisions

- **Evaluate prompt follows the same schema key sequence as the create prompt**: The 12
  evaluation checks in the evaluate prompt are ordered to mirror the YAML key sequence
  (naming → folder → style → fields → order → version → changelog → codes → comments →
  lint), making it easy to trace each check back to its governing section in the YAML
  without a cross-reference lookup.
- **`with_tables` defaults to `false`**: Markdown tables are a lint exception that must
  be explicitly requested in the prompt brief. Defaulting to `false` enforces the rule
  that structure-heavy content should use YAML fenced blocks, which are more parseable and
  diff-friendly than markdown tables.

---

## [0.4.0] — 2026-04-26

> **Milestone: Dual-Location Versioning Rule**
> This release codifies the rule that version numbers must be kept in sync across two
> locations, and clarifies the YAML frontmatter requirement for Markdown templates.

### Added

- **Dual-location version bump rule in `# USAGE` block** (`base-metadata.yaml`):
  Explicit prose rule stating that when bumping the version of any file derived from this
  template, two locations must always be updated together:
  1. The `# METADATA` comment block at the top of the file (`version:` field).
  2. The native metadata field in the document body (frontmatter, top-level key, or
     equivalent).
  A mismatch between these two locations indicates an inconsistent file.
- **Markdown files YAML frontmatter requirement in `# USAGE` block**
  (`base-metadata.yaml`): Explicit prose rule: templates generated for `.md` files must
  use YAML frontmatter (triple-dash `---` delimiters). All other file types follow
  `metadata_block_styles`.
- **Dual-location version bump rule in `## CHANGELOG USAGE`** (`base-metadata-README.md`):
  The same rule added to the YAML `# USAGE` block is now also documented in the README's
  `## CHANGELOG USAGE` section, so that both the source file and the documentation guide
  convey the constraint.

### Design Decisions

- **Two-location version rule rather than single-source**: The comment block `# METADATA`
  serves humans and tools that read raw file headers without parsing the full document.
  The native metadata field serves tools that parse the document structure. Both must be
  present and consistent. Having a single location would require every consumer to parse
  the full document, which is impractical for quick header inspection.

---

## [0.3.0] — 2026-04-26

> **Milestone: Native YAML Style — Removed Frontmatter Marker**
> This release corrects the fundamental style error of placing YAML frontmatter delimiters
> on a `.yaml` file.

### Removed

- **YAML frontmatter `---` marker at the top of `base-metadata.yaml`**: The file
  previously began with `---`, which is the YAML document-start delimiter used by
  Markdown processors to delimit YAML frontmatter. This is inappropriate for a `.yaml`
  file, which is itself a native YAML document. Its presence could confuse parsers that
  treat `---` as a multi-document boundary, and it was inconsistent with the
  `native_yaml` metadata block style defined in `metadata_block_styles` for `.yaml`
  and `.yml` files.

### Design Decisions

- **`native_yaml` style for `.yaml` files means top-level keys directly**: A `.yaml` file
  is already a native YAML document. There is no wrapper required. The correct representation
  of metadata on a `.yaml` file is a set of top-level keys (`title:`, `version:`, etc.)
  at the root of the document, not delimited by `---`. The `---` delimiter is reserved
  for Markdown files (via `yaml_frontmatter` block style) and YAML multi-document streams.

---

## [0.2.0] — 2026-04-26

> **Milestone: Initial Alignment Pass — Eight Correctness Fixes**
> The files were loaded and audited together for the first time. Eight structural and
> semantic misalignments were identified and resolved.

### Changed

- **`title` corrected in comment block METADATA and flat field** (`base-metadata.yaml`):
  The title was describing a different file type (a Markdown template). Corrected to
  `"Base Metadata — Shared Values for All Templates"`, which accurately describes the
  YAML file's purpose as a shared-values source of truth.
- **`filename` corrected** (`base-metadata.yaml`): The `filename` flat field and the
  `# METADATA` filename annotation were set to an incorrect value. Corrected to
  `"base-metadata.yaml"`.
- **`description` corrected** (`base-metadata.yaml`): The `description` field was
  describing a different artefact. Corrected to
  `"Single source of truth for author, project, and versioning defaults"`.
- **Workspace paths corrected** (both files): All workspace path references were missing
  the `GitHub` path segment. Corrected to use the portable `${WORKSPACE_ROOT}`
  placeholder.
- **Comment block `# METADATA` dates and author corrected** (`base-metadata.yaml`):
  The `created`, `last_updated`, and `authorname` fields in the comment header were
  stale or incorrect. Updated to reflect the actual creation date (`2026-04-24`) and
  maintainer (`Steven Paradise`).
- **README filename reference corrected** (`base-metadata-README.md`): The README
  `filename` frontmatter field and internal references were updated to match the
  actual filename `base-metadata-README.md`.
- **Version and release labels aligned** (both files): The `version` field and the
  `current_release_label` / `previous_release_label` values in the README `## Current
  Status` block were updated to be consistent with each other.

### Fixed

- **Duplicate `author:` key removed** (`base-metadata.yaml`): The file contained two
  `author:` keys: one as a flat string (`author: "Steven Paradise"`) and one as a nested
  mapping (`author: name/email/organisation`). YAML's last-wins rule meant the flat
  string was silently ignored. The flat string duplicate was removed; only the nested
  mapping form is retained, as it is more complete and structured.
- **Malformed `initial_changelog_entry` YAML** (`base-metadata.yaml`): The `changes`
  block under `initial_changelog_entry` used inconsistent indentation (mixed tabs and
  spaces), causing a YAML parse warning. The block was reformatted to consistent
  two-space indentation.

### Design Decisions

- **Nested `author` mapping retained over flat string**: A nested mapping
  (`author.name`, `author.email`, `author.organisation`) is more machine-readable and
  allows downstream tools to extract individual components without string-splitting.
  The flat `"Steven Paradise"` form is still used in changelog entries (as prose) and
  in `initial_changelog_entry.author` (as a fill-in placeholder), but the canonical
  author record is always the nested mapping.

---

## [0.1.0] — 2026-04-24

> **Milestone: Initial Creation**

### Added

- **`base-metadata.yaml`** — Initial file created. Establishes the base template schema
  for shared metadata defaults. Contains:
  - `# METADATA` comment block with title, description, filename, authorname,
    version, created, last_updated.
  - `# CHANGELOG` comment block with the 0.1.0 entry.
  - `# USAGE` prose block describing how the file is consumed by the README prompt guide.
  - Flat metadata fields: `title`, `description`, `version`, `filename`, `date`, `lastmod`.
  - `author` section: `name`, `email`, `organisation`.
  - `project` section: `workspace`, `templates_dir`, `default_version`, `default_date`.
  - `naming_convention` section: `pattern`, 5 examples, 4 rules.
  - `folder_convention` section: `pattern`, 4 examples, 4 rules.
  - `metadata_fields` section: `required` list (7 fields), `rules` (3 rules).
    *(Note: `schema_version` not yet a required field; `required_order` not yet defined.)*
  - `initial_changelog_entry` block with version, date, author, changes.
  - `# CHANGELOG USAGE` comment block with 13 SEMANTIC CHANGE CODES (BRK, CFG, CHG,
    DEL, DEP, DOC, FIX, IMP, OPS, REF, SEC, TST, WIP) and entry template.
  - `comment_styles` mapping: 11 groups covering all supported file extensions.
  - `metadata_block_styles` mapping: 8 styles (yaml_frontmatter, native_yaml,
    comment_block, json_keys, jsonc_keys, xml_elements, hashtable, label_block).

- **`base-metadata-README.md`** — Initial documentation guide created. Contains:
  - YAML frontmatter with filename, title, description, authorname, version, created,
    last_updated.
  - Versioning Recommendation section with three-layer snapshot approach.
  - Current Status block with release labels.
  - Documentation sections mirroring the YAML: Author/Owner, Project, Naming Convention,
    Folder Convention, Metadata Fields, Initial Changelog, CHANGELOG USAGE, Comment
    Style, Metadata Block Style.
  - `## Base Prompt — Create a New Template` with 10-requirement prompt text.
  - Example request blocks for `.md` and `.ts` file types.
  - Contents, Recommended Release Workflow, and Comparison Tips sections.

---

[0.12.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.11.0...v0.12.0
[0.11.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.9.0...v0.10.0
[0.9.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/Diceman175/My-Engineering-Cockpit/releases/tag/v0.1.0
[Unreleased]: https://github.com/Diceman175/My-Engineering-Cockpit/compare/v0.12.0...HEAD
