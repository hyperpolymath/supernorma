// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// SuperNorma - Main Entry Point
// This module exports the core functionality of SuperNorma

/**
 * SuperNorma - Super normalized data structures for financial self-awareness
 *
 * This module provides:
 * - Financial data models (income, expenses, savings)
 * - Pension modeling (DB, DC types)
 * - DAX expressions for Power BI integration
 * - Form-based data collection UI
 */

export const VERSION = "0.1.0";
export const PROJECT_NAME = "SuperNorma";

/**
 * Financial record structure
 */
export interface FinancialRecord {
  income: number;
  expenses: number;
  savings: number;
}

/**
 * Pension model types
 */
export type PensionType = "DB" | "DC" | "SIPP" | "ISA" | "State";

/**
 * Pension record structure
 */
export interface PensionRecord {
  type: PensionType;
  amount: number;
  contributionPercent: number;
  drawdownAge: number;
}

/**
 * Calculate net income from a financial record
 */
export function calculateNetIncome(record: FinancialRecord): number {
  return record.income - record.expenses;
}

/**
 * Check if a financial record represents a surplus
 */
export function isSurplus(record: FinancialRecord): boolean {
  return calculateNetIncome(record) > 0;
}

/**
 * Calculate total savings from multiple records
 */
export function calculateTotalSavings(records: FinancialRecord[]): number {
  return records.reduce((total, record) => total + record.savings, 0);
}

/**
 * Calculate pension projection at retirement
 * Simplified calculation for demonstration
 */
export function calculatePensionProjection(
  pension: PensionRecord,
  currentAge: number,
  annualGrowthRate: number = 0.05
): number {
  const yearsToRetirement = pension.drawdownAge - currentAge;
  if (yearsToRetirement <= 0) return pension.amount;

  // Compound growth formula
  const futureValue = pension.amount * Math.pow(1 + annualGrowthRate, yearsToRetirement);
  return Math.round(futureValue * 100) / 100;
}
