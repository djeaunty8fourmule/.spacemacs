;;; packages.el --- my-basic layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: sj <sysmanj@sysmanj-a>
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
;; added to `basic-my-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `basic-my/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `basic-my/pre-init-PACKAGE' and/or
;;   `basic-my/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-basic-packages
  '(key-chord ggtags ace-jump-mode helm helm-elisp evil-goggles helm-dash org-alert
              wordnut dictionary helm-rg engine-mode)


  ;; My incsearched setup worked seamlessly good:
  ;; helm-swoop-20180215.1154
  ;; helm-core-20190712.1716
  ;; ace-isearch-20190630.1552
  ;; ace-jump-mode-20140616.815
  "The list of Lisp packages required by the basic-my layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      Theher-window following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

;;; packages.el ends here
(defun my-basic/init-key-chord ()
  (use-package
    key-chord
    :ensure t
    :config (key-chord-mode 1)
    (key-chord-define evil-normal-state-map "gh" 'ace-jump-char-mode)
    (key-chord-define evil-normal-state-map "gl" 'ace-jump-line-mode)
    (key-chord-define evil-normal-state-map "gk" 'ace-jump-word-mode)
    (key-chord-define-global "UU" 'undo-tree-visualize)
    (key-chord-define-global "yy" 'helm-show-kill-ring)))

(defun my-basic/post-init-ggtags ()
  (add-hook 'ggtags-mode-hook '(lambda ()
                                 (evil-global-set-key 'normal (kbd "M-.") 'helm-gtags-dwim)
                                 (evil-global-set-key 'insert (kbd "M-.") 'helm-gtags-dwim)
                                 (evil-global-set-key 'normal (kbd "M-]")
                                                      'helm-gtags-dwim-other-window)
                                 (evil-global-set-key 'insert (kbd "M-]")
                                                      'helm-gtags-dwim-other-window)))
  (setq gtags-enable-by-default nil))



(defun my-basic/init-ace-jump-mode ()
  (use-package
    ace-jump-mode
    :defer t
    :ensure t))


(defun my-basic/post-init-helm ()
  (define-key helm-map (kbd "C-l") 'kill-backward-until-sep))

(defun my-basic/init-evil-goggles ()
  (use-package
    evil-goggles
    :ensure t
    :config (progn (evil-goggles-mode)
                   ;; (evil-goggles-use-diff-faces)
                   (setq evil-goggles-duration 0.3)
                   (setq evil-goggles-async-duration 1.2))


    ;; optionally use diff-mode's faces; as a result, deleted text
    ;; will be highlighed with `diff-removed` face which is typically
    ;; some red color (as defined by the color theme)
    ;; other faces such as `diff-added` will be used for other actions
    ))

(defun my-basic/init-helm-dash ()
  (use-package
    helm-dash
    :commands (helm-dash helm-dash-at-point)
    :defer t
    :init (progn
            (defun toggle-helm-dash-search-function ()
              (interactive)
              (if (equal helm-dash-browser-func 'eww)
                  (progn (message "setting helm-dash browser to BROWSER")
                         (setq helm-dash-browser-func 'browse-url))
                (message "setting helm-dash browser to EWW")
                (setq helm-dash-browser-func 'eww)))
            (spacemacs/set-leader-keys "dh" 'helm-dash)
            (spacemacs/set-leader-keys "dp" 'helm-dash-at-point)
            (spacemacs/set-leader-keys "dt" 'toggle-helm-dash-search-function))
    :config (progn
              (setq dash-docs-common-docsets '("LaTeX" "C" "Gradle DSL" "Gradle Java API"
                                               "Gradle Groovy API" "Gradle User Guide"
                                               "Android Gradle Plugin" "Python 3" "Android" "kotlin"
                                               "Java"))
              (defun dash-docs-read-json-from-url (url)
                (shell-command (concat "curl -s " url) "*helm-dash-download*")
                (with-current-buffer "*helm-dash-download*" (json-read))))))

(defun my-basic/init-org-alert ()
  (use-package
    org-alert
    :ensure t
    :config (progn (org-alert-enable)
                   (setq alert-default-style 'libnotify))))
(defun my-basic/init-wordnut ()
  (use-package
    wordnut
    :defer t
    :commands (wordnut-search wordnut-lookup-current-word)
    :init (progn (if (equal 0 (call-process "which" nil '("*Shell Command Output*" t) nil
                                            "wordnet")) nil (progn (message "installing wordnet...")
                                                                   (if (equal 0 (call-process "sudo"
                                                                                              nil
                                                                                              '("*Shell
 Command Output*" t) nil "apt-get" "-y" "install" "wordnet"))
                                                                       (progn (message
                                                                               "wordnet installed successfully!")
                                                                              (shell-command
                                                                               "rm /tmp/impossible-flag-name"))
                                                                     (progn
                                                                       (error
                                                                        "wordnet installation : `%s'"
                                                                        "ERROR")
                                                                       (shell-command
                                                                        "touch /tmp/impossible-flag-name"))))))
    :config (if (equal 0 (call-process "ls" nil '("*Shell
 Command Output*" t) nil "/tmp/impossible-flag-name"))
                (defun wordnut-search ()
                  (interactive)
                  (error
                   "please install `%s' package or run emacs with sudo"
                   "wordnet"))
              (message "configured wordnut"))))

(defun my-basic/init-dictionary ()
  (use-package
    dictionary
    :defer t
    :commands (dictionary-search)))
(defun my-basic/init-helm-rg ()
  (use-package
    dictionary
    :defer t
    :commands (helm-rg)))
(defun my-basic/pre-init-engine-mode ()
  (spacemacs|use-package-add-hook engine-mode
    :pre-init
    ;; Code
    (setq search-engine-config-list '((emacs-stack-exchange :name "emacs stack exchange"
                                                            :url
                                                            "https://emacs.stackexchange.com/search?q=%s")))))
(defun my-basic/post-init-helm-elisp ()
  (setq helm-source-complex-command-history (helm-build-sync-source "Complex Command History"
                                              :candidates (lambda ()
                                                            ;; Use cdr to avoid adding
                                                            ;; `helm-complex-command-history' here.
                                                            (cl-loop for i in command-history unless
                                                                     (equal i
                                                                            '(helm-complex-command-history))
                                                                     collect (prin1-to-string i)))
                                              :action (helm-make-actions "Eval" (lambda (candidate)
                                                                                  (and (boundp
                                                                                        'helm-sexp--last-sexp)
                                                                                       (setq
                                                                                        helm-sexp--last-sexp
                                                                                        candidate))
                                                                                  (let ((command
                                                                                         (read
                                                                                          candidate)))
                                                                                    (unless (equal
                                                                                             command
                                                                                             (car
                                                                                              command-history))
                                                                                      (setq
                                                                                       command-history
                                                                                       (cons command
                                                                                             command-history))))
                                                                                  (run-with-timer
                                                                                   0.1 nil
                                                                                   #'helm-sexp-eval
                                                                                   candidate))
                                                                         "Edit and eval" (lambda
                                                                                           (candidate)
                                                                                           (edit-and-eval-command
                                                                                            "Eval: "
                                                                                            (read
                                                                                             candidate)))
                                                                         "insert" (lambda
                                                                                    (candidate)
                                                                                    (insert
                                                                                     candidate)))
                                              :persistent-action #'helm-sexp-eval
                                              :multiline t)))