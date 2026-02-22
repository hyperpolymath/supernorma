<!-- SPDX-License-Identifier: PMPL-1.0-or-later -->
<!-- TOPOLOGY.md — Project architecture map and completion dashboard -->
<!-- Last updated: 2026-02-19 -->

# Supranorma — Project Topology

## System Architecture

```
                        ┌─────────────────────────────────────────┐
                        │              DEVELOPER / USER           │
                        │        (CLI Interface / Web App UI)     │
                        └───────────────────┬─────────────────────┘
                                            │ Command / Request
                                            ▼
                        ┌─────────────────────────────────────────┐
                        │           SUPRANORMA CORE (RESCRIPT)    │
                        │                                         │
                        │  ┌───────────┐  ┌───────────────────┐  │
                        │  │  AI Core  │  │  Data Framework   │  │
                        │  │ (Inference)│ │  (ETL Pipelines)  │  │
                        │  └─────┬─────┘  └────────┬──────────┘  │
                        │        │                 │              │
                        │  ┌─────▼─────┐  ┌────────▼──────────┐  │
                        │  │ CLI Tool  │  │  Web App          │  │
                        │  │ (Deno)    │  │ (Oak/React)       │  │
                        │  └─────┬─────┘  └────────┬──────────┘  │
                        └────────│─────────────────│──────────────┘
                                 │                 │
                                 ▼                 ▼
                        ┌─────────────────────────────────────────┐
                        │           EXTERNAL SERVICES             │
                        │  ┌───────────┐  ┌───────────────────┐  │
                        │  │ Anthropic │  │  OpenAI API       │  │
                        │  │ (Claude)  │  │  (GPT-4)          │  │
                        │  └───────────┘  └───────────────────┘  │
                        └───────────────────┬─────────────────────┘
                                            │
                                            ▼
                        ┌─────────────────────────────────────────┐
                        │          TARGET CODEBASE / DATA         │
                        │      (Analysis, Generation, Transforms) │
                        └─────────────────────────────────────────┘

                        ┌─────────────────────────────────────────┐
                        │          REPO INFRASTRUCTURE            │
                        │  Justfile Automation  .machine_readable/  │
                        │  Deno 2.x Runtime     0-AI-MANIFEST.a2ml  │
                        └─────────────────────────────────────────┘
```

## Completion Dashboard

```
COMPONENT                          STATUS              NOTES
─────────────────────────────────  ──────────────────  ─────────────────────────────────
CORE MODULES (RESCRIPT)
  AiCore (LLM Integration)          ██████████ 100%    Claude/GPT-4 stable
  DataFramework (ETL)               ██████████ 100%    JSON/CSV/JSONL stable
  Shared Utilities                  ██████████ 100%    Async queue & logger verified
  Web App (Frontend/Backend)        ████████░░  80%    JWT auth & task mgmt active

INTERFACES & TOOLS
  CLI (supranorma)                  ██████████ 100%    Full command set verified
  DevTools (Git/Scaffolding)        ██████████ 100%    Git automation verified
  Advisor Module                    ████████░░  80%    Refactoring logic stable

REPO INFRASTRUCTURE
  Justfile Automation               ██████████ 100%    Standard build/test tasks
  .machine_readable/                ██████████ 100%    STATE tracking active
  Language Policy (ReScript)        ██████████ 100%    RSR stack verified

─────────────────────────────────────────────────────────────────────────────
OVERALL:                            █████████░  ~90%   Stable and feature-rich suite
```

## Key Dependencies

```
AI Config ───────► AiCore Engine ──────► CLI Analysis ─────► Feedback
     │                 │                   │                 │
     ▼                 ▼                   ▼                 ▼
Data Source ────► DataFramework ──────► Web App UI ───────► Display
```

## Update Protocol

This file is maintained by both humans and AI agents. When updating:

1. **After completing a component**: Change its bar and percentage
2. **After adding a component**: Add a new row in the appropriate section
3. **After architectural changes**: Update the ASCII diagram
4. **Date**: Update the `Last updated` comment at the top of this file

Progress bars use: `█` (filled) and `░` (empty), 10 characters wide.
Percentages: 0%, 10%, 20%, ... 100% (in 10% increments).
