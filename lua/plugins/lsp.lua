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
        "lua-language-server",
        "rust_analyzer",
        "tree-sitter-cli",
      },
      automatic_enable = false,
    },
  },
  {
    "gentoo/gentoo-syntax",
    event = "BufEnter",
  },
}
