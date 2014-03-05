(TeX-add-style-hook "CRANtalk"
 (lambda ()
    (TeX-run-style-hooks
     "Sweave"
     "pdfpages"
     "hyperref"
     ""
     "latex2e"
     "beamer10"
     "beamer"
     "xcolor=svgnames")))

