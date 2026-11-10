> **First draft.** Written by qwen/qwen3.8-27b on 2026-11-10 without governance rules and not yet verified. The sp-document-by-tiers pass replaces this note. Record: docs/tier10/first-draft-handoff.md.

# Repository Layout

The files present in this repository (as listed in the run inventory):

```
.
├── .github/workflows/
│   ├── ci.yml                  # PR/dispatch CI: markdown lint + ruff + py_compile smoke
│   └── update-badges.yml       # daily 02:00 UTC + manual: runs the action in-repo
├── Weather/weather-app/        # static sample web app (HTML/CSS/JS)
│   ├── README.md
│   └── src/
│       ├── index.html
│       ├── scripts/script.js
│       └── styles/style.css
├── SampleFolder/
│   └── _folder.md
├── main.py                     # entry point: glue for GithubRepo + Credly
├── credly.py                   # Credly scraper (Credly class)
├── githubRepo.py               # GitHub API wrapper (GithubRepo class)
├── settings.py                 # env-var configuration + section markers
├── test_chromedriver.py        # standalone driver diagnostic
├── action.yml                  # GitHub Action definition (docker)
├── docker-compose.yml          # local compose wrapper for main.py
├── index.html                  # Docsify site entry point
├── _navbar.md                  # Docsify navbar (loadNavbar: true)
├── _sidebar.md                 # Docsify sidebar (loadSidebar: true)
├── .markdownlint.json          # markdownlint rule set
├── README.md                   # site home + template instructions
├── master-index.md             # anthology master list / template
├── master-template.md          # standard "how to" document template
├── release_checklist.md        # lightweight release checklist
├── sample.md                   # Markdown syntax sample (Daring Fireball excerpt)
├── test.md                     # sample page
├── second-page.md              # sample page
└── custom-navbar.md            # sample page
```

## Grouping

- **The action (code):** `main.py`, `credly.py`, `githubRepo.py`, `settings.py`, `action.yml`, `docker-compose.yml`, `test_chromedriver.py`, and the two workflows under `.github/workflows/`.
- **The Docsify site (content):** `index.html`, `_navbar.md`, `_sidebar.md`, `README.md` and the loose markdown pages.
- **The weather sample (content/code):** everything under `Weather/weather-app/`.

## Conventions

- The Docsify home is `README.md` (served at `/`); the README title is "My Testing Site based upon Docsify", while `index.html`'s `<title>` still says "Awesome Docsify Site" — the two are out of sync.
- `_sidebar.md` links to pages that are not in this inventory (`quickstart.md`, `themes.md`, `deploy.md`, etc.); the site would show those links as unresolvable in a fresh clone.
- The repository name/casing used by docs is `MyDocsify` (README links and site URL), while the inventory path is a worktree named `first-draft`.
