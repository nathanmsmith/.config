require("diagnostic.linters.rubocop")
require("lint").linters_by_ft = {
  ruby = { "rubocop" },
  lua = { "luacheck" },
}
