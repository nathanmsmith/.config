local helpers = require("custom-helpers")

-- Settings
vim.diagnostic.config({
  virtual_lines = { current_line = true },
  underline = true,
  float = {
    -- Always show the source of a diagnostic message in the floating window
    source = true,
    border = "single",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ">>",
      [vim.diagnostic.severity.WARN] = "--",
      [vim.diagnostic.severity.INFO] = "i",
      [vim.diagnostic.severity.HINT] = "?",
    },
    -- TODO: Implement background diagnostic coloring
    --   linehl = {
    --     [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
    --     [vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
    --     [vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
    --     [vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
    --   },
  },
})

local severity_levels = {
  vim.diagnostic.severity.ERROR,
  vim.diagnostic.severity.WARN,
  vim.diagnostic.severity.INFO,
  vim.diagnostic.severity.HINT,
}

local get_highest_error_severity = function()
  for _, level in ipairs(severity_levels) do
    local diags = vim.diagnostic.get(0, { severity = { min = level } })
    if #diags > 0 then
      return level, diags
    end
  end
end

-- TODO: get these to work with `ghgh`ing into a floating window
vim.keymap.set("n", "[w", function()
  vim.diagnostic.jump({
    count = -1,
    float = true,
    severity = get_highest_error_severity(),
    wrap = true,
  })
end)
vim.keymap.set("n", "]w", function()
  vim.diagnostic.jump({
    count = 1,
    float = true,
    severity = get_highest_error_severity(),
    wrap = true,
  })
end)

local function my_command_complete(arg_lead, cmd_line, cursor_pos)
  local completions = { "Error", "Warn", "Info", "Hint" }

  -- Filter completions based on the current argument lead
  return vim.tbl_filter(function(item)
    return vim.startswith(item, arg_lead)
  end, completions)
end

---Set the severity
---@param severity_string string
---@return vim.diagnostic.SeverityFilter
local function set_severity(severity_string)
  ---@type vim.diagnostic.SeverityFilter
  local severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR }
  if severity_string:lower() == "error" then
    severity = vim.diagnostic.severity.ERROR
  elseif severity_string:lower() == "warn" then
    severity = vim.diagnostic.severity.WARN
  elseif severity_string:lower() == "info" then
    severity = vim.diagnostic.severity.INFO
  elseif severity_string:lower() == "hint" then
    severity = vim.diagnostic.severity.HINT
  end

  return severity
end

vim.api.nvim_create_user_command("LspQuickfix", function(opts)
  vim.diagnostic.setqflist({ severity = set_severity(opts.args) })
end, { desc = "", nargs = "?", complete = my_command_complete })
vim.api.nvim_create_user_command("LspLoclist", function(opts)
  vim.diagnostic.setloclist({ severity = set_severity(opts.args) })
end, { desc = "", nargs = "?", complete = my_command_complete })

if helpers.isModuleAvailable("stripe") then
  require("stripe").initLinters()
else
  require("diagnostic.linters")
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  desc = "Rerun linters when buffer changes",
  group = vim.api.nvim_create_augroup("Lint", { clear = true }),
  callback = function()
    -- TODO(2024-12-01,nms): Handle .b (buffer) version
    if not vim.g.disable_autolint then
      require("lint").try_lint()
    end
  end,
})

vim.api.nvim_create_user_command("LintDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autolint = true
  else
    vim.g.disable_autolint = true
  end
end, {
  desc = "Disable linting",
  bang = true,
})
vim.api.nvim_create_user_command("LintEnable", function()
  vim.b.disable_autolint = false
  vim.g.disable_autolint = false
end, {
  desc = "Re-enable linting",
})
