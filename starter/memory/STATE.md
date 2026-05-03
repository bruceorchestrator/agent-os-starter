# Acme Notes — Current State

Last updated: 2026-05-03

## Priorities

| # | Priority | Status | Owner | Notes |
|---|----------|--------|-------|-------|
| 1 | Sync conflicts on offline edits | 🔴 P0 | Alex | Hotfix shipped 2026-05-02; now adding regression tests |
| 2 | Stripe billing integration | 🟡 P1 | Maya | Needed for public launch (~2 months) |
| 3 | PDF export with branding | 🟢 P2 | Alex | MVP ETA Friday — Bluefin pilot ask |
| 4 | Mobile-responsive polish | ⚪ P2 | Maya | Deferred to post-launch |
| 5 | Onboarding funnel | ✅ Shipped | Maya | 12% → 31% conversion (2026-05-01) |

## Blockers

None right now. Sync hotfix unblocked Bluefin and Tessera.

## Active design partners

- **Bluefin Coffee** — 12-person ops team, daily SOPs use case. Pilot stage. Open ask: PDF export with their branding.
- **Tessera Studio** — 8-person design agency, client briefs use case. Active user. Renewal 2026-06-01. Asked about SAML SSO (deferred to Q3).

See [[design-partner-program]] for the full list.

## Public launch

Target: ~2 months out. Gates:
- Stripe billing live and tested
- Sync regression suite green on iOS Safari + Chrome + desktop
- 8/8 design partners signed off

## Team

- **Maya** — solo founder. Product, design, frontend, customer dev.
- **Alex** — part-time backend contractor, ~20 hrs/week. Owns `sync/` + DB.
