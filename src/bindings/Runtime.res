// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// FFI bindings for Bun/Node runtime APIs

type bunFile
@val @scope("Bun") external file: string => bunFile = "file"
@send external text: bunFile => promise<string> = "text"
let readTextFile = (path: string): promise<string> => file(path)->text

// node:fs/promises readdir (no options) resolves directly to an array of
// filenames -- no async-iterable/collect step needed, unlike Deno.readDir.
@module("node:fs/promises") external listDir: string => promise<array<string>> = "readdir"

@val @scope("process") external exit: int => unit = "exit"
