;;; themes/vscode-treemacs-theme.el -*- lexical-binding: t; -*-
(require 'find-func)

(with-eval-after-load 'treemacs
  (treemacs-create-theme "vscode-treemacs-theme"
    :icon-directory (treemacs-join-path (file-name-directory (find-library-name "vscode-treemacs-theme")) "icons")
    :config
    (progn
      (treemacs-create-icon
       :file "file_type_text.png"
       :extensions (fallback))

      (treemacs-create-icon
       :file "chevron-down.png"
       :extensions (root-open))

      (treemacs-create-icon
       :file "chevron-right.png"
       :extensions (root-closed))

      (treemacs-create-icon
       :file "chevron-down.png"
       :extensions (tag-open))

      (treemacs-create-icon
       :file "chevron-right.png"
       :extensions (tag-closed))

      (treemacs-create-icon
       :file "chevron-down.png"
       :extensions (dir-open))

      (treemacs-create-icon
       :file "chevron-right.png"
       :extensions (dir-closed))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-faicon "tag"
                                                 :height 0.9
                                                 :face 'font-lock-type-face))
       :extensions (tag-leaf))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-material "error"
                                                   :height 0.9
                                                   :face 'error))
       :extensions (error)
       :fallback (propertize "• " 'face 'font-lock-warning-face))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-material "warning"
                                                   :height 0.9
                                                   :face 'error))
       :extensions (warning)
       :fallback (propertize "• " 'face 'font-lock-string-face))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-material "info"
                                                   :height 0.9
                                                   :face 'font-lock-string-face))
       :extensions (info)
       :fallback (propertize "• " 'face 'font-lock-string-face))

      ;; Icons for filetypes
      (treemacs-create-icon :file "file_type_actionscript.png"  :extensions ("actionscript"))
      (treemacs-create-icon :file "file_type_ai.png"            :extensions ("ai"))
      (treemacs-create-icon :file "file_type_apex.png"          :extensions ("cls" "tgr"))
      (treemacs-create-icon :file "file_type_apib.png"          :extensions ("apib"))
      (treemacs-create-icon :file "file_type_applescript.png"   :extensions ("applescript"))
      (treemacs-create-icon :file "file_type_appveyor.png"      :extensions ("appveyor.yml"))
      (treemacs-create-icon :file "file_type_arduino.png"       :extensions ("ino"))
      (treemacs-create-icon :file "file_type_asp.png"           :extensions ("asp"))
      (treemacs-create-icon :file "file_type_aspx.png"          :extensions ("aspx"))
      (treemacs-create-icon :file "file_type_assembly.png"      :extensions ("asm"))
      (treemacs-create-icon :file "file_type_autohotkey.png"    :extensions ("ahk"))
      (treemacs-create-icon :file "file_type_avro.png"          :extensions ("avro"))
      (treemacs-create-icon :file "file_type_babel.png"         :extensions ("babel.config.json" "babel.config.js" "babel.config.cjs" "babel.config.mjs" ".babelrc" ".babelrc.json" ".babelrc.js" ".babelrc.cjs" ".babelrc.mjs"))
      (treemacs-create-icon :file "file_type_bazaar.png"        :extensions ("bzr"))
      (treemacs-create-icon :file "file_type_bazel.png"         :extensions ("bzl"))
      (treemacs-create-icon :file "file_type_bower.png"         :extensions (".bowerrc"))
      (treemacs-create-icon :file "file_type_browserlist.png"   :extensions (".browserlistrc"))
      (treemacs-create-icon :file "file_type_c.png"             :extensions ("c"))
      (treemacs-create-icon :file "file_type_cabal.png"         :extensions ("cabal"))
      (treemacs-create-icon :file "file_type_cert.png"          :extensions ("cert"))
      (treemacs-create-icon :file "file_type_cf.png"            :extensions ("cf"))
      (treemacs-create-icon :file "file_type_cfc.png"           :extensions ("cfc"))
      (treemacs-create-icon :file "file_type_cfm.png"           :extensions ("cfm"))
      (treemacs-create-icon :file "file_type_cheader.png"       :extensions ("h"))
      (treemacs-create-icon :file "file_type_chef.png"          :extensions ("chef"))
      (treemacs-create-icon :file "file_type_clojure.png"       :extensions ("clj" "cljs" "cljc"))
      (treemacs-create-icon :file "file_type_cmake.png"         :extensions ("cmake"))
      (treemacs-create-icon :file "file_type_cobol.png"         :extensions ("cbl" "cob"))
      (treemacs-create-icon :file "file_type_codeclimate.png"   :extensions (".codeclimate.yml" ".codeclimate.json"))
      (treemacs-create-icon :file "file_type_coffeelint.png"    :extensions ("coffeelint.json"))
      (treemacs-create-icon :file "file_type_coffeescript.png"  :extensions ("coffee" "litcoffee"))
      (treemacs-create-icon :file "file_type_composer.png"      :extensions ("composer.json"))
      (treemacs-create-icon :file "file_type_cpp.png"           :extensions ("cpp" "cxx" "tpp" "cc"))
      (treemacs-create-icon :file "file_type_cppheader.png"     :extensions ("hpp" "hh"))
      (treemacs-create-icon :file "file_type_crystal.png"       :extensions ("cr"))
      (treemacs-create-icon :file "file_type_csharp.png"        :extensions ("cs"))
      (treemacs-create-icon :file "file_type_csproj.png"        :extensions ("csproj"))
      (treemacs-create-icon :file "file_type_css.png"           :extensions ("css" "min.css"))
      (treemacs-create-icon :file "file_type_cssmap.png"        :extensions ("css.map" "min.css.map"))
      (treemacs-create-icon :file "file_type_cucumber.png"      :extensions ("feature"))
      (treemacs-create-icon :file "file_type_cvs.png"           :extensions ("cvs"))
      (treemacs-create-icon :file "file_type_cypress.png"       :extensions ("cypress.json" "cypress.env.json"))
      (treemacs-create-icon :file "file_type_dartlang.png"      :extensions ("dart"))
      (treemacs-create-icon :file "file_type_docker.png"        :extensions ("dockerfile"))
      (treemacs-create-icon :file "file_type_editorconfig.png"  :extensions (".editorconfig"))
      (treemacs-create-icon :file "file_type_eex.png"           :extensions ("eex"))
      (treemacs-create-icon :file "file_type_ejs.png"           :extensions ("ejs"))
      (treemacs-create-icon :file "file_type_elixir.png"        :extensions ("ex" "exs"))
      (treemacs-create-icon :file "file_type_emacs.png"         :extensions ("el" "elc"))
      (treemacs-create-icon :file "file_type_erlang.png"        :extensions ("erl" "hrl"))
      (treemacs-create-icon :file "file_type_eslint.png"        :extensions ("eslintrc" "eslintrc.js"))
      (treemacs-create-icon :file "file_type_git2.png"          :extensions ("gitignore" "git" "gitattributes" "gitconfig" "gitmodules"))
      (treemacs-create-icon :file "file_type_gitlab.png"        :extensions (".gitlab-ci.yml"))
      (treemacs-create-icon :file "file_type_go.png"            :extensions ("go"))
      (treemacs-create-icon :file "file_type_graphql.png"       :extensions ("graphql" "gql"))
      (treemacs-create-icon :file "file_type_haskell.png"       :extensions ("hs"))
      (treemacs-create-icon :file "file_type_jar.png"           :extensions ("jar"))
      (treemacs-create-icon :file "file_type_java.png"          :extensions ("java"))
      (treemacs-create-icon :file "file_type_jinja.png"         :extensions ("j2" "jinja2"))
      (treemacs-create-icon :file "file_type_js.png"            :extensions ("js"))
      (treemacs-create-icon :file "file_type_testjs.png"        :extensions ("test.js" "spec.js"))
      (treemacs-create-icon :file "file_type_reactjs.png"       :extensions ("jsx"))
      (treemacs-create-icon :file "file_type_js_official.png"   :extensions ("svelte"))
      (treemacs-create-icon :file "file_type_json.png"          :extensions ("json"))
      (treemacs-create-icon :file "file_type_julia.png"         :extensions ("jl"))
      (treemacs-create-icon :file "file_type_kotlin.png"        :extensions ("kt" "kts"))
      (treemacs-create-icon :file "file_type_less.png"          :extensions ("less"))
      (treemacs-create-icon :file "file_type_lisp.png"          :extensions ("lisp"))
      (treemacs-create-icon :file "file_type_lua.png"           :extensions ("lua"))
      (treemacs-create-icon :file "file_type_markdown.png"      :extensions ("md" "markdown"))
      (treemacs-create-icon :file "file_type_maven.png"         :extensions ("pom.xml"))
      (treemacs-create-icon :file "file_type_nim.png"           :extensions ("nim" "nims"))
      (treemacs-create-icon :file "file_type_npm.png"           :extensions (".npmrc" ".npmignore" "package.json" "package-lock.json"))
      (treemacs-create-icon :file "file_type_ocaml.png"         :extensions ("ml" "mli"))
      (treemacs-create-icon :file "file_type_org.png"           :extensions ("org"))
      (treemacs-create-icon :file "file_type_pdf.png"           :extensions ("pdf"))
      (treemacs-create-icon :file "file_type_perl.png"          :extensions ("pl" "plx" "pm" "perl"))
      (treemacs-create-icon :file "file_type_perl6.png"         :extensions ("pm6" "p6" "t6" "raku" "rakumod" "rakudoc" "rakutest"))
      (treemacs-create-icon :file "file_type_php.png"           :extensions ("php"))
      (treemacs-create-icon :file "file_type_prettier.png"      :extensions ("prettierrc" "prettierrc.js" "prettier.config.js"))
      (treemacs-create-icon :file "file_type_puppet.png"        :extensions ("pp"))
      (treemacs-create-icon :file "file_type_python.png"        :extensions ("py"))
      (treemacs-create-icon :file "file_type_r.png"             :extensions ("r"))
      (treemacs-create-icon :file "file_type_racket.png"        :extensions ("racket" "rkt" "rktl" "rktd" "scrbl" "scribble" "plt"))
      (treemacs-create-icon :file "file_type_reason.png"        :extensions ("re" "rei"))
      (treemacs-create-icon :file "file_type_ruby.png"          :extensions ("rb"))
      (treemacs-create-icon :file "file_type_rust.png"          :extensions ("rs" "rlib"))
      (treemacs-create-icon :file "file_type_sass.png"          :extensions ("sass"))
      (treemacs-create-icon :file "file_type_sbt.png"           :extensions ("sbt"))
      (treemacs-create-icon :file "file_type_scala.png"         :extensions ("scala"))
      (treemacs-create-icon :file "file_type_script.png"        :extensions ("sh" "zsh" "fish"))
      (treemacs-create-icon :file "file_type_scss.png"          :extensions ("scss"))
      (treemacs-create-icon :file "file_type_sql.png"           :extensions ("sql"))
      (treemacs-create-icon :file "file_type_style.png"         :extensions ("styles"))
      (treemacs-create-icon :file "file_type_stylus.png"        :extensions ("styl"))
      (treemacs-create-icon :file "file_type_tex.png"           :extensions ("tex"))
      (treemacs-create-icon :file "file_type_typescript.png"    :extensions ("ts"))
      (treemacs-create-icon :file "file_type_testts.png"        :extensions ("test.ts" "spec.ts"))
      (treemacs-create-icon :file "file_type_typescriptdef.png" :extensions ("d.ts"))
      (treemacs-create-icon :file "file_type_reactts.png"       :extensions ("tsx"))
      (treemacs-create-icon :file "file_type_reacttemplate.png" :extensions ("test.tsx" "spec.tsx" "test.jsx" "spec.jsx"))
      (treemacs-create-icon :file "file_type_vagrant.png"       :extensions ("vagrantfile"))
      (treemacs-create-icon :file "file_type_vue.png"           :extensions ("vue"))
      (treemacs-create-icon :file "file_type_webpack.png"       :extensions ("webpack.settings.js"))
      (treemacs-create-icon :file "file_type_xml.png"           :extensions ("html" "htm"))
      (treemacs-create-icon :file "file_type_xsl.png"           :extensions ("xml" "xsl"))
      (treemacs-create-icon :file "file_type_yaml.png"          :extensions ("yml" "yaml"))
      (treemacs-create-icon :file "file_type_yarn.png"          :extensions ("yarn.lock"))
      (treemacs-create-icon :file "file_type_yeoman.png"        :extensions (".yo-rc.json"))

      ;; Image files icon
      (treemacs-create-icon
       :file "file_type_image.png"
       :extensions ("jpg" "jpeg" "png" "gif" "ico" "tif" "tiff" "svg" "bmp"
                    "psd" "eps" "indd" "mov" "avi" "mp4" "webm" "webp" "mkv"))

      ;; Video file icons
      (treemacs-create-icon
       :file "file_type_video.png"
       :extensions ("mov" "avi" "mp4" "webm" "webp" "mkv"))

      ;; Audio file icons
      (treemacs-create-icon
       :file "file_type_audio.png"
       :extensions ("wav" "mp3" "ogg" "midi"))

      ;; Text file icons
      (treemacs-create-icon
       :file "file_type_text.png"
       :extensions ("rst" "log" "txt" "contribute" "readme" "changelog"))

      ;; Config file icons
      (treemacs-create-icon
       :file "file_type_config.png"
       :extensions ("conf" "cfg" "toml" "cson" "ini" "iml" "config"))

      ;; Archive file icons
      (treemacs-create-icon
       :file "file_type_zip.png"
       :extensions ("zip" "xz" "tar" "gz" "7z" "rar"))))

  (setq treemacs-file-extension-regex "\\.")
  (treemacs-load-theme "vscode-treemacs-theme"))

(provide 'vscode-treemacs-theme)
;;; vscode-treemacs-theme.el ends here
