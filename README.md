# agent-os-starter

> A concrete implementation of [Andrej Karpathy's LLM wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f), adapted for AI coding agents working in real codebases.

**Status:** 🚧 Work in progress. Not ready for use yet. See [Roadmap](#roadmap) below.

The foundational idea is Karpathy's. This repo packages it as a copyable starter and adds operational state, agent state, skills, hooks, and governance so the pattern survives real project work.

## Roadmap (PR0)

- [x] Stage 1: Repo skeleton + MIT LICENSE
- [ ] Stage 2: Acme Notes fictional context
- [ ] Stage 3: `starter/` Simple Mode
- [ ] Stage 4: `full/` agent-os/{rules,agents,skills,hooks}
- [ ] Stage 5: `full/` AGENTS.md + adapters/ + scripts/
- [ ] Stage 6: Top-level docs (README, INSTALL, INSTALL_PROMPT, EXAMPLE_TOUR)
- [ ] Stage 7: Scrub pass for personal/project residue
- [ ] Stage 8: INSTALL_PROMPT testing + public release

When this README gets fleshed out — Stage 6.

## Credits

This work stands on the shoulders of:

- **[Andrej Karpathy's LLM wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)** — the foundational pattern (3-layer wiki + ingest/query/lint operations). All flowers to him.
- **[Anthropic Claude Code](https://docs.claude.com/claude-code)** — runtime primitives (CLAUDE.md, auto-loaded rules, skills, hooks).
- **This repo** — concrete instantiation + extensions for the working-codebase use case.

Full credits ladder will land in Stage 6.

## License

MIT. See [LICENSE](./LICENSE).
