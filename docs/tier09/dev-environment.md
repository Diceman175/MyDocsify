> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Development Environment

## Python

- CI pins Python **3.12** (`actions/setup-python@v5`, `ci.yml`) for the lint/compile jobs; that is the only Python version the repository's own automation demonstrates.
- Dependencies are imported but not declared anywhere in this inventory: `requests`, `beautifulsoup4` (`bs4`), `lxml`, `selenium`, `webdriver-manager` and `github` (PyGithub). There is no `requirements.txt`/`pyproject.toml` in the inventory, so the authoritative dependency list for the Docker image lives in the `Dockerfile`, which is not part of this inventory.
- Linting: `ruff`, installed on the fly in CI (`pip install ruff`) with the critical rules `E9,F63,F7,F82`. There is no repo-level ruff config file in the inventory.

## Chrome / chromedriver

- The scraper needs a Chromium browser plus a matching `chromedriver`. `credly.py`/`test_chromedriver.py` resolve the driver as: system `chromedriver` on `PATH` → `webdriver-manager` download → bare `webdriver.Chrome`.
- The Docker image (built from the `Dockerfile`, not in inventory) is where Chromium is provided for CI; the user-agent string in the options targets Chrome 137, which hints at the intended browser generation.
- Local development of the scraper is practical: `python3 credly.py` previews output and writes `test.md`; `python3 test_chromedriver.py` verifies the driver.

## Docker / Compose

- `docker-compose.yml` (version 3.8) builds the repo root and runs `python3 main.py` as `credly-scraper` with `PYTHONUNBUFFERED=1`, a `./output:/output` volume and `restart: unless-stopped`. Supply the `INPUT_*` variables externally to make a compose run functional.

## JavaScript / static site

- No Node toolchain is required: the Docsify site is served statically (`npx serve .` or `python -m http.server 8000` per the README) and pulls Docsify v4 from a CDN at runtime.
- The weather sample is plain browser JavaScript with no build step.

## Markdown tooling

- `.markdownlint.json` (version 1.0, lastmod 2026-07-27) is the lint rule set; its description notes it is a committed copy synced from a canonical workspace source, so local rule edits can be overwritten by the sync process.
