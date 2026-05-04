# Acme Notes — Learnings

**Curated** operational memory. Read by your AI agent at session start for pattern recall.

This is NOT a dump of every event (that's `daily/`). This file stays **active and signal-dense** — target ~300-500 lines. When it grows past that, run `/review-learnings` to curate (promote repeated mistakes to PATTERNS, archive stale entries to `learnings.archive.md`).

## Lifecycle

| Section | Purpose | Lifecycle |
|---|---|---|
| **MISTAKES** | Recent corrections (last 60-90 days) still likely to repeat | Append on user correction. Promote to PATTERN if same root cause repeats 2+ times. Archive when quiet 90+ days. |
| **PATTERNS** | Durable rules graduated from repeated mistakes | Always-on. Stays unless invalidated. |
| **WINS** | Positive signal log — what worked | Append-only, cheap to retain. |
| **ARCHIVED** | Old lessons preserved for searchability | Lives in separate `learnings.archive.md` (append-only, NOT auto-loaded). |

`daily/` is raw event log. `learnings.md` is the curated index. `learnings.archive.md` is history.

---

## MISTAKES

Format:

```
## YYYY-MM-DD — Short title
**Wrong:** what I did
**Correct:** what I should have done
**Why:** reason it matters
**Trigger:** when to recall this lesson
```

### 2026-04-20 — Shipped sync engine without conflict tests

**Wrong:** deployed CRDT merge logic to prod with smoke test only, no conflict regression suite.
**Correct:** sync changes need a dedicated conflict test pass before any prod deploy.
**Why:** lost a design partner's data temporarily. Recovery from backups, but trust-eroding.
**Trigger:** any change to `sync/` or merge logic — gate must include conflict regression tests.

### 2026-04-28 — Stripe webhooks pointed to localhost in prod

**Wrong:** local dev set webhook to ngrok, never reset env var, prod missed 3 days of payment events.
**Correct:** add Stripe env URL assertion to pre-deploy script.
**Why:** silent revenue blindness. 3 customers thought they paid but accounts didn't activate.
**Trigger:** any deploy touching `lib/billing/` — verify `STRIPE_WEBHOOK_URL` matches prod hostname.

---

## WINS

### 2026-05-01 — Onboarding rewrite: 12% → 31% conversion

4-step wizard replaced with single-page "your team in 30 seconds" flow.
Pattern: cut steps, frame as outcome ("your team setup in 30 seconds") not process ("step 1 of 4").

---

## PATTERNS

(empty — append durable insights as they emerge)
