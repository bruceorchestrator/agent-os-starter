# outputs/

Generated deliverables — specs, research reports, proposals, drafts, analyses. Anything your AI produces that you want to keep.

## Subdirectories grow organically

- `specs/` — technical specs and PRDs
- `research/` — research outputs (web research, comparisons)
- `drafts/` — writing drafts (proposals, blog posts, emails)
- `reports/` — generated reports and analyses

Don't pre-create them — let the agent add them as they're needed.

## Why this exists

When you ask your AI to "write a spec for X" or "research Y", the answer often disappears into chat history. Filing useful answers here makes them part of your knowledge base instead of one-shot conversations.

## Lifecycle

Outputs start ephemeral (you might iterate on them several times). Once stable, useful generated knowledge can be promoted to a `wiki/` page. The split:

- **outputs/** = one-time deliverables, often tied to a specific moment ("the spec we wrote for the PDF feature")
- **wiki/** = durable knowledge ("how billing works in this product")
