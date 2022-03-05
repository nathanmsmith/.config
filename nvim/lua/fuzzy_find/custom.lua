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

-- Frencency scorer: https://github.com/nvim-telescope/telescope-frecency.nvim/issues/49#issuecomment-1029356290https://github.com/nvim-telescope/telescope-frecency.nvim/issues/49#issuecomment-1029356290https://github.com/nvim-telescope/telescope-frecency.nvim/issues/49#issuecomment-1029356290https://github.com/nvim-telescope/telescope-frecency.nvim/issues/49#issuecomment-1029356290
local function frecency_score(self, prompt, line, entry)
  if prompt == nil or prompt == "" then
    for _, file_entry in ipairs(self.state.frecency) do
      local filepath = entry.cwd .. "/" .. entry.value
      if file_entry.filename == filepath then
        return 9999 - file_entry.score
      end
    end

    return 9999
  end

  return self.default_scoring_function(self, prompt, line, entry)
end
local function frecency_start(self, prompt)
  self.default_start(self, prompt)

  if not self.state.frecency then
    self.state.frecency = frecency_db.get_file_scores()
  end
end

M.frecency_sorter = function(opts)
  local fzf_sorter = fzf.native_fzf_sorter()

  fzf_sorter.default_scoring_function = fzf_sorter.scoring_function
  fzf_sorter.default_start = fzf_sorter.start

  fzf_sorter.scoring_function = frecency_score
  fzf_sorter.start = frecency_start

  return fzf_sorter
end

return M
