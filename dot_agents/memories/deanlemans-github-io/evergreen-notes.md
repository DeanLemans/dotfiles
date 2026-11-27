---
name: evergreen-notes
description: atomic/zettel/permanent notes = Matuschak evergreen notes; claim titles; current growing-note frontmatter + evidence format
metadata:
  type: feedback
---

- When Dean says "atomic", "zettel" or "permanent" notes he means **evergreen notes** (Andy Matuschak: atomic, concept-oriented, densely linked, claim-like titles, evolve over time). Judge them against evergreen principles, not Luhmann rules.
- **Frontmatter** (since the 2026-11-27 rework): `type: growing note` (plain string, not the old `[Atomic permanent zettel](...)` link), matched by `all_growing_notes.base`. Plus `publish: true`, `unlisted: false` and a `tags:` list (philosophy, note-taking...) so the MOC "unsorted" bases pick them up. Other bases: all_fleeting_notes, all_mocs, note_taking_unsorted, philosophy_unsorted. "Ignore quartz/publish" in reviews does not mean dropping these fields.
- **Title** = the claim as prose, taken from the notes own words where possible. When retitling, rename the file too (snake_case, [[linking]]) and update links ("dont just change the title").
- **Evidence** from other notes: `click for origin ["quote"](<./note.md>)` lines; say "came from", not "came out of". Related items can carry a relation label ("Builds on", "Tension with", "Contrast:", "Limit:").
- **Splitting/extracting**: some duplication of context between notes is fine, exact restatements in 2 notes are not.

**Why:** Dean corrected treating zettelkasten/permanent/evergreen as separate stages; I once used outdated conventions from an old summary and Dean was furious.
**How to apply:** copy the format from an existing growing note in the main checkout, not from this memory. Related: [[vault-edits-no-own-writing]].
