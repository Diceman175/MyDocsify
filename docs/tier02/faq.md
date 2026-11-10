> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Frequently Asked Questions

**Does it work on GitHub Enterprise?**
Yes. `action.yml` exposes a `GH_API_URL` input (default `https://api.github.com`) which `settings.py` reads as `INPUT_GH_API_URL` and passes to PyGithub's `Github(base_url=...)`. Point it at your enterprise API host.

**What happens if my README has no badge markers?**
`generate_new_readme` in `main.py` uses `LIST_REGEX` to match the block between `<!--START_SECTION:badges-->` and `<!--END_SECTION:badges-->`. If those markers are absent, `re.sub` finds nothing, returns the README unchanged, and because the new text equals the old text, `main.py` does not commit. You must add the two comment markers once for the section to be managed.

**Does the action use a credential I should worry about copying?**
It authenticates with `GH_TOKEN` (default `${{ github.token }}`). `githubRepo.py` prints a hint to save a GitHub token in repo secrets or use the built-in Actions token if authentication fails, then exits 1. Do not paste real tokens into documentation.

**Why are there sometimes fewer badges than I have on Credly?**
`credly.py` applies `NUMBER_LAST_BADGES` by slicing the scraped card list to the most recent N (when N is greater than 0; `0` means no limit), and then drops any badge whose parsed title is `Profile`. So the final output can be shorter than N when one of the selected cards is a Profile card.

**What if a badge has no parseable date?**
`get_markdown` parses dates of the form `DD/MM/YY` and treats unparsable/missing dates as `1900-01-01`, so undated badges sort to the end.

**Does it only scrape the first badge card?**
`return_badges_html` first tries `div[role=button][data-testid=desktop-badge-card]`; if none, it falls back through several class selectors and finally to any `div` with an `href` or `images.credly.com` images. The exact set matched depends on Credly's current page markup, which is why the selector list is layered.

**Can I preview the output without committing?**
Run `python3 credly.py` by itself. It prints the generated markdown and writes it to `test.md`; it does not touch GitHub.

**Why does the Docker/Chromium step sometimes fail?**
`credly.py` and `test_chromedriver.py` prefer a system `chromedriver` on `PATH` and otherwise download one via `webdriver_manager`. A mismatch between the installed Chromium and the driver, or a container without Chrome, causes the initialization fallback chain to run. `test_chromedriver.py` exists specifically to isolate this: it loads a page and exits 0/1.

**Why does the weather sample show an error or no results?**
`Weather/weather-app/src/scripts/script.js` has a placeholder API key `YOUR_API_KEY` and fetches a fixed list of five cities, so without a real key the fetch fails and it prints `Error fetching weather data.` It does not use the five text inputs.

**Is this a build tool?**
No. The README states it is a template for creating Markdown-based documentation sites "with no build process required"; Docsify renders the markdown in the browser at runtime.
