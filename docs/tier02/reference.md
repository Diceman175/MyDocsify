> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Reference

This page references the Python modules and the action definition.

## `action.yml`

| Field | Value |
| --- | --- |
| `name` | `Badges - Readme` |
| `author` | Pedro Matias de Araujo |
| `description` | Add a badges in your Readme |
| `runs.using` | `docker` |
| `runs.image` | `Dockerfile` |
| `branding` | icon `info`, color `blue` |

### Inputs

| Input | Required | Default | Mapped environment variable |
| --- | --- | --- | --- |
| `GH_TOKEN` | yes | `${{ github.token }}` | `INPUT_GH_TOKEN` |
| `REPOSITORY` | no | `${{ github.repository }}` | `INPUT_REPOSITORY` |
| `COMMIT_MESSAGE` | no | `Updated README with new badges` | `INPUT_COMMIT_MESSAGE` |
| `CREDLY_USER` | no | `${{ github.actor }}` | `INPUT_CREDLY_USER` |
| `NUMBER_LAST_BADGES` | no | `0` | `INPUT_NUMBER_LAST_BADGES` |
| `GH_API_URL` | no | `https://api.github.com` | `INPUT_GH_API_URL` |

## `settings.py`

| Name | Value / source |
| --- | --- |
| `START_COMMENT` | `<!--START_SECTION:badges-->` |
| `END_COMMENT` | `<!--END_SECTION:badges-->` |
| `REPOSITORY` | `os.getenv("INPUT_REPOSITORY")` |
| `GH_TOKEN` | `os.getenv("INPUT_GH_TOKEN")` |
| `GH_API_URL` | `os.getenv("INPUT_GH_API_URL")` |
| `COMMIT_MESSAGE` | `os.getenv("INPUT_COMMIT_MESSAGE")` |
| `CREDLY_USER` | `os.getenv("INPUT_CREDLY_USER")` |
| `NUMBER_LAST_BADGES` | `int(os.getenv("INPUT_NUMBER_LAST_BADGES"))`, falling back to `0` when the value is not an integer |
| `CREDLY_BASE_URL` | `https://www.credly.com` |
| `LIST_REGEX` | `f"{START_COMMENT}[\s\S]+{END_COMMENT}"` |

## `main.py`

- `generate_new_readme(md_badges, readme)`: returns `readme` unchanged when `md_badges` is falsy; otherwise returns `re.sub(LIST_REGEX, f"{START_COMMENT}\n{md_badges}\n{END_COMMENT}", readme)`.
- `__main__`: builds `GithubRepo` and `Credly`, fetches the README, splices the badges, and saves only when the content changed.

## `credly.py` — `Credly` class

| Member | Behavior |
| --- | --- |
| `__init__(username=None, number_badges=None, f=None)` | `BASE_URL` = `https://www.credly.com`; `USER` = `username or CREDLY_USER or "pemtajo"`; `NUMBER_BADGES` = `number_badges or NUMBER_LAST_BADGES or 0`; prints the initialized user. |
| `get_webdriver()` | Builds headless Chrome options (new headless mode, no-sandbox, 1920x1080 window, Chrome 137 user-agent, remote debugging on port 9222, among others). Prefers a system `chromedriver` found via `shutil.which`, else `ChromeDriverManager().install()`; falls back to a bare `webdriver.Chrome(options=...)`; raises if all fail. |
| `data_from_html()` | If `self.FILE` is set, reads that file. Otherwise scrapes `https://www.credly.com/users/<USER>` with the webdriver, waiting up to 15 seconds for the `#root` element to have non-empty innerHTML plus a 5-second settle sleep; on any Selenium failure retries with `requests.get` (same user-agent, 10 s timeout). Returns the HTML text, or `None` if both fail. |
| `convert_to_dict(htmlBadge)` | Parses one badge card into `{"title", "img", "issuer", "issue_date", "href"}`. Title comes from the badge-name span, else the organization-name div, else the image `alt` (default `"Badge"`). Image `src` is rewritten from `https://images.credly.com/` to `https://images.credly.com/size/80x80/`. Date is extracted with regex `(\d{2}/\d{2}/\d{2})`. `href` is the card's `href` (prefixed with the base URL) or `https://www.credly.com/users/<USER>/badges`. Returns `None` if no image is found. |
| `return_badges_html()` | Returns the list of badge card elements found by the selector cascade (testid `desktop-badge-card`, `Cardstyles__StyledContainer...`, a list of card classes, any `div[href]`, and finally `images.credly.com` images with parent lookup). |
| `generate_md_format(badges)` | Joins one line per badge: `<a href="{href}" title="{title}"><img src="{img}" alt="{title}" width="80" height="80"></a>`. Returns `None` when the list is empty. |
| `get_markdown()` | Pipeline: `return_badges_html()` → slice to `NUMBER_BADGES` (when > 0) → `convert_to_dict` each, dropping `None`s and titles equal to `"Profile"` → sort newest-first (dates parsed as `DD/MM/YY` with a 20xx/19xx century guess; unparseable dates sort as `1900-01-01`) → `generate_md_format`. |
| `save_markdown_to_file(filename="badges.md")` | Writes the markdown to a file, or prints a no-badges message. |
| `main()` / `__main__` | Standalone run: prints the markdown and writes it to `test.md`. |

## `githubRepo.py` — `GithubRepo` class

| Member | Behavior |
| --- | --- |
| `__init__()` | Creates `Github(base_url=GH_API_URL, login_or_token=GH_TOKEN)`. On `GithubException` from `get_repo`, prints an authentication hint and exits 1. Fetches the README into `self.contents_repo`; on any failure prints `The readme cannot be obtained!` and exits 1. |
| `save_readme(new_readme)` | `self.repo.update_file(path=self.contents_repo.path, message=self.COMMIT_MESSAGE, content=new_readme, sha=self.contents_repo.sha)` |
| `get_readme()` | Returns the README content base64-decoded to UTF-8. |
