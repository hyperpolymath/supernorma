// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// FFI bindings for @std/testing/bdd (Deno standard library)

@module("@std/testing/bdd") external describe: (string, unit => unit) => unit = "describe"

@module("@std/testing/bdd") external it: (string, unit => unit) => unit = "it"

@module("@std/testing/bdd")
external itAsync: (string, unit => promise<unit>) => unit = "it"
