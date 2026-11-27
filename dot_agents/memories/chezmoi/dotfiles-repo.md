---
name: dotfiles-repo
description: chezmoi dotfiles facts: public repo, per-machine data, sudo install scripts (never apply unasked), commit only when asked
metadata:
  type: project
---

- Source `~/.local/share/chezmoi`, remote `github.com/deanlemans/dotfiles`, **public**: no keys/tokens/discord ids (equibop pinned dms are stripped for that reason).
- Machines: `machine` (main/server) + `mcServer` in chezmoi config data. KDE files per machine under `.kde/<machine>/`; floorp only on main.
- System files (`/etc/...`, e.g. ly config, floorp policies) live in the repo and get installed by `.chezmoiscripts/run_onchange_*` with sudo. `run_onchange_before_install-packages` installs packages ∴ **never run `chezmoi apply` (or `update`) without asking**, it counts as installing ([[ask-before-acting]]). `chezmoi add` / `re-add` / `diff` are fine.
- `~/.agents` (memories + skills) is tracked as `dot_agents/`; `~/.claude/settings.json` (SessionStart hook) as `dot_claude/settings.json`, so claude changing its settings shows up in `chezmoi diff`.
- README is in Deans public voice ([[writing-voice]]), plain markdown, no obsidian-flavored syntax.
- Commit only when Dean asks ("commit it to the normal main"), on main, never push.

**Why:** facts Dean had to repeat while setting the repo up (2026-11-18..27).
**How to apply:** check secrets before every add; machine-specific stuff goes through the config data, not copies.
