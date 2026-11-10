> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# APIs and Integrations

## Credly (scraped)

- Endpoint: `https://www.credly.com/users/<CREDLY_USER>` (user profile page), fetched by `credly.py` with headless Chrome, falling back to a plain `requests` GET.
- Image CDN: badge images come from `https://images.credly.com/`; `convert_to_dict` rewrites the path to the `80x80` sized variant (`https://images.credly.com/size/80x80/...`) before emitting markdown.
- Badge detail links: `https://www.credly.com/badges/<badge-id>` when the card carries an `href`; otherwise the fallback link is the user's badge list page `https://www.credly.com/users/<USER>/badges`.
- No API key or authentication is used; the profile is public and the integration is HTML scraping, so it is sensitive to Credly page-markup changes (hence the layered selector fallbacks).
- The README additionally embeds a Credly badge via the Credly embed utility (`//cdn.credly.com/assets/utilities/embed.js`) for one badge — a documentation-site usage, separate from the scraper.

## GitHub (PyGithub)

- Client: `github.Github(base_url=GH_API_URL, login_or_token=GH_TOKEN)` in `githubRepo.py`; `GH_API_URL` defaults to `https://api.github.com` in `action.yml` and exists for GitHub Enterprise hosts.
- Calls used:
  - `g.get_repo(REPOSITORY)` — resolve the repository.
  - `repo.get_readme()` — fetch the README (its `path`, `sha` and base64 `content` are used).
  - `repo.update_file(path=..., message=COMMIT_MESSAGE, content=..., sha=...)` — the only write; a single file update that becomes one commit.
- Failure behavior: an auth failure prints a hint (save a token in repo secrets or use the Actions token) and exits 1; a README fetch failure prints `The readme cannot be obtained!` and exits 1.
- In CI the job needs `permissions: contents: write` (as in `update-badges.yml`) for the commit to succeed.

## OpenWeatherMap (weather sample only)

- Endpoint: `https://api.openweathermap.org/data/2.5/weather?q=<city>&appid=<key>&units=imperial` in `Weather/weather-app/src/scripts/script.js`.
- The API key is a placeholder (`YOUR_API_KEY`); requests fail until it is replaced.
- Response fields used: `name`, `main.temp` (°F, from `units=imperial`) and `weather[0].description`.

## GitHub Actions (the packaging)

- `action.yml` defines a Docker-run action (`runs.using: docker`, `runs.image: Dockerfile`); `docker-compose.yml` reuses the same build for local runs.
- Consumers: `.github/workflows/update-badges.yml` (scheduled + manual, in-repo `uses: ./`) and, for downstream users, any workflow referencing the action by tag (the README documents the stable `v1` tag convention).
- `.github/workflows/ci.yml` runs `actions/checkout@v6`, `actions/setup-python@v5` (Python 3.12) and `DavidAnson/markdownlint-cli2-action@v18`.

## Docsify (documentation site)

- CDN assets in `index.html`: Docsify v4 (`docsify@4/lib/docsify.min.js`), the vue theme (`docsify@4/lib/themes/vue.css`), the zoom-image plugin and the search plugin, all from `cdn.jsdelivr.net`.
- Navigation is driven by `_navbar.md` and `_sidebar.md`; there is no build step.
