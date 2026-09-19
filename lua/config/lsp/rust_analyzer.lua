-- rust_analyzer Configuration --

-- override rust-analyzer with the one installed using rustup, if it exists
local function rust_analyzer()
  local cargo_home = vim.env["CARGO_HOME"] or vim.fs.joinpath(vim.env["HOME"], ".cargo")
  local ra = vim.fs.joinpath(cargo_home, "bin", "rust-analyzer")

  if vim.fn.executable(ra) == 1 then
    return ra
  else
    return "rust-analyzer"
  end
end

return {
  cmd = { rust_analyzer() },
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
