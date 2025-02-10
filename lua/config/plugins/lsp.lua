return {
  ["mason"] = {
    ensure_installed = {
      "basedpyright",
      "clangd",
      -- "latexindent",
      "lua_ls",
      "ruff",
      "rust_analyzer",
      "texlab",
    },
  },
  ["mason-lspconfig"] = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}
