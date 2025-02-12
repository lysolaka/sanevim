local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({ trig = "%preamble", dscr = "Make a standard preamble" },
    fmta([[
      %! TeX program = <>
      \documentclass{article}
      \usepackage{graphicx}
      \usepackage{minted}
      \usepackage{xcolor}
      \usepackage{pgf}
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
      \setlength{\parindent}{0pt}
      \setlength{\parskip}{1em}
      \usepackage[scaled=0.92]{heuristica}

      \definecolor{mintedbg}{rgb}{0.9, 0.9, 0.9}

      <>
    ]], { i(1), i(0) })
  ),
}
