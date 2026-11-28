---
name: no-github-cli
description: never suggest, install or add the github cli (gh / github-cli), use ssh keys for github auth
metadata:
  type: feedback
---

Never suggest, install or add `gh` / `github-cli`, also not in package lists or install scripts. For github auth: Deans existing ssh key, remote as `git@github.com:...`. A personal access token is the fallback.

**Why:** "what the fuck? never add github cli" after I suggested it for pushing from the server (2026-11-27).
**How to apply:** github login problems -> ssh key, see [[ssh-key-and-networks]].
