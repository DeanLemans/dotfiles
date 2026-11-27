---
name: link-agents
description: how ~/.agents gets hooked into claude, codex, opencode, gemini: link-agents, the watcher, the hook, start-user-daemons
metadata:
  type: reference
---

- `~/.local/bin/link-agents` hooks `~/.agents` into every installed agent: claude gets one `@` import per global file in `~/.claude/CLAUDE.md`, `~/.claude/projects/<slug>/memory` symlinks for each project + each Delta worktree (Delta uses separate clones ∴ claude cant share memory by itself) + `~/.claude/skills/` links. Codex/opencode/gemini read `~/.agents/skills` natively and get `~/.agents/AGENTS.md` linked as `~/.codex/AGENTS.md`, `~/.config/opencode/AGENTS.md`, `~/.gemini/GEMINI.md` (only when that dir exists). AGENTS.md = globals copied + list of project memory dirs. Removed worktrees: dirs that only hold the memory link get pruned, sessions stay.
- Runs from the chezmoi apply script, the claude SessionStart hook (`~/.claude/settings.json`) + `~/.local/bin/link-agents-watch` (new worktrees, memory edits; inotifywait / fswatch, else polls every 5s, rerun every 5 min ∴ newly installed agents get linked). The watcher is needed: the hook alone is too late, session cpc5r7dm7s8b started w/o memories (2026-11-13); the watcher links in ~70 ms, before the session starts.
- `~/.local/bin/start-user-daemons` starts the watcher (+ promnesia-daemon) from xdg autostart, fish login, `~/.profile`, the apply script + the hook. One instance per daemon via `~/.local/lib/daemon-lock.sh`.

**Why:** Dean wanted memories AI agnostic + synced to all machines (2026-11-27); split out of the global agent-memory-setup ∵ only needed when working on these scripts.
**How to apply:** keep these scripts POSIX sh + OS agnostic (no systemd, no GNU-only flags, [[code-principles]]). Test changes w/ a fake `$HOME` in a scratch dir, never against the real `~/.claude` first.
