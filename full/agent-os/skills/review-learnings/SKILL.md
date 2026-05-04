---
name: review-learnings
description: Curate memory/learnings.md — group repeated mistakes, promote to PATTERNS, archive stale entries. Proposes changes, NEVER auto-applies. Use when user says "review learnings", "curate learnings", "audit mistakes", "promote patterns", or when learnings.md exceeds ~500 lines (size trigger from /morning or /lint).
allowed-tools: Read Write Edit Bash Grep
---

# /review-learnings

Curate `memory/learnings.md` — keep it short, active, signal-dense. Move old or redundant entries out without losing them.

This is the **lifecycle** skill for operational memory. Run periodically (when file grows past ~500 lines) or when noticeable noise creeps in.

## When to use

- User says: "review learnings", "curate learnings", "audit mistakes", "promote patterns", "почисти learnings"
- `/morning` or `/lint` flags learnings.md > 500 lines
- After a big project milestone (lessons accumulated; consolidate before next phase)
- When repeated mistakes blur into similar-looking entries

## Critical rule

**This skill PROPOSES changes. It does NOT auto-apply.** Mistakes encode painful context — losing nuance is worse than keeping noise. Every promotion / archive / merge requires user confirmation per item.

## Lifecycle (read this first)

```
daily/                       = raw event log, append-only (never curate)
memory/learnings.md          = active operational memory (curated, ~300-500 lines)
memory/learnings.archive.md  = old lessons, searchable but NOT auto-loaded by sessions
PATTERNS section             = repeated mistakes compressed into durable rules
```

## Procedure

### 1. Read

Read `memory/learnings.md` end-to-end. Note current line count.

### 2. Identify candidates (3 categories)

For each MISTAKE entry, classify:

**🔼 PROMOTE → PATTERN**
- Same root cause repeats in 2+ entries (e.g. 3 separate "agent claimed prod state without checking" stories)
- Suggest a canonical compressed PATTERN entry that supersedes the individual stories

**📦 ARCHIVE**
- Last triggered date >60-90 days ago AND no recent commit history shows the trigger condition was hit
- Old enough that it's history, not active guidance

**🔗 MERGE**
- 2+ entries describe variations of the same incident class with no meaningfully different lesson
- Propose a canonical merged entry keeping the strongest specifics from each

### 3. Output the proposal (do not edit yet)

Present to user:

```markdown
# Learnings curation proposal — YYYY-MM-DD

Current: N lines, M mistakes, K wins, L patterns.

## 🔼 PROMOTE (N candidates)

### Candidate 1 → new PATTERN
**Stories to compress:** [list 2-3 entry titles]
**Proposed PATTERN:**
> [compressed canonical rule — 3-5 lines]
**Confirm?** [y/n]

### Candidate 2 → new PATTERN
...

## 📦 ARCHIVE (N candidates)

### Candidate 1
**Entry:** "2026-01-XX — [title]"
**Reason:** Last trigger condition hit 90+ days ago, no recent recurrence
**Confirm archive?** [y/n]

### Candidate 2
...

## 🔗 MERGE (N candidates)

### Candidate 1
**Entries to merge:** [list]
**Proposed merged entry:**
> [text]
**Confirm?** [y/n]
```

Show the proposal. **Stop and wait** for the user to go through each item.

### 4. Apply user-confirmed changes

For each ✅ confirmed item:

**PROMOTE:**
- Add the new PATTERN entry to PATTERNS section of `learnings.md`
- Move the source MISTAKE entries to `learnings.archive.md` (append-only, create if doesn't exist)

**ARCHIVE:**
- Move entry from `learnings.md` to `learnings.archive.md` (append, with original date preserved)

**MERGE:**
- Replace source entries with the merged canonical version in `learnings.md`
- Append the originals to `learnings.archive.md` for traceability

### 5. Confirm to user

```
Curation done.

Before: N lines (M mistakes, K wins, L patterns)
After:  N' lines (M' mistakes, K' wins, L+X patterns)

Promoted: N
Archived: N (now in learnings.archive.md)
Merged:   N

learnings.md is back under target.
```

## Anti-patterns

- **Auto-applying without confirmation** — never. The user owns this curation.
- **Deleting entries entirely** — always move to `learnings.archive.md`. Lessons are precious data.
- **Aggressive promotion** — only promote when same root cause clearly repeats 2+ times with the same lesson. One-offs stay as MISTAKES.
- **Archiving recent mistakes** — keep at minimum last 60 days as MISTAKES, even if they look similar to old entries.
- **Skipping the proposal step** — the proposal IS the value. Without user judgment, automation drifts.

## Why this matters

`memory/learnings.md` is auto-loaded into AI sessions for pattern recall. Every line costs tokens AND attention. A 700-line file with 60% noise produces worse pattern recall than a 300-line curated one. Curation is signal compression.

`daily/` is the raw event log — keep it append-only.
`learnings.md` is the curated index — keep it active.
`learnings.archive.md` is history — searchable, not auto-loaded.
