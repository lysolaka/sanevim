-- DIAGNOSTICS --
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

-- Visuals for rust Option and Result types
vim.api.nvim_set_hl(0, "@lsp.typemod.enumMember.defaultLibrary.rust", { link = "Constant" })
