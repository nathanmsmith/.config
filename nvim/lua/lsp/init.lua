local helpers = require("custom-helpers")
local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

vim.lsp.set_log_level("debug")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

require("trouble").setup({
  icons = false,
  use_diagnostic_signs = true,
})

-- Define signs
local signs = { Error = ">>", Warn = "--", Hint = "?", Info = "i" }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local on_attach = function(client, bufnr)
  -- Keybindings for LSPs
  vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {
    noremap = true,
    silent = true,
  })
  vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {
    noremap = true,
    silent = true,
  })
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
end

local default_config = {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Source: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua
-- local sumneko_root_path = vim.fn.stdpath("data").."/lspinstall/lua/"
-- local sumneko_binary = sumneko_root_path.."/sumneko-lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local lua_config = {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
local no_format_config = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}

lsp_installer.settings({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
  allow_federated_servers = true,
})
lsp_installer.on_server_ready(function(server)
  if server.name == "sumneko_lua" then
    server:setup(lua_config)
  elseif server.name == "tsserver" or server.name == "jsonls" then
    server:setup(no_format_config)
  elseif server.name == "html" then
    server:setup(no_format_config)
  elseif server.name == "cssls" then
    server:setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
      end,
      settings = {
        css = {
          validate = false,
        },
      },
    })
  else
    server:setup(default_config)
  end
  vim.cmd([[ do User LspAttachBuffers ]])
end)

-- Non LspInstall server setup
if helpers.isModuleAvailable("stripe") then
  require("stripe").initServers(no_format_config.on_attach)
else
  -- lspconfig.html.setup(no_format_config)
  lspconfig.sorbet.setup(default_config)
  lspconfig.gopls.setup(no_format_config)

  -- null-ls config
  require('lsp.null_ls')
end
