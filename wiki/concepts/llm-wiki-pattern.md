---
title: LLM Wiki Pattern
type: concept
domain: ai-trends
tags: [ai, knowledge-management, llm, methodology, rag-alternative]
created: 2026-04-13
updated: 2026-04-13
sources: ["[[article-karpathy-llm-wiki]]"]
---

A pattern for building personal knowledge bases where the LLM incrementally builds and maintains a persistent wiki, rather than re-deriving knowledge via RAG on every query.

## Core Principles

- **Persistent compilation**: Knowledge is synthesized once and kept current, not re-derived per query
- **LLM as maintainer**: The LLM handles all bookkeeping — cross-references, summaries, consistency, filing
- **Human as curator**: The human sources documents, directs analysis, and asks questions
- **Compounding artifact**: Each new source enriches the entire wiki, not just adds a new chunk

## Architecture

Three layers:
1. **Raw sources** — immutable, human-curated
2. **Wiki** — LLM-generated and maintained markdown (entities, concepts, decisions, comparisons)
3. **Schema** — configuration governing LLM behavior (CLAUDE.md / AGENTS.md)

## Operations

- **Ingest** — process a source, update multiple wiki pages
- **Query** — answer questions from wiki, optionally file answers back
- **Lint** — health-check for contradictions, orphans, stale claims

## Relevance to Celonis

This is the foundation of the Sinapsis knowledge base. Applied to track product decisions, technology architecture, and AI trends relevant to a Principal PM role. The pattern is especially valuable for tracking how decisions evolve over time across many documents and conversations.

## Open Questions

- How well does index-based navigation scale beyond ~200 wiki pages?
- What's the right granularity for entity pages vs. concept pages?
- How to handle conflicting information from different stakeholders?

## Related

- [[andrej-karpathy]] — creator of the pattern
