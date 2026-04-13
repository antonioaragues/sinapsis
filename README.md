# Sinapsis

A personal knowledge base powered by LLMs and [Obsidian](https://obsidian.md). Instead of searching raw documents every time (RAG), an LLM incrementally builds and maintains a structured, interlinked wiki that compounds over time.

Based on Andrej Karpathy's [LLM Wiki](https://github.com/karpathy/llm-wiki) pattern.

## How it works

You capture raw sources throughout your day — meeting notes, articles, Slack threads, documents. When you're ready, you tell Claude to ingest them. The LLM reads each source, extracts key information, and integrates it into the wiki: creating entity pages, updating timelines, noting decisions, cross-referencing everything. The knowledge is compiled once and kept current.

```
You (capture) → raw/ → Claude (ingest) → wiki/ → You (query, browse, generate)
```

Three layers:

| Layer | What | Who owns it |
|-------|------|-------------|
| `raw/` | Source documents (meeting notes, articles, docs, Slack) | You — immutable |
| `wiki/` | Structured, interlinked markdown pages | Claude — auto-maintained |
| `CLAUDE.md` | Schema and conventions governing LLM behavior | Co-evolved |

## Getting started

### Prerequisites

- [Obsidian](https://obsidian.md) (free)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI
- Git

### Setup

1. **Clone the repo**

   ```bash
   git clone https://github.com/antonioaragues/sinapsis.git
   ```

2. **Open as Obsidian vault**

   Open Obsidian → "Open folder as vault" → select `sinapsis/`.

3. **Install community plugins**

   Go to Settings → Community plugins → Enable community plugins, then install:
   - **Templater** — for source capture templates
   - **Dataview** — for dynamic queries over wiki pages
   - **Marp Slides** — for generating presentations (optional)

4. **Configure Templater**

   Settings → Templater → Template folder location: `templates/`

5. **Configure Daily Notes** (core plugin)

   Settings → Daily notes:
   - New file location: `raw/daily`
   - Date format: `YYYY-MM-DD`
   - Template file location: `templates/daily.md`

6. **Done.** Open Claude Code in the `sinapsis/` directory and start ingesting.

## Daily workflow

### 1. Capture (throughout the day)

Use the daily note as your scratchpad. Open it with the daily note button or hotkey.

```markdown
# 2026-04-14, Monday

## Meetings
### Standup
- Feature X delayed, dependency on Platform team
- @maria raised concern about API rate limits

### 1:1 with James (VP Eng)
- Migration timeline: wants Q3, not Q4
- Decision: prioritize auth refactor over new dashboard

## Slack
- #product-strategy: competitor Y launching process mining for SAP

## Thoughts
- Revisit scoring model after Q1 data
```

For other sources:
- **Web articles**: use [Obsidian Web Clipper](https://obsidian.md/clipper) → saves to `raw/articles/`
- **Meeting transcripts**: paste into `raw/meetings/` using the meeting template (Templater)
- **Slack threads**: copy-paste into `raw/slack/` using the Slack template
- **Documents**: export from Google Docs → save to `raw/docs/`

All templates are available via Templater (`Ctrl/Cmd + T` or the command palette).

### 2. Ingest (end of day or whenever)

Open Claude Code in the `sinapsis/` directory:

```
# Ingest everything new at once
> ingest all new

# Or just today's captures
> ingest today

# Or a specific file
> ingest raw/articles/some-article.md

# Or a specific folder
> ingest all new meetings
```

Claude will:
- Read each source
- Create/update entity, concept, decision, and comparison pages
- Maintain cross-references and timelines
- Update the index and log
- Mark sources as ingested
- Give you a summary of everything that changed

### 3. Query (anytime)

Ask questions against the wiki:

```
> What decisions have been made about the auth refactor?
> How does our process mining approach compare to competitor Y?
> What AI trends are relevant to our roadmap?
> Give me a briefing on everything discussed about Feature X in the last 2 weeks
```

Claude searches the wiki index, reads relevant pages, and synthesizes an answer with citations. Good answers can be filed back into the wiki as new pages.

### 4. Generate (on demand)

Create artifacts from wiki content:

```
> Create a briefing on the Q3 migration plan
> Generate slides summarizing our competitive position
```

Outputs go to `outputs/briefings/` or `outputs/slides/` (Marp format).

### 5. Lint (periodically)

Ask Claude to health-check the wiki:

```
> lint the wiki
```

Finds contradictions, orphan pages, stale claims, missing cross-references, and gaps.

## Directory structure

```
sinapsis/
├── CLAUDE.md              # Schema — LLM behavior rules and conventions
├── raw/                   # Your source documents (immutable)
│   ├── daily/             # Daily notes (scratchpad)
│   ├── articles/          # Web clips
│   ├── meetings/          # Transcriptions
│   ├── docs/              # PRDs, design docs, Google Docs
│   ├── slack/             # Slack exports
│   ├── feedback/          # Customer feedback
│   └── assets/            # Images, attachments
├── wiki/                  # LLM-maintained knowledge base
│   ├── index.md           # Master page index
│   ├── log.md             # Activity log (chronological)
│   ├── overview.md        # High-level synthesis
│   ├── entities/          # Products, features, people, teams, companies
│   ├── concepts/          # Technical concepts, methodologies
│   ├── decisions/         # Decision records with timelines
│   ├── comparisons/       # Competitive analysis, trade-offs
│   └── sources/           # One summary per ingested source
├── outputs/               # Generated artifacts
│   ├── briefings/
│   └── slides/
└── templates/             # Templater templates for quick capture
    ├── daily.md
    ├── meeting.md
    ├── article.md
    ├── doc.md
    ├── slack-thread.md
    └── feedback.md
```

## Wiki page types

| Type | Location | Purpose |
|------|----------|---------|
| **Entity** | `wiki/entities/` | Products, features, people, teams, companies. Includes timeline. |
| **Concept** | `wiki/concepts/` | Technical concepts, methodologies, patterns. Includes relevance analysis. |
| **Decision** | `wiki/decisions/` | Decision records with context, options, outcome, and full timeline. |
| **Comparison** | `wiki/comparisons/` | Side-by-side analysis with comparison tables. |
| **Source** | `wiki/sources/` | Summary of each ingested raw source with key takeaways. |

All pages use YAML frontmatter (queryable with Dataview) and `[[wikilinks]]` for cross-referencing (visible in Obsidian's graph view).

## Customization

The system is designed to be adapted. Key configuration:

- **CLAUDE.md** — the main schema. Modify domains, page templates, workflows, writing style, naming conventions. This is the most important file.
- **templates/** — Templater templates for raw source capture. Add new ones for source types specific to your workflow.
- **.obsidian/** — Obsidian settings. Adjust to your preferences.

## Inspired by

- [LLM Wiki](https://github.com/karpathy/llm-wiki) by Andrej Karpathy
- [Memex](https://en.wikipedia.org/wiki/Memex) by Vannevar Bush (1945)
