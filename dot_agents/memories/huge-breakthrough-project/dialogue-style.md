---
name: dialogue-style
description: rules for .dialogue files (Dialogue Manager 4.2): own tone per entity, psychological horror, dialogue-specific AI tells
metadata:
  type: feedback
---

- Use Dialogue Manager 4.2 conventions; read its docs (github nathanhoad/godot_dialogue_manager docs) before changing syntax.
- Each entity has its own tone. Overall vibe: dark, creeping psychological horror (read the GDD). Direct, not verbose. Some silly stuff (teto) is fine as long as it turns wrong/creepy.
- Comments + thinking lines lowercase. No apostrophes ([[writing-voice]]).
- Formatting tags (color, wait, shake, rainbow, wave) sparingly, some is fine.
- Developer/explain text stays behind the explain/verbose toggle, not in normal lines.
- Dialogue-specific AI tells on top of the general [[writing-voice]] list: modular hub branching (intake > hub > menu > exam), near-identical question blocks, over-explained comments ("costs 5 sanity"), repeating motifs, faux-profound lines, implied prior loops, tidy fact names (`teto.met`), generic phrasing. Implication > explanation; let some lines have no twist.

**Why:** many rounds of dialogue feedback 2026-11-13..20 (teto dialogue especially).
**How to apply:** check every dialogue edit against both lists.
