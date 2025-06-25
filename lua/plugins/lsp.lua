-- LSP Plugins --

local cfg = require("config.plugins.lsp")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    opts = cfg["mason"],
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = cfg["mason-lspconfig"],
  },
  {
    "https://github.com/gentoo/gentoo-syntax",
  },
}
