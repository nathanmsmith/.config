local helpers = require("custom-helpers")
local servers = require("lsp.servers")

local installable_servers = servers.installable
local installable_tools = servers.tools
if helpers.isModuleAvailable("stripe") then
  installable_servers = require("stripe-lsp").installableServers()
  installable_tools = require("stripe-lsp").installableTools()
end

-- Installer config
require("mason-lspconfig").setup({
  ensure_installed = installable_servers,
  automatic_enable = false,
})
require("mason-tool-installer").setup({
  ensure_installed = installable_tools,
})

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP Specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})
vim.lsp.enable("lua_ls")
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")
vim.lsp.enable("cssls")
vim.lsp.enable("html")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("eslint")
vim.lsp.enable("vimls")
vim.lsp.enable("gopls")
vim.lsp.enable("docker_compose_language_service")
vim.lsp.enable("dockerls")
vim.lsp.enable("expert")

if helpers.isModuleAvailable("stripe") then
  require("stripe-lsp").initServers()
else
  vim.lsp.enable("sorbet")
  vim.lsp.enable("ruby_lsp")
  vim.lsp.enable("clangd")

  -- Enable TypeScript via typescript-tools
  require("typescript-tools").setup({
    settings = {
      separate_diagnostic_server = true,
      publish_diagnostic_on = "insert_leave",
      tsserver_max_memory = "auto",
      tsserver_locale = "en",
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
        if result.diagnostics == nil then
          return
        end

        local format_ts_errors = require("format-ts-errors")
        for _, entry in ipairs(result.diagnostics) do
          local formatter = format_ts_errors[entry.code]
          if formatter then
            entry.message = formatter(entry.message)
          end
        end

        vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
      end,
    },
  })
end

-- Non LspInstall server setup
if helpers.isModuleAvailable("stripe") then
  require("stripe-lsp").initServers()
end

require("lsp.handlers")
