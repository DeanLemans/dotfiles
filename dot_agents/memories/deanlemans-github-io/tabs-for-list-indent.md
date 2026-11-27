---
name: tabs-for-list-indent
description: in vault markdown, indent sub-bullets/nested lists with tabs, never spaces (YAML frontmatter stays spaces)
metadata:
  type: feedback
---

Nested list items (sub-bullets, checkbox sub-items) in vault notes must be indented with tabs, not spaces.

**Why:** Dean asked for it explicitly (2026-11-26) after reviewing vault_rules, colophon and lifecycle notes.
**How to apply:** when moving/merging text, convert leading spaces on list lines to tabs. Never touch YAML frontmatter (tabs are invalid YAML) or fenced code blocks like mermaid. Related: [[vault-edits-no-own-writing]]
