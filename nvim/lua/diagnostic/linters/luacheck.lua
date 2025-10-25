-- Copied from https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/luacheck.lua

local pattern = "[^:]+:(%d+):(%d+)-(%d+): %((%a)(%d+)%) (.*)"
local groups = { "lnum", "col", "end_col", "severity", "code", "message" }
local severities = {
  W = vim.diagnostic.severity.WARN,
  E = vim.diagnostic.severity.ERROR,
}

local function get_luacheck_config()
  local config = vim.fs.find(".luacheckrc", {
    upward = true,
    path = vim.api.nvim_buf_get_name(0),
    limit = 1,
    type = "file",
  })[1]
  return config
end

require("lint").linters.luacheck = {
  name = "Luacheck",
  cmd = "luacheck",
  stdin = true,
  args = { "--formatter", "plain", "--codes", "--ranges", "--config", get_luacheck_config, "-" },
  ignore_exitcode = true,
  parser = require("lint.parser").from_pattern(
    pattern,
    groups,
    severities,
    { ["source"] = "luacheck" },
    { end_col_offset = 0 }
  ),
}
