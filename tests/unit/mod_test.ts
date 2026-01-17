// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Unit tests for main module

import { assertEquals, assertExists } from "@std/assert";
import { describe, it } from "@std/testing/bdd";
import {
  VERSION,
  PROJECT_NAME,
  calculateNetIncome,
  isSurplus,
  calculateTotalSavings,
  calculatePensionProjection,
  type FinancialRecord,
  type PensionRecord,
} from "../../src/mod.ts";

describe("Module Exports", () => {
  it("should export VERSION constant", () => {
    assertExists(VERSION, "VERSION should be exported");
    assertEquals(VERSION, "0.1.0", "VERSION should be 0.1.0");
  });

  it("should export PROJECT_NAME constant", () => {
    assertExists(PROJECT_NAME, "PROJECT_NAME should be exported");
    assertEquals(PROJECT_NAME, "SuperNorma", "PROJECT_NAME should be SuperNorma");
  });
});

describe("Financial Calculations", () => {
  describe("calculateNetIncome", () => {
    it("should calculate positive net income", () => {
      const record: FinancialRecord = { income: 5000, expenses: 3000, savings: 2000 };
      const result = calculateNetIncome(record);
      assertEquals(result, 2000, "Net income should be 2000");
    });

    it("should calculate negative net income", () => {
      const record: FinancialRecord = { income: 3000, expenses: 4000, savings: 0 };
      const result = calculateNetIncome(record);
      assertEquals(result, -1000, "Net income should be -1000");
    });

    it("should calculate zero net income", () => {
      const record: FinancialRecord = { income: 3000, expenses: 3000, savings: 0 };
      const result = calculateNetIncome(record);
      assertEquals(result, 0, "Net income should be 0");
    });
  });

  describe("isSurplus", () => {
    it("should return true for surplus", () => {
      const record: FinancialRecord = { income: 5000, expenses: 3000, savings: 2000 };
      assertEquals(isSurplus(record), true, "Should be a surplus");
    });

    it("should return false for deficit", () => {
      const record: FinancialRecord = { income: 3000, expenses: 4000, savings: 0 };
      assertEquals(isSurplus(record), false, "Should be a deficit");
    });

    it("should return false for break-even", () => {
      const record: FinancialRecord = { income: 3000, expenses: 3000, savings: 0 };
      assertEquals(isSurplus(record), false, "Break-even should not be surplus");
    });
  });

  describe("calculateTotalSavings", () => {
    it("should sum savings from multiple records", () => {
      const records: FinancialRecord[] = [
        { income: 4000, expenses: 2500, savings: 1500 },
        { income: 3500, expenses: 2000, savings: 1500 },
        { income: 5000, expenses: 3000, savings: 2000 },
      ];
      const result = calculateTotalSavings(records);
      assertEquals(result, 5000, "Total savings should be 5000");
    });

    it("should return 0 for empty array", () => {
      const result = calculateTotalSavings([]);
      assertEquals(result, 0, "Empty array should return 0");
    });

    it("should handle single record", () => {
      const records: FinancialRecord[] = [{ income: 4000, expenses: 2500, savings: 1500 }];
      const result = calculateTotalSavings(records);
      assertEquals(result, 1500, "Single record savings should be 1500");
    });
  });
});

describe("Pension Calculations", () => {
  describe("calculatePensionProjection", () => {
    it("should project pension growth at default rate", () => {
      const pension: PensionRecord = { type: "DC", amount: 100000, contributionPercent: 5, drawdownAge: 65 };
      const currentAge = 55;
      const result = calculatePensionProjection(pension, currentAge);

      // 100000 * (1.05)^10 = ~162889
      assertEquals(result > 160000, true, "Projection should show growth");
      assertEquals(result < 165000, true, "Projection should be reasonable");
    });

    it("should project pension at custom growth rate", () => {
      const pension: PensionRecord = { type: "DB", amount: 200000, contributionPercent: 6, drawdownAge: 65 };
      const currentAge = 60;
      const result = calculatePensionProjection(pension, currentAge, 0.04);

      // 200000 * (1.04)^5 = ~243330
      assertEquals(result > 240000, true, "Projection should show growth");
      assertEquals(result < 250000, true, "Projection should be reasonable");
    });

    it("should return current amount if already at retirement age", () => {
      const pension: PensionRecord = { type: "SIPP", amount: 150000, contributionPercent: 5, drawdownAge: 65 };
      const currentAge = 65;
      const result = calculatePensionProjection(pension, currentAge);

      assertEquals(result, 150000, "Should return current amount at retirement");
    });

    it("should return current amount if past retirement age", () => {
      const pension: PensionRecord = { type: "ISA", amount: 50000, contributionPercent: 5, drawdownAge: 62 };
      const currentAge = 70;
      const result = calculatePensionProjection(pension, currentAge);

      assertEquals(result, 50000, "Should return current amount past retirement");
    });
  });
});
