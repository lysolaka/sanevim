local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({ trig = "%preamble", dscr = "Make a standard preamble" },
    fmta([[
      %! TeX program = <>
      \documentclass{article}
      \usepackage{amsmath}
      \usepackage{graphicx}
      \usepackage{xcolor}
      \usepackage{pgf}
      \usepackage{float}
      \usepackage{placeins}
      \usepackage{subcaption}
      \usepackage{minted}
      \usepackage{titlesec}
      \usepackage[
        colorlinks=true,
        linkcolor=blue,
        urlcolor=blue
      ]{hyperref}
      \usepackage[
        a4paper,
        left=2cm,
        right=2cm,
        top=2cm,
        bottom=2cm
      ]{geometry}
      % pdflatex:
      \usepackage{lmodern}
      \usepackage{newtxtext}
      \usepackage[T1]{fontenc}
      % lualatex or xelatex:
      % \usepackage{fontspec}
      % \usepackage{unicode-math}
      % \setmainfont{Nimbus Roman}
      % \setmathfont{NewComputerModernMath}
      % \setmonofont{SauceCodePro NFM}

      \setlength{\parindent}{0pt}
      \setlength{\parskip}{1em}

      \definecolor{mintedbg}{rgb}{0.8, 0.8, 0.8}

      \titleformat{\section}
        {\normalfont\Large\bfseries}
        {\thesection.}
        {10pt}
        {\vspace{-0.5em}}
      \titleformat{\subsection}
        {\normalfont\large\bfseries}
        {\thesubsection.}
        {10pt}
        {\vspace{-0.5em}}
      \titleformat{\subsubsection}
        {\normalfont\normalsize\bfseries}
        {\thesubsubsection.}
        {10pt}
        {\vspace{-0.5em}}

      <>
    ]], { i(1), i(0) })
  ),
}
