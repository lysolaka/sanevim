-- For capabilities defined in `lsp-method`:
--   set the key to the handler name
-- otherwise:
--   anything which is not defined in `lsp-method`
-- Look at `:h lsp-method`
return {
  ["textDocument/codeAction"] = {
    mode = "n",
    key = "<F4>",
    cmd = vim.lsp.buf.code_action,
  },
  ["textDocument/formatting"] = {
    mode = "n",
    key = "<F3>",
    cmd = function()
      vim.lsp.buf.format({ async = true })
    end,
  },
  ["textDocument/inlayHint"] = {
    mode = { "n", "i", "v" },
    key = "<F5>",
    cmd = function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
  },
  ["textDocument/rename"] = {
    mode = "n",
    key = "<F2>",
    cmd = vim.lsp.buf.rename,
  },
  ["openFloat"] = {
    mode = "n",
    key = "gl",
    cmd = vim.diagnostic.open_float,
  },
  -- texlab specific, will error on other servers (see :h vim.lsp.Client {supports_method})
  ["textDocument/build"] = {
    mode = "n",
    key = "<localleader>ll",
    cmd = function()
      vim.cmd([[TexlabBuild]])
    end,
  },
  ["textDocument/forwardSearch"] = {
    mode = "n",
    key = "<localleader>lg",
    cmd = function()
      vim.cmd([[TexlabForward]])
    end,
  },
}
