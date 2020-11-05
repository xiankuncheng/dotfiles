;;; packages.el --- smart-input-source layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2020 Sylvain Benner & Contributors
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
;; added to `smart-input-source-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `smart-input-source/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `smart-input-source/pre-init-PACKAGE' and/or
;;   `smart-input-source/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst smart-input-source-packages
  '(sis))


(defun smart-input-source/init-sis ()
  (use-package sis
    ;; :hook
    ;; enable the /follow context/ and /inline region/ mode for specific buffers
    ;; (((text-mode prog-mode) . sis-follow-context-mode)
    ;;  ((text-mode prog-mode) . sis-inline-mode))

    :config
    ;; For MacOS
    (sis-ism-lazyman-config

     ;; English input source may be: "ABC", "US" or another one.
     ;; "com.apple.keylayout.ABC"
     "com.apple.keylayout.US"

     ;; Other language input source: "rime", "sogou" or another one.
     ;; "im.rime.inputmethod.Squirrel.Rime"
     "com.sogou.inputmethod.sogou.pinyin")

    ;; enable the /cursor color/ mode
    (sis-global-cursor-color-mode t)
    ;; enable the /respect/ mode
    (sis-global-respect-mode t)
    ;; enable the /follow context/ mode for all buffers
    (sis-global-follow-context-mode t)
    ;; enable the /inline english/ mode for all buffers
    (sis-global-inline-mode t)
    ))


;;; packages.el ends here
