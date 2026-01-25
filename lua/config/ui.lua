-- UI and Visuals --

-- setup the theme
vim.cmd.colorscheme("tokyonight")

-- setup diagnostic boxes
vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = {
    spacing = 2,
    source = "if_many",
    prefix = "■",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  float = {
    border = "single",
  },
  severity_sort = true
})

-- highlighting for Rust's Option<T> and Result<T,E>
vim.api.nvim_set_hl(0, "@lsp.typemod.enumMember.defaultLibrary.rust", { link = "Constant" })

-- highlighting for tree-sitter-comment
vim.api.nvim_set_hl(0, "@comment.error", { fg = "#f7768e", bg = "#302430", bold = true })
vim.api.nvim_set_hl(0, "@comment.warning", { fg = "#e0af68", bg = "#2e2a2d", bold = true })
vim.api.nvim_set_hl(0, "@comment.note", { fg = "#9ece6a", bg = "#272d2d", bold = true })
vim.api.nvim_set_hl(0, "@comment.todo", { fg = "#bb9af7", bg = "#2a283b", bold = true })
