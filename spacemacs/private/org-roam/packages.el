;;; packages.el --- org-roam layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Xiankun Cheng <xiankuncheng@Xiankun-C02CD3ARMD6R>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `org-roam-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `org-roam/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `org-roam/pre-init-PACKAGE' and/or
;;   `org-roam/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst org-roam-packages
  '(org-roam))

(defun org-roam/init-org-roam ()
  (use-package org-roam
    :after org
    :hook
    ((org-mode . org-roam-mode)
     (after-init . org-roam--build-cache-async) ;; optional!
     )
    :custom
    (org-roam-directory "~/Dropbox/org/roam/")
    :init
    (progn
      (spacemacs/declare-prefix "ar" "org-roam")
      (spacemacs/set-leader-keys
        "arl" 'org-roam
        "art" 'org-roam-dailies-today
        "arf" 'org-roam-find-file
        "ari" 'org-roam-insert
        "arc" 'org-roam-capture
        "arg" 'org-roam-show-graph)
      (spacemacs/declare-prefix-for-mode 'org-mode "mr" "org-roam")
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "rl" 'org-roam
        "rt" 'org-roam-dailies-today
        "rf" 'org-roam-find-file
        "ri" 'org-roam-insert
        "rc" 'org-roam-capture
        "rg" 'org-roam-show-graph)
      )))

;;; packages.el ends here
