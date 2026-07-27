# Rules

Auto-loaded behavioral policies for your AI agent. These shape how the agent works, not what it works on.

## How rules are loaded

Rules are referenced from the main schema (`AGENTS.md` / `CLAUDE.md`). There are **two loading modes**, and picking the right one is the single biggest lever on your token bill.

**Always-on** — no `paths:` key in frontmatter. Loaded into the system prompt of every session, on every task, whether or not it is relevant. Reserve this for rules that apply to *any* work: how the agent verifies, how it talks to you, how it records mistakes.

**Conditional** — a `paths:` key listing globs. The rule loads only when the agent touches a matching file. Costs nothing until then.

```yaml
---
description: When to write tests, what they must cover, how they run.
paths:
  - "**/test_*.py"
  - "**/*.test.ts"
---
```

A testing rule is useless when you ask a question about the roadmap; a file-size gate is useless until code is being edited. Make those conditional. **The default of "everything always on" quietly costs thousands of tokens per session and gets worse with every rule you add.**

Measure before and after: `bash scripts/context_budget.sh`.

> This distinction is easy to get wrong even when you know about it. In the project this starter was extracted from, six heavy rules sat always-on for months (~42KB per session) because the decision was made by reading docs instead of measuring what actually reaches the context window.

For tools that don't auto-load directories (Codex, Aider), the schema lists each rule explicitly — conditional loading is a Claude Code feature, so those tools get everything.

## What's here

Generic, stack-agnostic rules:

**Always-on** (apply to any task):
- **`quality-gate.md`** — verification before completion, plan mode, bug-fix protocol
- **`agent-quality.md`** — agent dispatch protocol, memory loop scaling, verification iron law
- **`self-monitor.md`** — improvement loop, learnings format, correction protocol

**Conditional** (`paths:`-scoped, load only on matching files):
- **`testing.md`** — when to write tests, fixtures, anti-patterns
- **`file-size-triggers.md`** — file hygiene, decomposition triggers
- **`cost-aware-llm.md`** — LLM API cost discipline, model routing patterns

Adjust the globs to your stack — the shipped ones cover common Python/TS/JS layouts.

## Templates (rename to use)

- **`identity.md.template`** — defines your AI's persona and tone
- **`language.md.template`** — communication preferences (response language, code language)

## Why so few

A starter ships only rules that translate across projects. Stack-specific or domain-specific rules (e.g. "how we deploy to our serverless platform") belong in your project, not the starter.

If you want more rules: copy a generic one as a template, or write your own. The pattern is simple — markdown with clear sections, kept under ~200 lines each.

## Adding rules

When you hit a recurring issue your AI keeps making, write a rule. The flow:

1. The mistake gets logged in `memory/learnings/mistakes.md`
2. If the mistake repeats, promote the lesson to a rule here
3. Update the schema (`AGENTS.md`) to reference the new rule

Rules are for patterns the AI must follow on every task. One-off lessons stay in `learnings/mistakes.md`.
