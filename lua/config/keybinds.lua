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

-- setup LSP specific keybinds
local function setup_lsp_bindings(bufnr, client)
  -- keymap options
  local opts = {
    noremap = true,
    silent = true,
    buffer = bufnr,
  }

  -- set LSP capability specific keybinds
  for cap, bind in pairs(lsp_keybinds) do
    if client:supports_method(cap, bufnr) then
      vim.keymap.set(bind.mode, bind.key, bind.cmd, opts)
    end
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- LSP client running in the buffer
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- if no client for some reason return
    if not client then
      return
    end

    -- keymap options
    local opts = {
      noremap = true,
      silent = true,
      buffer = args.buf,
    }

    -- set keybinds
    for _, bind in pairs(keybinds) do
      vim.keymap.set(bind.mode, bind.key, bind.cmd, opts)
    end

    setup_lsp_bindings(args.buf, client)
  end,
})

-- original builtin handler for dynamic LSP capability registration
local client_register_capability = vim.lsp.handlers["client/registerCapability"]

vim.lsp.handlers["client/registerCapability"] = function(err, result, ctx, config)
  -- LSP client registering the new capability
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  -- run the original handler
  local ret = client_register_capability(err, result, ctx, config)

  -- if no client for some reason return
  if not client then
    return
  end

  -- setup keybinds for every buffer attached
  for bufnr in pairs(client.attached_buffers) do
    setup_lsp_bindings(bufnr, client)
  end

  return ret
end
