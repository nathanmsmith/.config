require("diagnostic.linters.rubocop")
require("diagnostic.linters.swiftlint")
require("lint").linters_by_ft = {
  json = {},
  lua = { "luacheck" },
  ruby = { "rubocop" },
  swift = { "swiftlint" },
  -- go = { "golangcilint" },
}
