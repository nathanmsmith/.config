-- Copied from https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/luacheck.lua
local pattern = "[^:]+:(%d+):(%d+)-(%d+): %((%a)(%d+)%) (.*)"
local groups = { "lnum", "col", "end_col", "severity", "code", "message" }
local severities = {
  W = vim.diagnostic.severity.WARN,
  E = vim.diagnostic.severity.ERROR,
}

return {
  cmd = "luacheck",
  stdin = true,
  args = { "--formatter", "plain", "--codes", "--ranges", "-" },
  ignore_exitcode = true,
  cwd = require("lspconfig.util").root_pattern(".luacheckrc"),
  parser = require("lint.parser").from_pattern(
    pattern,
    groups,
    severities,
    { ["source"] = "luacheck" },
    { end_col_offset = 0 }
  ),
}
