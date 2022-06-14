;;; $DOOMDIR/+keys.el -*- lexical-binding: t; -*-

;; Key bindings
(map!
 (:n  "g'"  #'evil-surround-edit)
 (:n  "g("  #'sp-wrap-round)
 (:n  "g)"  #'sp-splice-sexp)
 (:n  "g["  #'sp-wrap-square)
 (:n  "g{"  #'sp-wrap-curly)
 (:n  "gl"  #'goto-line)
 (:n  "gm"  #'er/expand-region)
 (:n  "gzs" #'evil-mc-skip-and-goto-next-match)

 (:map evil-insert-state-map
        :desc "Next corfu candidate" "C-j" #'corfu-next
        :desc "Previous corfu candidate" "C-k" #'corfu-previous)

 (:map lsp-ui-peek-mode-map
        :desc "Toggle file" "H" #'lsp-ui-peek--toggle-file)


 (:localleader
  :map org-agenda-mode-map
  "o" #'org-agenda-open-link)

 (:localleader
  :map css-mode-map
  "rf" #'tide-rename-file)


 (:localleader
  :map typescript-mode-map
  "j"  #'jest-popup
  "l"  #'insert-console-log)

 (:localleader
  :map web-mode-map
  "j"  #'jest-popup
  "l"  #'insert-console-log)

 (:localleader
  :map js2-mode-map
  "l"  #'insert-console-log)

 (:localleader
  :after tide
  :map tide-mode-map
  "j"  #'jest-popup
  "c"  #'tide-do-cleanups
  "l"  #'insert-console-log
  "ro" nil
  "rr" nil
  "f"  nil
  "f"  #'tide-fix
  "F"  #'tide-refactor
  "o"  #'tide-organize-imports
  "rf" #'tide-rename-file
  "rs" #'tide-rename-symbol
  "s"  #'tide-project-errors)

 (:leader
  (:prefix-map ("d" . "dired")
        :desc "Ranger" "r" #'ranger
        :desc "Create empty file" "f" #'dired-create-empty-file
        :desc "Deer" "d" #'deer)

  (:prefix-map ("c" . "code")
        :desc "Lsp peek find implementation" "i" #'lsp-ui-peek-find-implementation
        :desc "Xref go back" "b" #'xref-go-back)

  (:prefix-map ("I" . "indent")
       :desc "Indent rigidly" :n "i" #'indent-rigidly
       :desc "Indent region"  :n "r" #'indent-region)

  (:prefix-map ("r" . "random")
      (:prefix-map ("N" . "name")
           :desc "Full name"  :n "n" #'random-fullname
           :desc "First name" :n "f" #'random-firstname
           :desc "Last name"  :n "l" #'random-lastname)
       :desc "Email"  :n "e" #'random-email
       :desc "Number" :n "n" #'random-number
       :desc "Guid"   :n "g" #'random-guid
       :desc "Date"   :n "d" #'random-date
       :desc "Url"    :n "u" #'random-url)

 (:desc "open" :prefix "o"
       :desc "Open treemacs"  :n "p" #'treemacs)

 (:desc "toggle" :prefix "t"
       :desc "Toggle git-timemachine"  :n "t" #'git-timemachine-toggle)

 (:desc "git"    :prefix "g"
       :desc "Magit-ediff"          :n "e" #'magit-ediff
       :desc "Magit-diff-range"     :n "r" #'magit-diff-range
       :desc "History"              :n "h" #'magit-log-buffer-file
       :desc "Show Commit"          :n "v" #'vc-msg-show)))

;; Line break on Enter
(define-key evil-normal-state-map (kbd "RET")
  (lambda ()
    (interactive)
    (call-interactively 'end-of-line)
    (call-interactively 'newline-and-indent)))

;; (define-key evil-insert-state-map (kbd "C-j") nil)
;; (define-key evil-insert-state-map (kbd "C-k") nil)
