---
name: only-change-what-was-asked
description: no side edits (comments, READMEs, doc updates, CSS); 'dont touch content' = format/reorder only
metadata:
  type: feedback
---

- Only change what Dean asked. No extra comments, READMEs, doc/TDD updates, CSS changes or "while im here" fixes. Mention them in one line and let Dean choose.
- When Dean asks to format, reorder or restructure ("dont touch content"), do not add, remove or reword anything. Text before/after must be identical apart from order + formatting.

**Why:** "WHAT THE FUCK IS THAT USE COMMENTS YOU ADDED AND THAT UGLY FUCKING README" (dotfiles, 2026-11-18); "dont change my fucking css" (site, 2026-11-26); "i said dont touch content dipshit ... only format" (game docs, 2026-11-14); TDD rule commits I had to drop (2026-11-20).
**How to apply:** diff the result against the request before reporting. Related: [[no-third-party-edits]].
