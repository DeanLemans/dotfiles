---
name: agent-memory-setup
description: where memories/skills live (~/.agents via chezmoi) and how they are linked into claude
metadata:
  type: reference
---

- Memories + skills live in `~/.agents/` (chezmoi `dot_agents/`). Root `~/.agents/memories/*.md` = global, `~/.agents/memories/<project>/` = per project (`.path` holds the project path relative to `$HOME`).
- `.chezmoiscripts/run_after_link-agents.sh` imports the global files in `~/.claude/CLAUDE.md`, symlinks `~/.claude/projects/<project>/memory` -> the project folder, and links skills into `~/.claude/skills/`. `~/.local/bin/link-delta-memory` links Delta worktree memory dirs to the project one.
- Conventions: one memory per file, kebab-case file name = `name:`, frontmatter + **Why:** + **How to apply:**, Dean in 3rd person, "I" = the agent, no em dashes or apostrophes. Index line in the folders MEMORY.md.

**Why:** Dean wanted memories AI agnostic + synced to all machines via chezmoi (2026-11-27).
**How to apply:** save new global memories in the root folder, project ones in the project folder, then remind Dean to `chezmoi re-add` (new files: `chezmoi add`).
