---
name: ci-godot-version-mismatch
description: editor is Godot 4.8 beta but CI exports with 4.7.2 on purpose; 4.8 inlines PackedScene refs as sub_resources that 4.7 cant parse
metadata:
  type: project
---

Local editor is Godot 4.8 beta (binary path in [[no-running-godot]]), CI (.github/workflows/godot-ci.yaml) exports with barichello/godot-ci:4.7.2. Dean said not to treat the CI version as the problem, so dont bump CI.

4.8 saves `PackedScene` export props (parent_scene, packed_scene, options_packed_scene...) as inline `[sub_resource type="PackedScene"]` blocks + a `[resource]` marker; 4.7 fails with "Unknown tag 'resource'" and the menus/popups dont load on the deployed web build. Fixed 2026-11-19 in commit 95b4d18 by pointing them back at ExtResources (converter logic: take the value from before a0fc6d2, drop the prop if it was inherited).

**Why:** re-saving those scenes in the 4.8 editor may inline them again.
**How to apply:** if CI web build shows tscn "Unknown tag" parse errors, grep for `^\[sub_resource type="PackedScene"` in .tscn files. Testing like CI means a headless 4.7.2 export, which needs Deans explicit OK (see [[no-running-godot]]); otherwise give Dean the steps.
