> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Testing

Two independent testing surfaces exist in the inventory: the CI workflow (lint + smoke) and a standalone driver diagnostic. There is no automated unit-test suite for the scraper in this inventory.

## CI workflow (`.github/workflows/ci.yml`)

Triggers: `pull_request` and `workflow_dispatch` (not pushes to `main`). Two jobs, both on `ubuntu-latest`:

### `markdown-lint`

- Checks out with `actions/checkout@v6`.
- Runs `DavidAnson/markdownlint-cli2-action@v18` with explicit globs: `README.md`, `CHANGELOG.md`, `RELEASE_CHECKLIST.md`.
- What it catches: markdown style violations in those three files, governed by the repository's `.markdownlint.json` (rules `MD013` line-length, `MD032` lists, `MD033` inline HTML, `MD036` emphasis-as-heading and `MD060` are disabled; `MD024` is set to `siblings_only` and `MD025` to a `front_matter_title` mode). The config's description says it is a committed copy synced from a canonical workspace source (`governator175`), so local edits may be overwritten by the sync script.

### `python-quality`

- Sets up Python 3.12 via `actions/setup-python@v5`.
- Installs `ruff` (after upgrading pip) and runs `ruff check . --select E9,F63,F7,F82` — the critical rule set: syntax errors (E9), undefined names (F82), and related fatal lint issues. It is deliberately a low-noise gate, not a full style pass.
- Runs a compile smoke test: `python -m py_compile` on `settings.py`, `main.py`, `credly.py`, `githubRepo.py` and `test_chromedriver.py`. This catches syntax errors but does not import the modules, so it does not exercise the network code or the dependency imports.

## Standalone driver test (`test_chromedriver.py`)

A manual script, not run by CI: it verifies ChromeDriver starts and can load a page (see `tier03/test-chromedriver.md`). Exits 0 on success, 1 on failure. Use it to isolate Chromium/driver problems before blaming the scraper.

## What is NOT tested

- The Credly scraping/parse logic has no automated tests in this inventory; coverage of it is limited to the `py_compile` smoke test and the manual `credly.py` standalone run.
- `main.py`'s `generate_new_readme` regex behavior has no automated test in this inventory.
- The markdown files beyond the three CI globs (`master-index.md`, `sample.md`, etc.) are not linted by the workflow as configured.
