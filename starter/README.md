# Simple Mode — `starter/`

Everything you need to give your AI agent persistent memory across sessions. Drop this folder into your project and your agent will know how to use it.

## What's here

```
AGENTS.md           — schema (your AI reads this first)
CLAUDE.md           — same content, mirrored for Claude Code
memory/
  STATE.md          — current priorities and blockers
  learnings.md      — mistakes, wins, patterns
  daily/            — append-only event log per day
  wiki/             — topic pages, cross-linked
    INDEX.md
  outputs/          — generated deliverables (specs, reports)
  raw/              — immutable source dumps
```

12 files total. The example data is from a fictional product called **Acme Notes**. Replace it with your own as you go.

## How to use it

1. **Copy this `starter/` directory** into your own project (rename to whatever you want — `memory/` at project root works fine).
2. **Open the project in your AI agent** — Claude Code, Codex, Cursor, Aider, anything that reads markdown.
3. **Your agent reads `AGENTS.md` (or `CLAUDE.md`)** and learns the conventions automatically.
4. **Start working.** As you share URLs, ask questions, make decisions — the wiki maintains itself.
5. **Each session starts** with `STATE.md` + `learnings.md` + `wiki/INDEX.md` + latest `daily/*.md`.

## When you outgrow this

Simple Mode is for projects where one or two people work with one or two AI agents. When you need:

- Multi-domain agent state (separate context per role: backend-dev, frontend-dev, etc.)
- Behavioral rules (auto-loaded policies, e.g. testing rules, cost-aware LLM routing)
- Skills (reusable workflows like `/ingest`, `/lint`, `/morning`, `/endday`)
- Hooks (runtime enforcement: session-start auto-load, commit memory reminders)
- Pre-commit governance (staleness checks, source-of-truth discipline)

→ See [Advanced Mode in `../full/`](https://github.com/bruceorchestrator/agent-os-starter/tree/main/full).

## Credits

Concrete instantiation of [Andrej Karpathy's LLM wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f). The pattern is his — this packaging is one way to use it on a real project.
