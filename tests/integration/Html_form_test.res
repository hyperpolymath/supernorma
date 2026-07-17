// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Integration tests for HTML form and UI

open Assert
open Testing

let () = describe("HTML Form Integration", () => {
  describe("ui/webform.html", () => {
    itAsync("should be valid HTML document", async () => {
      let content = await Runtime.readTextFile("ui/webform.html")
      assertStringIncludes(content, "<!DOCTYPE html>", ~msg="Should have DOCTYPE")
      assertStringIncludes(content, "<html>", ~msg="Should have html tag")
      assertStringIncludes(content, "</html>", ~msg="Should close html tag")
    })

    itAsync("should contain a form element", async () => {
      let content = await Runtime.readTextFile("ui/webform.html")
      assertStringIncludes(content, "<form>", ~msg="Should have form tag")
      assertStringIncludes(content, "</form>", ~msg="Should close form tag")
    })

    itAsync("should have income input field", async () => {
      let content = await Runtime.readTextFile("ui/webform.html")
      assertStringIncludes(content, "Income", ~msg="Should have Income label")
      assertStringIncludes(content, "type='number'", ~msg="Should have number input")
    })

    itAsync("should have expenses input field", async () => {
      let content = await Runtime.readTextFile("ui/webform.html")
      assertStringIncludes(content, "Expenses", ~msg="Should have Expenses label")
    })

    itAsync("should have submit button", async () => {
      let content = await Runtime.readTextFile("ui/webform.html")
      assertStringIncludes(content, "type='submit'", ~msg="Should have submit button")
    })

    itAsync("should have SuperNorma branding", async () => {
      let content = await Runtime.readTextFile("ui/webform.html")
      assertStringIncludes(content, "SuperNorma", ~msg="Should reference SuperNorma")
    })
  })

  describe("ui/style.css", () => {
    itAsync("should exist and be readable", async () => {
      let content = await Runtime.readTextFile("ui/style.css")
      assertExists(content, ~msg="Should be able to read style.css")
    })
  })
})

let () = describe("Project Structure", () => {
  itAsync("should have ReScript source files", async () => {
    let srcDir = await Runtime.listDir("src")
    let resFiles = srcDir->Array.filter(name => name->String.endsWith(".res"))
    assertEquals(Array.length(resFiles) >= 1, true, ~msg="Should have at least one .res file")
  })

  itAsync("should have compiled JavaScript files", async () => {
    let srcDir = await Runtime.listDir("src")
    let jsFiles = srcDir->Array.filter(name => name->String.endsWith(".res.js"))
    assertEquals(Array.length(jsFiles) >= 1, true, ~msg="Should have at least one .res.js file")
  })

  itAsync("should have matching .res and .res.js files", async () => {
    let srcDir = await Runtime.listDir("src")
    let resFiles = srcDir->Array.filter(name => name->String.endsWith(".res"))
    let jsFiles = srcDir->Array.filter(name => name->String.endsWith(".res.js"))
    resFiles->Array.forEach(resFile => {
      let baseName = resFile->String.replace(".res", "")
      let hasCompiled = jsFiles->Array.some(js => js == `${baseName}.res.js`)
      assertEquals(hasCompiled, true, ~msg=`${resFile} should have compiled .res.js file`)
    })
  })
})
