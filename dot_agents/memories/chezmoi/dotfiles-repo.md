---
name: dotfiles-repo
description: chezmoi dotfiles facts: public repo, per-machine data, sudo install scripts (never apply unasked), commit only when asked
metadata:
  type: project
---

- Source `~/.local/share/chezmoi`, remote `github.com/deanlemans/dotfiles`, **public**: no keys/tokens/discord ids (equibop pinned dms are stripped for that reason).
- Machines: `machine` (main/server) + `mcServer` in chezmoi config data. KDE files per machine under `.kde/<machine>/`; floorp only on main.
- System files (ly config, floorp policies) live in `etc/` in the repo; `.chezmoiscripts/run_install-*` copy them as root via `.lib/as_root.sh` (run0 > pkexec > doas > sudo > pfexec > su) to `etc_prefix` (/etc on linux, /usr/local/etc on bsd), skipped when the app isnt installed.
- `run_onchange_before_install-packages` installs packages w/ pacman/paru/flatpak/pipx (arch names); on systems without them it only prints what to install, never fails the apply. It still installs ∴ **never run `chezmoi apply` (or `update`) without asking**, it counts as installing ([[only-do-what-was-asked]]). `chezmoi add` / `re-add` / `diff` are fine.
- No systemd units: background stuff (link-agents-watch, promnesia serve + hourly index) are POSIX sh daemons in `~/.local/bin`, see [[link-agents]]. Paths use `$HOME` / `{{ .chezmoi.homeDir }}`, never `/home/void` (server user is `tv`). ly config is linux only.
- `~/.agents` (memories + skills) is tracked as `dot_agents/`; `~/.claude/settings.json` (SessionStart hook) as `dot_claude/settings.json`, so claude changing its settings shows up in `chezmoi diff`.
- README is in Deans public voice ([[writing-voice]]), plain markdown, no obsidian-flavored syntax.
- Commit only when Dean asks ("commit it to the normal main"), on main, never push.

**Why:** facts Dean had to repeat while setting the repo up (2026-11-18..27).
**How to apply:** check secrets before every add; machine-specific stuff goes through the config data, not copies.
