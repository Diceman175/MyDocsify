> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Usage

## Running the badge updater

The entry point is `main.py`. Its `__main__` block does the whole job in one run:

1. `GithubRepo()` authenticates against the GitHub API (`INPUT_GH_API_URL`, `INPUT_GH_TOKEN`) and loads the repository (`INPUT_REPOSITORY`) and its README.
2. `Credly()` scrapes the Credly user page for `INPUT_CREDLY_USER`.
3. `generate_new_readme(badge_markdown, readme)` replaces the `<!--START_SECTION:badges-->` … `<!--END_SECTION:badges-->` section with the scraped markup.
4. If the result differs from the current README, `git.save_readme(new_readme)` commits it with `INPUT_COMMIT_MESSAGE`.

To run it outside GitHub Actions, set the `INPUT_*` environment variables listed in `tier00/configuration.md` and run `python3 main.py` (or `docker compose up` after supplying them).

If the README contains no badge section, `generate_new_readme` returns the README unchanged and nothing is committed; the regex only substitutes text that is already between the two markers.

## Using it as a GitHub Action

Add the action to a workflow and set its inputs (all optional except `GH_TOKEN`):

```yaml
- name: Update Badges
  uses: diceman175/MyDocsify@v1   # or ./ for in-repo use
  with:
    CREDLY_USER: 'steven-paradise'
    NUMBER_LAST_BADGES: 0
```

The repository's own `.github/workflows/update-badges.yml` does exactly this (in-repo `uses: ./`) on a daily cron, with `contents: write` permission on the job.

## Exploring the scraper standalone

- `python3 credly.py` runs the scraper alone: it fetches, sorts and prints the badge markdown, then writes it to `test.md` in the working directory.
- `python3 test_chromedriver.py` checks that ChromeDriver can start and load a page; it exits 0 on success, 1 on failure. Useful for debugging container/Chromium problems.

## Using the Docsify site

`index.html` is the site entry point. View it with any static server from the repository folder (the README suggests `npx serve .` or `python -m http.server 8000`). Pages are the markdown files at the repository root; `_sidebar.md` and `_navbar.md` drive the navigation.

To author new pages, the README describes the "Site Setup" template workflow: host on GitHub Pages (Settings → Pages → `main` branch) and edit pages by viewing the markdown file and using GitHub's pencil/commit UI; the site updates automatically. The markdown in this repository follows the template conventions seen in `master-template.md` (a `<!-- omit from toc -->` title, a manual Table of Contents with a `<a id="TOC"></a>` anchor, and `[TOC](#TOC)` back-references per section).

## Using the weather sample

`Weather/weather-app/README.md` says to open `Weather/weather-app/src/index.html` in a browser with an internet connection. In practice, `script.js` ignores the five city input fields (it fetches the fixed city list on page load) and the API key is the placeholder `YOUR_API_KEY`, so the results area will show the error message unless the key is replaced; see `tier02/faq.md`.
