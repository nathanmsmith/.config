local lsp_status = require('lsp-status')
local diagnostic = require('diagnostic')
local completion = require('completion')
local nvim_lsp = require('nvim_lsp')
local configs = require('nvim_lsp/configs')
local util = require('nvim_lsp/util')

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  diagnostic.on_attach(client, bufnr)
  completion.on_attach(client, bufnr)
end


lsp_status.register_progress()
lsp_status.config({
  status_symbol = ''
})

nvim_lsp.clangd.setup({
  callbacks = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true
  },
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
})
nvim_lsp.pyls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.sumneko_lua.setup{
  on_attach = on_attach,
}
nvim_lsp.vimls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.tsserver.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.html.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.cssls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  settings = {
    css = {
      validate = false
    },
    less = {
      validate = true
    },
    scss = {
      validate = true
    }
  }
}

local server_name = "svelte_lsp"
local bin_name = "svelteserver"

-- local installer = util.npm_installer {
--   server_name = server_name,
--   packages = {"svelte-language-server"},
--   binaries = {bin_name}
-- }

configs[server_name] = {
  default_config = {
    cmd = {bin_name, "--stdio"};
    filetypes = {"svelte"};
    root_dir = util.root_pattern("package.json", "tsconfig.json", ".git");
   -- docs = {
   --   description = [[
   --   https://github.com/theia-ide/typescript-language-server
   --   `typescript-language-server` can be installed via `:LspInstall tsserver` or by yourself with `npm`:
   --   ```sh
   --   npm install -g typescript-language-server
   --   ```
   --   ]];
   --   default_config = {
   --     root_dir = [[root_pattern("package.json", "tsconfig.json", ".git")]];
   --   };
   -- };
 };
}
nvim_lsp.svelte_lsp.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.rust_analyzer.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
