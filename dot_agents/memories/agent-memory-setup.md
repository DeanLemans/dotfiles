---
name: agent-memory-setup
description: where memories/skills live (~/.agents via chezmoi) and how link-agents hooks them into claude, codex, opencode, gemini
metadata:
  type: reference
---

- Memories + skills live in `~/.agents/` (chezmoi `dot_agents/`). Root `~/.agents/memories/*.md` = global, `~/.agents/memories/<project>/` = per project (`.path` holds the project path relative to `$HOME`).
- `~/.local/bin/link-agents` hooks it into every installed agent: claude gets one `@` import per global file in `~/.claude/CLAUDE.md`, `~/.claude/projects/<slug>/memory` symlinks for each project + each Delta worktree (Delta uses separate clones ∴ claude cant share memory by itself) + `~/.claude/skills/` links. Codex/opencode/gemini read `~/.agents/skills` natively and get `~/.agents/AGENTS.md` linked as `~/.codex/AGENTS.md`, `~/.config/opencode/AGENTS.md`, `~/.gemini/GEMINI.md` (only when that dir exists). AGENTS.md is generated (globals copied + list of project memory dirs), never edit it. Removed worktrees: dirs that only hold the memory link get pruned, sessions stay.
- Runs from the chezmoi apply script, the claude SessionStart hook (`~/.claude/settings.json`) + `~/.local/bin/link-agents-watch` (new worktrees, memory edits; inotifywait / fswatch, else polls every 5s, rerun every 5 min ∴ newly installed agents get linked). The watcher is needed: the hook alone is too late, session cpc5r7dm7s8b started w/o memories (2026-11-13); the watcher links in ~70 ms, before the session starts. `~/.local/bin/start-user-daemons` starts the watcher (+ promnesia-daemon) from xdg autostart, fish login, `~/.profile`, the apply script + the hook. One instance per daemon via `~/.local/lib/daemon-lock.sh`. Keep these scripts POSIX sh + OS agnostic (no systemd, no GNU-only flags).
- Conventions: one memory per file, kebab-case file name = `name:`, frontmatter + **Why:** + **How to apply:**, Dean in 3rd person, "I" = the agent, no em dashes or apostrophes. Project memories get an index line in their folders MEMORY.md, globals need none (every global file is loaded).

**Why:** Dean wanted memories AI agnostic + synced to all machines via chezmoi (2026-11-27).
**How to apply:** save new global memories in the root folder, project ones in the project folder, then remind Dean to `chezmoi re-add` (new files: `chezmoi add`).
