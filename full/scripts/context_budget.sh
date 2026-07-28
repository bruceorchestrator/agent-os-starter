#!/usr/bin/env bash
# context_budget.sh — measure what actually loads into EVERY session.
#
# Three always-on surfaces cost you tokens on every single request:
#   1. the schema file       — AGENTS.md / CLAUDE.md at repo root
#   2. always-on rules       — rules/*.md WITHOUT a `paths:` key in frontmatter
#                              (rules WITH `paths:` load only when a matching file is
#                              touched, so they are free until then)
#   3. the SessionStart hook — whatever scripts/context.sh emits
#
# Surface 3 has a hard cap. Past it the harness does not truncate the tail, it replaces the
# WHOLE payload with a short preview — your project state silently stops loading and nothing
# reports an error. Run this whenever you add rules or grow memory/.
#
# Usage: bash scripts/context_budget.sh

set -e

REPO_ROOT="${REPO_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

BUDGET="${CONTEXT_BUDGET_BYTES:-8192}"
BYTES_PER_TOKEN=4          # rough, for an order-of-magnitude figure only

# Works whether rules live in agent-os/rules (Advanced Mode) or .claude/rules (installed).
RULES_DIR=""
for candidate in agent-os/rules .claude/rules rules; do
  [ -d "$candidate" ] && { RULES_DIR="$candidate"; break; }
done

row() { printf '  %-44s %8s B\n' "$1" "$2"; }

echo "# Context budget — $(date '+%Y-%m-%d %H:%M')"
echo ""

# ---------- 1. schema ----------
# AGENTS.md and CLAUDE.md may both exist (one per harness) but only ONE is loaded in any
# given session, so charge the larger rather than the sum.
echo "## Schema (only one of these loads per harness — charging the larger)"
schema_bytes=0
for f in AGENTS.md CLAUDE.md; do
  [ -f "$f" ] || continue
  b=$(wc -c < "$f" | tr -d ' ')
  if [ -L "$f" ]; then
    row "$f -> $(readlink "$f")" "$b"
  else
    row "$f" "$b"
  fi
  [ "$b" -gt "$schema_bytes" ] && schema_bytes=$b
done
[ "$schema_bytes" -eq 0 ] && echo "  (no AGENTS.md / CLAUDE.md found)"
echo ""

# ---------- 2. rules ----------
always_bytes=0
scoped_bytes=0
if [ -n "$RULES_DIR" ]; then
  echo "## Rules in $RULES_DIR — ALWAYS loaded (no \`paths:\`)"
  for f in "$RULES_DIR"/*.md; do
    [ -f "$f" ] || continue
    case "$(basename "$f")" in README.md) continue ;; esac
    b=$(wc -c < "$f" | tr -d ' ')
    if head -15 "$f" | grep -qE '^paths:'; then
      scoped_bytes=$((scoped_bytes + b))
    else
      row "$(basename "$f")" "$b"
      always_bytes=$((always_bytes + b))
    fi
  done
  row "SUBTOTAL" "$always_bytes"
  echo ""
  echo "## Rules — conditional (\`paths:\` scoped, free until a match is touched)"
  for f in "$RULES_DIR"/*.md; do
    [ -f "$f" ] || continue
    head -15 "$f" | grep -qE '^paths:' && row "$(basename "$f")" "$(wc -c < "$f" | tr -d ' ')"
  done
  row "SUBTOTAL (not charged)" "$scoped_bytes"
  echo ""
fi

# ---------- 3. session context ----------
# Measure what the HARNESS receives, not what context.sh prints: the SessionStart hook
# wraps the digest in a preamble first, and that wrapper counts against the same cap.
echo "## SessionStart hook payload"
ctx_bytes=0
if [ -f scripts/context.sh ]; then
  script_bytes=$(bash scripts/context.sh 2>/dev/null | wc -c | tr -d ' ')
  ctx_bytes=$script_bytes
  row "scripts/context.sh output" "$script_bytes"
  if [ -f agent-os/hooks/session-start.sh ]; then
    hook_bytes=$(CLAUDE_PROJECT_DIR="$REPO_ROOT" bash agent-os/hooks/session-start.sh 2>/dev/null \
      | python3 -c 'import json,sys; print(len(json.load(sys.stdin)["hookSpecificOutput"]["additionalContext"].encode()))' 2>/dev/null || true)
    if [ -n "$hook_bytes" ]; then
      ctx_bytes=$hook_bytes
      row "+ hook preamble = what the harness gets" "$hook_bytes"
    fi
  fi
  if [ "$ctx_bytes" -le "$BUDGET" ]; then
    echo "  STATUS: OK — under the ${BUDGET} B budget, loads into context"
  else
    echo "  STATUS: OVER BUDGET (${BUDGET} B) — the harness may persist the payload to a"
    echo "          file and inject only a short preview. Session state would NOT load."
    ctx_bytes=2048   # what you would actually get
  fi
else
  echo "  (scripts/context.sh not found)"
fi
echo ""

# ---------- total ----------
total=$((schema_bytes + always_bytes + ctx_bytes))
echo "## Total charged to every session"
row "schema + always-on rules + hook" "$total"
echo "  ~$((total / BYTES_PER_TOKEN)) tokens (approx, ${BYTES_PER_TOKEN} B/token)"
echo ""
echo "Too high? Give a rule a \`paths:\` frontmatter key so it loads only when relevant,"
echo "and keep the schema file an index of pointers rather than a manual."
