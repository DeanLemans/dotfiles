# ~/.agents

- memories + skills for ai agents live in ~/.agents (dot_agents here), not in my repos. i dont want ai files in my game repo, and this way every machine has the same ones
- memories/*.md are global rules (how i write, git stuff, dont touch addons ETC), memories/<project>/ is per project, its .path says which repo
- link-agents hooks it into whatever agent is installed. claude gets the memories imported in its CLAUDE.md + project memory and skills symlinked. codex/opencode/gemini read ~/.agents/skills themselves and get a generated AGENTS.md bc codex cant do imports. agents that arent installed get nothing
- delta runs every session in its own clone, and claude keys memory by path, so every session started with empty memory. link-agents-watch links the new worktree the moment delta makes it, before the session starts. the claude hook alone was too late
- agents write new memories straight into ~/.agents, so chezmoi re-add to keep them (new files chezmoi add ~/.agents)
- dont edit ~/.agents/AGENTS.md, it gets regenerated

---

## References

- [Claude Code memory](https://code.claude.com/docs/en/memory)
- [Codex AGENTS.md](https://developers.openai.com/codex/guides/agents-md)
- [opencode rules](https://opencode.ai/docs/rules/)
- [Gemini CLI GEMINI.md](https://geminicli.com/docs/cli/gemini-md/)
