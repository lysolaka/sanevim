local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = require("mason-lspconfig").get_installed_servers()

-- UPDATE AUTOCOMPLETION FOR ALL CLIENTS --
vim.lsp.config("*", cmp_capabilities)

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
  local cfg = fetch_cfg(server)
  vim.lsp.config(server, cfg)
  vim.lsp.enable(server)
end
