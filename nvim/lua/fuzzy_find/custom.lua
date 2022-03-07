local ext = require("telescope._extensions")
local builtins = require("telescope.builtin")
local frecency_db = require("telescope._extensions.frecency.db_client")
local fzf = ext.manager.fzf

local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

return M
