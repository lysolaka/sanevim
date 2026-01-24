-- LSP Specific Keybindings --

-- table with keys corresponding to `lsp-method` (`:h lsp-method`)
-- the values are passed to `vim.keymap.set` as they appear here
--
-- these keybinds will only be set if the LSP supports their lsp-method
local lsp_keybinds = {
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
    mode = { "n", "i" },
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
}

-- table with other bindings to be set on `LspAttach` autocmd
-- the keys can be anything, most useful would be names of what the binding does
local keybinds = {
  ["openFloat"] = {
    mode = "n",
    key = "gl",
    cmd = vim.diagnostic.open_float,
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- LSP client running in the buffer
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- keymap options
    local opts = {
      noremap = true,
      silent = true,
      buffer = args.buf,
    }

    -- if no client for some reason return
    if not client then
      return
    end

    -- set keybinds
    for _, bind in pairs(keybinds) do
      vim.keymap.set(bind.mode, bind.key, bind.cmd, opts)
    end

    -- set LSP capability specific keybinds
    for cap, bind in pairs(lsp_keybinds) do
      if client:supports_method(cap) then
        vim.keymap.set(bind.mode, bind.key, bind.cmd, opts)
      end
    end

  end,
})
