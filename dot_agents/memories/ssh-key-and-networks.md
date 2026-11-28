---
name: ssh-key-and-networks
description: Dean reuses one ssh key on every machine (no new keys), main pc + server are on different networks, never assume a shared lan
metadata:
  type: user
---

- Dean wants his existing personal ssh key on every machine. He rejected making a new key per machine, dont suggest it again.
- Main pc + server (leftover pc, user `tv`) are on **different networks**, the server router cant port forward. Lan ssh/scp between them doesnt work. They reach each other over a tor onion service (see the dotfiles README, server section).
- Dont assume setup details Dean didnt say (network, hardware, what is installed). Check or ask.

**Why:** I assumed a shared lan + then pushed a new key, Dean got very angry both times ("WHEN THE FUCK DID I SAY ITS ON THE SAME NETWORK", "NO NEW FUCKING KEY") (2026-11-27).
**How to apply:** moving files between his machines -> over the onion service (`ssh server` from main) or croc / magic-wormhole. Related: [[no-github-cli]], [[user-setup]].
