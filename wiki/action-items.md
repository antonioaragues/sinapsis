---
title: Action Items
type: overview
created: 2026-04-13
updated: 2026-04-13
---

# Action Items

Centralized view of all action items extracted from ingested sources. Tasks are written in [Obsidian Tasks plugin](https://publish.obsidian.md/tasks/Introduction) format and aggregated automatically via the queries below.

Tasks live in two places:
1. **Source summaries** in `wiki/sources/` — each ingest extracts action items inline
2. **Entity pages** when an action item is about a specific feature/person/project

The Tasks plugin queries below aggregate across the whole vault.

---

## Open — Overdue

```tasks
not done
due before today
sort by due
```

## Open — Today and this week

```tasks
not done
due after yesterday
due before in 7 days
sort by due
```

## Open — Later

```tasks
not done
due after in 7 days
sort by due
```

## Open — No due date

```tasks
not done
no due date
sort by created reverse
```

## Recently completed (last 7 days)

```tasks
done
done after 7 days ago
sort by done reverse
```
