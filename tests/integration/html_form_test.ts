// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Integration tests for HTML form and UI

import { assertEquals, assertStringIncludes } from "@std/assert";
import { describe, it } from "@std/testing/bdd";

describe("HTML Form Integration", () => {
  describe("ui/webform.html", () => {
    it("should be valid HTML document", async () => {
      const content = await Deno.readTextFile("ui/webform.html");
      assertStringIncludes(content, "<!DOCTYPE html>", "Should have DOCTYPE");
      assertStringIncludes(content, "<html>", "Should have html tag");
      assertStringIncludes(content, "</html>", "Should close html tag");
    });

    it("should contain a form element", async () => {
      const content = await Deno.readTextFile("ui/webform.html");
      assertStringIncludes(content, "<form>", "Should have form tag");
      assertStringIncludes(content, "</form>", "Should close form tag");
    });

    it("should have income input field", async () => {
      const content = await Deno.readTextFile("ui/webform.html");
      assertStringIncludes(content, "Income", "Should have Income label");
      assertStringIncludes(content, "type='number'", "Should have number input");
    });

    it("should have expenses input field", async () => {
      const content = await Deno.readTextFile("ui/webform.html");
      assertStringIncludes(content, "Expenses", "Should have Expenses label");
    });

    it("should have submit button", async () => {
      const content = await Deno.readTextFile("ui/webform.html");
      assertStringIncludes(content, "type='submit'", "Should have submit button");
    });

    it("should have SuperNorma branding", async () => {
      const content = await Deno.readTextFile("ui/webform.html");
      assertStringIncludes(content, "SuperNorma", "Should reference SuperNorma");
    });
  });

  describe("ui/style.css", () => {
    it("should exist and be readable", async () => {
      const content = await Deno.readTextFile("ui/style.css");
      assertEquals(typeof content, "string", "Should be able to read style.css");
    });
  });
});

describe("Project Structure", () => {
  it("should have ReScript source files", async () => {
    const srcDir = await Array.fromAsync(Deno.readDir("src"));
    const resFiles = srcDir.filter((entry) => entry.name.endsWith(".res"));
    assertEquals(resFiles.length >= 1, true, "Should have at least one .res file");
  });

  it("should have compiled JavaScript files", async () => {
    const srcDir = await Array.fromAsync(Deno.readDir("src"));
    const jsFiles = srcDir.filter((entry) => entry.name.endsWith(".res.js"));
    assertEquals(jsFiles.length >= 1, true, "Should have at least one .res.js file");
  });

  it("should have matching .res and .res.js files", async () => {
    const srcDir = await Array.fromAsync(Deno.readDir("src"));
    const resFiles = srcDir.filter((entry) => entry.name.endsWith(".res"));
    const jsFiles = srcDir.filter((entry) => entry.name.endsWith(".res.js"));

    for (const resFile of resFiles) {
      const baseName = resFile.name.replace(".res", "");
      const hasCompiled = jsFiles.some((js) => js.name === `${baseName}.res.js`);
      assertEquals(hasCompiled, true, `${resFile.name} should have compiled .res.js file`);
    }
  });
});
