// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
// Form submission handler - vanilla JS bindings
@val @scope("document") external querySelector: string => Nullable.t<Dom.element> = "querySelector"
@set external setOnsubmit: (Dom.element, unit => unit) => unit = "onsubmit"
@val external alert: string => unit = "alert"

let init = () => {
  querySelector("form")
  ->Nullable.toOption
  ->Option.forEach(form => {
    form->setOnsubmit(() => alert("Data submitted to SuperNorma"))
  })
}

let _ = init()
