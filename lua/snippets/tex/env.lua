local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
  s({ trig = "env", dscr = "Generic environment" },
    fmta([[
      \begin{<>}
        <>
      \end{<>}
    ]], { i(1), i(0), rep(1) })
  ),
  s({ trig = "fig2", dscr = "Figure environment (PGF)" },
    fmta([[
      \begin{figure}[!ht]
        \centering
        \resizebox{<>\textwidth}{!}{\input{<>}}
        \caption{<>}
        \label{fig:<>}
      \end{figure}
    ]], { i(1), i(2, "filename"), i(3), i(4) })
  ),
  s({ trig = "fig1", dscr = "Figure environment (Other)" },
    fmta([[
      \begin{figure}[!ht]
        \centering
        \includegraphics[width=<>\textwidth]{<>}
        \caption{<>}
        \label{fig:<>}
      \end{figure}
    ]], { i(1), i(2, "filename"), i(3), i(4) })
  ),
  s({ trig = "cod", dscr = "Code listing environment" },
    fmta([[
      \begin{minted}[bgcolor=mintedbg, bgcolorpadding=0.4em, linenos=<>]{<>}
      <>
      \end{minted}
    ]], { i(1), i(2), i(0) })
  ),
  s({ trig = "tab", dscr = "Table environment" },
    fmta([[
      \begin{table}[!ht]
        \centering
        \renewcommand{\arraystretch}{1.15}
        \begin{tabular}{<>}
          <>
        \end{tabular}
        \caption{<>}
        \label{tab:<>}
      \end{table}
    ]], { i(1), i(0), i(2), i(3) })
  ),
}
