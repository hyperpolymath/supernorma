// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Integration tests for project configuration

open Deno_Std_Assert
open Deno_Std_Testing

@val external jsonParse: string => {..} = "JSON.parse"

let () = describe("Project Configuration", () => {
  describe("rescript.json", () => {
    itAsync("should have valid JSON structure", async () => {
      let content = await Deno_Api.readTextFile("rescript.json")
      let config = jsonParse(content)
      assertExists(config["name"], ~msg="Should have name field")
    })

    itAsync("should have correct project name", async () => {
      let content = await Deno_Api.readTextFile("rescript.json")
      let config = jsonParse(content)
      assertEquals(config["name"], "supernorma", ~msg="Project name should be supernorma")
    })

    itAsync("should use ES6 module output", async () => {
      let content = await Deno_Api.readTextFile("rescript.json")
      let config = jsonParse(content)
      let specs = config["package-specs"]
      let first = specs[0]
      assertEquals(first["module"], "es6", ~msg="Should output ES6 modules")
    })

    itAsync("should use .res.js suffix", async () => {
      let content = await Deno_Api.readTextFile("rescript.json")
      let config = jsonParse(content)
      assertEquals(config["suffix"], ".res.js", ~msg="Should use .res.js suffix")
    })

    itAsync("should use dependencies instead of bs-dependencies", async () => {
      let content = await Deno_Api.readTextFile("rescript.json")
      let config = jsonParse(content)
      assertEquals(config["bs-dependencies"], Js.undefined, ~msg="Should not have bs-dependencies")
      assertExists(config["dependencies"], ~msg="Should use dependencies instead")
    })
  })

  describe("deno.json", () => {
    itAsync("should have valid JSON structure", async () => {
      let content = await Deno_Api.readTextFile("deno.json")
      let config = jsonParse(content)
      assertExists(config["name"], ~msg="Should have name field")
    })

    itAsync("should have correct project name and version", async () => {
      let content = await Deno_Api.readTextFile("deno.json")
      let config = jsonParse(content)
      assertEquals(
        config["name"],
        "@hyperpolymath/supernorma",
        ~msg="Project name should be @hyperpolymath/supernorma",
      )
      assertExists(config["version"], ~msg="Should have version")
    })

    itAsync("should have ReScript build tasks", async () => {
      let content = await Deno_Api.readTextFile("deno.json")
      let config = jsonParse(content)
      let tasks = config["tasks"]
      assertExists(tasks["rescript:build"], ~msg="Should have rescript:build task")
      assertExists(tasks["rescript:clean"], ~msg="Should have rescript:clean task")
    })

    itAsync("should have test task", async () => {
      let content = await Deno_Api.readTextFile("deno.json")
      let config = jsonParse(content)
      let tasks = config["tasks"]
      assertExists(tasks["test"], ~msg="Should have test task")
    })

    itAsync("should have import map", async () => {
      let content = await Deno_Api.readTextFile("deno.json")
      let config = jsonParse(content)
      let imports = config["imports"]
      assertExists(imports, ~msg="Should have imports")
      assertExists(imports["@std/assert"], ~msg="Should import @std/assert")
    })
  })

  describe("flake.nix", () => {
    itAsync("should exist and reference SuperNorma", async () => {
      let content = await Deno_Api.readTextFile("flake.nix")
      assertStringIncludes(content, "SuperNorma", ~msg="Should reference SuperNorma")
      assertStringIncludes(content, "deno", ~msg="Should include deno")
    })

    itAsync("should have SPDX license header", async () => {
      let content = await Deno_Api.readTextFile("flake.nix")
      assertStringIncludes(content, "SPDX-License-Identifier", ~msg="Should have SPDX header")
    })
  })

  describe("guix.scm", () => {
    itAsync("should exist and define supernorma package", async () => {
      let content = await Deno_Api.readTextFile("guix.scm")
      assertStringIncludes(content, "SuperNorma", ~msg="Should define SuperNorma")
      assertStringIncludes(content, "define-public", ~msg="Should have package definition")
    })

    itAsync("should have SPDX license header", async () => {
      let content = await Deno_Api.readTextFile("guix.scm")
      assertStringIncludes(content, "SPDX-License-Identifier", ~msg="Should have SPDX header")
    })
  })
})

let () = describe("RSR Compliance Files", () => {
  itAsync("should have STATE.scm", async () => {
    let content = await Deno_Api.readTextFile("STATE.scm")
    assertStringIncludes(content, "supernorma", ~msg="Should reference project")
  })

  itAsync("should have META.scm", async () => {
    let content = await Deno_Api.readTextFile("META.scm")
    assertStringIncludes(content, "supernorma", ~msg="Should reference project")
  })

  itAsync("should have ECOSYSTEM.scm", async () => {
    let content = await Deno_Api.readTextFile("ECOSYSTEM.scm")
    assertStringIncludes(content, "supernorma", ~msg="Should reference project")
  })

  itAsync("should have RSR_COMPLIANCE.adoc", async () => {
    let content = await Deno_Api.readTextFile("RSR_COMPLIANCE.adoc")
    assertEquals(typeof content, "string", ~msg="Should be able to read RSR_COMPLIANCE.adoc")
  })

  itAsync("should have SECURITY.md", async () => {
    let content = await Deno_Api.readTextFile("SECURITY.md")
    assertEquals(typeof content, "string", ~msg="Should be able to read SECURITY.md")
  })

  itAsync("should have LICENSE.txt", async () => {
    let content = await Deno_Api.readTextFile("LICENSE.txt")
    assertEquals(typeof content, "string", ~msg="Should be able to read LICENSE.txt")
  })
})
