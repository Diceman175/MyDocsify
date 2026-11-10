> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Configuration

All runtime configuration is read from environment variables by `settings.py`, which is the only place the values are defined. `main.py`, `credly.py` and `githubRepo.py` import the values from there.

## Environment variables

| Variable | Read in | Meaning | Default when unset |
| --- | --- | --- | --- |
| `INPUT_REPOSITORY` | `settings.py` | GitHub repository to update (owner/name) | `None` (no default) |
| `INPUT_GH_TOKEN` | `settings.py` | GitHub token with repository access | `None` (no default) |
| `INPUT_GH_API_URL` | `settings.py` | GitHub API base URL (set for GitHub Enterprise) | `None` (no default) |
| `INPUT_COMMIT_MESSAGE` | `settings.py` | Commit message used when the README is updated | `None` (no default) |
| `INPUT_CREDLY_USER` | `settings.py` | Credly user whose badge page is scraped | `None` (no default) |
| `INPUT_NUMBER_LAST_BADGES` | `settings.py` | Maximum number of badges to keep; `0` means no limit | `0` (also used when the value is not an integer) |

`settings.py` also defines fixed values that are not configurable:

- `START_COMMENT` is `<!--START_SECTION:badges-->`
- `END_COMMENT` is `<!--END_SECTION:badges-->`
- `CREDLY_BASE_URL` is `https://www.credly.com`
- `LIST_REGEX` is the regular expression that matches from `START_COMMENT` through `END_COMMENT` (built from the two comment strings); `main.py` uses it to replace the section in the README.

## GitHub Action inputs (`action.yml`)

When the repository is consumed as a composite-able Docker action, `action.yml` declares these inputs; each maps to the `INPUT_`-prefixed environment variable that `settings.py` reads.

| Action input | Maps to environment variable | Required | Default |
| --- | --- | --- | --- |
| `GH_TOKEN` | `INPUT_GH_TOKEN` | yes | `${{ github.token }}` |
| `REPOSITORY` | `INPUT_REPOSITORY` | no | `${{ github.repository }}` |
| `COMMIT_MESSAGE` | `INPUT_COMMIT_MESSAGE` | no | `Updated README with new badges` |
| `CREDLY_USER` | `INPUT_CREDLY_USER` | no | `${{ github.actor }}` |
| `NUMBER_LAST_BADGES` | `INPUT_NUMBER_LAST_BADGES` | no | `0` |
| `GH_API_URL` | `INPUT_GH_API_URL` | no | `https://api.github.com` |

`action.yml` runs the action with `using: "docker"` and `image: "Dockerfile"`.

## Fallbacks in code

- `Credly.__init__` in `credly.py` resolves the user as `username or CREDLY_USER or "pemtajo"`: a constructor argument wins, then the `INPUT_CREDLY_USER` environment variable, then the hardcoded username `pemtajo`.
- The badge limit resolves as `number_badges or NUMBER_LAST_BADGES or 0`; because `0` is falsy, a `NUMBER_LAST_BADGES` of `0` still results in `0` (no limit) via the final fallback.
- `Credly` also accepts an optional `f` (file path): when given, `data_from_html()` reads that local file instead of scraping.

## Docker Compose

`docker-compose.yml` defines one service, `credly-scraper`:

- `build: .` (builds from the repository root; the Dockerfile it builds from is not part of this inventory)
- `container_name: credly-scraper`
- environment: `PYTHONUNBUFFERED=1` only
- volume: `./output:/output`
- command: `python3 main.py`
- restart policy: `unless-stopped`
- Compose file version: `3.8`

Note that the Compose file sets no `INPUT_*` variables, so a plain `docker compose up` run will not supply the token, repository or Credly user that `settings.py` expects; supplying those requires additional environment configuration not present in the file.
