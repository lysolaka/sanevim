local bindings = require("config.keybinds.bindings")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = {
      noremap = true,
      silent = true,
      buffer = bufnr
    }

    if not client then
      return
    end

    for cap, bind in pairs(bindings) do
      if client.supports_method(cap) then
        vim.keymap.set(bind.mode, bind.key, bind.cmd, opts)
      end
    end

  end,
})
