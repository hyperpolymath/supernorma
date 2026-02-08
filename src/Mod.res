// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// SuperNorma - Main Entry Point

let version = "0.1.0"
let projectName = "SuperNorma"

type financialRecord = {
  income: float,
  expenses: float,
  savings: float,
}

type pensionType = DB | DC | SIPP | ISA | State

type pensionRecord = {
  @as("type") pensionType: pensionType,
  amount: float,
  contributionPercent: float,
  drawdownAge: int,
}

let calculateNetIncome = (record: financialRecord): float => {
  record.income -. record.expenses
}

let isSurplus = (record: financialRecord): bool => {
  calculateNetIncome(record) > 0.0
}

let calculateTotalSavings = (records: array<financialRecord>): float => {
  records->Array.reduce(0.0, (total, record) => total +. record.savings)
}

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
