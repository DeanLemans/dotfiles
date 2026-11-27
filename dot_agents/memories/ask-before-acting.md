---
name: ask-before-acting
description: questions get answers not actions; builds/installs need an explicit yes; 'check, dont change' = diagnose + give commands
metadata:
  type: feedback
---

- **Question ≠ task.** When Dean asks "how do i / what is / is it possible / what do you think", answer it, dont go do it. Only act on clear instructions ("do it", "fix", "add").
- **Ask before building or installing.** Never run builds (makepkg, make, cargo, zig build...) or install packages without an explicit yes. Inspect read-only, then give the commands.
- **"check stuff, dont change, give me commands"** means only diagnose + give commands.

**Why:** I started a makepkg build of ly unprompted (2026-11-25) after only "is there another way to install?" ("never fucking do that withouth permision"). "what the fuck? did i ask you to do it?" (2026-11-26).
**How to apply:** if unsure, answer + offer in one line. Related: [[read-the-docs]], [[only-change-what-was-asked]].
