local function get_file_name()
  return vim.api.nvim_buf_get_name(0)
end

local pattern = "%[%a%]%s+(.+)%s+[^:]+:(%d+):?(%d*)%s+(.*)"
local groups = { "severity", "lnum", "col", "message" }
local severity = {
  ["↑"] = vim.diagnostic.severity.ERROR,
  ["↗"] = vim.diagnostic.severity.WARN,
  ["→"] = vim.diagnostic.severity.INFO,
  ["↘"] = vim.diagnostic.severity.HINT,
  ["↓"] = vim.diagnostic.severity.HINT,
}

require("lint").linters.credo = {
  cmd = "mix",
  stdin = true,
  args = { "credo", "--read-from-stdin", "list", "--format=oneline", "--strict", get_file_name },
  stream = "stdout",
  ignore_exitcode = true, -- credo only returns 0 if there are no errors
  parser = require("lint.parser").from_pattern(pattern, groups, severity, { ["source"] = "credo" }),
}
