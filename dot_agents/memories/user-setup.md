---
name: user-setup
description: Deans machines + tools: CachyOS/KDE, fish, paru, nemo, zed, lazygit, public chezmoi dotfiles, Delta
metadata:
  type: user
---

- Dean. Main machine + a server, both CachyOS (arch) + KDE Plasma. No COSMIC anymore.
- Shell is **fish**: every command given to Dean must work in fish (a glob w/ no match is an error, so dont mix optional globs into one `rm`).
- AUR helper is **paru** (`yay` is aliased to it). File manager is nemo, not dolphin. Editor is zed (refuses to run as root, so no `sudo zeditor`). Git UI is lazygit.
- Dotfiles: chezmoi, source `~/.local/share/chezmoi`, repo is **public**: never keys/tokens/passwords/ids in it.
- Agents run through Delta (zeds agent app). Sessions start in `<repo>/.delta/worktrees/<id>/<name>`.

**Why:** wrong-tool mistakes so far: dolphin/cosmic assumptions, a fish glob error, `sudo zeditor`.
**How to apply:** see [[fresh-main-checkout]] for the Delta worktree rule.
