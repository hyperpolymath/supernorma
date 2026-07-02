<!--
SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
<!-- TOPOLOGY.md — Project architecture map and completion dashboard -->
<!-- Last updated: 2026-07-02 (honesty pass: dashboard now reflects the actual tree) -->

# SuperNorma — Project Topology

## System Architecture

```
        ┌─────────────────────────────────────────┐
        │                  USER                   │
        │   (web form / Power BI / future chat)   │
        └───────┬───────────────┬─────────────────┘
                │               │
                ▼               ▼
    ┌───────────────────┐  ┌──────────────────────┐
    │  ui/webform.html  │  │  Power BI workbook   │
    │  + src/UI.res     │  │  (dax/ measures over │
    │  (form hook)      │  │   workbook/ CSVs)    │
    └────────┬──────────┘  └──────────┬───────────┘
             │ (not wired yet)        │
             ▼                        ▼
    ┌─────────────────────────────────────────────┐
    │       CALCULATION CORE (src/Mod.res)        │
    │  net income · surplus · total savings ·     │
    │  pension projection (DB/DC/SIPP/ISA/State)  │
    └────────────────────┬────────────────────────┘
                         │ (future)
                         ▼
    ┌─────────────────────────────────────────────┐
    │   ADVISOR (advisor/system_prompt.txt)       │
    │   LLM persona: Bookkeeper / Forensic        │
    │   Analyst / Empowered Advocate — UNWIRED    │
    └─────────────────────────────────────────────┘
```

## Completion Dashboard

```
COMPONENT                          STATUS              NOTES
─────────────────────────────────  ──────────────────  ─────────────────────────────────
CALCULATION CORE (RESCRIPT)
  Mod.res (finance kernels)        ████████░░  80%    Compiles; unit tests specify API
  UI.res (form hook)               ███░░░░░░░  30%    Submits to alert(); not wired to core
  Deno bindings (src/bindings/)    ████████░░  80%    Thin externals; used by tests

CONTENT
  DAX measures (dax/)              ██████░░░░  60%    3 measures mirroring the core
  CSV templates (workbook/, data/) ██████░░░░  60%    Sample income + pension models
  Web form (ui/webform.html)       █████░░░░░  50%    Static form, no persistence
  Advisor prompt (advisor/)        ███░░░░░░░  30%    Persona text only; no model wiring

TESTS
  Unit (Mod/Data)                  ██████░░░░  60%    Real value assertions; need compiled
                                                      *_test.res.js to run under deno test
  Integration (Config/Html_form)   ████░░░░░░  40%    File-presence checks; repointed at
                                                      files that exist

REPO INFRASTRUCTURE
  deno.json tasks                  ████████░░  80%    build/test/lint/fmt defined
  Justfile                         ███████░░░  70%    Delegates to deno tasks
  CI workflows (15)                ██████░░░░  60%    Heavy for repo size; external deps

─────────────────────────────────────────────────────────────────────────────
OVERALL:                            ██░░░░░░░░  ~20%   Early development
```

Previous versions of this dashboard described an AI developer-tools suite
(AiCore, DataFramework, CLI, WebApp, DevTools) at ~90% completion. Those
modules were never present in this repository; the dashboard now tracks what
actually exists.

## Path to a usable v0.1

1. Compile ReScript so `src/Mod.res.js` (the declared deno.json export) and
   the `*_test.res.js` files exist; make `deno task test` green
2. Wire the web form to the calculation core and render results
3. Wire the advisor persona to a local LLM (e.g. LM Studio's
   OpenAI-compatible localhost API) with the calculation core supplying
   every number
4. CSV import: parse `workbook/` templates via `@std/csv` into
   `financialRecord`/`pensionRecord` values

## Update Protocol

This file is maintained by both humans and AI agents. When updating:

1. **After completing a component**: Change its bar and percentage
2. **After adding a component**: Add a new row in the appropriate section
3. **After architectural changes**: Update the ASCII diagram
4. **Date**: Update the `Last updated` comment at the top of this file

Progress bars use: `█` (filled) and `░` (empty), 10 characters wide.
Percentages: 0%, 10%, 20%, ... 100% (in 10% increments).
