-- Treesitter --

local cfg = require("config.plugins.treesitter")

return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "VeryLazy" },
  -- lazy load when nvim was launched with no args
  lazy = vim.fn.argc(-1) == 0,
  init = function(plug)
    require("lazy.core.loader").add_to_rtp(plug)
    require("nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  -- c, lua, markdown, query, vim, vimdoc are installed by default in gentoo
  -- REMEMBER to remove them to avoid 10 milion errors
  opts = cfg["nvim-treesitter"],
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
