; SPDX-License-Identifier: MPL-2.0
;; guix.scm — GNU Guix package definition for supernorma
;; Usage: guix shell -f guix.scm

(use-modules (guix packages)
             (guix build-system gnu)
             (guix licenses))

(package
  (name "supernorma")
  (version "0.1.0")
  (source #f)
  (build-system gnu-build-system)
  (synopsis "supernorma")
  (description "supernorma — part of the hyperpolymath ecosystem.")
  (home-page "https://github.com/hyperpolymath/supernorma")
  (license mpl2.0))
