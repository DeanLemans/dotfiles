---
name: code-principles
description: Deans general code rules: less code, bsd/suckless, fail loudly where it matters, built-ins first, explicit names, no warning clutter, POSIX sh
metadata:
  type: feedback
---

- Less code is a feature. Write the minimum. Is this abstraction earning its keep? Consider deleting or merging before adding, and propose it during reviews (only do it when asked, [[only-do-what-was-asked]]).
- Like netbsd (easy to inspect, modify, extend), openbsd (simple, clear, consistent), suckless (small enough for one person to read + rewrite).
- **Fail loudly where a mistake is likely** (bad ids, missing wiring, broken save data, wrong config): report it, never continue silently. This is not a reason to wrap every engine call in checks, that is clutter.
- Use the built-ins of the engine/language/addons before writing your own.
- Explicit, descriptive names (full words, say the system/target). Make code easy to grep.
- Never silence warnings w/ clutter (ignore annotations, dummy vars, wrappers). Only fix warnings when the change is small + has clear benefit.
- Shell scripts + CI: POSIX `sh` only, no bash/dash extensions.
- Portable, but only for current releases: assume every OS (linux distros, the BSDs, illumos...) runs its latest version. No fallbacks or workarounds for old systems, they are clutter.

**Why:** Deans TDD rules, which he says apply more generally; "asume all OSes use their latest release ... dont acount for old ass stuff" (2026-11-27); he asked for more defensive checks (2026-11-25) but also "too much code clutter" for checks on every call (2026-11-15).
**How to apply:** project specifics (e.g. godot) in project memories.
