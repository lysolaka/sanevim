-- rust_analyzer Configuration --

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
}
