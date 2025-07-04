return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = false,
  },
  root_markers = {
    ".git",
  },
  settings = {
    json = {
      schemas = {
        {
          name = "jsonc files",
          fileMatch = { "*.jsonc" },
          schema = {
            allowTrailingCommas = true,
            allowComments = true,
          },
        },
        {
          description = "code snippet files",
          fileMatch = { "nvim/snippets/**/*.jsonc" },
          name = "Neovim/VSCode Code Snippets",
          url = "https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json",
        },
      },
      -- TODO: Adding the JSONC rule dosen't seem to work. Is there another way to enable schemastore?
      -- Does it make sense to enable schemastore?
      -- schemas = require("schemastore").json.schemas({
      --   extra = {
      --     name = "jsonc files",
      --     fileMatch = { "*.jsonc" },
      --     schema = {
      --       allowTrailingCommas = true,
      --       allowComments = true,
      --     },
      --   },
      -- }),
      validate = {
        enable = true,
      },
      commandsSchema = {
        ignoredComments = true,
      },
    },
  },
}
