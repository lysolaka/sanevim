local lspconfig = require("lspconfig")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = require("mason-lspconfig").get_installed_servers()
-- make a manual list because formatters are lsp servers apparently
-- local servers = {
--   "basedpyright",
--   "clangd",
--   "lua_ls",
--   "ruff",
--   "rust_analyzer",
--   "texlab",
-- }

local function fetch_cfg(server)
  local exists, lsp_cfg = pcall(require, "config.lsp." .. server)
  if exists then
    return lsp_cfg
  else
    return {}
  end
end

-- LOAD LSP CONFIGS --
for _, server in ipairs(servers) do
  local lsp_cfg = fetch_cfg(server)
  local cfg = vim.tbl_extend("keep", lsp_cfg, cmp_capabilities)
  lspconfig[server].setup(cfg)
end
