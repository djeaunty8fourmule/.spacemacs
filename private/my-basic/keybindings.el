(evil-global-set-key 'normal (kbd "\C-cl") 'org-store-link)
(evil-global-set-key 'normal (kbd ">") 'goto-delimiter-forward)
(evil-global-set-key 'visual (kbd ">") 'goto-delimiter-forward)
(evil-global-set-key 'operator (kbd ">") 'goto-delimiter-forward)
(evil-global-set-key 'normal (kbd "H") 'goto-delimiter-backward-stop)
(evil-global-set-key 'visual (kbd "H") 'goto-delimiter-backward-stop)
(evil-global-set-key 'operator (kbd "H") 'goto-delimiter-backward-stop)
(evil-global-set-key 'normal (kbd "<") 'goto-delimiter-backward)
(evil-global-set-key 'visual (kbd "<") 'goto-delimiter-backward)
(evil-global-set-key 'operator (kbd "<") 'goto-delimiter-backward)
(evil-global-set-key 'visual (kbd "{")
                     '(lambda nil
                        (interactive)
                        (progn (call-interactively (quote evil-shift-left))
                               (execute-kbd-macro "gv"))))
(evil-global-set-key 'visual (kbd "}")
                     '(lambda nil
                        (interactive)
                        (progn (call-interactively (quote evil-shift-right))
                               (execute-kbd-macro "gv"))))
(evil-define-key 'normal evil-matchit-mode-map "M" 'evilmi-jump-items)
(evil-define-key 'visual evil-matchit-mode-map "M" 'evilmi-jump-items)
(evil-define-key 'operator evil-matchit-mode-map "M" 'evilmi-jump-items)
(evil-define-key 'normal flymake-diagnostics-buffer-mode-map (kbd "RET")
  '(lambda ()
     (interactive)
     (beginning-of-line)
     (forward-char 20)
     (flymake-goto-diagnostic (point))))
(evil-define-key 'normal 'global "L" "y$")
(evil-define-key 'normal 'global ":" 'eval-expression)

;; (with-eval-after-loaefine-key eww-mode-map "z" 'evil-scroll-line-to-center)
;;                       )
(with-eval-after-load 'evil-evilified-state
  (define-key evil-evilified-state-map ":" 'eval-expression)
  (define-key evil-evilified-state-map "zz" 'evil-scroll-line-to-center))


(with-eval-after-load 'eglot (spacemacs/set-leader-keys "," '(lambda ()
                                                               (interactive)
                                                               (let ((buffer (current-buffer)))
                                                                 (eglot-help-at-point)
                                                                 (switch-to-buffer buffer)))))
(spacemacs/set-leader-keys "ec" 'eshell-copy-last-command-output)
(spacemacs/set-leader-keys "o" 'helm-multi-swoop-org)
(spacemacs/set-leader-keys "ao" 'org-agenda)
(spacemacs/set-leader-keys "sgp" 'helm-projectile-rg)
(spacemacs/set-leader-keys "r/" 'spacemacs/helm-dir-do-ag)
(spacemacs/set-leader-keys "r?" 'helm-do-ag)
(spacemacs/set-leader-keys "io" 'org-insert-heading)
(spacemacs/set-leader-keys ":" 'evil-ex)
(spacemacs/set-leader-keys "ee" 'switch-to-eshell)
(spacemacs/set-leader-keys "ys" 'describe-variable-and-kill-value)
(spacemacs/set-leader-keys "yc" '(lambda ()
                                   (interactive)
                                   (kill-new (pwd))))
(spacemacs/set-leader-keys "." 'lazy-helm/helm-mini)
(spacemacs/set-leader-keys "bb" '(lambda ()
                                   (interactive)
                                   (ido-mode 1)
                                   (ido-switch-buffer)))
(spacemacs/set-leader-keys "ff" '(lambda ()
                                   (interactive)
                                   (ido-mode 1)
                                   (ido-find-file)))
(spacemacs/set-leader-keys "dd" 'flymake-goto-purposed-window)
(spacemacs/set-leader-keys "ss" 'helm-swoop)
(spacemacs/set-leader-keys "s\\" 'helm-occur)
(spacemacs/set-leader-keys "pn" 'export-notes-to-html)
(spacemacs/set-leader-keys "rg" '(lambda ()
                                   (interactive)
                                   (git-gutter-mode -1)
                                   (git-gutter-mode 1)))
(spacemacs/set-leader-keys "ef" '(lambda ()
                                   (interactive)
                                   (elisp-format-file buffer-file-name)
                                   (delete-trailing-whitespace)))
(spacemacs/set-leader-keys "[" '(lambda ()
                                  (interactive)
                                  (evil--jumps-jump 0 0)))

(spacemacs/set-leader-keys "=" 'spacemacs/scale-transparency-transient-state/body)
(spacemacs/set-leader-keys "dl" '(lambda ()
                                   (interactive)
                                   (delete-window (get-buffer-window "*tex-shell*"))))
(spacemacs/set-leader-keys "e<" 'eww-back-url)
(spacemacs/set-leader-keys "e>" 'eww-forward-url)
(spacemacs/set-leader-keys "s?" '(lambda ()
                                   (interactive)
                                   (let ((browse-url-browser-function 'eww-browse-url))
                                     (call-interactively 'browse-url))))
(spacemacs/set-leader-keys "s/" '(lambda ()
                                   (interactive)
                                   (call-interactively 'browse-url)))
(spacemacs/set-leader-keys "s]" '(lambda ()
                                   (interactive)
                                   (persp-save-state-to-file "~/.emacs.d/.cache/layouts/persp-my-layout")))
(spacemacs/set-leader-keys "s[" '(lambda ()
                                   (interactive)
                                   (persp-load-state-from-file "~/.emacs.d/.cache/layouts/persp-my-layout")))


(defcustom helm-ag-always-set-extra-option nil
  "Always set `ag' options of `helm-do-ag'."
  :type 'boolean)

(spacemacs|add-toggle helm-ag-extra-args
      :status helm-ag-always-set-extra-option
            :on (setq helm-ag-always-set-extra-option t)
            :off (setq helm-ag-always-set-extra-option nil)
            :documentation "toggle extra options for helm-ag (rg or the like)"
            :on-message "extra options for helm-ag: ON"
            :off-message "extra options for helm-ag: OFF"
            :evil-leader "t/")
(spacemacs/set-leader-keys "ek" 'kill-eww-buffers)
(spacemacs/set-leader-keys "bk" '(lambda ()
                                   (interactive)
                                   (spacemacs/kill-matching-buffers-rudely ".*[^o][^r][^g]$")))

(spacemacs/set-leader-keys "b/" #'(lambda (arg)
                                    (interactive "P")
                                    (with-persp-buffer-list () (ibuffer arg))))
(global-set-key (kbd "\C-x\C-b") 'ibuffer)
(spacemacs/set-leader-keys "f/" 'helm-find)
(spacemacs/set-leader-keys "sv" 'split-visual-region)
(global-unset-key (kbd "M-l"))
(global-unset-key (kbd "M-;"))

(global-set-key (kbd "M-; a") 'custom-layout1)
(global-set-key (kbd "M-; b") 'custom-layout2)
(global-set-key (kbd "C-r") 'backward-delete-char)

(global-set-key (kbd "\C-x.") 'helm-eshell-history)
(global-set-key (kbd "\C-x.") 'helm-eshell-history)
(global-set-key (kbd "\C-x?") 'helm-complex-command-history)
(global-set-key (kbd "\C-x,")
                '(lambda ()
                   (interactive)
                   (command-history)
                   (lisp-interaction-mode)
                   (read-only-mode)))
(global-set-key (kbd "\C-xg") 'magit-status)

(global-set-key (kbd "C-M-n") 'evil-jump-forward)
(global-set-key (kbd "C-o") 'evil-jump-backward)

(global-set-key (kbd "C-M-]") 'company-complete)
(global-set-key (kbd "M-\\") 'xref-find-definitions)
(global-set-key (kbd "M-[") 'xref-pop-marker-stack)
(global-set-key (kbd "\C-c4") 'xref-find-definitions-other-window)
(global-set-key (kbd "\C-x]") 'ace-window)
(global-set-key (kbd "M-j") 'evil-window-down)
(global-set-key (kbd "M-k") 'evil-window-up)
(global-set-key (kbd "M-h") 'evil-window-left)
(global-set-key (kbd "M-l") 'evil-window-right)

(global-set-key (kbd "M-DEL") 'shell-command)
(define-key dired-mode-map (kbd "M-DEL") 'shell-command)

(define-key dired-mode-map (kbd "C-j")
  '(lambda ()
     (interactive)
     (async-start-process "xdg-open" "xdg-open" nil (dired-get-file-for-visit))))

(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-c o") #'yas-expand)
(define-key yas-minor-mode-map (kbd "M-'") #'yas-next-field)


