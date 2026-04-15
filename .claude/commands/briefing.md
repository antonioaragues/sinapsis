---
description: Generate a briefing from wiki content on a given topic
argument-hint: <topic or question>
---

Generate a briefing on: $ARGUMENTS

Run the **Briefing Workflow** from CLAUDE.md:

1. Search the wiki index for relevant pages
2. Read those pages
3. Synthesize a concise briefing (lead with the most important info)
4. Save to `outputs/briefings/YYYY-MM-DD-{slug}.md`
5. Append to `wiki/log.md`
