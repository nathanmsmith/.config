local function get_file_name()
  return vim.api.nvim_buf_get_name(0)
end

local swiftlint_severities = {
  -- info = vim.diagnostic.severity.INFO,
  -- refactor = vim.diagnostic.severity.HINT,
  -- convention = vim.diagnostic.severity.WARN,
  Warning = vim.diagnostic.severity.WARN,
  Error = vim.diagnostic.severity.ERROR,
  -- fatal = vim.diagnostic.severity.ERROR,
}

require("lint").linters.swiftlint = {
  cmd = "swiftlint",
  stdin = true,
  args = { "lint", "--use-stdin", "--reporter", "json", "--quiet", get_file_name },
  stream = "stdout",
  ignore_exitcode = true,
  env = nil,
  parser = function(output, bufnr)
    print(output)
    local offenses = vim.json.decode(output)
    if vim.tbl_isempty(offenses) then
      return {}
    end
    local diagnostics = {}
    for _, offense in pairs(offenses) do
      table.insert(diagnostics, {
        lnum = offense.line - 1,
        col = 0,
        message = offense.reason,
        severity = swiftlint_severities[offense.severity],
        code = offense.rule_id,
        source = "swiftlint",
      })
    end
    return diagnostics
  end,
}
