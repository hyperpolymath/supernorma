// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Unit tests for data processing functionality

open Deno_Std_Assert
open Deno_Std_Testing
open Deno_Std_Csv

let () = describe("Data Files", () => {
  describe("workbook/template.csv", () => {
    itAsync("should have valid CSV structure", async () => {
      let content = await Deno_Api.readTextFile("workbook/template.csv")
      let records = parse(content, {skipFirstRow: false})
      assertEquals(Array.length(records) >= 2, true, ~msg="Should have at least 2 rows (header + data)")
    })

    itAsync("should contain required columns", async () => {
      let content = await Deno_Api.readTextFile("workbook/template.csv")
      let records = parse(content, {skipFirstRow: false})
      let headers = records[0]
      switch headers {
      | Some(h) =>
        assertArrayIncludes(h, ["Income"], ~msg="Should have Income column")
        assertArrayIncludes(h, ["Expenses"], ~msg="Should have Expenses column")
        assertArrayIncludes(h, ["Savings"], ~msg="Should have Savings column")
      | None => assertExists(None, ~msg="Headers should exist")
      }
    })

    itAsync("should have valid numeric values", async () => {
      let content = await Deno_Api.readTextFile("workbook/template.csv")
      let records = parseAsRecords(content, {skipFirstRow: true})
      records->Array.forEach(row => {
        let values = row->Dict.valuesToArray
        values->Array.forEach(value => {
          let num = Float.fromString(value)
          assertExists(num, ~msg=`Value '${value}' should be a valid number`)
        })
      })
    })
  })

  describe("workbook/pensions_model.csv", () => {
    itAsync("should have valid pension model structure", async () => {
      let content = await Deno_Api.readTextFile("workbook/pensions_model.csv")
      let records = parse(content, {skipFirstRow: false})
      assertEquals(Array.length(records) >= 2, true, ~msg="Should have at least 2 rows")
      let headers = records[0]
      switch headers {
      | Some(h) =>
        assertArrayIncludes(h, ["Type"], ~msg="Should have Type column")
        assertArrayIncludes(h, ["Amount"], ~msg="Should have Amount column")
      | None => assertExists(None, ~msg="Headers should exist")
      }
    })

    itAsync("should have valid pension types", async () => {
      let content = await Deno_Api.readTextFile("workbook/pensions_model.csv")
      let records = parseAsRecords(content, {skipFirstRow: true})
      let validTypes = ["DB", "DC", "SIPP", "ISA", "State"]
      records->Array.forEach(row => {
        switch row->Dict.get("Type") {
        | Some(pensionType) =>
          assertArrayIncludes(
            validTypes,
            [pensionType],
            ~msg=`Pension type '${pensionType}' should be valid`,
          )
        | None => assertExists(None, ~msg="Type column should exist")
        }
      })
    })
  })

  describe("data/sample_input/income_example.csv", () => {
    itAsync("should have valid income data", async () => {
      let content = await Deno_Api.readTextFile("data/sample_input/income_example.csv")
      let records = parse(content, {skipFirstRow: false})
      assertEquals(Array.length(records) >= 2, true, ~msg="Should have at least 2 rows")
      let headers = records[0]
      switch headers {
      | Some(h) =>
        assertArrayIncludes(h, ["Income Source"], ~msg="Should have Income Source column")
        assertArrayIncludes(h, ["Amount"], ~msg="Should have Amount column")
      | None => assertExists(None, ~msg="Headers should exist")
      }
    })
  })
})
