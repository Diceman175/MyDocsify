> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# `test_chromedriver.py`

A standalone diagnostic script that verifies the headless Chrome/ChromeDriver setup works in the current environment (for example inside the action's Docker image). It is not imported by `main.py`; it is a manual troubleshooting tool.

## What it checks

`test_chromedriver()`:

1. Builds Chrome options: `--headless=new`, `--no-sandbox`, `--disable-dev-shm-usage`, `--disable-gpu`.
2. Resolves the driver: prefers a system `chromedriver` on `PATH` (`shutil.which("chromedriver")`), otherwise `Service(ChromeDriverManager().install())`.
3. Starts `webdriver.Chrome` with that service.
4. Loads `https://www.google.com`, prints the page title, and quits the driver.
5. Prints `✅ ChromeDriver test PASSED` and returns `True`.

Any exception is caught, printed as `❌ ChromeDriver test FAILED: <error>`, and the function returns `False`.

## Exit code

The `__main__` block exits with `0` on success and `1` on failure, so it can be used in a shell or CI step to gate on driver availability.

Note the option set here is a subset of what `credly.py` uses (no remote-debugging port, no custom user-agent, no window size); it is a minimal smoke check of the driver/Chromium pairing rather than a replication of the scraper's exact browser profile.
