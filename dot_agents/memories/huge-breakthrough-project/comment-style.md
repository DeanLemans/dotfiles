---
name: comment-style
description: gdscript comments: lowercase, no trailing dot, compact, symbols instead of words, `not` instead of `!`
metadata:
  type: feedback
---

- Inline + doc comments in scripts: lowercase, dont end with a dot, as compact as possible.
- Symbols instead of words even if slightly less readable: `∴` so, `∵` because, `≠`, `≈`, `⚠`, `∅` nothing, `+` and, `/` or, `>` then (not `->`).
- In code use `not` instead of `!`.
- Doc comments still document the contract ([[code-rules]]), just tersely.

**Why:** Dean asked for these 2026-11-20 + 2026-11-25 across the whole scripts folder.
**How to apply:** match it in every comment I write. Deleting or rewriting existing comments only in a comment pass Dean asked for ([[only-change-what-was-asked]]). Dont write this rule into the TDD unless asked ([[design-doc-rules]]).
