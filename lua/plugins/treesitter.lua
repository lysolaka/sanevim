-- Treesitter Highlighting --

return {
  {
    "romus204/tree-sitter-manager.nvim",
    opts = {
      ensure_installed = {
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
      },
      border = "single",
    },
  },
}
