return {
  ["nvim-treesitter"] = {
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    auto_install = false,
    sync_install = false,
    ensure_installed = {
      -- c, lua, markdown, query, vim, vimdoc are installed by default in gentoo
      -- REMEMBER to remove them to avoid 10 milion errors
      "c", "cpp", "lua", "luadoc", "python", "rust", "toml",
      "make", "markdown", "query", "vim", "vimdoc",
    },
  },
}
