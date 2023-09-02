local rubocop = require("formatting.rubocop")

require("formatter").setup({
  logging = true,
  log_level = vim.log.levels.DEBUG,
  filetype = {
    typescript = { require("formatter.filetypes.typescript").prettierd },
    javascript = { require("formatter.filetypes.javascript").prettierd },
    typescriptreact = { require("formatter.filetypes.typescriptreact").prettierd },
    javascriptreact = { require("formatter.filetypes.javascriptreact").prettierd },
    html = { require("formatter.filetypes.html").prettierd },
    css = { require("formatter.filetypes.css").prettierd },
    json = { require("formatter.filetypes.json").prettierd },
    yaml = { require("formatter.filetypes.yaml").prettierd },
    markdown = { require("formatter.filetypes.markdown").prettierd },
    lua = { require("formatter.filetypes.lua").stylua },
    ruby = { rubocop },
    -- ["*"] = {
    --   require("formatter.filetypes.any").remove_trailing_whitespace,
    -- },
  },
})
