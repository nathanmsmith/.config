local util = require("lspconfig.util")

-- Copied from https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/luacheck.lua
local pattern = "[^:]+:(%d+):(%d+)-(%d+): %((%a)(%d+)%) (.*)"
local groups = { "lnum", "col", "end_col", "severity", "code", "message" }
local severities = {
  W = vim.diagnostic.severity.WARN,
  E = vim.diagnostic.severity.ERROR,
}

local function get_luacheck_config()
  return util.path.join(util.root_pattern(".luacheckrc")(vim.api.nvim_buf_get_name(0)), ".luacheckrc")
end

require("lint").linters.luacheck = {
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
