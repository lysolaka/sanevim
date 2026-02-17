-- LSP Plugins --

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
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
        "clangd",
        "lua_ls",
        "ruff",
        "rust_analyzer",
        "texlab"
      },
      automatic_enable = false,
    },
  },
  {
    "gentoo/gentoo-syntax",
    event = "BufEnter",
  },
}
