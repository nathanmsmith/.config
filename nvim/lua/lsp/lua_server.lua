local capabilities = require("lsp.capabilities")
local on_attach = require("lsp.on_attach")

local neovim_settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = "LuaJIT",
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
}

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
      },
    },
  }
end

-- Source: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
require("lspconfig").sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    local path = client.workspace_folders[1].name

    if string.match(path, ".config/hammerspoon") then
      client.config.settings = create_hs_config()
    elseif string.match(path, ".config/nvim") then
      client.config.settings = neovim_settings
    end

    client.notify("workspace/didChangeConfiguration")
    return true
  end,
})
