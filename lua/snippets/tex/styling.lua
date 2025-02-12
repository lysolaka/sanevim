local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

local function get_visual(_, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

return {
  s({ trig = "href", dscr = "hyperref package's href{}{} command (for url links)" },
    fmta([[\href{<>}{<>}]], { i(1, "url"), i(2, "display name") })
  ),
  s({ trig = "tit", dscr = "Put selected text in an italic command" },
    fmta([[\textit{<>}]], { d(1, get_visual) })
  ),
  s({ trig = "tbf", dscr = "Put selected text in a bold command" },
    fmta([[\textbf{<>}]], { d(1, get_visual) })
  ),
  s({ trig = "ttt", dscr = "Put selected text in a monospace command" },
    fmta([[\texttt{<>}]], { d(1, get_visual) })
  ),
}
