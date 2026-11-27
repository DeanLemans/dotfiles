#!/bin/sh
# hooks the ai-agnostic ~/.agents (memories/ + skills/) into claude code.
# project memory dirs become symlinks to ~/.agents/memories/<project>/, so new
# memories land in ~/.agents too (then chezmoi re-add).
set -e
a="$HOME/.agents" p="$HOME/.claude/projects"

mkdir -p "$HOME/.claude/skills"
for s in "$a"/skills/*/; do
    [ -d "$s" ] && ln -sfn "${s%/}" "$HOME/.claude/skills/$(basename "$s")"
done

# root memories/*.md are global: import each one, drop imports of removed ones
f="$HOME/.claude/CLAUDE.md"
touch "$f"
grep -v '^@~/.agents/memories/' "$f" > "$f.tmp" || true
for m in "$a"/memories/*.md; do
    [ -f "$m" ] && [ "$(basename "$m")" != MEMORY.md ] && echo "@~/.agents/memories/$(basename "$m")" >> "$f.tmp"
done
mv "$f.tmp" "$f"

# each memories/<name>/.path holds the project path relative to $HOME
for d in "$a"/memories/*/; do
    d=${d%/}
    [ -f "$d/.path" ] || continue
    slug=$(printf '%s' "$HOME/$(cat "$d/.path")" | sed 's/[^A-Za-z0-9]/-/g')
    m="$p/$slug/memory"
    [ -L "$m" ] && [ "$(readlink "$m")" = "$d" ] && continue
    mkdir -p "$p/$slug"
    # keep whatever claude had, never delete it
    [ -e "$m" ] || [ -L "$m" ] && mv "$m" "$m.bak-$(date +%Y%m%d%H%M%S)"
    ln -s "$d" "$m"
done

# delta worktrees link to the project memory dir above
[ -x "$HOME/.local/bin/link-delta-memory" ] && "$HOME/.local/bin/link-delta-memory" >/dev/null 2>&1 || true
