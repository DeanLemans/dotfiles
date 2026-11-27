---
name: vault-scope
description: where to work (main checkout, branch v5), vault = content/ only, never touch .trash, exclude Plugin data, read vault rules/colophon/lifecycle first
metadata:
  type: feedback
---

Where:
- Main checkout `~/repositories/deanlemans.github.io`, absolute paths + `cd` there in every Bash call. The Delta worktree is not even for reads ([[fresh-main-checkout]], strictest form). Commits go on branch `v5`, no side branches, only when asked, no push.
- The vault is `content/`. When reviewing or analysing notes, look only there and ignore `.obsidian` + quartz/publish stuff (Dean says "ignore quartz completely" often).
- Obsidian/quartz **config** tasks are separate: when Dean asks to configure plugins, graph or quartz, editing their settings is the task ([[no-third-party-edits]]).

Off limits:
- `content/.trash` (Obsidian trash): no edits, deletes, moves or link updates, and exclude it from every grep/find/scan (`-not -path '*/.trash/*'`, `--exclude-dir=.trash`). Links from .trash dont count as backlinks.
- `content/Plugin data/`: plugin history (custom-attachment-location, advanced-metadata-cache), gitignored ∴ damage is invisible in git status. Exclude it in every vault-wide script or search-and-replace. Same for `.obsidian/` in note-wide scripts.
- Obsidian is usually running on the vault and its rename-handler plugins react to external renames (once removed + re-created files mid-operation) ∴ re-verify after bulk renames.

Conventions:
- Conventions live in 3 notes: vault rules, colophon, note lifecycle. Read them fresh before structural work, they win over these memories. Put new vault-wide rules there only when asked.
- `static_files` is the attachment folder, it wins over plugin settings.
- Focus is extracting from what already exists, not writing new notes.
- "see also / related / references / sources" were conflated; a note in archive/clipping counts as a reference. Skip school notes for that kind of pass.

**Why:** repeated corrections while reviewing the vault (2026-11-16..26). 2026-11-26 Dean said "ignore old worktree" and I still audited it ∴ many findings wrong. "tf? where is there a separe branch?, just commit to v5, dont push" (2026-11-16), "TO THE FUCKING MAIN" (2026-11-18). "dont ever in your fucking live ever do something to files in the .trash folder" (2026-11-18). A bulk apostrophe-strip script rewrote Plugin data logs by accident (2026-11-18).
**How to apply:** add the excludes to every find/grep/script before running it. See also [[vault-edits-no-own-writing]].
