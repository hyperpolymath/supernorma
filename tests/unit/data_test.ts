// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Unit tests for data processing functionality

import { assertEquals, assertArrayIncludes } from "@std/assert";
import { describe, it } from "@std/testing/bdd";
import { parse } from "@std/csv";

describe("Data Files", () => {
  describe("workbook/template.csv", () => {
    it("should have valid CSV structure", async () => {
      const content = await Deno.readTextFile("workbook/template.csv");
      const records = parse(content, { skipFirstRow: false });

      // Should have header row and at least one data row
      assertEquals(records.length >= 2, true, "Should have at least 2 rows (header + data)");
    });

    it("should contain required columns", async () => {
      const content = await Deno.readTextFile("workbook/template.csv");
      const records = parse(content, { skipFirstRow: false });
      const headers = records[0] as unknown as string[];

      assertArrayIncludes(headers, ["Income"], "Should have Income column");
      assertArrayIncludes(headers, ["Expenses"], "Should have Expenses column");
      assertArrayIncludes(headers, ["Savings"], "Should have Savings column");
    });

    it("should have valid numeric values", async () => {
      const content = await Deno.readTextFile("workbook/template.csv");
      const records = parse(content, { skipFirstRow: true });

      for (const row of records) {
        const values = Object.values(row as Record<string, string>);
        for (const value of values) {
          const num = parseFloat(value);
          assertEquals(!isNaN(num), true, `Value '${value}' should be a valid number`);
        }
      }
    });
  });

  describe("workbook/pensions_model.csv", () => {
    it("should have valid pension model structure", async () => {
      const content = await Deno.readTextFile("workbook/pensions_model.csv");
      const records = parse(content, { skipFirstRow: false });

      assertEquals(records.length >= 2, true, "Should have at least 2 rows");

      const headers = records[0] as unknown as string[];
      assertArrayIncludes(headers, ["Type"], "Should have Type column");
      assertArrayIncludes(headers, ["Amount"], "Should have Amount column");
    });

    it("should have valid pension types", async () => {
      const content = await Deno.readTextFile("workbook/pensions_model.csv");
      const records = parse(content, { skipFirstRow: true });

      const validTypes = ["DB", "DC", "SIPP", "ISA", "State"];

      for (const row of records) {
        const rowRecord = row as Record<string, string>;
        const pensionType = rowRecord["Type"];
        assertArrayIncludes(validTypes, [pensionType], `Pension type '${pensionType}' should be valid`);
      }
    });
  });

  describe("data/sample_input/income_example.csv", () => {
    it("should have valid income data", async () => {
      const content = await Deno.readTextFile("data/sample_input/income_example.csv");
      const records = parse(content, { skipFirstRow: false });

      assertEquals(records.length >= 2, true, "Should have at least 2 rows");

      const headers = records[0] as unknown as string[];
      assertArrayIncludes(headers, ["Income Source"], "Should have Income Source column");
      assertArrayIncludes(headers, ["Amount"], "Should have Amount column");
    });
  });
});
