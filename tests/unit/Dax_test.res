// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Unit tests for DAX expressions

open Deno_Std_Assert
open Deno_Std_Testing

@val @scope("RegExp") external matchAll: (string, string) => array<string> = "prototype.match.call"

// Helper to count occurrences of a character in a string
let countChar = (str: string, char: string): int => {
  let parts = str->String.split(char)
  Array.length(parts) - 1
}

let () = describe("DAX Expressions", () => {
  describe("measures.dax", () => {
    itAsync("should contain TotalSavings measure", async () => {
      let content = await Deno_Api.readTextFile("dax/measures.dax")
      assertStringIncludes(content, "TotalSavings", ~msg="Should define TotalSavings measure")
      assertStringIncludes(content, "SUM", ~msg="Should use SUM function")
    })

    itAsync("should contain NetIncome measure", async () => {
      let content = await Deno_Api.readTextFile("dax/measures.dax")
      assertStringIncludes(content, "NetIncome", ~msg="Should define NetIncome measure")
      assertStringIncludes(content, "SUM", ~msg="Should use SUM function for Income")
      assertStringIncludes(content, "Expenses", ~msg="Should reference Expenses")
    })

    itAsync("should reference Finance table", async () => {
      let content = await Deno_Api.readTextFile("dax/measures.dax")
      assertStringIncludes(content, "'Finance'", ~msg="Should reference Finance table")
    })
  })

  describe("columns.dax", () => {
    itAsync("should contain IsSurplus column", async () => {
      let content = await Deno_Api.readTextFile("dax/columns.dax")
      assertStringIncludes(content, "IsSurplus", ~msg="Should define IsSurplus column")
    })

    itAsync("should use IF function for conditional logic", async () => {
      let content = await Deno_Api.readTextFile("dax/columns.dax")
      assertStringIncludes(content, "IF", ~msg="Should use IF function")
      assertStringIncludes(content, "NetIncome", ~msg="Should reference NetIncome measure")
    })

    itAsync("should return boolean values", async () => {
      let content = await Deno_Api.readTextFile("dax/columns.dax")
      assertStringIncludes(content, "TRUE()", ~msg="Should return TRUE() for surplus")
      assertStringIncludes(content, "FALSE()", ~msg="Should return FALSE() for deficit")
    })
  })
})

let () = describe("DAX Syntax Validation", () => {
  itAsync("should have matching parentheses in measures.dax", async () => {
    let content = await Deno_Api.readTextFile("dax/measures.dax")
    let openParens = countChar(content, "(")
    let closeParens = countChar(content, ")")
    assertEquals(openParens, closeParens, ~msg="Parentheses should be balanced")
  })

  itAsync("should have matching parentheses in columns.dax", async () => {
    let content = await Deno_Api.readTextFile("dax/columns.dax")
    let openParens = countChar(content, "(")
    let closeParens = countChar(content, ")")
    assertEquals(openParens, closeParens, ~msg="Parentheses should be balanced")
  })

  itAsync("should have matching brackets in measures.dax", async () => {
    let content = await Deno_Api.readTextFile("dax/measures.dax")
    let openBrackets = countChar(content, "[")
    let closeBrackets = countChar(content, "]")
    assertEquals(openBrackets, closeBrackets, ~msg="Brackets should be balanced")
  })

  itAsync("should have matching quotes in measures.dax", async () => {
    let content = await Deno_Api.readTextFile("dax/measures.dax")
    let singleQuotes = countChar(content, "'")
    assertEquals(mod(singleQuotes, 2), 0, ~msg="Single quotes should be balanced")
  })
})
