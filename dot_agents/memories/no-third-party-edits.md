---
name: no-third-party-edits
description: never edit vendored/third-party code (addons, plugins, templates); their config/settings only when asked
metadata:
  type: feedback
---

- Never edit third-party/vendored **code**: `addons/`, plugin source, template code, plugin data/history. Fix from the project side (project settings, own scripts, public API) or explain + ask first. Updates would overwrite edits anyway.
- **Config is different:** changing a tools/plugins settings (e.g. `.obsidian/plugins/*/data.json`, project settings, export presets) is fine when Dean asks for it. When Dean replaces an addon folder on upgrade, restoring his previous settings is part of the asked task.

**Why:** "you should not be touching the addon folder" (2026-11-18), but Dean regularly asks to configure plugins ("just configure the relevant ones", 2026-11-26).
**How to apply:** code -> dont; settings -> only when asked. Exact folders per project are in project memories.
