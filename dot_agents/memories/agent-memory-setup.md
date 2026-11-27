---
name: agent-memory-setup
description: where memories + skills live (~/.agents, synced via chezmoi), where to save new ones + the memory conventions
metadata:
  type: reference
---

- Memories + skills live in `~/.agents/` (chezmoi source `dot_agents/`), shared by every agent (claude, codex, opencode, gemini). Root `~/.agents/memories/*.md` = global, loaded in every session. `~/.agents/memories/<project>/` = per project: `.path` holds the repo path relative to `$HOME`, `MEMORY.md` is its index. Skills: `~/.agents/skills/<name>/SKILL.md`.
- Claudes memory dir of a project (+ of each Delta worktree) is a symlink to that project folder ∴ a saved claude memory lands there. Other agents write the file into the project folder directly.
- `~/.agents/AGENTS.md` is generated, never edit it. How the linking works: chezmoi project memory [[link-agents]].
- Conventions: one memory per file, kebab-case file name = `name:`, frontmatter + **Why:** + **How to apply:**, Dean in 3rd person, "I" = the agent, no em dashes or apostrophes. Project memories get an index line in their folders MEMORY.md, globals need none.

**Why:** Dean wanted memories AI agnostic + synced to all machines via chezmoi (2026-11-27).
**How to apply:** save new global memories in the root folder, project ones in the project folder, then remind Dean to `chezmoi re-add` (new files: `chezmoi add`).
