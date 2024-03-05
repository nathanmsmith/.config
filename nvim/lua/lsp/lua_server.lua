local function create_hs_config()
  -- Source: https://www.reddit.com/r/neovim/comments/pla7bv/since_everyone_is_getting_more_familiar_with_lua/
  local hs_version = vim.fn.system("hs -c _VERSION"):gsub("[\n\r]", "")
  local hs_path = vim.split(vim.fn.system("hs -c package.path"):gsub("[\n\r]", ""), ";")

  return {
    settings = {
      Lua = {
        runtime = {
          version = hs_version,
          path = hs_path,
        },
        diagnostics = { globals = { "hs" } },
        workspace = {
          library = {
            string.format("%s/.config/hammerspoon/Spoons/EmmyLua.spoon/annotations", os.getenv("HOME")),
          },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Source: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
require("lspconfig").lua_ls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local path = client.workspace_folders[1].name

    if string.match(path, ".config/hammerspoon") then
      client.config.settings = create_hs_config()
      client.notify("workspace/didChangeConfiguration")
    end

    return true
  end,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})
