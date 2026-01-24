-- lua-language-server Configuration --

return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        -- include nvim APIs
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
