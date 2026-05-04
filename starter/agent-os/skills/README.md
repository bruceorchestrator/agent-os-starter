# Skills (Simple Mode)

4 core memory-loop workflows. The minimum needed for the wiki to actually update over time.

## What's here

- **`morning/`** — start of day. Load `STATE.md` + `learnings.md` + latest `daily/`, propose plan
- **`endday/`** — end of day. Save session events to `daily/`, update `STATE.md` if priorities shifted, log corrections to `learnings.md`
- **`ingest/`** — Karpathy ingest. URL/file/text → `raw/` + update `wiki/` + log `daily/`. **The single most important skill — without it the wiki never grows.**
- **`lint/`** — Karpathy lint. Mechanical wiki health check (orphans, broken cross-links, stale pages) + semantic LLM pass

## What's NOT here (Advanced Mode only)

These belong to `full/agent-os/skills/`:

- `/create-spec` — generate structured specs before complex tasks
- `/call-debrief` — extract decisions from call transcripts
- `/web-researcher` — multi-source deep research
- `/create` — bootstrap new skills/agents
- `/swarm` — multi-agent task decomposition

If you outgrow Simple Mode, copy `full/agent-os/skills/` over your starter setup.

## How to invoke

Different tools have different mechanisms:

- **Claude Code:** typing `/skill-name` or AI invokes via `Skill` tool when context matches description
- **Codex / OpenCode:** AI reads `SKILL.md` when relevant context appears
- **Cursor / Aider / etc.:** AI reads on user request or matching trigger phrase

Trigger phrases are listed in each skill's frontmatter description.
