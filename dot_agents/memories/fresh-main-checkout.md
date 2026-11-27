---
name: fresh-main-checkout
description: work in the main checkout (not the Delta worktree) and re-read files every time, never from memory or old summaries
metadata:
  type: feedback
---

- Dean looks at the main checkout (lazygit at the repo root). The Delta worktree the session starts in is stale. Read + edit + commit in the main checkout with absolute paths unless Dean says otherwise.
- Dean edits files himself between turns (obsidian, zed, lazygit). Re-read current files before editing or analysing. Never work from memory, an old summary or an old worktree. "read fresh" / "ignore old worktree" is absolute.
- This includes memories: they say what was true when written. If a memory and the current files disagree, the files win (and the memory needs an update).
- The main checkout has Deans uncommitted work: never commit, stash or discard it (see [[git-workflow]]).

**Why:** edits + commits left in worktrees were invisible to Dean ("i dont see the changes in lazygit" many times, "alwasy do it in the main"); "are you using fucking memories? your shit is not up to date"; "READ EVERYTHING FRESH DIPSHIT" after I analysed a stale worktree (2026-11-26).
**How to apply:** cwd resets to the worktree ∴ absolute paths in every call.
