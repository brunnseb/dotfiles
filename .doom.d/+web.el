;;; $DOOMDIR/+web.el -*- lexical-binding: t; -*-
;; Enable prettier
(add-hook 'js2-mode-hook        #'setup-prettier)
(add-hook 'web-mode-hook        #'setup-prettier)
(add-hook 'typescript-mode-hook #'setup-prettier)
(add-hook 'json-mode-hook       #'setup-prettier)
(add-hook 'css-mode-hook        #'setup-prettier)

(defun setup-prettier()
  (setq prettier-js-args '(
                           "--trailing-comma" "all"
                           "--single-quote" "true"
                           ))
  (rainbow-delimiters-mode)
  (prettier-js-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(after! flycheck
  (setq flycheck-check-syntax-automatically '(save)))

(add-hook! 'typescript-tsx-mode-hook
  ((lambda ()
     (setq-local emmet-expand-jsx-className? t))))
