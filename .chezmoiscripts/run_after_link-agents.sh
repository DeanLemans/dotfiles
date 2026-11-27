#!/bin/sh
# hooks the ai agnostic ~/.agents (memories/ + skills/) into claude code.
# project memory dirs become symlinks to ~/.agents/memories/<project>/ ∴ new
# memories land in ~/.agents too (then chezmoi re-add). POSIX sh (2024).
set -eu
a=$HOME/.agents p=$HOME/.claude/projects

mkdir -p "$HOME/.claude/skills"
for s in "$a"/skills/*/; do
	[ -d "$s" ] || continue
	s=${s%/} t=$HOME/.claude/skills/${s##*/}
	if [ -L "$t" ] && [ "$(readlink "$t")" = "$s" ]; then continue; fi
	if [ -L "$t" ]; then rm -f "$t"; fi
	ln -s "$s" "$t"
done

# root memories/*.md are global: import each one, drop imports of removed ones
f=$HOME/.claude/CLAUDE.md
touch "$f"
grep -v '^@~/.agents/memories/' "$f" > "$f.tmp" || true
for m in "$a"/memories/*.md; do
	[ -f "$m" ] || continue
	[ "${m##*/}" = MEMORY.md ] && continue
	printf '@~/.agents/memories/%s\n' "${m##*/}" >> "$f.tmp"
done
mv "$f.tmp" "$f"

# each memories/<name>/.path holds the project path relative to $HOME
for d in "$a"/memories/*/; do
	d=${d%/}
	[ -f "$d/.path" ] || continue
	slug=$(printf '%s' "$HOME/$(cat "$d/.path")" | sed 's/[^A-Za-z0-9]/-/g')
	m=$p/$slug/memory
	if [ -L "$m" ] && [ "$(readlink "$m")" = "$d" ]; then continue; fi
	mkdir -p "$p/$slug"
	# keep whatever claude had, never delete it
	if [ -e "$m" ] || [ -L "$m" ]; then mv "$m" "$m.bak-$(date +%Y%m%d%H%M%S)"; fi
	ln -s "$d" "$m"
done

# delta worktrees: link now + keep watching (lock ∴ never twice)
w=$HOME/.local/bin/link-delta-memory-watch
if [ -x "$w" ]; then nohup "$w" >/dev/null 2>&1 & fi
exit 0
