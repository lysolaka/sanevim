-- Treesitter Parsers Installation --

local ts = require("nvim-treesitter")

-- parsers to install
local parsers = {
  "c",
  "comment",
  "cpp",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "python",
  "rust",
  "toml",
  "vim",
  "vimdoc",
}

-- install `tree-sitter-cli` from `mason.nvim` if not present
if vim.fn.executable("tree-sitter") == 0 then
  vim.notify("[SaneVim] `tree-sitter-cli` executable not found, attempting to install from `mason.nvim`")
  local mr = require("mason-registry")
  mr.refresh(function()
    local p = mr.get_package("tree-sitter-cli")
    p:install(
      nil,
      vim.schedule_wrap(function(success)
        if success then
          vim.notify("[SaneVim] Installed `tree-sitter-cli` from `mason.nvim`", vim.log.levels.INFO)
        else
          vim.notify("[SaneVim] Error installing `tree-sitter-cli` from `mason.nvim`", vim.log.levels.WARN)
        end
      end)
    )
  end)
end

-- install the parsers, `ts.install()` internally skips already installed ones
ts.install(parsers)
local installed = ts.get_installed()

-- enable the parsers
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)

    -- if our lang is not installed: return
    if not vim.tbl_contains(installed, lang) then
      return
    end

    -- else start highlighting
    vim.treesitter.start(args.buf, lang)
    -- and indenting
    vim.api.nvim_set_option_value(
      "indentexpr",
      "v:lua.require('nvim-treesitter').indentexpr()",
      { scope = "local", buf = args.buf }
    )
  end,
})
