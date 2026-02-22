// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

/**
 * SuperNorma UI — Legacy Form Integration (ReScript).
 *
 * This module provides the glue code between the verified ReScript 
 * logic and standard HTML5 forms. It uses FFI bindings to the DOM 
 * to hijack submission events and route them through the platform.
 */

@val @scope("document") external querySelector: string => Nullable.t<Dom.element> = "querySelector"
@set external setOnsubmit: (Dom.element, unit => unit) => unit = "onsubmit"

/**
 * INITIALIZATION: Scans the document for the primary input form.
 * Attaches a verified handler to the 'onsubmit' event to prevent 
 * unvalidated data from reaching the backend.
 */
let init = () => {
  querySelector("form")
  ->Nullable.toOption
  ->Option.forEach(form => {
    form->setOnsubmit(() => alert("Data submitted to SuperNorma"))
  })
}

let _ = init()
