> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Operations

## Daily badge refresh

`.github/workflows/update-badges.yml` (name: "Update README.md Badges") runs the action on a schedule:

- Trigger: cron `0 2 * * *` (daily at 02:00 UTC) plus manual `workflow_dispatch`.
- Job `update-badges` runs on `ubuntu-latest` with `permissions: contents: write`.
- It checks out with `actions/checkout@v6` and then runs the action via `uses: ./` with `CREDLY_USER: 'steven-paradise'` and `NUMBER_LAST_BADGES: 0` (the inline comment says "0 = all").

What the action does on each run (`main.py`):

1. Constructs a `GithubRepo` and a `Credly` scraper.
2. Fetches the repository's current README via the GitHub API.
3. Scrapes the Credly user page and builds the badge markup.
4. Replaces the text between `<!--START_SECTION:badges-->` and `<!--END_SECTION:badges-->` with the new markup.
5. Commits the README **only if the generated content differs from the current README** (`if new_readme != readme`). On an unchanged README the run makes no commit.

The repo's own README currently holds three Credly badges between those markers; the daily run keeps that section in sync with the Credly profile.

## Release and tag operations

`release_checklist.md` is the lightweight checklist for small, safe releases of the action and docs repo:

1. **Prepare** — confirm the branch is up to date with `main`; run quick validation (workflow lint and Docker build sanity where possible); confirm README usage examples still match current behavior.
2. **Update Changelog** — add user-visible changes to the `Unreleased` section of `CHANGELOG.md`; update the `Milestone Releases` summary when a phase is new or materially changed; group entries under `Added`, `Changed`, `Fixed`.
3. **Cut Release** — pick the target commit; move the major tag with `git tag -f v1 <commit-sha>`; push it with `git push origin v1 --force`; optionally create a dated/immutable tag (example `2026.04.20`) and push it.
4. **Verify** — confirm the tag with `git show-ref --tags v1`; trigger `update-badges.yml` manually to validate runtime behavior; verify the README badge section updates correctly.
5. **Publish Notes** — move `Unreleased` changelog items into a new dated section; commit the changelog update and release notes; share a short summary of what changed, the risk level and the rollback plan.

The README documents the same major-tag convention: workflows reference the stable tag `v1`, and re-pointing it is done with `git tag -f v1 <commit-sha>` and `git push origin v1 --force`.

## Rollback

From `release_checklist.md`: point `v1` back at the previous known-good commit with `git tag -f v1 <previous-commit-sha>` and `git push origin v1 --force`.
