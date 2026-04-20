# Changelog

All notable changes to this project are documented in this file.

This changelog now includes a full historical backfill from git commit history.

## Unreleased

### Added
- Added project maintenance links in README for changelog and release checklist.
- Added lightweight release checklist in RELEASE_CHECKLIST.md.
- Added PR CI workflow for markdown lint, Python lint, and compile smoke checks.

### Changed
- Switched workflow action reference to stable major tag v1.
- Fixed Dockerfile dependency install instruction to use a valid RUN layer.

### Fixed
- Removed unresolved merge conflict marker from .gitignore.
- Converted remaining bare URLs in README to markdown links.

## Milestone Releases

### M1 Docsify Foundation (2025-09-22 to 2025-10-01)
- Bootstrapped the repository and template structure.
- Built core Docsify navigation and content pages.
- Performed early README and badge-formatting updates.

### M2 Content Expansion (2025-11-13 to 2025-12-11)
- Expanded sample documentation content and folder pages.
- Iterated on sidebar and page organization.
- Added weather app sample and repository housekeeping updates.

### M3 Action and Automation Buildout (2026-01-11 to 2026-01-29)
- Established badge-update workflow direction and cleanup of legacy workflow variants.
- Added Docker/action runtime files: Dockerfile, action.yml, requirements, setup script, and Python badge update modules.
- Stabilized README badge output with repeated automated update runs.

### M4 Runtime Hardening (2026-03-19 to 2026-04-12)
- Improved Chromium and ChromeDriver setup in the container workflow.
- Iterated Docker runtime behavior and install steps.

## Historical

### 2025-09-22
- 57b3444 Initial commit
- 6379390 add template files
- 44b3b05 commit

### 2025-09-23
- 1a8bebd Add Sidebar Items
- ee9d93d Update _sidebar.md
- 5a930d3 Update Headings
- a87a041 add navbar
- e727226 Update !test.md
- a77e28e Update _navbar.md
- b940023 Update Files
- 4d3fc7c Update README.md

### 2025-09-29
- fdf7fc7 File Updates
- 3a7c64f Create !test.md
- 7b1d661 Delete !test.md
- 0dbaa39 Delete test.pdf
- c47066b Remove Files

### 2025-10-01
- 4ff84e6 Moved files to make public
- 370cd29 Update Site
- 5fadb88 Update README.md
- f5e4007 Update testing
- 4727c89 update nav bars
- 3bbb9cd Update _sidebar.md
- 363647d Update testing
- 95d641f Update GitHub-Syntax-Testing-of-Badges.md
- d37a618 Update badges

### 2025-11-13
- 7891e8f Update files

### 2025-11-15
- 6f0e8df Update README.md
- c7570c0 Update README.md
- a2b7cc6 Update README.md
- 81002f3 add files
- 31dbac1 add files
- 31a08fd Update Readme
- 3080018 Update _sidebar.md
- 0cf3b3e updates
- f3d6eac samples
- 31c288d Update _folder.md
- ccda303 testing
- aac196d Update _folder.md
- 8cc57dd Update _folder.md
- 9c88958 update tests
- 6fa3e18 Update _folder.md
- 6cfaa07 Update _folder.md
- 570ae8c Update second-page.md

### 2025-11-16
- 251a4cc Update second-page.md
- 2fcb98a Update
- 669ae5c update files

### 2025-11-17
- 7c52a39 Update master-template.md

### 2025-11-18
- 20c1994 Create git-cheat-sheet-Modified-Print.md
- ab5d0a4 update
- b49ad3d Update git-cheat-sheet-Modified-Print.md

### 2025-11-21
- ee348c4 update TOC

### 2025-11-22
- 731d151 Delete git-cheat-sheet-Modified-Print.md

### 2025-11-26
- d194ce7 add test weather app

### 2025-12-01
- 038c992 Update README.md
- ab169d8 Update README.md
- b2e02fd Update README.md

### 2025-12-07
- 1d09011 Badges

### 2025-12-11
- aa201cb Create .gitignore

### 2026-01-11
- f0a2ee1 Rename update-badges workflow file

### 2026-01-26
- d156c1b Update update-badges.yml.org
- 030fff3 Update update-badges.yml.org
- e6ba25d Update update-badges.yml.org
- dde756e Update update-badges.yml.org
- a8c809e Update update-badges.yml.org
- f7f4e6c Create update-badgea.yml
- 8d4bf36 Update update-badgea.yml
- 5d35ea8 Update update-badgea.yml
- 4c6cd92 Update update-badgea.yml
- bbaa819 Update README.md
- cf2ec5f Update update-badges.yml
- 5eee7b5 Update update-badgea.yml
- a23e562 Add initial Dockerfile
- 32919e2 Create Dockerfile for Python app with Chrome setup
- bb4ea7f Create action.yml
- 4a295fa Create requirements.txt
- 6e839f3 Delete .github/workflows/update-badges.yml.org
- b644a80 Create setup_chrome.sh
- 81a468d Create docker-compose.yml
- ffe8443 Create settings.py
- 0fa9642 Create test_chromedriver.py
- 891f527 Create main.py
- b1bb8c7 Create credly.py
- 724ecde Create githubRepo.py
- e557bb1 Create update-badges.yml
- 4986d8c Delete update-badgea.yml
- 5be8969 Update README.md
- 80699a0 Update README.md
- 90a02c6 Update README.md
- 33616cc Update README.md
- 0c93f4f Update README.md
- 66b3963 Update README.md
- 9a3b824 Clean up README formatting and whitespace

### 2026-01-27
- e244315 Updated README with new badges
- 14bce88 Updated README with new badges
- 24f0a62 Updated README with new badges

### 2026-01-28
- 0daf955 Updated README with new badges

### 2026-01-29
- 89039f1 Merge branch main from remote repository

### 2026-03-19
- 982ed7f hoping this does not break me

### 2026-04-12
- fda2917 Install Chromium/ChromeDriver and add setup script
- 64a8d56 Update Dockerfile
- e315885 Comment out apt-get RUN in Dockerfile
