return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        buildScripts = {
          enable = true
        },
      },
      completion = {
        autoimport = {
          enable = false
        },
      },
      procMacro = {
        enable = true
      },
    },
  },
  -- on_attach = function(client, _)
  --   client.server_capabilities.semanticTokensProvider = nil
  -- end,
}
