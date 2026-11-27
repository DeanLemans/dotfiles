---
name: code-rules
description: the TDD in nexus is the source of truth for coding/doc/naming rules; the godot-specific points on top of the global code-principles
metadata:
  type: project
---

The real TDD is `~/repositories/nexus/content/long term celcit pixie horror game/TDD.md` (synced into the game repo root by CI, dont edit that copy). Read its coding rules, documentation + comment rules and function naming guide before any code task or review; if it disagrees with this memory, the TDD wins. The general rules (less code, fail loudly, built-ins first, explicit names, no warning clutter) are in the global [[code-principles]]. Godot specifics:
- godot flavored component-based architecture, but not everything a component; small composable scenes, not a framework on top. Merging components is fine when it removes code.
- narrow interfaces where change is expected (`PlayerApi`: give_item, has_item, set_flag...)
- fail loudly = `push_error` for bad ids, `_on_setup()` reports missing wiring, save data validated
- easy to grep = one class per file, file named after class, stable IDs (item ID = file name), shared names are `StringName` constants (`Animations`, `StateEvents`)
- `##` doc comments for public API (contract, units, Godot tags @warning/@experimental, [member x] links), `#` inline for why. Compact per [[comment-style]], but the contract stays.
- explicit names: add() -> add_inventory_item(), keep Godot-defined names
- built-ins = godot + addon features, read the godot docs
- warnings: never `@warning_ignore`, no dummy `var _x = call()`, no push_error on every `connect()`. Discarded returns (`connect`, `move_and_slide`, `erase`, tweens) stay as they are.
- editor is 4.8 but CI exports with 4.7.2 ([[ci-godot-version-mismatch]]) ∴ flag 4.8-only APIs/scene formats instead of bumping CI

**Why:** Dean gave these rules repeatedly (2026-11-12..25) and keeps them in the TDD.
**How to apply:** check new code against these, and say which rule a change follows when it matters. Related: [[design-doc-rules]].
