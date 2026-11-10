> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Architecture

The repository contains two independent programs that share a folder, plus a Docsify documentation site.

## 1. Credly badge updater (the GitHub Action)

Four small Python modules cooperate:

- **`settings.py`** — configuration. Reads `INPUT_REPOSITORY`, `INPUT_GH_TOKEN`, `INPUT_GH_API_URL`, `INPUT_COMMIT_MESSAGE`, `INPUT_CREDLY_USER` and `INPUT_NUMBER_LAST_BADGES` from environment variables; defines the badge-section markers (`START_COMMENT`/`END_COMMENT`), `CREDLY_BASE_URL` and `LIST_REGEX`.
- **`credly.py`** — the `Credly` class. Scrapes a Credly user page (`https://www.credly.com/users/<user>`) with headless Chrome via Selenium, falling back to a plain `requests` GET if Selenium fails. Parses badge cards with BeautifulSoup (a cascade of class selectors, then an image-hostname fallback), converts each card to a dict of `title`, `img`, `issuer`, `issue_date`, `href`, sorts newest first by parsed issue date, limits to `NUMBER_BADGES` when non-zero, and emits one line of `<a href=...><img ... width="80" height="80"></a>` per badge. It also has a `__main__` block that prints the markdown and writes it to `test.md`.
- **`githubRepo.py`** — the `GithubRepo` class. Wraps PyGithub: authenticates with the token and API URL, opens the repository, fetches the README (base64-decoding its content); `save_readme()` calls `repo.update_file` with the fetched README's path, sha and the configured commit message. Both setup failures print a message and exit with code 1.
- **`main.py`** — the entry point (23 lines). Instantiates `GithubRepo` and `Credly`, and `generate_new_readme()` splices the badge markup into the README with a regex substitution over `LIST_REGEX`. It saves the README only when the result differs from the original.

Data flow: environment → `settings.py` → `Credly` (scrape/parse/sort/format) + `GithubRepo` (fetch/commit) → `main.py` (splice/compare/commit).

`action.yml` packages this as a Docker-run GitHub Action named "Badges - Readme" with the inputs documented in `tier00/configuration.md`. `.github/workflows/update-badges.yml` is the scheduled consumer (daily at 02:00 UTC) and `docker-compose.yml` is a local-ops wrapper around the same `main.py`.

## 2. Weather app sample (`Weather/weather-app/`)

A self-contained static web app inside the repository: `src/index.html` (five city input fields and a "Get Weather" button), `src/styles/style.css` and `src/scripts/script.js`. `script.js` fetches weather for a fixed list of five US cities from the OpenWeatherMap API (`https://api.openweathermap.org/data/2.5/weather?...&units=imperial`) and renders name, temperature and description per city; it expects an element with id `weather-container`. Its own README describes it as a simple HTML/CSS/JavaScript project.

## 3. Docsify documentation site

`index.html` boots Docsify v4 from a CDN with the vue theme, `loadNavbar`/`loadSidebar` (so `_navbar.md` and `_sidebar.md` drive navigation), auto2top, `maxLevel: 0`, `subMaxLevel: 3` and a search plugin (depth 2), plus the zoom-image plugin. The markdown files (`README.md`, `master-index.md`, `master-template.md`, `release_checklist.md`, `sample.md`, `test.md`, `second-page.md`, `github-syntax-testing-of-badges.md`, `custom-navbar.md`, `SampleFolder/_folder.md`) are the pages it serves.
