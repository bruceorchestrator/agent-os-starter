# Acme Notes — Learnings

Append-only record of mistakes (so we don't repeat them), wins (so we remember what worked), and patterns (durable insights). Read by your AI agent at session start.

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
