local prettier = require("formatting.prettier")
local stylua = require("formatting.stylua")
local rubocop = require("formatting.rubocop")

require("formatter").setup({
  filetype = {
    typescript = { prettier },
    javascript = { prettier },
    typescriptreact = { prettier },
    javascriptreact = { prettier },
    html = { prettier },
    css = { prettier },
    json = { prettier },
    yaml = { prettier },
    markdown = { prettier },
    lua = { stylua },
    ruby = { rubocop },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
})
