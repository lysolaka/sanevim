return {
  settings = {
    ["rust-analyzer"] = {
      completion = {
        autoimport = {
          enable = false
        },
      },
    },
  },
  -- on_attach = function(client, _)
  --   client.server_capabilities.semanticTokensProvider = nil
  -- end,
}
