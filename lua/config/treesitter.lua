-- Treesitter Parsers Installation --

local ts = require("nvim-treesitter")

-- parsers to install
local parsers = {
  "c",
  "cpp",
  "lua",
  "luadoc",
  "python",
  "rust",
  "toml",
  "make",
  "markdown",
  "vim",
  "vimdoc",
}

-- install the parsers, for already installed ones this is a no-op
ts.install(parsers)

-- enable the parsers
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)

    -- if our lang is not installed: return
    if not vim.tbl_contains(parsers, lang) then
      return
    end

    -- else start highlighting
    vim.treesitter.start(args.buf, lang)
    -- and indenting
    -- TODO: check which one works
    vim.api.nvim_set_option_value("indentexpr", "v:lua.ts.indentexpr()", { scope = "local", buf = args.buf })
    -- vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
