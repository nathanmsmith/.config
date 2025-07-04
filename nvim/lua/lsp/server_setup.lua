local helpers = require("custom-helpers")
local lspconfig = require("lspconfig")

local basic_servers = require("lsp.servers").basic
if helpers.isModuleAvailable("stripe") then
  basic_servers = require("stripe-lsp").basicServers()
end

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP Specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

for _, lsp in ipairs(basic_servers) do
  lspconfig[lsp].setup({ capabilities = capabilities })
end

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

-- Enable servers
vim.lsp.enable("lua_ls")
vim.lsp.enable("jsonls")

-- Advanced server setup
--
--
-- require("lsp.emmet")
-- require("lsp.lua_server")
-- require("lsp.jsonls")
require("lsp.yamlls")

-- Non LspInstall server setup
if helpers.isModuleAvailable("stripe") then
  require("stripe-lsp").initServers()
else
  -- require("lsp.sourcekit")
  require("lsp.sorbet")
  require("lsp.typescript")
  require("lsp.ruby_lsp")

  -- 2025-06-02: This is the new nvim 0.11 way of enabling LSPs.
  vim.lsp.enable("clangd")
end
