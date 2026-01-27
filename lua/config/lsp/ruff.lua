-- ruff Configuration --

return {
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      lineLength = 100,
      fixAll = false,
      organizeImports = false,
      showSyntaxErrors = false,
      lint = {
        enable = false,
      },
    },
  },
}
