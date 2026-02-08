// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Unit tests for main module

open Deno_Std_Assert
open Deno_Std_Testing

let () = describe("Module Exports", () => {
  it("should export VERSION constant", () => {
    assertExists(Mod.version, ~msg="VERSION should be exported")
    assertEquals(Mod.version, "0.1.0", ~msg="VERSION should be 0.1.0")
  })

  it("should export PROJECT_NAME constant", () => {
    assertExists(Mod.projectName, ~msg="PROJECT_NAME should be exported")
    assertEquals(Mod.projectName, "SuperNorma", ~msg="PROJECT_NAME should be SuperNorma")
  })
})

let () = describe("Financial Calculations", () => {
  describe("calculateNetIncome", () => {
    it("should calculate positive net income", () => {
      let record: Mod.financialRecord = {income: 5000.0, expenses: 3000.0, savings: 2000.0}
      let result = Mod.calculateNetIncome(record)
      assertEquals(result, 2000.0, ~msg="Net income should be 2000")
    })

    it("should calculate negative net income", () => {
      let record: Mod.financialRecord = {income: 3000.0, expenses: 4000.0, savings: 0.0}
      let result = Mod.calculateNetIncome(record)
      assertEquals(result, -1000.0, ~msg="Net income should be -1000")
    })

    it("should calculate zero net income", () => {
      let record: Mod.financialRecord = {income: 3000.0, expenses: 3000.0, savings: 0.0}
      let result = Mod.calculateNetIncome(record)
      assertEquals(result, 0.0, ~msg="Net income should be 0")
    })
  })

  describe("isSurplus", () => {
    it("should return true for surplus", () => {
      let record: Mod.financialRecord = {income: 5000.0, expenses: 3000.0, savings: 2000.0}
      assertEquals(Mod.isSurplus(record), true, ~msg="Should be a surplus")
    })

    it("should return false for deficit", () => {
      let record: Mod.financialRecord = {income: 3000.0, expenses: 4000.0, savings: 0.0}
      assertEquals(Mod.isSurplus(record), false, ~msg="Should be a deficit")
    })

    it("should return false for break-even", () => {
      let record: Mod.financialRecord = {income: 3000.0, expenses: 3000.0, savings: 0.0}
      assertEquals(Mod.isSurplus(record), false, ~msg="Break-even should not be surplus")
    })
  })

  describe("calculateTotalSavings", () => {
    it("should sum savings from multiple records", () => {
      let records: array<Mod.financialRecord> = [
        {income: 4000.0, expenses: 2500.0, savings: 1500.0},
        {income: 3500.0, expenses: 2000.0, savings: 1500.0},
        {income: 5000.0, expenses: 3000.0, savings: 2000.0},
      ]
      let result = Mod.calculateTotalSavings(records)
      assertEquals(result, 5000.0, ~msg="Total savings should be 5000")
    })

    it("should return 0 for empty array", () => {
      let result = Mod.calculateTotalSavings([])
      assertEquals(result, 0.0, ~msg="Empty array should return 0")
    })

    it("should handle single record", () => {
      let records: array<Mod.financialRecord> = [
        {income: 4000.0, expenses: 2500.0, savings: 1500.0},
      ]
      let result = Mod.calculateTotalSavings(records)
      assertEquals(result, 1500.0, ~msg="Single record savings should be 1500")
    })
  })
})

let () = describe("Pension Calculations", () => {
  describe("calculatePensionProjection", () => {
    it("should project pension growth at default rate", () => {
      let pension: Mod.pensionRecord = {
        pensionType: DC,
        amount: 100000.0,
        contributionPercent: 5.0,
        drawdownAge: 65,
      }
      let result = Mod.calculatePensionProjection(pension, 55)
      assertEquals(result > 160000.0, true, ~msg="Projection should show growth")
      assertEquals(result < 165000.0, true, ~msg="Projection should be reasonable")
    })

    it("should project pension at custom growth rate", () => {
      let pension: Mod.pensionRecord = {
        pensionType: DB,
        amount: 200000.0,
        contributionPercent: 6.0,
        drawdownAge: 65,
      }
      let result = Mod.calculatePensionProjection(pension, 60, ~annualGrowthRate=0.04)
      assertEquals(result > 240000.0, true, ~msg="Projection should show growth")
      assertEquals(result < 250000.0, true, ~msg="Projection should be reasonable")
    })

    it("should return current amount if already at retirement age", () => {
      let pension: Mod.pensionRecord = {
        pensionType: SIPP,
        amount: 150000.0,
        contributionPercent: 5.0,
        drawdownAge: 65,
      }
      let result = Mod.calculatePensionProjection(pension, 65)
      assertEquals(result, 150000.0, ~msg="Should return current amount at retirement")
    })

    it("should return current amount if past retirement age", () => {
      let pension: Mod.pensionRecord = {
        pensionType: ISA,
        amount: 50000.0,
        contributionPercent: 5.0,
        drawdownAge: 62,
      }
      let result = Mod.calculatePensionProjection(pension, 70)
      assertEquals(result, 50000.0, ~msg="Should return current amount past retirement")
    })
  })
})
