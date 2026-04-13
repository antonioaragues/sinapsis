---
title: "Article: LLM Wiki — A Pattern for Personal Knowledge Bases"
type: article
date: 2026-04-13
url: https://github.com/karpathy/llm-wiki
author: Andrej Karpathy
tags: [article, ai, knowledge-management]
status: ingested
---

# LLM Wiki — A Pattern for Personal Knowledge Bases

By Andrej Karpathy. Published April 2026.

Core idea: instead of RAG (re-deriving knowledge on every query), have the LLM incrementally build and maintain a persistent wiki. The wiki is a compounding artifact — cross-references, contradictions, and synthesis are maintained continuously.

Three-layer architecture:
1. Raw sources — immutable source documents
2. The wiki — LLM-generated markdown files (summaries, entities, concepts, comparisons)
3. The schema — configuration that tells the LLM how to maintain the wiki (e.g., CLAUDE.md)

Key operations:
- **Ingest**: Read source, create summary, update entities/concepts across wiki, update index and log
- **Query**: Search index, read relevant pages, synthesize answer, optionally file back into wiki
- **Lint**: Health-check for contradictions, orphan pages, stale claims, missing cross-references

Tooling recommendations: Obsidian as the IDE, Dataview for frontmatter queries, Marp for slides, git for versioning. Optional: qmd for search at scale.

Key insight: humans abandon wikis because maintenance burden grows faster than value. LLMs eliminate the maintenance cost. The human curates sources and asks questions; the LLM does the bookkeeping.

Related to Vannevar Bush's Memex (1945) — private, curated knowledge store with associative trails.
