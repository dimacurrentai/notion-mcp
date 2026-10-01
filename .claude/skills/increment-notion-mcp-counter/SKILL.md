---
name: increment-notion-mcp-counter
description: Increments the "MCP access counter" on the MCP 0xdeadbeef Test Page in Notion by one, via the Notion MCP server, and verifies the new value. Use when the user invokes /increment-notion-mcp-counter or asks to bump, increment, or tick the Notion MCP counter.
---

# Increment the Notion MCP counter

The counter lives on the Notion page titled exactly **MCP 0xdeadbeef Test Page**.
It is a single text line of the form `MCP access counter: <N>`, where `<N>` is a non-negative integer.

## Steps

1. **Find the page.** Call `notion-search` with the query `MCP 0xdeadbeef Test Page`. Search is fuzzy, so keep only the results of type `page` whose title is exactly `MCP 0xdeadbeef Test Page`. If there is not exactly one such result, stop and report the matching titles and URLs you saw. Use that result's ID and URL for the rest of the steps. If the Notion tools are not loaded or a call fails with an auth error, stop and tell the user to run `/mcp` → **notion** → **Authenticate**.
2. **Read the page.** Call `notion-fetch` with the ID from step 1.
3. **Find the current value.** In the page content, find the line matching `MCP access counter: <N>`. If there is no such line, or more than one, or `<N>` is not an integer, stop and report what the page actually contains. Do not create or rewrite the line.
4. **Increment it.** Call `notion-update-page` with `command: "update_content"`, `allow_async: false`, and one content update whose `old_str` is the exact line `MCP access counter: <N>` and whose `new_str` is `MCP access counter: <N+1>`. Change nothing else on the page.
5. **Verify.** Fetch the page again and confirm the line now reads `MCP access counter: <N+1>`. If it shows a different value (for example, someone else incremented it at the same time), report the value you saw rather than claiming success.
6. **Report** in one line: the old value, the new value, and the page URL from step 1.
