local M = {}
local is_work = require("custom-helpers").isModuleAvailable("stripe")

--- Set formatters for a filetype, choosing between work and personal config.
--- If the active context has no config for this filetype, no formatters are set.
---@param ft string
---@param opts { work?: conform.FormatterList, personal?: conform.FormatterList }
function M.set(ft, opts)
  local formatters = is_work and opts.work or opts.personal
  if formatters then
    require("conform").formatters_by_ft[ft] = formatters
  end
end

return M
