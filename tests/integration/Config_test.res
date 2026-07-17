// SPDX-License-Identifier: MPL-2.0
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Integration tests for project configuration

open Assert
open Testing

@val external jsonParse: string => {..} = "JSON.parse"

let () = describe("Project Configuration", () => {
  describe("rescript.json", () => {
    itAsync("should have valid JSON structure", async () => {
      let content = await Runtime.readTextFile("rescript.json")
      let config = jsonParse(content)
      assertExists(config["name"], ~msg="Should have name field")
    })

    itAsync("should have correct project name", async () => {
      let content = await Runtime.readTextFile("rescript.json")
      let config = jsonParse(content)
      assertEquals(
        config["name"],
        "@hyperpolymath/supernorma",
        ~msg="Project name should be @hyperpolymath/supernorma",
      )
    })

    itAsync("should use ES module output", async () => {
      let content = await Runtime.readTextFile("rescript.json")
      let config = jsonParse(content)
      let specs = config["package-specs"]
      let first = specs[0]->Option.getOrThrow(~message="package-specs should have one entry")
      assertEquals(first["module"], "esmodule", ~msg="Should output ES modules")
    })

    itAsync("should use .res.js suffix", async () => {
      let content = await Runtime.readTextFile("rescript.json")
      let config = jsonParse(content)
      assertEquals(config["suffix"], ".res.js", ~msg="Should use .res.js suffix")
    })

    itAsync("should not use legacy bs-dependencies", async () => {
      let content = await Runtime.readTextFile("rescript.json")
      let config = jsonParse(content)
      // ReScript 12's built-in stdlib means no dependency entries are needed.
      assertEquals(config["bs-dependencies"], undefined, ~msg="Should not have bs-dependencies")
    })
  })

  describe("package.json", () => {
    itAsync("should have valid JSON structure", async () => {
      let content = await Runtime.readTextFile("package.json")
      let config = jsonParse(content)
      assertExists(config["name"], ~msg="Should have name field")
    })

    itAsync("should have correct project name and version", async () => {
      let content = await Runtime.readTextFile("package.json")
      let config = jsonParse(content)
      assertEquals(
        config["name"],
        "@hyperpolymath/supernorma",
        ~msg="Project name should be @hyperpolymath/supernorma",
      )
      assertExists(config["version"], ~msg="Should have version")
    })

    itAsync("should have ReScript build scripts", async () => {
      let content = await Runtime.readTextFile("package.json")
      let config = jsonParse(content)
      let scripts = config["scripts"]
      assertExists(scripts["rescript:build"], ~msg="Should have rescript:build script")
      assertExists(scripts["rescript:clean"], ~msg="Should have rescript:clean script")
    })

    itAsync("should have test script", async () => {
      let content = await Runtime.readTextFile("package.json")
      let config = jsonParse(content)
      let scripts = config["scripts"]
      assertExists(scripts["test"], ~msg="Should have test script")
    })

    itAsync("should declare the rescript devDependency", async () => {
      let content = await Runtime.readTextFile("package.json")
      let config = jsonParse(content)
      let devDeps = config["devDependencies"]
      assertExists(devDeps, ~msg="Should have devDependencies")
      assertExists(devDeps["rescript"], ~msg="Should depend on rescript")
    })
  })

  describe("guix.scm", () => {
    itAsync("should exist and define supernorma package", async () => {
      let content = await Runtime.readTextFile("guix.scm")
      assertStringIncludes(content, "SuperNorma", ~msg="Should define SuperNorma")
      assertStringIncludes(content, "define-public", ~msg="Should have package definition")
    })

    itAsync("should have SPDX license header", async () => {
      let content = await Runtime.readTextFile("guix.scm")
      assertStringIncludes(content, "SPDX-License-Identifier", ~msg="Should have SPDX header")
    })
  })
})

let () = describe("RSR Compliance Files", () => {
  itAsync("should have STATE.a2ml", async () => {
    let content = await Runtime.readTextFile(".machine_readable/6a2/STATE.a2ml")
    assertStringIncludes(content, "supernorma", ~msg="Should reference project")
  })

  itAsync("should have META.a2ml", async () => {
    let content = await Runtime.readTextFile(".machine_readable/6a2/META.a2ml")
    assertStringIncludes(content, "supernorma", ~msg="Should reference project")
  })

  itAsync("should have ECOSYSTEM.a2ml", async () => {
    let content = await Runtime.readTextFile(".machine_readable/6a2/ECOSYSTEM.a2ml")
    assertStringIncludes(content, "supernorma", ~msg="Should reference project")
  })

  itAsync("should have RSR_COMPLIANCE.adoc", async () => {
    let content = await Runtime.readTextFile("RSR_COMPLIANCE.adoc")
    assertExists(content, ~msg="Should be able to read RSR_COMPLIANCE.adoc")
  })

  itAsync("should have SECURITY.md", async () => {
    let content = await Runtime.readTextFile("SECURITY.md")
    assertExists(content, ~msg="Should be able to read SECURITY.md")
  })

  itAsync("should have LICENSE", async () => {
    let content = await Runtime.readTextFile("LICENSE")
    assertExists(content, ~msg="Should be able to read LICENSE")
  })
})
