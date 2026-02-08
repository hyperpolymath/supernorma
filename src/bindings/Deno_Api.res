// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// FFI bindings for Deno runtime APIs

@val @scope("Deno") external readTextFile: string => promise<string> = "readTextFile"

type dirEntry = {
  name: string,
  isFile: bool,
  isDirectory: bool,
  isSymlink: bool,
}

@val @scope("Deno") external readDir: string => 'asyncIterable = "readDir"

@val @scope("Deno") external exit: int => unit = "exit"

// Array.fromAsync to collect async iterables
@val @scope("Array") external fromAsync: 'asyncIterable => promise<array<dirEntry>> = "fromAsync"
