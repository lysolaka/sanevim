-- basedpyright Configuration --

return {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
  -- disable semantic tokens: treesitter for Python is better
  -- TODO: check if the statement above is true
  -- on_attach = function(client, _)
  --   client.server_capabilities.semanticTokensProvider = nil
  -- end,
}
