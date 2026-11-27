---
name: hands-off-folders
description: dont edit addons/; dont clean up template code, demo levels, ARCHIVE SCRIPTS or state chart examples
metadata:
  type: feedback
---

- **addons/**: never edit, even for a real plugin bug. Fix from the project side (project settings, export presets, own autoload/scene, plugin public API). If only the addon can fix it, explain + ask. Formatter/linter must skip it too.
- **Leave alone in audits + cleanups**: `scripts/ARCHIVE SCRIPTS/`, `godot_state_charts_examples/`, Maaack template demo levels (`scenes/game/levels/level_1/2/3.tscn` + scripts only they use), template-derived scripts under `scenes/` (`level.gd`, `game_timer.gd`, `tutorial_manager.gd`, menus...). Dont propose deleting reference/template material.
- TDD audit rules apply to Deans own code in `scripts/` + `pickup_toast.gd` + `showcase_hud.gd`.

**Why:** patched `addons/debug_menu/debug_menu.gd` 2026-11-18 ("you should not be touching the addon folder"); 2026-11-14 Dean dropped my commit deleting demo levels + told me to ignore these folders.
**How to apply:** exclude these from audits, cleanups and formatter runs.
