---
name: git-workflow
description: never push; commit only when asked unless the project says otherwise; recheck git before rewriting; squash only when asked
metadata:
  type: feedback
---

- **Never push.** No `git push`, PRs or remote branch updates unless Dean asks. Dean reviews in lazygit + pushes himself.
- **Committing:** default is only when Dean asks. A project memory can allow committing without asking (huge-breakthrough-project does). Finishing an asked task + committing it is not "acting unasked" there.
- **Stage only my own changes.** The main checkout often has Deans uncommitted work: `git add <files I changed>`, never `git add -A` / `commit -a`, never stash/reset/checkout his changes away.
- **Small + single-purpose while working**, so Dean can revert each commit in lazygit.
- **Cleaning the log is a separate, asked-for step.** When Dean asks to merge/squash/reword, merge related or obsolete unpushed commits and fold small fixes into the commit they belong to. When he asks to split, split. Dont squash on my own initiative.
- **Recheck before any rewrite.** Run `git fetch`, `git status -sb`, `git log` again right before reword/squash/rebase/fixup, never from memory of earlier turns. Dean squashes/rebases/pushes in lazygit between turns, thats normal. Never rewrite commits already on origin (`git branch -r --contains <commit>`), never rewrite while Dean is working in lazygit.

**Why:** "did you push them??? never fucking to that"; "STOP FUCKING REWRITING THE GIT HISTORY WHEN IM CHANGING STUFF WITH LAZYGIT"; "tf, why do i need to pull"; "you fucked with the git, i cant push or commit withouth overwrithing some shit".
**How to apply:** small commits by default, squash only on request. Related: [[commit-message-style]], [[no-ai-attribution]], [[fresh-main-checkout]].
