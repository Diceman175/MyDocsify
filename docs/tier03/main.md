> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# `main.py`

`main.py` is the entry point of the badge updater. It is the only module that ties the two others together.

## What it does

```python
git = GithubRepo()
credly_badges = Credly()
readme = git.get_readme()
new_readme = generate_new_readme(credly_badges.get_markdown(), readme)
if new_readme != readme:
    git.save_readme(new_readme)
```

- `GithubRepo()` (from `githubRepo.py`) authenticates to the GitHub API and fetches the README. On an authentication or README failure it prints a message and exits with status 1, so the script never proceeds with a bad connection.
- `Credly()` (from `credly.py`) scrapes the Credly profile and `get_markdown()` returns the formatted badge markup, or `None` when no badges were found.
- `generate_new_readme` splices the markup into the README and `save_readme` commits it.

## `generate_new_readme(md_badges, readme)`

- If `md_badges` is falsy (the scraper found nothing), it returns the original `readme` untouched, so nothing is committed.
- Otherwise it builds `"{START_COMMENT}\n{md_badges}\n{END_COMMENT}"` and returns `re.sub(LIST_REGEX, <that>, readme)`. `LIST_REGEX` matches everything from the start comment to the end comment, so only the managed section changes.

## Behavior notes

- The script commits **only when the generated README differs from the current one** (`if new_readme != readme`). Repeated runs on an unchanged profile produce no commit.
- All configuration comes from `settings.py` environment variables; see `tier00/configuration.md`. There are no command-line arguments.
- The `__main__` guard means importing `main` (for `generate_new_readme`) does not run the scraper.
