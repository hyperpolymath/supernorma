// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// FFI bindings for bun:test's expect() (Bun's built-in test runner)

type expectation<'a>
@module("bun:test") external expect: ('a, ~msg: string=?) => expectation<'a> = "expect"
@send external toEqual: (expectation<'a>, 'b) => unit = "toEqual"
@send external toContain: (expectation<string>, string) => unit = "toContain"
@send external toBeDefined: expectation<'a> => unit = "toBeDefined"
@get external not_: expectation<'a> => expectation<'a> = "not"
@send external toBeNull: expectation<'a> => unit = "toBeNull"
@module("bun:test") @scope("expect")
external arrayContaining: array<'a> => 'b = "arrayContaining"

let assertEquals = (actual: 'a, expected: 'a, ~msg=?): unit =>
  expect(actual, ~msg?)->toEqual(expected)

let assertExists = (actual: 'a, ~msg=?): unit => {
  expect(actual, ~msg?)->toBeDefined
  expect(actual, ~msg?)->not_->toBeNull
}

let assertStringIncludes = (actual: string, expected: string, ~msg=?): unit =>
  expect(actual, ~msg?)->toContain(expected)

let assertArrayIncludes = (actual: array<'a>, expected: array<'a>, ~msg=?): unit =>
  expect(actual, ~msg?)->toEqual(arrayContaining(expected))
