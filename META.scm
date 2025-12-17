;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;;; META.scm — supernorma

(define-module (supernorma meta)
  #:export (architecture-decisions development-practices design-rationale))

(define architecture-decisions
  '((adr-001
     (title . "RSR Compliance")
     (status . "accepted")
     (date . "2025-12-15")
     (context . "Jonathan D.A. Jewell <jonathan.jewell@gmail.com>")
     (decision . "Follow Rhodium Standard Repository guidelines")
     (consequences . ("RSR Gold target" "SHA-pinned actions" "SPDX headers" "Multi-platform CI")))))

(define development-practices
  '((code-style (languages . ("CSS" "HTML" "Just" "PowerShell" "ReScript" "Scheme")) (formatter . "auto-detect") (linter . "auto-detect"))
    (security (sast . "CodeQL") (credentials . "env vars only"))
    (testing (coverage-minimum . 70))
    (versioning (scheme . "SemVer 2.0.0"))))

(define design-rationale
  '((why-rsr "RSR ensures consistency, security, and maintainability.")))
;; ============================================================================
;; CROSS-PLATFORM STATUS (Added 2025-12-17)
;; ============================================================================

(cross-platform-status
  (generated "2025-12-17")
  (primary-platform "github")
  (gitlab-mirror
    (path "hyperpolymath/extensions/office/SuperNorma")
    (url "https://gitlab.com/hyperpolymath/extensions/office/SuperNorma")
    (last-gitlab-activity "2025-12-16")
    (sync-status "gh-primary")
    (notes "GitHub slightly newer. Safe to sync GH→GL."))
  
  (reconciliation-instructions
    ";; git remote add gitlab https://gitlab.com/hyperpolymath/extensions/office/SuperNorma.git"
    ";; git fetch gitlab && git log gitlab/main --oneline"
    ";; git diff main gitlab/main"
    ";; git merge gitlab/main --allow-unrelated-histories  # if needed")
  
  (action-required "gh-primary"))

