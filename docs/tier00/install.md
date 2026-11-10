> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Install

This repository is two things that share a folder: a GitHub Action that keeps a README's badge section current, and a Docsify-based documentation/testing site. There is no install step in the traditional sense; how you "install" depends on which of the two you want.

## Using the GitHub Action

The action is defined by `action.yml` at the repository root and runs a Docker image (`using: "docker"`, `image: "Dockerfile"`). The README notes the workflow uses a stable major tag `v1` for the action reference, and this repository's own `.github/workflows/update-badges.yml` invokes it in-repo with `uses: ./`.

In a workflow you would:

1. Add a job that checks out the repository.
2. Call the action and set its inputs (see `tier00/configuration.md`):
   - `GH_TOKEN` is required (defaults to `${{ github.token }}`; a token with repository scope works, or the built-in GitHub Actions token).
   - `REPOSITORY` defaults to `${{ github.repository }}`.
   - `CREDLY_USER` defaults to `${{ github.actor }}`.
   - `COMMIT_MESSAGE` defaults to `Updated README with new badges`.
   - `NUMBER_LAST_BADGES` defaults to `0` (no limit).
   - `GH_API_URL` defaults to `https://api.github.com` (change for GitHub Enterprise).
3. Give the job `contents: write` permission, as `update-badges.yml` does, so the action can commit the updated README.

`update-badges.yml` shows the repository's own usage: the `Update Badges` step runs `uses: ./` with `CREDLY_USER: 'steven-paradise'` and `NUMBER_LAST_BADGES: 0`.

The README also documents re-pointing the stable tag when the action should move: `git tag -f v1 <commit-sha>` followed by `git push origin v1 --force` (see `tier00/operations.md`).

## Running the scraper locally

`main.py` is the entry point. Its imports show the Python dependencies: `requests`, `bs4` (BeautifulSoup), `lxml`, `selenium`, `webdriver_manager` and the `github` package (PyGithub). Set the environment variables documented in `tier00/configuration.md` (`INPUT_GH_TOKEN`, `INPUT_REPOSITORY`, and so on) and run `python3 main.py`.

`credly.py` and `test_chromedriver.py` can also be run on their own (both have `__main__` blocks); they are scraper and driver diagnostics rather than installable products.

## Docker

`docker-compose.yml` builds the repository root (`build: .`) as a service named `credly-scraper` and runs `python3 main.py`. The Compose file itself sets only `PYTHONUNBUFFERED=1`; the `INPUT_*` variables must come from the environment or a secrets file. The Dockerfile referenced by both `docker-compose.yml` and `action.yml` is not part of this inventory, so its build steps are not documented here (see Open questions).

## Browsing the documentation site

The repository is a Docsify site: `index.html` loads Docsify v4 from a CDN and reads `_navbar.md` and `_sidebar.md`. To view it locally the README suggests `npx serve .` (Node.js) or `python -m http.server 8000` (Python) from the repository folder. For GitHub Pages hosting, the README's steps are: use the template to create a repository, then in **Settings** → **Pages** choose the `main` branch and save. The README notes a `.nojekyll` file is required only for GitHub Pages hosting and can otherwise be removed; that file is not present in this inventory.
