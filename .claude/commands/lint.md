---
description: Health-check the wiki for contradictions, orphans, gaps
---

Run the **Lint Workflow** from CLAUDE.md:

Scan all wiki pages and report findings organized by severity:
- Contradictions between pages
- Stale claims superseded by newer sources
- Orphan pages (no inbound links)
- Important concepts mentioned but lacking their own page
- Missing cross-references
- Entities mentioned in sources but missing entity pages
- Timeline gaps

Ask before fixing anything. Append findings to `wiki/log.md`.
