return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
  -- yet another hack today, FACK majkrosoft
  on_attach = function(client, _)
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
