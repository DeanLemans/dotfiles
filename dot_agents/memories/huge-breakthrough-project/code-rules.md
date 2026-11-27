---
name: code-rules
description: the TDD in nexus is the source of truth for coding/doc/naming rules; key points + how they fit together
metadata:
  type: project
---

The real TDD is `~/repositories/nexus/content/long term celcit pixie horror game/TDD.md` (synced into the game repo root by CI, dont edit that copy). Read its coding rules, documentation + comment rules and function naming guide before any code task or review; if it disagrees with this memory, the TDD wins. Dean says those rules apply more generally too (also to GDD/FDD).

Key points:
- godot flavored component-based architecture, but not everything a component; small composable scenes, not a framework on top. Merging components is fine when it removes code.
- narrow interfaces where change is expected (`PlayerApi`: give_item, has_item, set_flag...)
- fail loudly where mistakes are likely: `push_error` for bad ids, `_on_setup()` reports missing wiring, save data validated. Not checks on every engine call.
- easy to grep: one class per file, file named after class, stable IDs (item ID = file name), shared names are `StringName` constants (`Animations`, `StateEvents`)
- `##` doc comments for public API (contract, units, Godot tags @warning/@experimental, [member x] links), `#` inline for why. Compact per [[comment-style]], but the contract stays.
- function names explicit + descriptive (add() -> add_inventory_item()), keep Godot-defined names
- use godot built-ins + addon features before own logic; read the godot docs, not own knowledge
- editor is 4.8 but CI exports with 4.7.2 ([[ci-godot-version-mismatch]]) ∴ flag 4.8-only APIs/scene formats instead of bumping CI

Warnings: never `@warning_ignore`, never clutter to silence one (dummy `var _x = call()`, wrappers, push_error on every `connect()`). Only small fixes w/ clear benefit (explicit types, real `await`, useful error checks). Discarded returns (`connect`, `move_and_slide`, `erase`, tweens) stay as they are.

**Why:** Dean gave these rules repeatedly (2026-11-12..25) and keeps them in the TDD.
**How to apply:** check new code against these, and say which rule a change follows when it matters. Related: [[design-doc-rules]].
