---
description: Sync all tracked Google Docs and process changes
---

Run the **Google Docs Sync** workflow from CLAUDE.md:

1. Read `wiki/gdoc-registry.md`
2. Re-fetch each registered doc from Drive
3. Compare with snapshots in `raw/docs/`
4. For changed docs: update snapshot, source summary, affected wiki pages, timelines
5. Report which docs changed and what was updated
