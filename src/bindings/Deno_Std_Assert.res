// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// FFI bindings for @std/assert (Deno standard library)

@module("@std/assert") external assertEquals: ('a, 'a, ~msg: string=?) => unit = "assertEquals"

@module("@std/assert") external assertExists: ('a, ~msg: string=?) => unit = "assertExists"

@module("@std/assert")
external assertStringIncludes: (string, string, ~msg: string=?) => unit = "assertStringIncludes"

@module("@std/assert")
external assertArrayIncludes: (array<'a>, array<'a>, ~msg: string=?) => unit = "assertArrayIncludes"
