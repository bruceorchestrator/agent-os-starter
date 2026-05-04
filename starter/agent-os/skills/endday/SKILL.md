---
name: endday
description: End of day — save context for next session. Use when user says "endday", "end of day", "wrap up", "handoff", or invokes `/endday`.
---

# /endday

End-of-day ritual. Save what happened so tomorrow's session has context.

## When to use

- User signals end of working session
- Trigger phrases: "endday", "end of day", "wrapping up", "handoff", "/endday"
- Before a long break (>1 day) where session continuity matters

## Procedure

### 1. Append to `memory/daily/YYYY-MM-DD.md`

Update today's daily log with what happened in this session. If the file doesn't exist yet, create it.

Template:

```markdown
# YYYY-MM-DD

## Actions
- [what got done — bullets, action verbs]

## Decisions
- [decisions made, with rationale]

## Insights
- [non-obvious things learned]

## Tomorrow
- [what's next — sets up next morning]
```

Only include sections that have content. Bullets, not paragraphs.

### 2. Update `memory/STATE.md` if priorities shifted

If today's work changed priorities (something blocked, something shipped, something escalated), update the priorities section to reflect new state.

Bump `Last updated: YYYY-MM-DD` to today.

### 3. If the user corrected you today

Append entry to `memory/learnings.md` MISTAKES section with the format:

```
## YYYY-MM-DD — Short title
**Wrong:** what I did
**Correct:** what I should have done
**Why:** reason
**Trigger:** when to recall this
```

This is the highest-value step — the AI gets sharper over time only if mistakes are recorded.

### 4. Confirm to user

Tight summary:

```
Saved to memory:
- daily/YYYY-MM-DD.md (N actions, N decisions)
- STATE.md (updated priorities) [if applicable]
- learnings.md (N new mistakes recorded) [if applicable]

See you tomorrow.
```

## Anti-patterns

- Writing a 2-page novel in daily/ — bullets, not paragraphs
- Including chat trivia ("user asked X, I responded Y") — only meaningful events
- Overwriting yesterday's state — append, don't replace
- Skipping the user-correction → learnings.md step (highest-value transcript output)
