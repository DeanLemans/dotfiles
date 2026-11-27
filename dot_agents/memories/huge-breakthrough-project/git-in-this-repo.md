---
name: git-in-this-repo
description: here commits are OK without asking (small, single-purpose); message style w/ ∴ why-line like e5a814f; GPG signed
metadata:
  type: feedback
---

- **Commit without asking** at the end of each task, small + single-purpose so Dean can revert each one in lazygit. This is the project exception to the global default ([[git-workflow]]): still never push, still stage only my own files, squash/merge only when Dean asks.
- **Message style:** copy Deans recent commits (e5a814f, bef873b, bc5f0b3, 282c81b, a4d4ddf, db2321e, 4c39c17), `git log -15` first every time. Subject lowercase imperative, no period, ~50 chars ("merge FacingComponent into PlatformerMovementBase"). Body optional, ONE line of why in the TDD shorthand: `∴` so, `+` and, `w/` with, `∅` nothing, `>` then. E.g. "Log.pr on them printed object id ∴ to_pretty returns to_dictionary." Squashes too. Old capitalized/list commits (ff7bc15, b41242a) are NOT the style.
- **GPG signed:** check `git log --format='%h %G? %s'` after rewriting.

**Why:** "i use lazygit myself, so you can, but sometimes i will revert stuff" (2026-11-12). Style corrected 2026-11-12, 11-15, 11-17; bullet-list squash body on 2026-11-25 got "we have already talked about this multiple times". Reworded an already pushed commit 2026-11-18, fixed up from a stale view 2026-11-25.
**How to apply:** say the commits are local when reporting.
