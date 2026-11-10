> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# `credly.py`

`credly.py` contains the `Credly` class, a scraper that turns a Credly user's public profile into the markdown badge markup that `main.py` splices into the README.

## Configuration

`Credly.__init__(username=None, number_badges=None, f=None)`:

- `USER` = `username or CREDLY_USER or "pemtajo"` — a constructor argument, then the `INPUT_CREDLY_USER` environment value, then the hardcoded username `pemtajo`.
- `NUMBER_BADGES` = `number_badges or NUMBER_LAST_BADGES or 0` — `0` means no limit.
- `FILE` = `f` — an optional path to a local HTML file; when set, `data_from_html()` reads the file instead of scraping.
- `BASE_URL` is always `https://www.credly.com`.

## Scraping pipeline

1. **`data_from_html()`** — the source of the HTML.
   - With `self.FILE`: reads and returns that file.
   - Otherwise: opens `https://www.credly.com/users/<USER>` in headless Chrome. It waits up to 15 s for the `#root` element's innerHTML to become non-empty, then sleeps 5 s before taking `driver.page_source`, and always `driver.quit()`s in a `finally`.
   - If any Selenium step raises, it retries with `requests.get` using a desktop Chrome user-agent and a 10 s timeout.
   - Returns the HTML text, or `None` if both methods fail.
2. **`return_badges_html()`** — finds the badge card elements. Selector cascade:
   - `div[role="button"][data-testid="desktop-badge-card"]`
   - `div` whose class contains `Cardstyles__StyledContainer-fredly__sc-1yaakoz-0`
   - each of `EarnedBadgeCardstyles__StyledCard-fredly__sc-gsqjwh-1`, `cr-public-earned-badge-grid-item`, `cr-earned-badge-grid-item`, `badge-grid-item`, `badge-card__card`
   - any `div` with an `href` attribute
   - last resort: `<img>` elements on `images.credly.com`, walking up to five ancestor levels looking for a container with `href` or `role="button"` or a `Card`-like class.
3. **`convert_to_dict(htmlBadge)`** — one card to a dict.
   - `title`: the badge-name span, else the organization-name div, else the image `alt` (defaulting to `"Badge"`); embedded quotes are escaped.
   - `img`: the first matched image (a list of known badge-image classes, then the first `<img>` in the card); its `src` is rewritten from `https://images.credly.com/` to `https://images.credly.com/size/80x80/`.
   - `issuer`: the issuer span, else the issuer-name div (may stay `""`).
   - `issue_date`: the first `DD/MM/YY` date found in the expiration-date span or the issued div (may stay `""`).
   - `href`: the card's `href` prefixed with the base URL, else `https://www.credly.com/users/<USER>/badges`.
   - Returns `None` if the card has no image.
4. **`get_markdown()`** — orchestration: slice the card list to `NUMBER_BADGES` (when > 0) → `convert_to_dict` each, dropping `None` results and any badge whose title is `"Profile"` → sort newest first (dates parsed `DD/MM/YY`; two-digit years map to 20xx when < 50 else 19xx; unparseable dates sort as `1900-01-01`) → `generate_md_format`.
5. **`generate_md_format(badges)`** — one line per badge:
   `<a href="{href}" title="{title}"><img src="{img}" alt="{title}" width="80" height="80"></a>`, newline-joined. Returns `None` for an empty list.

## Headless Chrome setup (`get_webdriver()`)

Chrome options: new headless mode, `--no-sandbox`, `--disable-dev-shm-usage`, `--disable-gpu`, `--disable-software-rasterizer`, background-timer and occluded-window throttling disabled, `--disable-features=TranslateUI`, `--disable-ipc-flooding-protection`, `--window-size=1920,1080`, `--remote-debugging-port=9222`, a Chrome 137 desktop user-agent, `--log-level=3`, `--silent`.

Driver resolution: prefer a system `chromedriver` found with `shutil.which("chromedriver")`; otherwise `Service(ChromeDriverManager().install())`; if that also fails, a final fallback to `webdriver.Chrome(options=...)`; if all fail, the exception is raised. `test_chromedriver.py` exercises the same resolution path for diagnosis.

## Standalone use

`main()` in the `__main__` block prints the initialized user and badge count, generates the markdown and prints it; if non-empty it writes it to `test.md`. This is a local preview path that never touches GitHub.
