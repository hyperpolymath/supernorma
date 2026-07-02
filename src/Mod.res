// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

/**
 * SuperNorma — Financial Normalization and Projection (ReScript).
 *
 * This module implements the primary domain model for the SuperNorma 
 * project. It provides deterministic financial calculation kernels 
 * for analyzing income, expenses, and pension growth.
 */

// PROJECT METADATA
let version = "0.1.0"
let projectName = "SuperNorma"

// DATA MODELS: Typed representations of financial entities.
type financialRecord = {
  income: float,
  expenses: float,
  savings: float,
}

type pensionType = DB | DC | SIPP | ISA | State

type pensionRecord = {
  pensionType: pensionType,
  amount: float,
  contributionPercent: float,
  drawdownAge: int,
}

/**
 * NET INCOME: Income remaining after expenses for one record.
 */
let calculateNetIncome = (record: financialRecord): float => {
  record.income -. record.expenses
}

/**
 * SURPLUS CHECK: True only when income strictly exceeds expenses;
 * break-even is not a surplus.
 */
let isSurplus = (record: financialRecord): bool => {
  record.income > record.expenses
}

/**
 * PROJECTION: Calculates the future value of a pension pot.
 * 
 * ALGORITHM: Compound Interest.
 * Formula: `FutureValue = PresentValue * (1 + GrowthRate)^Years`
 * Ensures the result is rounded to two decimal places for currency consistency.
 */
let calculatePensionProjection = (
  pension: pensionRecord,
  currentAge: int,
  ~annualGrowthRate: float=0.05,
): float => {
  let yearsToRetirement = pension.drawdownAge - currentAge
  if yearsToRetirement <= 0 {
    pension.amount
  } else {
    let futureValue =
      pension.amount *. Math.pow(1.0 +. annualGrowthRate, ~exp=Int.toFloat(yearsToRetirement))
    Math.round(futureValue *. 100.0) /. 100.0
  }
}

/**
 * AGGREGATION: Computes the total savings across multiple records.
 */
let calculateTotalSavings = (records: array<financialRecord>): float => {
  records->Array.reduce(0.0, (total, record) => total +. record.savings)
}
