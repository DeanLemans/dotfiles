---
name: main-checkout-v5
description: never touch the Delta worktree (not even reads); all work + commits in /home/void/repositories/deanlemans.github.io on v5, no side branch
metadata:
  type: feedback
---

- Never use the Delta worktree for anything, reads + searches + analysis included. Always absolute paths under `/home/void/repositories/deanlemans.github.io` (e.g. `.../content`), `cd` there in every Bash call. The worktree is stale.
- Commits go on branch `v5` in the main checkout, no separate branches, only when asked, no push.

**Why:** 2026-11-26 Dean said "ignore old worktree" and I still audited it ∴ many findings wrong. "tf? where is there a separe branch?, just commit to v5, dont push" (2026-11-16), "TO THE FUCKING MAIN" (2026-11-18).
**How to apply:** global [[fresh-main-checkout]] in its strictest form.
