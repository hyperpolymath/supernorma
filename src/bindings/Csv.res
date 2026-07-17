// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Minimal CSV parsing (no quoted-field escaping) -- pure ReScript, no
// external dependency. Sufficient for this project's simple sample data;
// swap for a real CSV library if quoted/escaped fields are ever needed.

type parseOptions = {skipFirstRow: bool}

let splitLines = (text: string): array<string> =>
  text
  ->String.split("\n")
  ->Array.map(line => line->String.trim)
  ->Array.filter(line => line !== "")

let splitRow = (line: string): array<string> => line->String.split(",")->Array.map(String.trim)

let parse = (text: string, options: parseOptions): array<array<string>> => {
  let rows = splitLines(text)->Array.map(splitRow)
  options.skipFirstRow
    ? rows->Array.slice(~start=1)
    : rows
}

// Always uses the first row as headers (required to produce keyed records);
// the remaining rows become one Dict per row, keyed by header.
let parseAsRecords = (text: string, _options: parseOptions): array<Dict.t<string>> => {
  let rows = splitLines(text)->Array.map(splitRow)
  switch rows {
  | [] => []
  | [_] => []
  | rows =>
    let headers = rows->Array.getUnsafe(0)
    rows
    ->Array.slice(~start=1)
    ->Array.map(row => {
      let dict = Dict.make()
      headers->Array.forEachWithIndex((header, i) => {
        switch row->Array.get(i) {
        | Some(value) => dict->Dict.set(header, value)
        | None => ()
        }
      })
      dict
    })
  }
}
