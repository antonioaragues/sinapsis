---
description: Ingest all un-ingested local files in raw/
---

Run the **Batch Ingest Workflow** from CLAUDE.md:

1. Scan all markdown files under `raw/` (excluding `raw/assets/`)
2. Diff against `raw:` paths in `wiki/sources/`
3. List new files and confirm before processing
4. Process each, accumulating wiki changes
5. Update index, overview, log once at end
