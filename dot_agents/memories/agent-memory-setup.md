---
name: agent-memory-setup
description: where memories/skills live (~/.agents via chezmoi) and how they are linked into claude
metadata:
  type: reference
---

- Memories + skills live in `~/.agents/` (chezmoi `dot_agents/`). Root `~/.agents/memories/*.md` = global, `~/.agents/memories/<project>/` = per project (`.path` holds the project path relative to `$HOME`).
- `.chezmoiscripts/run_after_link-agents.sh` imports the global files in `~/.claude/CLAUDE.md`, symlinks `~/.claude/projects/<project>/memory` -> the project folder, and links skills into `~/.claude/skills/`. `~/.local/bin/link-delta-memory` links Delta worktree memory dirs to the project one; `~/.local/bin/link-delta-memory-watch` reruns it on every new worktree (inotifywait, else polling). Both POSIX sh, no systemd: started by xdg autostart (`~/.config/autostart/link-delta-memory.desktop`), fish login shells (`~/.config/fish/conf.d/link-delta-memory.fish`, covers headless/ssh), the apply script and the claude SessionStart hook (`~/.claude/settings.json`, tracked in chezmoi). One instance per user via a lock dir. Needs `inotify-tools` for instant linking (in the package script), else polls every 5s.
- Conventions: one memory per file, kebab-case file name = `name:`, frontmatter + **Why:** + **How to apply:**, Dean in 3rd person, "I" = the agent, no em dashes or apostrophes. Index line in the folders MEMORY.md.

**Why:** Dean wanted memories AI agnostic + synced to all machines via chezmoi (2026-11-27).
**How to apply:** save new global memories in the root folder, project ones in the project folder, then remind Dean to `chezmoi re-add` (new files: `chezmoi add`).
