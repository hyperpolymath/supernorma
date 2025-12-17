;; SuperNorma - Guix Package Definition
;; Run: guix shell -D -f guix.scm

(use-modules (guix packages)
             (guix gexp)
             (guix git-download)
             (guix build-system gnu)
             ((guix licenses) #:prefix license:)
             (gnu packages base))

;; SPDX-License-Identifier: MIT OR AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

(define-public supernorma
  (package
    (name "SuperNorma")
    (version "0.1.0")
    (source (local-file "." "SuperNorma-checkout"
                        #:recursive? #t
                        #:select? (git-predicate ".")))
    (build-system gnu-build-system)
    (synopsis "Guix channel/infrastructure")
    (description "Guix channel/infrastructure - part of the RSR ecosystem.")
    (home-page "https://github.com/hyperpolymath/SuperNorma")
    ;; Dual licensed: MIT OR AGPL-3.0-or-later (user's choice)
    (license (list license:expat license:agpl3+))))

;; Return package for guix shell
supernorma
