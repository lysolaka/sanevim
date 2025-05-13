return {
  ["mason"] = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  ["mason-lspconfig"] = {
    ensure_installed = {
      "basedpyright",
      "clangd",
      "lua_ls",
      "ruff",
      "rust_analyzer",
      "texlab",
    },
    automatic_enable = false,
  },
}
