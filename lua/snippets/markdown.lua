local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({ trig = "```", dscr = "Make a code block" },
    fmta([[
      ```<>
      <>
      ```
    ]], { i(2), i(1) })
  ),
}
