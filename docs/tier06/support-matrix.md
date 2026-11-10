> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Support Matrix

What the code and CI actually pin or depend on:

| Component | Pinned / supported value | Evidence |
| --- | --- | --- |
| Python (CI lint + compile) | 3.12 | `.github/workflows/ci.yml` `actions/setup-python@v5` with `python-version: '3.12'` |
| Python (Docker action / compose) | whatever the Dockerfile installs (not in inventory) | `action.yml` `runs.image: Dockerfile`; `docker-compose.yml` `build: .` |
| GitHub Actions runners | `ubuntu-latest` | both workflows |
| `actions/checkout` | v6 | both workflows |
| `actions/setup-python` | v5 | `ci.yml` |
| `DavidAnson/markdownlint-cli2-action` | v18 | `ci.yml` |
| Chrome (scraper) | headless "new" mode; user-agent string Chrome 137; driver from system `chromedriver` or `webdriver_manager` | `credly.py`, `test_chromedriver.py` |
| Docsify (site) | v4 via CDN (`docsify@4`) | `index.html` |
| GitHub API | `https://api.github.com` default, configurable for Enterprise | `action.yml` `GH_API_URL` |
| Compose file format | version `3.8` | `docker-compose.yml` |
| Action reference tag | stable major tag `v1` (force-moved on release) | `README.md`, `release_checklist.md` |

Not covered by the code (see Open questions): no `requirements.txt`/`pyproject.toml` is in the inventory, so the minimum supported Python for the Docker image and the exact PyGithub/BS4/Selenium versions are not documented here; no `Dockerfile` is in the inventory.
