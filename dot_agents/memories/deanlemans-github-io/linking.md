---
name: linking
description: link text is the pretty title, path relative + snake_case; in-sentence zettel links carry the full title as prose w/ short glue
metadata:
  type: feedback
---

- **Link text** is the pretty title, never the escaped filename: `[Les daan motivatie week 7 P1](les_daan_motivatie_week_7_p1.md)`. If a note has no pretty title/alias, add one derived from the filename.
- **Path** is relative to the note. Wrap it in `<...>` when it has spaces or special characters, e.g. `[How to Take Smart Notes. Notes](<./How to Take Smart Notes. Notes.md>)`. Filenames use `_`, new/renamed ones snake_case.
- **Where links go:** bare under `## Related` by default ([[vault-edits-no-own-writing]]). When the task is linking zettels/growing notes into each other, put the target notes whole title into the sentence as prose (lowercased first letter), before/after the sentence or w/ a minimal rewrite, not in `## Related`. A plain link on an existing word is "not enough".
- **Glue text** for those in-sentence links: short, in Deans tone (lowercase, "bc", "thats", "kinda", "ofc", "since", "want", no apostrophes), a clause at most, every bridge listed in the report.

**Why:** link format correction 2026-11-16; "dont add markdown link to them ... the whole title as prose" (2026-11-26).
**How to apply:** check an existing note in the main checkout for the current link style before bulk changes. See [[evergreen-notes]] for titles + evidence lines.
