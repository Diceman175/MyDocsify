# Release Checklist (Lightweight)

Use this checklist for small, safe releases of this action and docs repo.

## 1) Prepare

- Confirm local branch is up to date with `main`.
- Run quick validation (workflow lint and Docker build sanity where possible).
- Confirm README usage examples still match current behavior.

## 2) Update Changelog

- Add all user-visible changes to the `Unreleased` section in CHANGELOG.md.
- Update the `Milestone Releases` summary in CHANGELOG.md when the release introduces a new phase or materially changes an existing phase summary.
- Group entries under `Added`, `Changed`, and `Fixed`.
- Keep entries short and action-focused.

## 3) Cut Release

- Pick the target commit SHA for release.
- Move the major tag to that commit: `git tag -f v1 <commit-sha>`.
- Push the major tag: `git push origin v1 --force`.
- Optionally create a dated/immutable tag (example: `2026.04.20`) and push it.

## 4) Verify

- Confirm tag points to expected commit: `git show-ref --tags v1`.
- Trigger `.github/workflows/update-badges.yml` manually to validate runtime behavior.
- Verify README badge section updates correctly when changes are detected.

## 5) Publish Notes

- Move `Unreleased` changelog items into a new dated section.
- Commit changelog update and release notes links.
- Share short summary: what changed, risk level, and rollback plan.

## Rollback

- Point `v1` back to the previous known-good commit:
  - `git tag -f v1 <previous-commit-sha>`
  - `git push origin v1 --force`
