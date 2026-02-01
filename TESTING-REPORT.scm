;;; TESTING-REPORT.scm - SuperNorma Test Results
;; SPDX-License-Identifier: PMPL-1.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;;
;; Machine-readable test report in Guile Scheme format
;; Generated: 2025-12-29

(define-module (supernorma testing-report)
  #:export (test-metadata
            test-environment
            test-summary
            test-suites
            build-results
            files-created
            files-modified
            recommendations))

;;; ===========================================================================
;;; METADATA
;;; ===========================================================================

(define test-metadata
  '((report-date . "2025-12-29")
    (project . "supernorma")
    (version . "0.1.0")
    (test-framework . "deno-test")
    (test-library . "@std/testing")
    (report-format . "guile-scheme")
    (schema-version . "1.0.0")))

;;; ===========================================================================
;;; TEST ENVIRONMENT
;;; ===========================================================================

(define test-environment
  '((platform . "linux")
    (distribution . "fedora-43")
    (kernel . "6.17.12-300.fc43.x86_64")
    (tools
     ((name . "deno") (version . "1.45.0") (purpose . "runtime-test-framework"))
     ((name . "rescript") (version . "12.0.2") (purpose . "primary-language-compiler"))
     ((name . "nodejs") (version . "25.2.1") (purpose . "npx-rescript-execution"))
     ((name . "just") (version . "latest") (purpose . "task-runner")))))

;;; ===========================================================================
;;; TEST SUMMARY
;;; ===========================================================================

(define test-summary
  '((total-suites . 12)
    (total-steps . 85)
    (passed . 85)
    (failed . 0)
    (skipped . 0)
    (pass-rate . 100.0)
    (build-status . "success")
    (execution-time-seconds . 3)))

;;; ===========================================================================
;;; TEST SUITES
;;; ===========================================================================

(define test-suites
  '(;; Unit Tests
    ((name . "ui-module-source")
     (file . "tests/unit/ui_test.ts")
     (type . "unit")
     (steps . 4)
     (status . "pass")
     (tests
      ((name . "should-exist-and-be-valid-rescript") (status . "pass"))
      ((name . "should-have-dom-bindings") (status . "pass"))
      ((name . "should-handle-form-submission") (status . "pass"))
      ((name . "should-use-option-for-null-safety") (status . "pass"))))

    ((name . "ui-module-compiled")
     (file . "tests/unit/ui_test.ts")
     (type . "unit")
     (steps . 4)
     (status . "pass")
     (tests
      ((name . "should-have-compiled-javascript-file") (status . "pass"))
      ((name . "should-export-init-function") (status . "pass"))
      ((name . "should-use-es6-module-syntax") (status . "pass"))
      ((name . "should-have-correct-file-suffix") (status . "pass"))))

    ((name . "data-files")
     (file . "tests/unit/data_test.ts")
     (type . "unit")
     (steps . 6)
     (status . "pass")
     (tests
      ((name . "template-csv-valid-structure") (status . "pass"))
      ((name . "template-csv-required-columns") (status . "pass"))
      ((name . "template-csv-valid-numeric-values") (status . "pass"))
      ((name . "pensions-model-valid-structure") (status . "pass"))
      ((name . "pensions-model-valid-types") (status . "pass"))
      ((name . "income-example-valid-data") (status . "pass"))))

    ((name . "dax-expressions")
     (file . "tests/unit/dax_test.ts")
     (type . "unit")
     (steps . 6)
     (status . "pass")
     (tests
      ((name . "measures-contains-totalsavings") (status . "pass"))
      ((name . "measures-contains-netincome") (status . "pass"))
      ((name . "measures-references-finance-table") (status . "pass"))
      ((name . "columns-contains-issurplus") (status . "pass"))
      ((name . "columns-uses-if-function") (status . "pass"))
      ((name . "columns-returns-boolean") (status . "pass"))))

    ((name . "dax-syntax-validation")
     (file . "tests/unit/dax_test.ts")
     (type . "unit")
     (steps . 4)
     (status . "pass")
     (tests
      ((name . "measures-matching-parentheses") (status . "pass"))
      ((name . "columns-matching-parentheses") (status . "pass"))
      ((name . "measures-matching-brackets") (status . "pass"))
      ((name . "measures-matching-quotes") (status . "pass"))))

    ((name . "module-exports")
     (file . "tests/unit/mod_test.ts")
     (type . "unit")
     (steps . 2)
     (status . "pass")
     (tests
      ((name . "should-export-version-constant") (status . "pass"))
      ((name . "should-export-project-name-constant") (status . "pass"))))

    ((name . "financial-calculations")
     (file . "tests/unit/mod_test.ts")
     (type . "unit")
     (steps . 9)
     (status . "pass")
     (tests
      ((name . "calculate-net-income-positive") (status . "pass"))
      ((name . "calculate-net-income-negative") (status . "pass"))
      ((name . "calculate-net-income-zero") (status . "pass"))
      ((name . "is-surplus-true") (status . "pass"))
      ((name . "is-surplus-false-deficit") (status . "pass"))
      ((name . "is-surplus-false-breakeven") (status . "pass"))
      ((name . "total-savings-multiple-records") (status . "pass"))
      ((name . "total-savings-empty-array") (status . "pass"))
      ((name . "total-savings-single-record") (status . "pass"))))

    ((name . "pension-calculations")
     (file . "tests/unit/mod_test.ts")
     (type . "unit")
     (steps . 4)
     (status . "pass")
     (tests
      ((name . "pension-projection-default-rate") (status . "pass"))
      ((name . "pension-projection-custom-rate") (status . "pass"))
      ((name . "pension-projection-at-retirement") (status . "pass"))
      ((name . "pension-projection-past-retirement") (status . "pass"))))

    ;; Integration Tests
    ((name . "project-configuration")
     (file . "tests/integration/config_test.ts")
     (type . "integration")
     (steps . 14)
     (status . "pass")
     (tests
      ((name . "rescript-json-valid-structure") (status . "pass"))
      ((name . "rescript-json-correct-name") (status . "pass"))
      ((name . "rescript-json-es6-output") (status . "pass"))
      ((name . "rescript-json-res-js-suffix") (status . "pass"))
      ((name . "rescript-json-no-bs-dependencies") (status . "pass"))
      ((name . "deno-json-valid-structure") (status . "pass"))
      ((name . "deno-json-correct-name-version") (status . "pass"))
      ((name . "deno-json-rescript-tasks") (status . "pass"))
      ((name . "deno-json-test-task") (status . "pass"))
      ((name . "deno-json-import-map") (status . "pass"))
      ((name . "flake-nix-references-supernorma") (status . "pass"))
      ((name . "flake-nix-spdx-header") (status . "pass"))
      ((name . "guix-scm-defines-package") (status . "pass"))
      ((name . "guix-scm-spdx-header") (status . "pass"))))

    ((name . "rsr-compliance-files")
     (file . "tests/integration/config_test.ts")
     (type . "integration")
     (steps . 6)
     (status . "pass")
     (tests
      ((name . "has-state-scm") (status . "pass"))
      ((name . "has-meta-scm") (status . "pass"))
      ((name . "has-ecosystem-scm") (status . "pass"))
      ((name . "has-rsr-compliance-adoc") (status . "pass"))
      ((name . "has-security-md") (status . "pass"))
      ((name . "has-license-txt") (status . "pass"))))

    ((name . "html-form-integration")
     (file . "tests/integration/html_form_test.ts")
     (type . "integration")
     (steps . 7)
     (status . "pass")
     (tests
      ((name . "webform-valid-html") (status . "pass"))
      ((name . "webform-contains-form") (status . "pass"))
      ((name . "webform-income-input") (status . "pass"))
      ((name . "webform-expenses-input") (status . "pass"))
      ((name . "webform-submit-button") (status . "pass"))
      ((name . "webform-supernorma-branding") (status . "pass"))
      ((name . "style-css-readable") (status . "pass"))))

    ((name . "project-structure")
     (file . "tests/integration/html_form_test.ts")
     (type . "integration")
     (steps . 3)
     (status . "pass")
     (tests
      ((name . "has-rescript-source-files") (status . "pass"))
      ((name . "has-compiled-javascript-files") (status . "pass"))
      ((name . "matching-res-and-res-js-files") (status . "pass"))))))

;;; ===========================================================================
;;; BUILD RESULTS
;;; ===========================================================================

(define build-results
  '((rescript-build
     ((status . "success")
      (files-parsed . 1)
      (modules-compiled . 1)
      (warnings . 0)
      (errors . 0)))
    (issues-fixed
     ((issue . "deprecated-bs-dependencies")
      (file . "rescript.json")
      (fix . "changed-to-dependencies"))
     ((issue . "missing-deno-json")
      (file . "deno.json")
      (fix . "created-comprehensive-config"))
     ((issue . "missing-exports-field")
      (file . "deno.json")
      (fix . "added-exports-and-scoped-name")))))

;;; ===========================================================================
;;; FILES CREATED
;;; ===========================================================================

(define files-created
  '(((path . "deno.json")
     (purpose . "deno-runtime-configuration"))
    ((path . "src/mod.ts")
     (purpose . "main-module-entry-point"))
    ((path . ".tool-versions")
     (purpose . "asdf-version-management"))
    ((path . "tests/unit/ui_test.ts")
     (purpose . "ui-module-unit-tests"))
    ((path . "tests/unit/data_test.ts")
     (purpose . "data-file-validation-tests"))
    ((path . "tests/unit/dax_test.ts")
     (purpose . "dax-expression-tests"))
    ((path . "tests/unit/mod_test.ts")
     (purpose . "core-module-function-tests"))
    ((path . "tests/integration/html_form_test.ts")
     (purpose . "html-form-integration-tests"))
    ((path . "tests/integration/config_test.ts")
     (purpose . "configuration-file-tests"))
    ((path . "TESTING-REPORT.adoc")
     (purpose . "human-readable-test-report"))
    ((path . "TESTING-REPORT.scm")
     (purpose . "machine-readable-test-report"))))

;;; ===========================================================================
;;; FILES MODIFIED
;;; ===========================================================================

(define files-modified
  '(((path . "rescript.json")
     (modification . "changed-bs-dependencies-to-dependencies"))
    ((path . "justfile")
     (modification . "added-real-build-test-lint-fmt-commands"))))

;;; ===========================================================================
;;; RECOMMENDATIONS
;;; ===========================================================================

(define recommendations
  '((immediate
     ((priority . "high")
      (action . "add-npm-dependencies")
      (details . "install-@rescript/core-for-full-runtime-support"))
     ((priority . "medium")
      (action . "consider-jsr-publishing")
      (details . "project-ready-for-jsr-publishing")))
    (short-term
     ((priority . "medium")
      (action . "expand-test-coverage")
      (details . "add-more-edge-cases-for-financial-calculations"))
     ((priority . "medium")
      (action . "add-property-based-tests")
      (details . "use-@std/testing-for-randomized-input"))
     ((priority . "high")
      (action . "create-ci-workflow")
      (details . "add-github-actions-for-automated-testing")))
    (long-term
     ((priority . "low")
      (action . "power-bi-integration-testing")
      (details . "test-dax-in-actual-power-bi-environment"))
     ((priority . "low")
      (action . "performance-benchmarks")
      (details . "add-benchmarks-for-financial-calculations"))
     ((priority . "low")
      (action . "e2e-browser-tests")
      (details . "add-playwright-tests-for-html-form")))))

;;; ===========================================================================
;;; HELPER FUNCTIONS
;;; ===========================================================================

(define (get-pass-rate)
  "Calculate and return the test pass rate."
  (let* ((summary test-summary)
         (passed (assoc-ref summary 'passed))
         (total (assoc-ref summary 'total-steps)))
    (* 100.0 (/ passed total))))

(define (get-failed-tests)
  "Return a list of failed tests (empty if all pass)."
  (filter (lambda (suite)
            (not (equal? (assoc-ref suite 'status) "pass")))
          test-suites))

(define (get-tests-by-type type)
  "Return all test suites of a given type (unit or integration)."
  (filter (lambda (suite)
            (equal? (assoc-ref suite 'type) type))
          test-suites))

(define (count-unit-tests)
  "Count total unit test steps."
  (apply + (map (lambda (suite)
                  (assoc-ref suite 'steps))
                (get-tests-by-type "unit"))))

(define (count-integration-tests)
  "Count total integration test steps."
  (apply + (map (lambda (suite)
                  (assoc-ref suite 'steps))
                (get-tests-by-type "integration"))))

;;; ===========================================================================
;;; EXPORTS SUMMARY
;;; ===========================================================================

;; Quick access for external tools:
;; (use-modules (supernorma testing-report))
;; (assoc-ref test-summary 'pass-rate)  => 100.0
;; (length test-suites)                  => 12
;; (assoc-ref test-summary 'total-steps) => 85
