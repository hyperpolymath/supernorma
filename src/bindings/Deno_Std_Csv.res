// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// FFI bindings for @std/csv (Deno standard library)

type parseOptions = {skipFirstRow: bool}

@module("@std/csv") external parse: (string, parseOptions) => array<array<string>> = "parse"

// When skipFirstRow is true, returns array of objects with column headers as keys
@module("@std/csv")
external parseAsRecords: (string, parseOptions) => array<Dict.t<string>> = "parse"
