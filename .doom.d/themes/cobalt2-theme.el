;;; cobalt2-theme.el --- inspired by cobalt2 -*- no-byte-compile: t; -*
(require 'doom-themes)

(defgroup doom-cobalt2-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-cobalt2-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-cobalt2-theme
  :type 'boolean)

(defcustom doom-cobalt2-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-cobalt2-theme
  :type 'boolean)

(defcustom doom-cobalt2-comment-bg doom-cobalt2-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-cobalt2-theme
  :type 'boolean)

(defcustom doom-cobalt2-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-cobalt2-theme
  :type '(choice integer boolean))

(def-doom-theme cobalt2 "Cobalt2 theme"

  ;; name        default   256       16
  ((bg              '("#21425b" "#21425b" nil))
   (bg-alt          '("#1A3549" "#1A3549" nil))
   (base0           '("#1B2229" "black"   "black"))
   (base1           '("#1c1f24" "#1e1e1e" "brightblack"))
   (base2           '("#202328" "#2e2e2e" "brightblack"))
   (base3           '("#23272e" "#262626" "brightblack"))
   (base4           '("#3f444a" "#3f3f3f" "brightblack"))
   (base5           '("#5B6268" "#525252" "brightblack"))
   (base6           '("#686b78" "#686b78" "brightblack"))
   (base7           '("#9ca0a4" "#979797" "brightblack"))
   (base8           '("#DFDFDF" "#dfdfdf" "white"))
   (fg              '("#E2EFFE" "#E2EFFE" "brightwhite"))
   (fg-alt          '("#5B6268" "#2d2d2d" "white"))
   (grey            base4)
   (red             '("#D45A7E" "#D45A7E" "red"))
   (orange          '("#FF9D03" "#FF9D03" "brightred"))
   (green           '("#97EA88" "#97EA88" "green"))
   (teal            '("#00C8A0" "#00C8A0" "brightgreen"))
   (yellow          '("#FFD701" "#FFD701" "yellow"))
   (blue            '("#0088FF" "#0088FF" "brightblue"))
   (dark-blue       '("#006dcc" "#006dcc" "blue"))
   (magenta         '("#FF6CA4" "#FF6CA4" "brightmagenta"))
   (violet          '("#7F6ABE" "#7F6ABE" "brightmagenta"))
   (cyan            '("#90EBED" "#90EBED" "brightcyan"))
   (dark-cyan       '("#84DCC6" "#84DCC6" "cyan"))

   ;; face categories -- required for all themes
   (highlight      yellow)
   (vertical-bar   (doom-darken base4 0.2))
   (selection      red)
   (builtin        yellow)
   (comments       blue)
   (doc-comments   (doom-lighten blue 0.25))
   (constants      red)
   (functions      cyan)
   (keywords       yellow)
   (methods        cyan)
   (operators      green)
   (type           orange)
   (strings        green)
   (variables      cyan)
   (numbers        red)
   (region         (doom-darken blue 0.45))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-cobalt2-brighter-modeline)
   (-modeline-pad (when doom-cobalt2-padded-modeline (if (integerp doom-cobalt2-padded-modeline)
                                                         doom-cobalt2-padded-modeline 4)))
   (modeline-fg     fg)
   (modeline-fg-alt base5)
   (modeline-bg (if -modeline-bright (doom-darken blue 0.475)
                  `(,(doom-darken (car bg-alt) 0.35)
                    ,@(cdr base0))))
   (modeline-bg-l (if -modeline-bright (doom-darken blue 0.45)
                    `(,(doom-darken (car bg-alt) 0.1)
                      ,@(cdr base0))))
   (modeline-bg-inactive   `(,(doom-darken (car bg) 0.03)
                             ,@(cdr bg-alt)))
   (modeline-bg-inactive-l `(,(car bg-alt)
                             ,@(cdr base1))))


  ;; --- extra faces ------------------------
   (((line-number &override) :foreground base5)
    ((line-number-current-line &override) :foreground fg)

   (font-lock-comment-face :foreground comments
                           :background (if doom-cobalt2-comment-bg (doom-lighten bg 0.05)))
   (mode-line :background modeline-bg
              :foreground modeline-fg
              :box (if -modeline-pad
                       `(:line-width ,-modeline-pad
                         :color ,modeline-bg)))
   (mode-line-inactive :background modeline-bg-inactive
                       :foreground modeline-fg-alt
                       :box (if -modeline-pad
                                `(:line-width ,-modeline-pad
                                  :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))
   (solaire-mode-line-face :inherit 'mode-line
                           :background modeline-bg-l
                           :box (if -modeline-pad
                                    `(:line-width ,-modeline-pad
                                      :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face :inherit 'mode-line-inactive
                                    :background modeline-bg-inactive-l
                                    :box (if -modeline-pad
                                             `(:line-width ,-modeline-pad
                                               :color ,modeline-bg-inactive-l)))

   ;; Doom modeline
   (doom-modeline-bar               :background (if -modeline-bright modeline-bg highlight))
   (doom-modeline-buffer-file       :foreground yellow
                                    :weight 'bold)
   (doom-modeline-buffer-path       :inherit 'mode-line-emphasis
                                    :weight 'bold)
   (doom-modeline-buffer-modified   :foreground magenta
                                    :slant 'italic
                                    :weight 'bold)
   (doom-modeline-buffer-major-mode :foreground orange :weight 'bold)
   (doom-modeline-project-dir       :foreground blue
                                    :weight 'bold)
   (doom-modeline-evil-insert-state :foreground yellow)
   (doom-modeline-evil-normal-state :foreground teal)
   (doom-modeline-evil-visual-state :foreground blue)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property           :foreground magenta)
   (css-property                       :foreground teal)
   (css-selector                       :foreground blue)

   ;; LaTeX-mode
   (font-latex-math-face               :foreground green)

   ;; js/rjsx/web
   (js2-function-call                  :foreground yellow)
   (js2-function-param                 :foreground blue)
   (js2-warning                        :underline `(:style wave
                                                    :color ,yellow))
   (js2-error                          :underline `(:style wave
                                                    :color ,red))
   (js2-external-variable              :underline `(:style wave
                                                    :color ,blue))
   (js2-jsdoc-tag                      :background nil
                                       :foreground red)
   (js2-jsdoc-type                     :background nil
                                       :foreground orange)
   (js2-jsdoc-value                    :background nil
                                       :foreground blue)
   (js2-private-member                 :background nil
                                       :foreground orange)
   (js2-object-property                :foreground cyan)
   (rjsx-tag                           :foreground teal
                                       :slant 'italic
                                       :weight 'bold)
   (rjsx-attr                          :foreground cyan)
   (rjsx-tag-bracket-face              :foreground magenta)
   ;; web-mode
   (web-mode-html-tag-face             :foreground teal
                                       :slant 'italic
                                       :weight 'bold)
   (web-mode-html-tag-bracket-face     :foreground magenta)
   (web-mode-html-attr-name-face       :foreground yellow)
   (web-mode-html-attr-value-face      :foreground fg)
   (web-mode-function-call-face        :foreground orange)
   (web-mode-css-selector-face         :foreground blue)
   (web-mode-css-property-name-face    :foreground teal)
   ;; ivy
   (ivy-current-match                  :background base2
                                       :foreground magenta)
   (ivy-posframe-cursor                :background red
                                       :foreground base0)

   ;; markdown-mode
   (markdown-markup-face               :foreground base5)
   (markdown-header-face               :inherit 'bold
                                       :foreground red)
   ((markdown-code-face &override)     :background (doom-lighten base3 0.05))
   (markdown-list-face                 :foreground green)
   (markdown-pre-face                  :foreground blue)
   (markdown-blockquote-face           :inherit 'italic
                                       :foreground blue)
   (markdown-link-face                 :inherit 'bold
                                       :foreground blue)
   (markdown-header-face-1             :weight 'bold
                                       :foreground magenta)
   (markdown-header-face-2             :weight 'bold
                                       :foreground cyan)
   (markdown-header-face-3             :weight 'bold
                                       :foreground orange)
   (markdown-header-face-4             :weight 'bold
                                       :foreground teal)
   (markdown-header-face-5             :weight 'bold
                                       :foreground magenta)
   (markdown-header-face-6             :weight 'bold
                                       :foreground cyan)
   ;; org-mode
   (org-hide                           :foreground hidden)
   (solaire-org-hide-face              :foreground hidden)
   (org-level-1                        :foreground blue    :weight 'bold :height 1.75)
   (org-level-2                        :foreground teal    :weight 'bold :height 1.5)
   (org-level-3                        :foreground magenta :weight 'bold :height 1.25)
   (org-level-4                        :foreground orange  :weight 'bold :height 1.1)
   (org-level-5                        :foreground cyan    :weight 'bold)
   (org-level-6                        :foreground blue    :weight 'bold)
   (org-level-7                        :foreground teal    :weight 'bold)
   (org-level-8                        :foreground magenta :weight 'bold)
   (org-list-dt                        :foreground magenta)
   (org-link                           :foreground dark-blue :underline t)
   (org-document-title                 :foreground yellow  :weight 'bold :height 2.0 :underline nil)
   (org-document-info-keyword          :foreground comments)
   (org-meta-line                      :foreground base6)
   (org-tag                            :foreground base6
                                       :weight 'normal)
   (org-block                          :background grey
                                       :extend t)
   (org-code                           :foreground yellow)

   ;; corfu
   ;; (corfu-background                   :inherit 'tooltip)
   (corfu-current                      :background red :foreground fg)
   (corfu-annotations                  :foreground violet)
   (corfu-default                      :background bg-alt)

   ;; orderless
   (orderless-match-face-0             :foreground yellow)
   (orderless-match-face-1             :foreground blue)
   (orderless-match-face-2             :foreground red)
   (orderless-match-face-3             :foreground teal)

   ;; treemacs
   (treemacs-git-untracked-face        :foreground green)
   (treemacs-git-modified-face         :foreground yellow)
   (treemacs-git-added-face            :foreground teal)
   (treemacs-root-face                 :inherit 'variable-pitch
                                       :foreground yellow
                                       :weight 'bold
                                       :height 1.3)

   ;;magit
   (magit-section-heading             :foreground yellow)
   (magit-branch-local                :foreground teal)
   (magit-branch-current              :foreground magenta)
   (magit-branch-remote               :foreground yellow)
   (magit-hash                        :foreground teal)
   (magit-filename                    :foreground teal)
   (magit-diff-hunk-heading-highlight :foreground bg :background (doom-darken blue 0.2))
   (magit-diff-hunk-heading           :foreground (doom-darken blue 0.2))
   (magit-blame-name                  :foreground (doom-lighten blue 0.5))
   (magit-blame-heading               :foreground (doom-lighten yellow 0.5)  :background base2)
   (magit-blame-date                  :foreground (doom-lighten teal 0.5))
   (magit-blame-margin                :foreground (doom-lighten blue 0.3))
   (magit-blame-dimmed                :foreground (doom-lighten yellow 0.3))

   ;; which-key
   (which-key-command-description-face :foreground blue)
   (which-key-separator-face           :foreground dark-blue)
   (which-key-group-description-face   :foreground teal)
   (which-key-key-face                 :foreground yellow)

   ;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face    :foreground yellow)
   (rainbow-delimiters-depth-2-face    :foreground blue)
   (rainbow-delimiters-depth-3-face    :foreground red)
   (rainbow-delimiters-depth-4-face    :foreground cyan)
   (rainbow-delimiters-depth-5-face    :foreground orange)
   (rainbow-delimiters-depth-6-face    :foreground green)
   (rainbow-delimiters-depth-7-face    :foreground magenta))
  ;; --- extra variables ---------------------
  ())

;;; doom-cobalt2-theme.el ends here
