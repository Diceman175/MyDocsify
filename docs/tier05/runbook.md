> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Runbook

This runbook covers the day-to-day and incident paths for the badge updater.

## Normal daily operation

- The scheduled job `.github/workflows/update-badges.yml` runs daily at 02:00 UTC (`cron: "0 2 * * *"`), with `contents: write` permission.
- Expected steady state: a new commit on the repository on days when the Credly profile changed, with the default commit message `Updated README with new badges`. On days when nothing changed, `main.py` makes no commit and the run still succeeds.
- **No action is needed** on a green run. Occasional missing commits are normal (no profile change).

## Trigger a manual refresh

- From the repository: **Actions → "Update README.md Badges" → Run workflow** (the `workflow_dispatch` trigger), or push any change — the workflow only has schedule/dispatch triggers, so a push alone does not start it.
- After a Credly profile change (new badge, expiry, order change), a manual run is the fastest way to update the README before the next daily run.

## Symptoms and responses

| Symptom | Likely cause | Response |
| --- | --- | --- |
| Job fails: authentication error printed, exit 1 | Token missing/insufficient scope or enterprise host mismatch | Check `GH_TOKEN` secret (needs repo scope; the built-in `${{ github.token }}` works in-repo) and `GH_API_URL` for Enterprise. The failure message in `githubRepo.py` says exactly: save a token in repo secrets or use the Actions token. |
| Job fails: `The readme cannot be obtained!`, exit 1 | README missing or not fetchable with the token | Confirm the repo has a README and the token can read it. |
| ChromeDriver initialization failures printed, then a fallback | Chromium/driver mismatch in the container | Run `python3 test_chromedriver.py` in the same environment; it exits 0/1 to confirm the driver works. The scraper already falls back from system driver → webdriver-manager → bare Chrome; if all fail the run errors. |
| Selenium fails, `requests` fallback used | Credly blocked the browser or JS didn't render | The `requests` fallback returns raw HTML; if badge cards are JS-rendered, fewer or zero badges parse. Check the printed `Found N badges` lines in the logs. |
| Badges out of order or missing | Credly markup changed, or a date failed to parse | Check the printed `Extracted badge dates` / `Sorted badges` output; undated badges sort to the end. If a new Credly card class appears, `convert_to_dict` may need a new selector (code change, not a config change). |
| Fewer badges than expected | `NUMBER_LAST_BADGES` limit or `Profile`-titled cards dropped | The limit applies before the Profile filter; set `NUMBER_LAST_BADGES: 0` for all. |
| README badge section unchanged after a run | No markers, or generated text identical to current | Ensure `<!--START_SECTION:badges-->` / `<!--END_SECTION:badges-->` exist; `main.py` only writes on difference. |

## Releasing a fix (from `release_checklist.md`)

1. Prepare: branch up to date with `main`; run the CI validations (markdown lint, ruff, py_compile); confirm README examples match behavior.
2. Update `CHANGELOG.md` (`Unreleased` → Added/Changed/Fixed).
3. Cut: `git tag -f v1 <commit-sha>`; `git push origin v1 --force`; optionally a dated immutable tag.
4. Verify: `git show-ref --tags v1`; trigger the badge workflow manually; confirm the README section updates.
5. Publish notes with what changed, risk level and rollback plan.

**Rollback:** `git tag -f v1 <previous-commit-sha>` and `git push origin v1 --force` to restore the previous action behavior; the README itself is versioned in git, so a regression commit can be reverted normally.

## Data note

The scraper writes no local files in CI. Running `credly.py` standalone locally writes `test.md` in the working directory; `save_markdown_to_file` (default `badges.md`) is available but not called by `main.py`.
