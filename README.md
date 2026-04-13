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
- **Google Docs**: ingested directly from Drive — no export needed (see [Google Docs integration](#google-docs-integration))

All templates are available via Templater (`Ctrl/Cmd + T` or the command palette).

### 2. Update (end of day or whenever)

Open Claude Code in the `sinapsis/` directory:

```
# The all-in-one command — processes everything new in a single pass
> update everything
```

This does two things:
1. Finds new local files in `raw/` that haven't been ingested yet
2. Re-syncs all tracked Google Docs for changes

You can also be more specific:

```
# Only new local files
> ingest all new

# Only today's captures
> ingest today

# Only a specific file
> ingest raw/articles/some-article.md

# Only a specific folder
> ingest all new meetings

# Only Google Docs sync
> sync google docs
```

Claude will:
- Read each source
- Create/update entity, concept, decision, and comparison pages
- Maintain cross-references and timelines
- Update the index and log
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

## Google Docs integration

Google Docs are "living" documents that change over time. Instead of manually exporting them, Sinapsis reads them directly from Google Drive and tracks changes automatically.

### Setup

1. **Install the Google Drive MCP server** for Claude Code. Add this to your Claude Code MCP settings (`~/.claude/settings.json` or project-level `.claude/settings.json`):

   ```json
   {
     "mcpServers": {
       "google-drive": {
         "type": "url",
         "url": "https://mcp.google.com/gdrive"
       }
     }
   }
   ```

2. **Authenticate** — the first time Claude accesses Drive, it will prompt you to authorize via OAuth in the browser.

3. **Done.** You can now ingest Google Docs directly by URL or search for them from Drive.

### Usage

**Ingest a Google Doc by URL:**

```
> ingest https://docs.google.com/document/d/1abc123.../edit
```

Claude reads the doc directly from Drive, creates a local snapshot in `raw/docs/`, processes it through the standard ingest workflow, and registers it for future syncing.

**Search your Drive:**

```
> search Drive for Q3 roadmap
> find docs modified this week
```

Claude searches your Google Drive and presents results. You choose which ones to ingest.

**Sync tracked docs:**

Once a Google Doc is ingested, it's registered in `wiki/gdoc-registry.md`. Sync pulls the latest version and processes any changes:

```
# Sync all tracked Google Docs
> sync google docs

# Sync a specific doc
> sync Q3 Roadmap PRD
```

Claude will:
- Re-fetch each registered doc from Drive
- Compare with the previous snapshot
- Update source summaries and wiki pages with what changed
- Add timeline entries noting the evolution
- Skip docs that haven't changed

This is ideal for living documents like PRDs, design docs, and roadmaps that evolve over weeks or months. The wiki tracks the full history of changes.

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
│   ├── gdoc-registry.md   # Tracked Google Docs for sync
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
