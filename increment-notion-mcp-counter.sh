#!/usr/bin/env bash
# Increments the Notion MCP counter by running the increment-notion-mcp-counter
# skill as an scsh job (a Claude agent in a container, on a clean clone of HEAD).
set -euo pipefail

cd "$(dirname "$0")"

# A unique nonce per run defeats scsh's result cache; without it a second run
# on the same commit would replay the old result instead of incrementing.
INCREMENT_NONCE="$(date -u +%Y%m%dT%H%M%SZ)-$$-$RANDOM"
export INCREMENT_NONCE

RESULT=tmp/increment-notion-mcp-counter.json

scsh run

STATUS="$(jq -r '.status' "$RESULT")"
if [ "$STATUS" != ok ]; then
  echo "Counter not incremented: $(jq -r '.error // "no error given"' "$RESULT")" >&2
  exit 1
fi
jq -r '"MCP access counter: \(.old) → \(.new) — \(.url)"' "$RESULT"
