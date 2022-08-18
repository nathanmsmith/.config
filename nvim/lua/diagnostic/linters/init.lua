require("diagnostic.linters.rubocop")
require("diagnostic.linters.swiftlint")
require("lint").linters_by_ft = {
  lua = { "luacheck" },
  ruby = { "rubocop" },
  swift = { "swiftlint" },
  go = { "golangcilint" },
}
