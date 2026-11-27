---
name: hands-off-folders
description: never touch or even search content/.trash; exclude content/Plugin data from every script; Obsidian is open during edits
metadata:
  type: feedback
---

- `content/.trash` (Obsidian trash): no edits, deletes, moves or link updates, and exclude it from every grep/find/scan (`-not -path '*/.trash/*'`, `--exclude-dir=.trash`). Links from .trash dont count as backlinks.
- `content/Plugin data/`: plugin history (custom-attachment-location, advanced-metadata-cache), gitignored ∴ damage is invisible in git status. Exclude it in every vault-wide script or search-and-replace. Same for `.obsidian/` in note-wide scripts (its plugin settings are only edited in config tasks, [[vault-scope]]).
- Obsidian is usually running on the vault and its rename-handler plugins react to external renames (once removed + re-created files mid-operation) ∴ re-verify after bulk renames.

**Why:** "dont ever in your fucking live ever do something to files in the .trash folder" (2026-11-18). A bulk apostrophe-strip script rewrote Plugin data logs by accident (2026-11-18).
**How to apply:** add the excludes to every find/grep/script before running it.
