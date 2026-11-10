> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Data Handling

## Secrets and credentials

- **`INPUT_GH_TOKEN`** — a GitHub token. It is read from the environment in `settings.py` and used only to construct the PyGithub client in `githubRepo.py`. It is never written to files, never printed, and never embedded in output. In CI it comes from `${{ github.token }}` (the default in `action.yml`) or a repo secret; the `update-badges.yml` job requests `contents: write`.
- **OpenWeatherMap key** — `Weather/weather-app/src/scripts/script.js` contains a **placeholder** `YOUR_API_KEY`. This is not a real credential, but the file shows the pattern: if a real key were ever pasted there it would be committed to the repository. Do not commit live keys to that file.
- **Credly** — no credential is used; the scraper reads a public profile page. The only personal data the code handles is the public `CREDLY_USER` username. (Separately, the README's static Parchment badge URLs contain an `identity__email` query parameter; those lines are pre-existing README content, not produced by the code, but they do embed a personal email and are worth noting.)

## Data collected / processed

| Data | Source | Where it goes |
| --- | --- | --- |
| Credly user profile HTML | `https://www.credly.com/users/<CREDLY_USER>` (browser or `requests`) | held in memory; parsed into badge dicts; rendered to markdown; committed into the README badge section via a single `update_file` call |
| Badge metadata (title, issuer, image URL, issue date, link) | parsed from the profile HTML | embedded in the README commit; nothing else is stored |
| Current README | GitHub API (`get_readme`, base64-decoded in memory) | replaced in memory; committed only if changed |
| GitHub identity (`github.actor`, `github.repository`) | Actions context | used as defaults for `CREDLY_USER` / `REPOSITORY` in `action.yml` |

No local database, no logging of scraped content beyond `print()` diagnostics, and no telemetry.

## Files written by the code

- **CI / action run:** none locally — the only write is the GitHub commit of `README.md`.
- **`credly.py` standalone (`__main__`):** writes `test.md` in the current working directory.
- **`Credly.save_markdown_to_file` (default `badges.md`):** available but not called by `main.py`.
- **`docker-compose.yml`:** mounts `./output:/output`; the code in this inventory does not write to `/output`, so the mount is inert unless the Dockerfile (not in inventory) uses it.

## Sensitive-data handling details

- `githubRepo.py` prints only fixed, generic error strings on failure (no token content, no URLs with credentials).
- The scraper prints diagnostic lines (user name, URLs, badge titles/dates) to stdout; these are public-profile data, not secrets.
- README update preserves all existing README content except the managed badge section; `generate_new_readme` only substitutes between the two marker comments.
