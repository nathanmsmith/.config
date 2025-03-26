require("diagnostic.linters.rubocop")
require("diagnostic.linters.swiftlint")
require("diagnostic.linters.luacheck")

local lint = require("lint")
-- HACK: temp fix until
-- https://github.com/mfussenegger/nvim-lint/pull/761 is merged
lint.linters.golangcilint.args = {
  "run",
  "--output.json.path=stdout",
  "--issues-exit-code=0",
  "--show-stats=false",
  function()
    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
  end,
}
lint.linters_by_ft = {
  json = {},
  lua = { "luacheck" },
  ruby = { "rubocop" },
  swift = { "swiftlint" },
  go = { "golangcilint" },
}
