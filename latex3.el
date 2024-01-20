;;; latex3.el --- Provide syntax highlighting for LaTeX3 (expl3) -*- lexical-binding: t; -*-

;; Copyright (C) enkorvaks (github username)


;; Author: En Korvaks
;; Version: 0.1
;; Keywords: languages, faces, tex
;; URL: https://github.com/enkorvaks/emacslatex

;;; This file is not part of GNU Emacs.

;; This package is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This package is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This package provides latex-sty-mode, a mode for highlighting LaTeX
;; class and style files, particularly those using expl3 code.
;;
;; To activate this mode, type M-x latex-sty-mode
;;
;; To use this mode for all LaTeX style and class files, add the
;; following to your startup file (~/.emacs or ~/.emacs.d/init.el):
;; (require 'latex3)
;; (setq auto-mode-alist
;;      (append '(("\\.sty$" . latex-sty-mode)
;;                ("\\.cls$" . latex-sty-mode))
;;                )
;;              auto-mode-alist)
;;      )
;;
;; The creation of this file was inspired by Andrew Stacy's post here:
;;  https://tex.stackexchange.com/a/129521/244233
;; with ideas from the various answers here:
;;  https://stackoverflow.com/q/18621036/20781718
;; and additional thoughts and ideas from here:
;;  https://superuser.com/q/485363
;; Detection of AUCTeX from here:
;;  https://emacs.stackexchange.com/q/20995

;;; Code:

(require 'tex-mode)

;; TODO groups - latex3-fonts (top level), subgroups?
(defgroup LaTeX3 nil
  "Top-level group for all customisations for the modes provided by latex3.el"
  )

(defgroup LaTeX3-font-lock nil
  "Font lock faces introduced by latex3.el"
  :group 'LaTeX3
  )

(defvar LaTeX3-base-mode "base-tex"
  "A variable used internally by latex3.el to make it easier to
  set things differently when AUCTeX is present, rather than the
  default Emacs TeX-Mode.

  Users should not set this value manually. If it is changed,
  some things may fail to work correctly (or at all).
")

(defun latex3-auctex-customisations ()
    "Things which need to be done only if AUCTeX is loaded"
    (advice-add 'TeX-command-master :before-until #'latex-style-mode-compile-advice)
    (advice-add 'TeX-command-region :before-until #'latex-style-mode-compile-advice)
    (advice-add 'TeX-command-buffer :before-until #'latex-style-mode-compile-advice)
    (advice-add 'TeX-command-section :before-until #'latex-style-mode-compile-advice)
    (advice-add 'TeX-command-run-all :before-until #'latex-style-mode-compile-advice)
    (setq LaTeX3-base-mode "AUCTeX")
    )

(defun latex3-tex-mode-customisations ()
  "Things which need to be done only if AUCTeX is NOT loaded"
  
  (defface font-latex-warning-face
    '((t :inherit font-lock-warning-face))
    "Face for important keywords"
    :group 'tex
    :group 'font-lock-faces
    :group 'LaTeX3-font-lock
    )
  
  )

;; Make any changes required early, choosing method based on if AUCTeX
;; is present or not
(if (require 'tex-site nil t)
    (latex3-auctex-customisations)
  (latex3-tex-mode-customisations))

;; Create new faces
(defface font-latex-expl3-kernel-face
  '((t :inherit font-lock-keyword-face))
  "Face for LaTeX3 kernel functions"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-arg-face
  '((t :inherit font-lock-function-name-face))
  "Face for LaTeX macro arguments"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-expl3-arg-spec-face
  '((t :inherit font-lock-constant-face))
  "Face for LaTeX3 argument specifications"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-builtin-face
  '((t :inherit font-lock-builtin-face))
  "Face for LaTeX builtins and basic commands"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-expl3-variable-name-face
  '((t :inherit font-lock-variable-name-face))
  "Face for LaTeX3 variables (public)"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-expl3-private-variable-name-face
  '((t :inherit font-lock-variable-name-face))
  "Face for LaTeX3 variables (private)"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-expl3-function-name-face
  '((t :inherit font-lock-function-name-face))
  "Face for LaTeX3 functions (non-kernel)"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-expl3-private-function-name-face
  '((t :inherit font-lock-function-name-face))
  "Face for LaTeX3 functions (private)"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-latex2e-function-name-face
  '((t :inherit font-lock-function-name-face))
  "Face for LaTeX2e functions (public)"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-latex2e-private-function-name-face
  '((t :inherit font-lock-function-name-face))
  "Face for LaTeX2e functions (private)"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defface font-latex-environment-name-face
  '((t :inherit font-lock-type-face))
  "Face for environment names in LaTeX documents, class files, and style files"
  :group 'tex
  :group 'font-lock-faces
  :group 'LaTeX3-font-lock
  )

(defvar all-argspec "cDefFnNopTvVwx")
(defvar normal-argspec "")

(defun set-argspec-warn (optionname newvalue)
  "Set the argument specifiers which will show up as 'Warning'"
  (prog1
      (set optionname newvalue)
    (let ((case-fold-search nil))
      (setq normal-argspec
            (replace-regexp-in-string
             (concat "\\([" newvalue "]\\)")
             ""
             all-argspec t))
      )
    )
  )


(defcustom argspecwarn "Dwx"
  "Set of characters which, when used in an arg-spec, should be
highlighted. Sensible choices would contain at the very least 'D'
and 'w', but may contain anything which is generally an argument
specifier. Note that this will only change highlighting if 'Save
for Future Sessions' is selected, and emacs is restarted. This is
due to the use of 'eval-when-compile' on the font-lock keywords.

As a result, the only way this variable can be (meaningfully) set
outside of the Customize mechanism is by putting something like
'(defvar argspecwarn \"Dw\")' before loading 'latex3.el' in your
initialisation file"
  
  :type '(string)
  :tag "Warning-coloured Argument Specifiers"
  :group 'LaTeX3
  :set 'set-argspec-warn
  )


;; TODO create a Title face (\??section*{facegoeshere}, \part{facegoeshere},\chapter{facegoeshere}, \paragraph{}, \subparagraph{},\appendix{})
;; TODO create a key/value face (\something[key=value,keynext=otherval]{}) (or a keyface/valueface?)


;; TODO for LaTeX-Doc mode, use warning face for 'stuff that doc authors
;; possibly should not be use' like \\, \par, \clearpage, \vskip
;; (this same face can be used for the deprecated/discouraged arg-specs as well)

(defvar latex3-arg-spec         'font-latex-expl3-arg-spec-face)
(defvar latex3-function         'font-latex-expl3-function-name-face)
(defvar latex3-private-function 'font-latex-expl3-private-function-name-face)
(defvar latex3-kernel           'font-latex-expl3-kernel-face)
(defvar latex3-variable         'font-latex-expl3-variable-name-face)
(defvar latex3-private-variable 'font-latex-expl3-private-variable-name-face)
(defvar latex2-function         'font-latex-latex2e-function-name-face)
(defvar latex2-private-function 'font-latex-latex2e-private-function-name-face)
(defvar latex-arg               'font-latex-arg-face)
(defvar latex-builtin           'font-latex-builtin-face)
;; TODO other latex doc faces go here
(defvar latex-env               'font-latex-environment-name-face)
(defvar latex-warn              'font-latex-warning-face)

(defvar re-string-backslash        "\\\\")
(defvar re-string-l2-public        "\\(?:[a-zA-Z]+[*]?\\)")
(defvar re-string-l2-private       "\\(?:\\(?:[a-zA-Z]*@+[a-zA-Z]*\\)+[*]?\\)")

;; end-macro is basically 'space, punctuation, digit' - It should be
;; anything which is not catcode 11.
;; Due to the annoyance of regular expressions, it is currently
;; limited to what emacs considers puncuation, spaces, and numbers.
;; Anything else can just put up with not highlighting properly.
(defvar re-string-end-macro        "\\(?:[[:punct:][:space:][:digit:]]\\)")
(defvar re-string-l3-chars         "\\(?:[@a-zA-Z_]+\\)")
(defvar re-string-l3-warn-arg-spec (concat "\\(?:[" all-argspec "]+\\)"))
(defvar re-string-l3-func-arg-spec (concat "\\(?:[" normal-argspec "]+\\)"))
(defvar re-string-l3-variable      "\\(?:\\(?:l\\|g\\|c\\)_[a-zA-Z_]+\\)")
(defvar re-string-l3-private-var   "\\(?:\\(?:l\\|g\\|c\\)__[a-zA-Z_]+\\)")

(defvar re-string-l3-kernel
  (regexp-opt
   '(
     ;; list generated by:
     ;; awk -F ',' '/l3kernel/ {print "\""$1"\""}' /usr/local/texlive/2023/texmf-dist/doc/latex/l3kernel/l3prefixes.csv

     "alignment" "alloc" "ampersand" "atsign" "backslash" "bitset"
     "bool" "box" "catcode" "cctab" "char" "chk" "circumflex" "clist"
     "code" "codedoc" "codepoint" "coffin" "colon" "color" "cs" "debug"
     "dim" "document" "dollar" "driver" "e" "else" "empty" "etex" "exp"
     "expl" "false" "fi" "file" "flag" "fp" "group" "hash" "hbox"
     "hcoffin" "if" "inf" "initex" "insert" "int" "intarray" "ior" "iow"
     "job" "kernel" "keys" "keyval" "left" "log" "lua" "luatex" "mark"
     "marks" "math" "max" "minus" "mode" "msg" "muskip" "nan" "nil" "no"
     "novalue" "one" "or" "other" "parameter" "pdf" "pdftex" "peek"
     "percent" "pi" "prg" "prop" "ptex" "quark" "recursion" "ref"
     "regex" "reverse" "right" "scan" "seq" "skip" "sort" "space" "stop"
     "str" "sys" "tag" "term" "tex" "text" "tilde" "tl" "tmpa" "tmpb"
     "token" "true" "underscore" "uptex" "use" "utex" "vbox" "vcoffin"
     "xetex" "zero"
     
     )
   t))

(defvar re-string-builtin-commands
  ;; Commands which are considered 'builtin'
  (regexp-opt
   '(
     "NeedsTeXFormat"
     "RequirePackage"
     "ProvidesExplClass"
     "ProvidesClass"
     "ProvidesPackage"
     "ProvidesExplPackage"
     "ProvidesFile"
     "ProvidesExplFile"
     "DeclareOption"
     "DeclareOption*"
     "ProcessOptions"
     "LoadClass"
     "PassOptionsToClass"
     "CurrentOption"
     "ExecuteOptions"
     "NewDocumentCommand"
     "RenewDocumentCommand"
     "NewExpandableDocumentCommand"
     "NewDocumentEnvironment"
     "RenewDocumentEnvironment"
     "AddToHook"

     ;; {At|After|Before}{Begin|End}{Document|Preamble|??}
     ;; input?
     ;; setlength?
     ;; TODO go through this list. Do i just want to make anything
     ;; starting with a capital (followed by lowercase) builtin?
     )
   t))

(defvar re-string-environmentmarkers
  ;; Strings which mark an environment name
  (regexp-opt
   '(
     "begin" "end" "newenvironment" "renewenvironment"
     "NewDocumentEnvironment" "RenewDocumentEnvironment"
     )
   t))

;; TODO rename this, and consider what goes in it
(defvar re-string-discouraged-commands
  ;; Commands which should not really be used in Style and Class files
  ;; or commands which have better replacements
  (regexp-opt
   '(
     ;; "newcommand" "renewcommand" "usepackage"?
     ;; newenvironment, renewenvironment, providescommand?
     ;;
     ;; The below should items probably be 'doc-discouraged-commands',
     ;; but are not really discouraged in a sty/cls file:
     ;; \\, \vskip, \hskip, clearpage, cleardoublepage, newpage, ...
     ;; (possibly others)
     )
   t))

(defun l2-public-font-lock-search (search-limit)
  "called to highlight the LaTeX2e public functions"
  (prog1
    (re-search-forward
     (concat 
      "\\(" re-string-backslash re-string-l2-public "\\)"
      "\\(?:" re-string-end-macro "\\|$"  "\\)"
      )
     search-limit t)
    (backward-char)
    )
  )
(defun l2-private-font-lock-search (search-limit)
  "called to highlight the LaTeX2e private functions"
  (prog1
    (re-search-forward
     (concat 
      "\\(" re-string-backslash re-string-l2-private "\\)"
      "\\(?:" re-string-end-macro "\\|$" "\\)"
      )
     search-limit t)
    (backward-char)
    )
  )
(defun l3-variable-font-lock-search (search-limit)
  "called to highlight the LaTeX3 variable"
  (prog1
    (re-search-forward
     (concat 
      "\\(" re-string-backslash re-string-l3-variable "\\)"
      "\\(?:" re-string-end-macro "\\|$" "\\)"
      )
     search-limit t)
    (backward-char)
    )
  )
(defun l3-private-variable-font-lock-search (search-limit)
  "called to highlight the LaTeX3 private variable"
  (prog1
    (re-search-forward
     (concat 
      "\\(" re-string-backslash re-string-l3-private-var "\\)"
      "\\(?:" re-string-end-macro "\\|$" "\\)"
      )
     search-limit t)
    (backward-char)
    )
  )
(defun l3-function-font-lock-search (search-limit)
  "called to highlight the LaTeX3 function"
  (prog1
    (re-search-forward
     (concat 
      "\\(" re-string-backslash re-string-l3-chars "_" re-string-l3-chars ":" "\\)"
      "\\(?:\\(" re-string-l3-func-arg-spec "\\)\\|\\(" re-string-l3-warn-arg-spec "\\)\\)?"
      "\\(?:" re-string-end-macro "\\|$" "\\)"
      )
     search-limit t)
    (backward-char)
    )
  )
(defun l3-private-function-font-lock-search (search-limit)
  "called to highlight the LaTeX3 private function"
  (prog1
    (re-search-forward
     (concat
      "\\(" re-string-backslash "__" re-string-l3-chars ":" "\\)"
      "\\(?:\\(" re-string-l3-func-arg-spec "\\)\\|\\(" re-string-l3-warn-arg-spec "\\)\\)?"
      "\\(?:" re-string-end-macro "\\|$" "\\)"
      )
     search-limit t)
    (backward-char)
    )
  )

(defun l3-kernel-font-lock-search (search-limit)
  "called to highlight the LaTeX3 kernel function"
  (prog1
    (re-search-forward
     (concat 
      "\\(" re-string-backslash re-string-l3-kernel "_" re-string-l3-chars ":" "\\)"
      "\\(" re-string-l3-warn-arg-spec "\\)?"
      ;; this appears to work with the same warnings, because the
      ;; argspec is not overridden from the and private methods. I
      ;; think. But it does work.
      "\\(?:" re-string-end-macro "\\|$" "\\)"
      )
     search-limit t)
    (backward-char)
    )
  )

(defun latex-env-font-lock-search (search-limit)
  "called to highlight the environment names"
  (prog1
      (re-search-forward
       (concat
        re-string-backslash
        "\\(?:"
        re-string-environmentmarkers ; these make 'match 1' due to use of regexp-opt
        "\\|"
        "\\(?:" "documentclass\\(?:[[][^]]*]\\)?" "\\)"
        "\\)"
        "{" ; the begining (incl. the optional bit for docclass and the brace
        "\\(" "[^}]*" "\\)"; the stuff in the brace
        "}" ; the closing brace
        )
       search-limit t)
    (backward-char)
    )
  )


(defconst latex-sty-font-lock-keywords
  (eval-when-compile
    (let* 
	(;; Commands relevant to data structures

	 (numbered-args "\\(#+[1-9]\\)")
	 )
      (list
       (list (concat"\\(" re-string-backslash re-string-builtin-commands "\\)") 1 'latex-builtin)

       ;; L3 private functions and private variables
       (list 'l3-private-function-font-lock-search
             (list 1 'latex3-private-function )
	     (list 2 'latex3-arg-spec nil t)
             (list 3 'latex-warn nil t))
       (list 'l3-private-variable-font-lock-search
             1 'latex3-private-variable)
       
       ;; L3 kernel functions (kernel keywords detailed in the search function)
       (list 'l3-kernel-font-lock-search
	     (list 1 'latex3-kernel)
	     (list 2 'latex3-arg-spec))

       ; L3 variables (not functions). Must start with g_, c_, or l_.
       (list 'l3-variable-font-lock-search
	     1 'latex3-variable)

       ; L3 functions (any L3 which is not a kernel function)
       (list 'l3-function-font-lock-search
	     (list 1 'latex3-function )
	     (list 2 'latex3-arg-spec nil t)
             (list 3 'latex-warn nil t))

       ; Numbered macro arguments
       (list numbered-args
	     1 'latex-arg)

       ; L2 Private methods (letters and @)
       (list 'l2-private-font-lock-search
	     1 'latex2-private-function)

       ;; L2 public functions (no @ symbol)
       (list 'l2-public-font-lock-search
	     1 'latex2-function)
       ; L3 function argument specifier (for both kernel and non-kernel)
       ; older versions of emacs need this
       ;; The 2 arg-spec doesn't work with older versions of emacs,
       ;; but the first arg should work anyway
;;       (list 'l3-kernel-font-lock-search 1 'latex3-kernel)
;;       (list 'l3-function-font-lock-search 1 'latex3-function)
;;       (list (concat
;;	      re-string-backslash
;;	      l3func
;;	      "\\(" re-string-l3-func-arg-spec "\\)"
;;	      re-string-end-macro)
;;	     1 'latex3-arg-spec)

; The below is an example of the 'anchored keyword' type of highlighting
; The first 'nil' is the pre-form, the second is the post-form
;       (list (concat "\\(" slash l3func "\\)" )
;	     (list 1 'latex3-function)
;	     (list (concat "\\(" l3func-arg-spec "\\)" end-of-macro) nil nil
;		   (list 1 'latex3-arg-spec))
;	     )
;	     (list (concat "\\(" l3func-arg-spec "\\)" novar) nil nil
;		   (list 1 'l3func-arg-spec)
;		   )
;	     )
       )
      )
    )
  "Extra keywords to highlight in LaTeX .sty and .cls files (LaTeX Style mode)."
  )

;; In order that compiling a file doesn't attempt to compile style and
;; class files, Emacs can add advise to the function so it won't run
;; when LaTeX-Style mode is active
(defun latex-style-mode-compile-advice (&optional rest)
    "Disable tex-file command when in LaTeX-Style mode"
  (prog1
      (string= major-mode "latex-sty-mode")
    (if (string= major-mode "latex-sty-mode")
	(message "Refusing to tex-compile a non-document")
      )
    )
  )

(advice-add 'tex-file :before-until #'latex-style-mode-compile-advice)
(advice-add 'tex-buffer :before-until #'latex-style-mode-compile-advice)
(advice-add 'tex-region :before-until #'latex-style-mode-compile-advice)
(advice-add 'tex-compile :before-until #'latex-style-mode-compile-advice)
;; AUCTeX compile methods are advised earlier in this file

(defconst latex-doc-font-lock-keywords
  (eval-when-compile
    (let* 
	(;; Commands relevant to data structures
	 (numbered-args "\\(#+[1-9]\\)")
	 )
      (list
       (list (concat"\\(" re-string-backslash re-string-builtin-commands "\\)") 1 'latex-builtin)
       ;; L2 public functions (no @ symbol)
       (list 'l2-public-font-lock-search
	     1 'latex2-function)

       ; Numbered macro arguments
       (list numbered-args
	     1 'latex-arg)

       ;; TODO other things:
       ;;  strings (ordinary string face) - copied directly from tex-mode.el
       (cons (concat (regexp-opt '("``" "\"<" "\"`" "<<" "«") t)
		      "[^'\">{]+"	;a bit pessimistic
		      (regexp-opt '("''" "\">" "\"'" ">>" "»") t))
	      'font-lock-string-face)
       ;;  titles  (new latex-doc-face)
       ;;  warnings (uses 'font-latex-warning-face)
       ;;  environments (uses 'font-latex-environment-name-face)
       (list 'latex-env-font-lock-search
             2 'latex-env)
       ;;  bold/italic/tt/subscript/superscript/... (as per latex-mode)
       )
      )
    )
  "Extra keywords to highlight in LaTeX .tex files (LaTeX Doc mode)."
  )


;; redo some of the latex font lock stuff, but with the faces above,
;; rather than the default built-in faces
;;;###autoload
(defun latex-doc-font-setup ()
  "Set up font lock for LaTeX Doc mode"
  ;; TODO confirm the use and correctness of the variables below
  (set (make-local-variable 'font-lock-defaults)
       '((latex-doc-font-lock-keywords)
         ;; strings, titles, warnings, environments, bold/italic/tt/... ,
	 nil nil ((?$ . "\"")) nil
	 ;; Who ever uses that anyway ???
         (font-lock-mark-block-function . mark-paragraph)
         (font-lock-syntactic-face-function
          . tex-font-lock-syntactic-face-function)
         (font-lock-unfontify-region-function
          . tex-font-lock-unfontify-region)
;         (font-lock-syntactic-keywords
;          . tex-font-lock-syntactic-keywords)
         (parse-sexp-lookup-properties . t)))
  )

; make something new (not tex-font-lock-keywords - that has the wrong faces)
(define-derived-mode latex-doc-mode latex-mode "LaTeX Doc"
  "Major mode to edit LaTeX document file (with syntax highlighting)"
  (latex-doc-font-setup)
)


;;;###autoload
(defun latex-sty-font-setup ()
  "Set up font lock for LaTeX Sty mode"
  ;; TODO confirm the use and correctness of the variables below
  (set (make-local-variable 'font-lock-defaults)
       '((latex-sty-font-lock-keywords)
         nil nil ((?$ . "\"")) nil
         ;; Who ever uses that anyway ???
         (font-lock-mark-block-function . mark-paragraph)
         (font-lock-syntactic-face-function
          . tex-font-lock-syntactic-face-function)
         (font-lock-unfontify-region-function
          . tex-font-lock-unfontify-region)
;         (font-lock-syntactic-keywords
;          . tex-font-lock-syntactic-keywords)
         (parse-sexp-lookup-properties . t)))
 )

;;;###autoload
(define-derived-mode latex-sty-mode latex-mode "LaTeX Style"
  "Major mode to edit LaTeX class and style files (with syntax highlighting for LaTeX3)."
  (latex-sty-font-setup)
  )

;;;###autoload
(defun latex-doctex3-font-setup ()
  ;; Possibly do something similar to AUCTeX's font-latex-setup,
  ;; except use the style-mode colouring from here...

  )

;;;###autoload
(define-derived-mode latex-doctex3-mode latex-mode "LaTeX Style"
  "Major mode to edit LaTeX class and style files (with syntax highlighting for LaTeX3)."
  (latex-doctex3-font-setup)
  )

(provide 'latex3)

;;; latex3.el ends here
