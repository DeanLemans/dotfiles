---
name: no-running-godot
description: never run the godot binary (headless, editor, --check-only, scripts) in this project, not even GUT tests
metadata:
  type: feedback
---

Do not run Godot itself in this project: no `godot --headless`, `--editor`, `--check-only`, `-s script.gd`, and no GUT runs.

**Why:**
- 2026-11-12: Dean stopped a headless run. Running it rewrites `.godot/` caches, and the Net autoload connects to SpacetimeDB maincloud.
- 2026-11-25: Dean briefly allowed headless runs, then took it back ("dont run it headless, takes to much time").

**How to apply:**
- Verify by reading code and grepping.
- Dean runs the tests in the editor. Tell Dean what to run and what might fail.
- For reference, Deans editor binary is `~/Downloads/Godot_v4.8-beta4_linux.x86_64`.
