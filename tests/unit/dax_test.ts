// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Unit tests for DAX expressions

import { assertEquals, assertStringIncludes } from "@std/assert";
import { describe, it } from "@std/testing/bdd";

describe("DAX Expressions", () => {
  describe("measures.dax", () => {
    it("should contain TotalSavings measure", async () => {
      const content = await Deno.readTextFile("dax/measures.dax");
      assertStringIncludes(content, "TotalSavings", "Should define TotalSavings measure");
      assertStringIncludes(content, "SUM", "Should use SUM function");
    });

    it("should contain NetIncome measure", async () => {
      const content = await Deno.readTextFile("dax/measures.dax");
      assertStringIncludes(content, "NetIncome", "Should define NetIncome measure");
      assertStringIncludes(content, "SUM", "Should use SUM function for Income");
      assertStringIncludes(content, "Expenses", "Should reference Expenses");
    });

    it("should reference Finance table", async () => {
      const content = await Deno.readTextFile("dax/measures.dax");
      assertStringIncludes(content, "'Finance'", "Should reference Finance table");
    });
  });

  describe("columns.dax", () => {
    it("should contain IsSurplus column", async () => {
      const content = await Deno.readTextFile("dax/columns.dax");
      assertStringIncludes(content, "IsSurplus", "Should define IsSurplus column");
    });

    it("should use IF function for conditional logic", async () => {
      const content = await Deno.readTextFile("dax/columns.dax");
      assertStringIncludes(content, "IF", "Should use IF function");
      assertStringIncludes(content, "NetIncome", "Should reference NetIncome measure");
    });

    it("should return boolean values", async () => {
      const content = await Deno.readTextFile("dax/columns.dax");
      assertStringIncludes(content, "TRUE()", "Should return TRUE() for surplus");
      assertStringIncludes(content, "FALSE()", "Should return FALSE() for deficit");
    });
  });
});

describe("DAX Syntax Validation", () => {
  it("should have matching parentheses in measures.dax", async () => {
    const content = await Deno.readTextFile("dax/measures.dax");
    const openParens = (content.match(/\(/g) || []).length;
    const closeParens = (content.match(/\)/g) || []).length;
    assertEquals(openParens, closeParens, "Parentheses should be balanced");
  });

  it("should have matching parentheses in columns.dax", async () => {
    const content = await Deno.readTextFile("dax/columns.dax");
    const openParens = (content.match(/\(/g) || []).length;
    const closeParens = (content.match(/\)/g) || []).length;
    assertEquals(openParens, closeParens, "Parentheses should be balanced");
  });

  it("should have matching brackets in measures.dax", async () => {
    const content = await Deno.readTextFile("dax/measures.dax");
    const openBrackets = (content.match(/\[/g) || []).length;
    const closeBrackets = (content.match(/\]/g) || []).length;
    assertEquals(openBrackets, closeBrackets, "Brackets should be balanced");
  });

  it("should have matching quotes in measures.dax", async () => {
    const content = await Deno.readTextFile("dax/measures.dax");
    const singleQuotes = (content.match(/'/g) || []).length;
    assertEquals(singleQuotes % 2, 0, "Single quotes should be balanced");
  });
});
