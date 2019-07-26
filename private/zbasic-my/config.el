(spacemacs|define-jump-handlers kotlin-mode)
(add-hook 'kotlin-mode-hook '(lambda () (lsp nil)))
(add-hook 'kotlin-mode-hook 'ggtags-mode)
;; (add-hook 'kotlin-mode-hook 'periodic-refresh-lsp-kotlin)
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?$ ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?< ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?> ".")))

(setq evil-escape-key-sequence "z[")
(setq purpose-layout-dirs '("/home/sysmanj/Documents/.spacemacs/private/zbasic-my/layouts/"))
;; (custom-layout2)
(advice-add 'server-create-window-system-frame :after '(lambda (&rest args)
                                                         (interactive)
							(set-face-font 'default "-xos4-Terminess Powerline-normal-normal-normal-*-16-*-*-*-c-80-iso10646-1" )))

(with-eval-after-load 'window-purpose
          (custom-layout1))
