---
title:         "Metadata Schema — Prompt Guide for Creating New Templates"
description:   "How to create and version template docs using shared metadata defaults"
author:        "Steven Paradise"
filename:      "metadata-schema.readme.md"
schema_version: "2.0.0"
version:       "2.0.0"
date:          "2026-04-24"
lastmod:       "2026-05-02"
---

# _metadata-schema — Versioned Guide

This folder is the single source of truth for shared metadata values and template rules.
Use it to keep template creation consistent, and to keep README revisions auditable.

## Versioning Recommendation

Use a three-layer approach:

1. Keep one canonical working file in each template folder root.
2. Snapshot each folder into its own version directory:
- `ansible/versions/0.1.0 (2026-04-24)/...`
- `powershell/versions/0.2.0 (2026-04-26)/...`
- `markdown/versions/0.2.0 (2026-04-26)/...`
1. Track all changes in git for line-level diff and blame.

This gives you fast comparison at both levels:
- human-readable version snapshots
- git-level history and exact diffs

## Current Status

```yaml
document:
  current_release_label: "2.0.0 (2026-05-02)"
  previous_release_label: "0.13.0 (2026-05-01)"
  production_location: "each template folder root"
  snapshot_location_pattern: "<template-folder>/versions/x.y.z (YYYY-MM-DD)/<filename>"
```

## Canonical Naming Map (Current)

```yaml
canonical_naming_map:
  governance_docs:
    - metadata-schema.changelog-governance.md
    - metadata-schema.encoding-governance.md
    - metadata-schema.naming-governance.md
  governance_rules:
    - metadata-schema.changelog-rules.jsonc
    - metadata-schema.changelog-rules.yaml
    - metadata-schema.changelog-rules.schema.json
    - metadata-schema.encoding-rules.yaml
    - metadata-schema.encoding-rules.schema.json
    - metadata-schema.naming-rules.yaml
    - metadata-schema.naming-rules.schema.json
    - metadata-schema.existing-templates.schema.json
```

## Compatibility Policy

```yaml
compatibility_policy:
  schema_version:
    minor: "Backward-compatible schema clarifications and additive rule updates"
    major: "Breaking changes to required fields, required_order, or consumer-visible object shapes"
  file_naming:
    rule: "Once a governance family adopts dotted sidecar naming, hyphenated alternates are not allowed"
  migration_expectation:
    rule: "Any breaking change requires a changelog entry with explicit migration notes"
```

## Owner Profile

```yaml
owner:
  name: "Steven Paradise"
  email: "steveparadise@me.com"
  organisation: "My-Engineering-Cockpit"
```

## Project / Workspace Defaults

```yaml
project:
  workspace: "${WORKSPACE_ROOT}"
  templates_dir: "${WORKSPACE_ROOT}/_templates"
  current_schema_version: "2.0.0"  # Canonical schema_version for all new metadata-governed files
  default_version: "0.1.0"
  default_date: "YYYY-MM-DD"          # Update to today's date when creating a new template
  default_lastmod: "YYYY-MM-DD"       # Same as date on first version; update on subsequent revisions
```

## Naming Convention

```yaml
naming_convention:
  pattern_with_extension: "template-{ext}-with-metadata[-{special_case}].{ext}"
  pattern_extensionless: "template-{basename}-with-metadata[-{special_case}]"
  examples:
    - "template-ps1-with-metadata.ps1"
    - "template-md-with-metadata.md"
    - "template-prompt-with-metadata.prompt"
    - "template-md-with-metadata-changelog.md"
    - "template-yml-with-metadata-github-actions.yml"
    - "template-tsx-with-metadata-component.tsx"
    - "template-gitignore-with-metadata"
    - "template-env-with-metadata"
  rules:
    - "Use the file extension (not the language name) as {ext}"
    - "Use the basename as {basename} for extension-less templates such as dockerfile, editorconfig, env, and gitignore"
    - "Only add -{special_case} when the file has a distinct purpose within the same extension"
    - "Extension-less files append -with-metadata directly: template-gitignore-with-metadata"
    - "All names are lowercase with hyphens only — no underscores, no spaces"
```

## Folder Convention

```yaml
folder_convention:
  pattern: "_templates/{language-or-type}/"
  examples:
    - _templates/powershell/
    - _templates/markdown/
    - _templates/react/
    - _templates/git/
  rules:
    - "Folder name is the language or ecosystem name, not the extension"
    - "Exception: git/ holds .gitignore and .editorconfig"
    - "Exception: react/ holds all React-specific variants (.tsx, .ts, .scss)"
    - "Exception: node/ holds package.json"
```

## Metadata Block — Required Fields for Every Template

```yaml
metadata_fields:
  required:
    - title: "One-line human-readable title"
    - description: "Brief description of the file's purpose"
    - author: "Author name — use the top-level author value from this file"
    - filename: "The actual filename this template will be saved as (must match naming_convention patterns)"
    - schema_version: "Version of the metadata standard used by the file"
    - version: "Semantic version starting at 0.1.0 (MAJOR.MINOR.PATCH)"
    - date: "ISO 8601 creation/publish date — YYYY-MM-DD"
    - lastmod: "ISO 8601 last modified date — YYYY-MM-DD (same as date on first version)"
  required_order:
    - title
    - description
    - author
    - filename
    - schema_version
    - version
    - date
    - lastmod
  rules:
    - "Required metadata fields must appear in required_order unless a file-type style explicitly overrides layout"
    - "The version in the METADATA comment block and the native metadata block must always match"
    - "schema_version tracks the metadata specification version, not the document revision"
    - "Bump schema_version when required fields, field names, canonical ordering, or consumer-visible object shapes change"
```

## Standard Initial Changelog Entry

```yaml
initial_changelog_entry:
  version: "0.1.0"
  date: "YYYY-MM-DD"     # Replace with today's date
  author: "Steven Paradise"    # Replace with author
  changes:
    - code: "IMP"
      note: "Initial {description} setup with metadata template"
```

## CHANGELOG USAGE

```text
The most recent change entries are on top.
Reference change-governance rules from _templates/_metadata-schema/metadata-schema.changelog-rules.jsonc for semantic versioning.
Copy and paste this block above the previous most recent entry.
After adding an entry, update the version in BOTH locations:
  1. The METADATA comment block at the top of the file (version field)
  2. The native metadata field in the document body
These two must always match.
```

```text
SEMANTIC CHANGE CODES

  BRK  Breaking changes          major bump
  CFG  Configuration changes     minor bump
  CHG  Improvements/refactoring  minor bump
  DEL  File or feature removed   minor bump
  DEP  Dependency updates        patch bump
  DOC  Documentation updates     patch bump
  FIX  Bug fixes                 patch bump
  IMP  New features              minor bump
  OPS  Operational/deployment    patch bump
  REF  Documentation/references  patch bump
  SEC  Security fixes            patch bump
  TST  Tests or CI updates       patch bump
  WIP  Work in progress          none (pre-commit only — do not use in committed changelog entries)
```

```yaml
changelog_entry_template:
  - version: "X.Y.Z"
    date: "YYYY-MM-DD"
    author: "{author}"
    changes:
      - CHG: Short summary of what changed
      - FIX: Another summary of what else changed
```

## Comment Style by File Type

```yaml
comment_styles:
  hash: ["yaml", "toml", "py", "sh", "bash", "pl", "rb", "tf", "nu", "gitignore", "editorconfig", "dockerfile", "env"]
  double_slash: ["js", "ts", "tsx", "jsx", "cs", "jsonc", "mmd"]
  block: ["css", "scss"]
  sql_block: ["sql"]
  xml: ["xml", "html", "hta", "wsf"]
  semicolon: ["ini", "reg"]
  apostrophe: ["vbs"]
  rem: ["bat", "cmd"]
  double_colon: ["btm"]
  cs_block: ["au3"]
  ps_block: ["ps1", "psm1", "psd1"]
  html_comment: ["md", "mdx", "prompt"]
```

## Metadata Block Style by File Type

```yaml
metadata_block_styles:
  yaml_frontmatter:
    extensions: ["md", "mdx", "prompt"]
    description: "YAML delimited by triple-dashes (---) at the top of the file. Required for all .md, .mdx, and .prompt template generation."
  native_yaml:
    extensions: ["yaml", "yml"]
    description: "Top-level YAML keys in the document; use a leading metadata: key only when the target format explicitly requires it or when governance sidecar parity is required with a JSON/JSONC mirror. Governance sidecars may use a dual-header pattern (hash-comment METADATA header plus native YAML keys) as long as both version values stay synchronized. GitHub Actions workflow templates are an approved exception and may use a leading hash-comment metadata block to preserve executable compatibility."
  comment_block:
    extensions: ["ps1", "psm1", "bat", "sh", "py", "pl", "tf", "nu", "au3", "btm", "css", "scss", "js", "ts", "tsx", "jsx", "cs", "toml", "vbs", "ini", "mmd", "dockerfile", "gitignore", "editorconfig", "env"]
    description: "Comment block at the top of the file using the file's native comment syntax"
  json_keys:
    extensions: ["json"]
    description: "Underscore-prefixed keys: _metadata{}, _changelog[], _change_codes[]"
  jsonc_keys:
    extensions: ["jsonc"]
    description: "Metadata inside the JSON object with // comment annotations"
  xml_elements:
    extensions: ["xml", "html", "wsf", "hta"]
    description: "<metadata> and <changelog> XML/HTML elements in the document"
  hashtable:
    extensions: ["psd1"]
    description: "@{} hashtable with # comment header block"
  label_block:
    extensions: ["reg"]
    description: "; comment header at top of file"
```

## Lint Rules — Common

```yaml
lint_rules_common:
  required_metadata_fields:
    - title
    - description
    - author
    - filename
    - schema_version
    - version
    - date
    - lastmod
  required_order_ref: "metadata_fields.required_order"
  rules:
    - "The METADATA comment block version must match the native metadata version"
    - "The oldest changelog entry must start at 0.1.0"
    - "The most recent changelog entry must be first"
    - "date, lastmod, and changelog date fields must use YYYY-MM-DD"
    - "Filename must match naming_convention.pattern_with_extension or naming_convention.pattern_extensionless"
    - "Extension-less filenames must match naming_convention.pattern_extensionless"
    - "Extension-less special-case filenames must follow special_case_rules_extensionless"
    - "Folder location must match folder_convention"
```

## Lint Profiles

```yaml
lint_profiles:
  yaml_frontmatter:
    applies_to: ["md", "mdx", "prompt"]
    rules:
      - "Metadata must be enclosed by --- delimiters"
      - "Field order in frontmatter must follow metadata_fields.required_order"
  native_yaml:
    applies_to: ["yaml", "yml"]
    rules:
      - "Metadata must be represented as top-level YAML keys unless an approved metadata: wrapper is required"
      - "Top-level key order must follow metadata_fields.required_order"
      - "GitHub Actions workflow templates may use a leading hash-comment metadata block when top-level metadata keys would alter workflow runtime semantics"
  comment_block:
    applies_to: ["ps1", "psm1", "bat", "sh", "py", "pl", "tf", "nu", "au3", "btm", "css", "scss", "js", "ts", "tsx", "jsx", "cs", "toml", "vbs", "ini", "mmd", "dockerfile", "gitignore", "editorconfig", "env"]
    rules:
      - "Comment header metadata must use the file's native comment syntax"
      - "Metadata fields in the comment block must follow metadata_fields.required_order"
  json_keys:
    applies_to: ["json"]
    rules:
      - "Metadata must be stored in approved underscore-prefixed keys"
  jsonc_keys:
    applies_to: ["jsonc"]
    rules:
      - "Metadata must be stored in the JSON object with JSONC-compatible comments"
  xml_elements:
    applies_to: ["xml", "html", "wsf", "hta"]
    rules:
      - "Metadata and changelog must be represented as XML/HTML elements"
  hashtable:
    applies_to: ["psd1"]
    rules:
      - "Metadata must be represented in a PowerShell hashtable-compatible layout"
  label_block:
    applies_to: ["reg"]
    rules:
      - "Metadata must be represented in a leading semicolon comment block"
```

## Lint Extension Overrides

```yaml
lint_extension_overrides:
  md:
    rules:
      - "Markdown special-case naming must follow special_case_rules_md when applicable"
      - "Markdown tables are allowed only when explicitly requested by the prompt or template brief"
  mdx:
    rules:
      - "MDX must follow yaml_frontmatter and special_case_rules_md naming rules unless an MDX-specific special case is defined"
  ps1:
    rules:
      - "PowerShell templates may use .METADATA inside a top comment-based help block as long as required fields and required_order are preserved"
  psd1:
    rules:
      - "Hashtable ordering must remain readable and PowerShell-compatible"
  reg:
    rules:
      - "Leading comment metadata must use semicolon-prefixed lines only"
  dockerfile:
    rules:
      - "Treat Dockerfile as hash-comment metadata with extension-less naming rules"
  gitignore:
    rules:
      - "Treat .gitignore as hash-comment metadata with extension-less naming rules"
  editorconfig:
    rules:
      - "Treat .editorconfig as hash-comment metadata with extension-less naming rules"
  env:
    rules:
      - "Treat extension-less env templates as hash-comment metadata with extension-less naming rules"
  github_actions_workflow:
    rules:
      - "GitHub Actions workflow templates may use leading hash-comment metadata instead of top-level YAML metadata keys"
      - "Do not introduce arbitrary top-level metadata keys that would change workflow semantics or invalidate the workflow"
  node:
    rules:
      - "Node package.json templates must follow json_keys metadata style and naming conventions"
  typescript:
    rules:
      - "TypeScript source templates use comment_block style; tsconfig templates use json_keys style"
```

## Lint Severity

```yaml
lint_severity:
  critical:
    - "Missing required metadata fields"
    - "Wrong metadata block style for the extension"
    - "Version mismatch between METADATA comment block and native metadata"
    - "Malformed changelog structure"
  moderate:
    - "Metadata field order does not match metadata_fields.required_order"
    - "Filename or folder placement does not follow convention"
    - "Invalid or unknown change codes"
  minor:
    - "Style inconsistencies that do not break parsing"
    - "Optional metadata fields are absent"
```

## Existing Templates (YAML Style)

```yaml
existing_templates_ref: "metadata-schema.existing-templates.yaml"
metadata_schema_schema_ref: "metadata-schema.schema.json"
```

The full inventory now lives in `metadata-schema.existing-templates.yaml`. Each template
appears once under its canonical owning category: `node` owns `package.json`, and
`typescript` owns `tsconfig.json` and `.ts` source templates.

## Change Governance Sidecars

```yaml
change_governance_ref: "metadata-schema.changelog-governance.md"
change_rules_ref: "metadata-schema.changelog-rules.jsonc"
change_rules_yaml_ref: "metadata-schema.changelog-rules.yaml"
change_rules_schema_ref: "metadata-schema.changelog-rules.schema.json"
validate_ref: "metadata-schema.validate.ps1"
```

These sidecars are now part of the metadata-schema package and replace the prior
standalone `rules-change-codes` folder with a strict change-governance naming family.

Integrated legacy release history from rules-change-codes:

```yaml
legacy_rules_change_governance_releases:
  - version: "1.2.0"
    date: "2026-04-21"
    note: "Created dedicated rules-change-codes changelog and release-promote integration notes"
  - version: "1.1.0"
    date: "2026-04-20"
    note: "Added metadata information to change governance rule assets"
  - version: "1.0.0"
    date: "2026-04-09"
    note: "Implemented initial change-code rule set"
```

## Encoding Governance Sidecars

```yaml
encoding_governance_ref: "metadata-schema.encoding-governance.md"
encoding_rules_ref: "metadata-schema.encoding-rules.yaml"
encoding_rules_schema_ref: "metadata-schema.encoding-rules.schema.json"
```

The repository encoding governance and machine-readable rule matrix now live in this
folder to keep template-generation policy references alongside the metadata schema.

The canonical enforcement script remains at:

```text
tools/utilities/check-encodings.ps1
```

### Encoding Implementation Plan Reference

Comprehensive rollout planning, onboarding templates, and CI templates are maintained in:

```text
${WORKSPACE_ROOT}/AI-Engineering/Projects-Ideas/metadata-schema-encoding-governance
```

Primary planning artifacts:

```yaml
planning_artifacts:
  - metadata-schema-encoding-governance.readme.md
  - metadata-schema-encoding-governance.check-encodings.template.ps1
  - metadata-schema-encoding-governance.encoding-governance.workflow.yml
  - metadata-schema-encoding-governance.editorconfig-baseline.template
  - metadata-schema-encoding-governance.onboarding-playbook.md
```

## Naming Governance Sidecars

```yaml
naming_governance_ref: "metadata-schema.naming-governance.md"
naming_rules_ref: "metadata-schema.naming-rules.yaml"
naming_rules_schema_ref: "metadata-schema.naming-rules.schema.json"
existing_templates_schema_ref: "metadata-schema.existing-templates.schema.json"
```

The governed filename-family policy and machine-readable rule matrix now live in
this folder to keep dotted base-name governance alongside the metadata schema.

### Naming Implementation Plan Reference

Comprehensive rollout planning, onboarding templates, and CI templates are maintained in:

```text
${WORKSPACE_ROOT}/AI-Engineering/Projects-Ideas/metadata-schema-naming-governance
```

Primary planning artifacts:

```yaml
planning_artifacts:
  - metadata-schema-naming-governance.readme.md
  - metadata-schema-naming-governance.check-governed-filenames.template.ps1
  - metadata-schema-naming-governance.naming-governance.workflow.yml
  - metadata-schema-naming-governance.onboarding-playbook.md
```

## CI Integration Package Reference

Portable CI onboarding, path mapping, and enforcement templates are maintained in:

```text
${WORKSPACE_ROOT}/AI-Engineering/Projects-Ideas/metadata-schema-ci-integration
```

Primary CI integration artifacts:

```yaml
ci_integration_artifacts:
  - metadata-schema-ci-integration.readme.md
  - metadata-schema-ci-integration.drop-in-kit-guide.md
  - metadata-schema-ci-integration.repo-onboarding-playbook.md
  - metadata-schema-ci-integration.path-mapping.template.yaml
  - metadata-schema-ci-integration.github-actions.workflow.template.yml
  - metadata-schema-ci-integration.pre-push-hook.template.ps1
```

## Special Case Decision Rules

```yaml
special_case_rules:
  rules:
    - if: "first template for extension"
      action: "do not add special case"
      format: "template-{ext}-with-metadata.{ext}"
    - if: "same extension, different purpose"
      action: "add special case suffix"
      format: "template-{ext}-with-metadata-{special_case}.{ext}"
    - if: "purpose duplicates existing template"
      action: "update existing template instead of creating duplicate"
```

```yaml
special_case_rules_md:
  rules:
    - if: "first template for .md"
      action: "do not add special case"
      format: "template-md-with-metadata.md"
    - if: "same extension, different purpose"
      action: "add special case suffix"
      format: "template-md-with-metadata-{special_case}.md"
    - if: "purpose duplicates existing template"
      action: "update existing template instead of creating duplicate"
  known_special_cases:
    - "changelog"
    - "conversational-ai"
    - "how-to"
    - "new-markdown-document"
    - "prompt-session"
    - "readme"
    - "runbook"
```

## Prompts

### Base Prompt — Create a New Template

```text
Read the file:
  ${WORKSPACE_ROOT}/My-Engineering-Cockpit/Projects/metadata-schema-governance/governed _templates/_templates/_metadata-schema/metadata-schema.yaml

Using the values from that file, create a new template file for the .{EXT} file type.

Requirements:
1. Filename follows naming_convention.pattern_with_extension or naming_convention.pattern_extensionless from metadata-schema.yaml.
2. Use the extension as {ext}; only add -{special_case} when needed per special_case_rules.
3. Place file in correct subfolder per folder_convention.
4. Use metadata block style from metadata_block_styles for this extension.
   - For .md and .mdx files, YAML frontmatter (--- delimiters) is required.
5. Populate required metadata fields from metadata_fields.required in metadata_fields.required_order.
  - Include schema_version and keep it separate from the document version.
6. Add initial changelog from initial_changelog_entry.
   - Version starts at 0.1.0. Bump both the METADATA comment block and the native metadata field.
7. Use the CHANGELOG USAGE comment block for change code reference.
8. Follow lint_rules_common, the matching lint profile, and any lint_extension_overrides for the extension.
9. Use native comment style per comment_styles.
10. Add realistic working content, not placeholder text.
```

### Base Prompt — Evaluate an Existing File

```text
Read the file:
  ${WORKSPACE_ROOT}/My-Engineering-Cockpit/Projects/metadata-schema-governance/governed _templates/_templates/_metadata-schema/metadata-schema.yaml

Evaluate the file at {FILE_PATH} against the rules defined in metadata-schema.yaml.

Check the following and report each finding as PASS, FAIL, or WARN:

1. NAMING         — Does the filename follow naming_convention.pattern?
2. FOLDER         — Is the file in the correct subfolder per folder_convention?
3. METADATA STYLE — Does the metadata block use the correct style for this extension
                    per metadata_block_styles?
                    For .md and .mdx, YAML frontmatter (--- delimiters) is required.
4. REQUIRED FIELDS — Are all fields from metadata_fields.required present and populated?
5. FIELD ORDER    — Do metadata fields appear in metadata_fields.required_order?
6. VERSION SYNC   — Does the version in the METADATA comment block match the native
                    metadata field? Both must always match.
7. SCHEMA VERSION — Is schema_version present and used for metadata standard tracking only?
8. CHANGELOG FORMAT — Do changelog entries match the CHANGELOG ENTRY TEMPLATE format?
9. CHANGE CODES   — Are all change codes valid per the SEMANTIC CHANGE CODES list?
10. COMMENT STYLE  — Does the file use the correct comment syntax per comment_styles?
11. INITIAL VERSION — Does the first (oldest) changelog entry start at 0.1.0?
12. LINT PROFILE  — Does the file comply with lint_rules_common, the matching lint profile,
                    and any lint_extension_overrides?

After the evaluation, list all recommended changes grouped by severity:
  CRITICAL  — Structural or spec violations that must be fixed
  MODERATE  — Inconsistencies that should be fixed
  MINOR     — Style or clarity improvements
```

### Example: Create a New .md Template

```yaml
example_request:
  ext: "md"
  special_case: "runbook"
  description: "Operational runbook with metadata tracking"
  expected_filename: "template-md-with-metadata-runbook.md"
  expected_folder: "_templates/markdown/"
  with_tables: false          # Set to true to permit markdown tables in the template body
  notes:
    - "Use YAML frontmatter (--- delimiters) for the metadata block"
    - "Use YAML fenced blocks in body"
    - "If with_tables is false, use YAML fenced blocks or lists instead of markdown tables"
    - "If with_tables is true, markdown tables are permitted in the body"
```

### Example: Create a New .ts Template

```yaml
example_request:
  ext: "ts"
  special_case: "express-router"
  description: "Express router with typed handlers and metadata"
  expected_filename: "template-ts-with-metadata-express-router.ts"
  expected_folder: "_templates/typescript/"
  notes:
    - "Use JSDoc header"
    - "Use // for code comments"
    - "Include input validation and exports"
```

### Special Case Decision Rules — .md Files

See `## Special Case Decision Rules` above for the `special_case_rules_md` definition and known special cases.

## Contents of This Folder (YAML Style)

```yaml
contents:
  - file: "metadata-schema.yaml"
    purpose: "Shared author, project, naming, style, and lint defaults"
  - file: "metadata-schema.schema.json"
    purpose: "JSON schema for validating metadata-schema.yaml structure"
  - file: "metadata-schema.readme.md"
    purpose: "Live guide aligned to the YAML source of truth"
  - file: "metadata-schema.changelog.md"
    purpose: "Versioned change history and migration notes"
  - file: "metadata-schema.existing-templates.yaml"
    purpose: "Sidecar inventory of existing templates"
  - file: "metadata-schema.existing-templates.schema.json"
    purpose: "JSON schema for validating existing-template inventory sidecar assets"
  - file: "metadata-schema.changelog-governance.md"
    purpose: "Canonical semantic change-governance policy"
  - file: "metadata-schema.changelog-rules.jsonc"
    purpose: "JSONC machine-readable change-rule matrix"
  - file: "metadata-schema.changelog-rules.yaml"
    purpose: "YAML mirror of machine-readable change rules"
  - file: "metadata-schema.changelog-rules.schema.json"
    purpose: "JSON schema for validating change-rule metadata assets"
  - file: "metadata-schema.encoding-governance.md"
    purpose: "Repository-wide encoding governance policy and operating guidance"
  - file: "metadata-schema.encoding-rules.yaml"
    purpose: "Machine-readable encoding policy matrix for lint and automation"
  - file: "metadata-schema.encoding-rules.schema.json"
    purpose: "JSON schema for validating encoding-rule metadata assets"
  - file: "metadata-schema.naming-rules.schema.json"
    purpose: "JSON schema for validating naming-rule metadata assets"
  - file: "metadata-schema.validate.ps1"
    purpose: "Enterprise baseline validator for references, portability placeholders, and required-order consistency"
```

## Recommended Release Workflow

```yaml
release_workflow:
  - step: "Keep production templates in each folder root"
    output: "_templates/<folder>/<files>"
  - step: "Create per-folder snapshot release"
    output: "_templates/<folder>/versions/x.y.z (YYYY-MM-DD)/<files>"
  - step: "Run manifest-driven metadata updater"
    output: "Updated production template metadata"
  - step: "Optionally write run summary per folder"
    output: "run-summary.json in each version folder"
  - step: "Commit with change code"
    output: "DOC or CHG commit"
```

## Comparison Tips

```yaml
comparison:
  quick:
    - "Compare production file with its folder snapshot, e.g. ansible/template-yml-with-metadata-ansible-playbook.yml vs ansible/versions/0.1.0 (2026-04-24)/template-yml-with-metadata-ansible-playbook.yml"
  detailed:
    - "Use git diff for line-level inspection"
  release_gate:
    - "Do not publish a new version until snapshot is saved"
```
