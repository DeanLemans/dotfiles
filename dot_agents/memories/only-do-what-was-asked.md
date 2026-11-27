---
name: only-do-what-was-asked
description: questions get answers not actions; builds/installs need an explicit yes; change only what was asked, no side edits; 'dont touch content' = format/reorder only
metadata:
  type: feedback
---

When to act:
- **Question ≠ task.** When Dean asks "how do i / what is / is it possible / what do you think", answer it, dont go do it. Only act on clear instructions ("do it", "fix", "add").
- **Ask before building or installing.** Never run builds (makepkg, make, cargo, zig build...) or install packages without an explicit yes. Inspect read-only, then give the commands.
- **"check stuff, dont change, give me commands"** means only diagnose + give commands.

How much to change:
- Only change what Dean asked. No extra comments, READMEs, doc/TDD updates, CSS changes or "while im here" fixes. Mention them in one line and let Dean choose.
- When Dean asks to format, reorder or restructure ("dont touch content"), do not add, remove or reword anything. Text before/after must be identical apart from order + formatting.

**Why:** I started a makepkg build of ly unprompted (2026-11-25) after only "is there another way to install?" ("never fucking do that withouth permision"). "what the fuck? did i ask you to do it?" (2026-11-26). "WHAT THE FUCK IS THAT USE COMMENTS YOU ADDED AND THAT UGLY FUCKING README" (dotfiles, 2026-11-18); "dont change my fucking css" (site, 2026-11-26); "i said dont touch content dipshit ... only format" (game docs, 2026-11-14); TDD rule commits I had to drop (2026-11-20).
**How to apply:** if unsure, answer + offer in one line. Diff the result against the request before reporting. Related: [[read-the-docs]], [[no-third-party-edits]].
