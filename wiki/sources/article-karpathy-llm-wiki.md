---
title: "Source: LLM Wiki — A Pattern for Personal Knowledge Bases"
type: source
domain: ai-trends
tags: [ai, knowledge-management, llm, methodology]
created: 2026-04-13
updated: 2026-04-13
raw: "[[raw/articles/karpathy-llm-wiki]]"
---

## Summary

Andrej Karpathy proposes an alternative to RAG-based knowledge systems: instead of re-deriving knowledge from raw documents on every query, have an LLM incrementally build and maintain a persistent, interlinked wiki. The wiki compounds over time — cross-references, contradictions, and synthesis are maintained continuously rather than reconstructed from scratch.

The architecture has three layers: immutable raw sources, an LLM-maintained wiki of markdown files, and a schema document that governs LLM behavior. Three core operations (ingest, query, lint) keep the wiki current and healthy.

## Key Takeaways

- RAG re-derives knowledge on every query; a persistent wiki compiles it once and keeps it current
- The LLM does all maintenance (cross-referencing, filing, consistency) — the human curates sources and asks questions
- [[obsidian]] serves as the IDE; the LLM is the programmer; the wiki is the codebase
- The pattern applies to personal, research, business, and competitive analysis contexts
- At scale (~100+ sources), a search tool like qmd replaces the index-based navigation

## Entities Mentioned

- [[andrej-karpathy]] — author, former Tesla AI director, prominent AI educator

## Impact on Wiki

- Pages created: [[andrej-karpathy]], [[llm-wiki-pattern]], this source summary
- Pages updated: [[index]], [[overview]], [[log]]
