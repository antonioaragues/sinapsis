---
description: Process all new local files and sync tracked Google Docs in one pass
---

Run the **Update Everything Workflow** as defined in CLAUDE.md:

1. Find new local files in `raw/` (diff against `wiki/sources/`) and ingest them
2. Re-sync all Google Docs in `wiki/gdoc-registry.md`
3. Update `wiki/index.md`, `wiki/overview.md`, and `wiki/log.md` once at the end
4. Report a unified summary
