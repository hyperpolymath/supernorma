// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

/**
 * SuperNorma — Financial Normalization and Projection (ReScript).
 *
 * This module implements the primary domain model for the SuperNorma 
 * project. It provides deterministic financial calculation kernels 
 * for analyzing income, expenses, and pension growth.
 */

// DATA MODELS: Typed representations of financial entities.
type financialRecord = {
  income: float,
  expenses: float,
  savings: float,
}

type pensionType = DB | DC | SIPP | ISA | State

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
      pension.amount *. Math.pow(1.0 +. annualGrowthRate, Int.toFloat(yearsToRetirement))
    Math.round(futureValue *. 100.0) /. 100.0
  }
}

/**
 * AGGREGATION: Computes the total savings across multiple records.
 */
let calculateTotalSavings = (records: array<financialRecord>): float => {
  records->Array.reduce(0.0, (total, record) => total +. record.savings)
}
