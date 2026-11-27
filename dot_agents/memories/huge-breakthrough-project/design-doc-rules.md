---
name: design-doc-rules
description: rules for GDD/FDD/TDD in nexus: one fact one place, stages vs zones, open questions, FDD for non-programmers, 2D is prototype
metadata:
  type: feedback
---

Design docs live in `~/repositories/nexus/content/long term celcit pixie horror game/` (GDD.md, FDD.md, TDD.md). The TDD doc/comment rules apply to all three. Its a different repo (nexus, branch v5): dont commit there unless asked.

- one fact, one place: GDD = why/feel, FDD = rules + numbers, TDD = code; others link, dont copy
- prose = decided only; every [ ] goes in the docs Open Questions section
- decision made -> update section + Open Questions + Decisions table together
- same word for same thing (terms live in Info sections): sanity has **stages**, world has **zones**; code still says `zone` for stages
- FDD readable by non-programmers: minimal code references
- tone: [[writing-voice]], extra cold + concise here (cut articles), jokes ok. Status quotes use `>`.
- keep markdown/wikilinks to sources, Dean needs to know where info came from
- TOC at top ("Content in Doc"), in-doc links `[see Multiplayer.](#multiplayer)` style
- 2D code (player_body_2d, remote_player_2d, movement_2d_component) is prototype, real game is 3D: dont document it or flag it missing
- update docs only when asked ("update the TDD"), never as a side effect of code tasks
- Dean edits these in Obsidian at the same time; diff against your last version before editing, an open buffer can overwrite changes

**Why:** collected from doc reviews 2026-11-14..20 ("keep this in mind, update where relevant"); "update the nexus, dont commit" (2026-11-15).
**How to apply:** check these whenever editing any of the three docs.
