-- QOL Plugins --

local cfg = require("config.plugins.completion")

return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v2.*",
    build = "make install_jsregexp",
    opts = cfg["LuaSnip"]
  },
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>na", "<cmd>Neogen<CR>" }
    },
    opts = cfg["neogen"]
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      {
        "micangl/cmp-vimtex",
        ft = "tex",
      },
    },
    opts = cfg["nvim-cmp"]
  },
}
