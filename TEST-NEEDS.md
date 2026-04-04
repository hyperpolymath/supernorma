# TEST-NEEDS.md — supernorma

## CRG Grade: C — ACHIEVED 2026-04-04

## Current Test State

| Category | Count | Notes |
|----------|-------|-------|
| ReScript unit tests | 4 | `tests/unit/{Mod,Data,Ui,Dax}_test.res` |
| ReScript integration tests | 2 | `tests/integration/{Config,Html_form}_test.res` |
| Test framework | ReScript built-in | Jest-compatible |

## What's Covered

- [x] Module system tests
- [x] Data transformation tests
- [x] UI component tests
- [x] DAX query tests
- [x] Configuration tests
- [x] HTML form integration tests

## Still Missing (for CRG B+)

- [ ] Property-based data transformation testing
- [ ] Visual regression testing
- [ ] End-to-end workflow tests
- [ ] Performance benchmarks

## Run Tests

```bash
cd /var/mnt/eclipse/repos/supernorma && rescript build && npm test
```
