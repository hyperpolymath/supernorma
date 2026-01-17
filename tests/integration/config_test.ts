// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Integration tests for project configuration

import { assertEquals, assertStringIncludes, assertExists } from "@std/assert";
import { describe, it } from "@std/testing/bdd";

describe("Project Configuration", () => {
  describe("rescript.json", () => {
    it("should have valid JSON structure", async () => {
      const content = await Deno.readTextFile("rescript.json");
      const config = JSON.parse(content);
      assertExists(config.name, "Should have name field");
    });

    it("should have correct project name", async () => {
      const content = await Deno.readTextFile("rescript.json");
      const config = JSON.parse(content);
      assertEquals(config.name, "supernorma", "Project name should be supernorma");
    });

    it("should use ES6 module output", async () => {
      const content = await Deno.readTextFile("rescript.json");
      const config = JSON.parse(content);
      const packageSpec = config["package-specs"][0];
      assertEquals(packageSpec.module, "es6", "Should output ES6 modules");
    });

    it("should use .res.js suffix", async () => {
      const content = await Deno.readTextFile("rescript.json");
      const config = JSON.parse(content);
      assertEquals(config.suffix, ".res.js", "Should use .res.js suffix");
    });

    it("should not use deprecated bs-dependencies", async () => {
      const content = await Deno.readTextFile("rescript.json");
      const config = JSON.parse(content);
      assertEquals(config["bs-dependencies"], undefined, "Should not have bs-dependencies");
      assertExists(config.dependencies, "Should use dependencies instead");
    });
  });

  describe("deno.json", () => {
    it("should have valid JSON structure", async () => {
      const content = await Deno.readTextFile("deno.json");
      const config = JSON.parse(content);
      assertExists(config.name, "Should have name field");
    });

    it("should have correct project name and version", async () => {
      const content = await Deno.readTextFile("deno.json");
      const config = JSON.parse(content);
      assertEquals(config.name, "@hyperpolymath/supernorma", "Project name should be @hyperpolymath/supernorma");
      assertExists(config.version, "Should have version");
    });

    it("should have ReScript build tasks", async () => {
      const content = await Deno.readTextFile("deno.json");
      const config = JSON.parse(content);
      assertExists(config.tasks["rescript:build"], "Should have rescript:build task");
      assertExists(config.tasks["rescript:clean"], "Should have rescript:clean task");
    });

    it("should have test task", async () => {
      const content = await Deno.readTextFile("deno.json");
      const config = JSON.parse(content);
      assertExists(config.tasks.test, "Should have test task");
    });

    it("should have import map", async () => {
      const content = await Deno.readTextFile("deno.json");
      const config = JSON.parse(content);
      assertExists(config.imports, "Should have imports");
      assertExists(config.imports["@std/assert"], "Should import @std/assert");
    });
  });

  describe("flake.nix", () => {
    it("should exist and reference SuperNorma", async () => {
      const content = await Deno.readTextFile("flake.nix");
      assertStringIncludes(content, "SuperNorma", "Should reference SuperNorma");
      assertStringIncludes(content, "deno", "Should include deno");
    });

    it("should have SPDX license header", async () => {
      const content = await Deno.readTextFile("flake.nix");
      assertStringIncludes(content, "SPDX-License-Identifier", "Should have SPDX header");
    });
  });

  describe("guix.scm", () => {
    it("should exist and define supernorma package", async () => {
      const content = await Deno.readTextFile("guix.scm");
      assertStringIncludes(content, "SuperNorma", "Should define SuperNorma");
      assertStringIncludes(content, "define-public", "Should have package definition");
    });

    it("should have SPDX license header", async () => {
      const content = await Deno.readTextFile("guix.scm");
      assertStringIncludes(content, "SPDX-License-Identifier", "Should have SPDX header");
    });
  });
});

describe("RSR Compliance Files", () => {
  it("should have STATE.scm", async () => {
    const content = await Deno.readTextFile("STATE.scm");
    assertStringIncludes(content, "supernorma", "Should reference project");
  });

  it("should have META.scm", async () => {
    const content = await Deno.readTextFile("META.scm");
    assertStringIncludes(content, "supernorma", "Should reference project");
  });

  it("should have ECOSYSTEM.scm", async () => {
    const content = await Deno.readTextFile("ECOSYSTEM.scm");
    assertStringIncludes(content, "supernorma", "Should reference project");
  });

  it("should have RSR_COMPLIANCE.adoc", async () => {
    const content = await Deno.readTextFile("RSR_COMPLIANCE.adoc");
    assertEquals(typeof content, "string", "Should be able to read RSR_COMPLIANCE.adoc");
  });

  it("should have SECURITY.md", async () => {
    const content = await Deno.readTextFile("SECURITY.md");
    assertEquals(typeof content, "string", "Should be able to read SECURITY.md");
  });

  it("should have LICENSE.txt", async () => {
    const content = await Deno.readTextFile("LICENSE.txt");
    assertEquals(typeof content, "string", "Should be able to read LICENSE.txt");
  });
});
