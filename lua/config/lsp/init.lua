-- LSP Configuration and Startup --
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = require("mason-lspconfig").get_installed_servers()

-- update autocompletion for all clients
vim.lsp.config("*", cmp_capabilities)

-- fetch LSP config from its config file
-- if there is no user cfg, returns an empty table
local function fetch_cfg(server)
  local exists, cfg = pcall(require, "config.lsp." .. server)
  if exists then
    return cfg
  else
    return {}
  end
end

-- load config and enable the LSP
for _, server in ipairs(servers) do
  local cfg = fetch_cfg(server)
  vim.lsp.config(server, cfg)
  vim.lsp.enable(server)
end
