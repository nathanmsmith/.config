require("diagnostic.linters.rubocop")
require("diagnostic.linters.swiftlint")
require("diagnostic.linters.luacheck")

local lint = require("lint")
lint.linters_by_ft = {
  json = {},
  lua = { "luacheck" },
  ruby = { "rubocop" },
  swift = { "swiftlint" },
  go = { "golangcilint" },
  elixir = { "credo" },
}
