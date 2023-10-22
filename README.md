# Emacs LaTeX Sty mode (with support for LaTeX 3)

This project provides a Major Mode for emacs to allow syntax
highlighting for LaTeX3 syntax. Primarily, it is for Class (`.cls`) and
Style (`.sty`) files, but the mode can be activated for documents (`.tex`)
as well.

Originally, it was derived from emacs' standard `latex-mode`, but if
`AUCTeX` is present, it will derive from that, instead. There still
need to be some changes for that, see `TODO.md` in this repo for
details.

## Modes Provided

There are two modes (currently) provided - `LaTeX Style` and `LaTeX
Doc`, for use with class or style files and document files
respectively. Future work will include a `DocTeX` mode, allowing that
to have LaTeX3 syntax highlighting as well.

## Font Faces

The faces provided by this mode (in addition to the faces provided by
`AUCTeX`) are:
- Font Latex Arg Face
- Font Latex Builtin Face
- Font Latex Environment Name Face
- Font Latex Expl3 Arg Spec Face
- Font Latex Expl3 Function Name Face
- Font Latex Expl3 Kernel Face
- Font Latex Expl3 Private Function Name Face
- Font Latex Expl3 Private Variable Name Face
- Font Latex Expl3 Variable Name Face
- Font Latex Latex2e Function Name Face
- Font Latex Latex2e Private Function Name Face

This face is provided by `AUCTeX` if present, or defined by this style
otherwise:
- Font Latex Warning Face

### Customising Faces

If you wish to customise these faces, this can be done from the
`Customize Emacs` menu item, or can be done in your initialisation
file (usually `~/.emacs` or `~/.emacs.d/init.el`) similar to the
following:
```
(set-face-foreground 'font-latex-latex2e-function-name-face "purple4")
(set-face-foreground 'font-latex-latex2e-private-function-name-face "white")
(set-face-background 'font-latex-latex2e-private-function-name-face "purple4")
```

This example sets the LaTeX 2e public functions to be purple4 (on your
default background colour), and LaTeX 2e private functions to be
displayed in white on purple4.


