// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// FFI bindings for bun:test (Bun's built-in test runner)

@module("bun:test") external describe: (string, unit => unit) => unit = "describe"

@module("bun:test") external it: (string, unit => unit) => unit = "it"

// bun:test's `it` natively supports async callbacks; itAsync is kept as a
// distinctly-typed alias so existing call sites need no changes.
@module("bun:test")
external itAsync: (string, unit => promise<unit>) => unit = "it"
