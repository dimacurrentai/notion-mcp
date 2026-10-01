---
name: increment-notion-mcp-counter
description: scsh entry point — increments the Notion MCP counter by following the repo's /increment-notion-mcp-counter skill, then writes the outcome as JSON to $SCSH_RESULT.
---

# Increment the Notion MCP counter (scsh job)

1. Follow `.claude/skills/increment-notion-mcp-counter/SKILL.md` exactly, steps 1 through 5.
   It is the single source of truth for what to read, what to change, and how to verify.
2. Instead of step 6, write one JSON object to the path in `$SCSH_RESULT`
   (create parent directories if needed):
   - On verified success:
     `{"status": "ok", "old": <N>, "new": <N+1>, "url": "<the page URL found in step 1>", "results_markdown": "MCP access counter: <N> → <N+1>"}`
   - On any stop condition from that skill (no Notion tools, auth error, page not found or
     not unique, missing or ambiguous counter line, verification mismatch):
     `{"status": "failed", "error": "<what happened, including what the page actually showed>"}`
   Always write the file, even on failure. Numbers are JSON integers.
