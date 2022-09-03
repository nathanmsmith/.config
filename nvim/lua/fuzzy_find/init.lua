require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
      },
    },
    file_ignore_patterns = { "^.git/", ".DS_Store" },

    -- Theme
    sorting_strategy = "ascending",
    layout_strategy = "center",
    results_title = false,
    preview_title = "Preview",
    layout_config = {
      preview_cutoff = 1, -- Preview should always show (unless previewer = false)

      width = function(_, max_columns, _)
        return math.min(max_columns - 3, 80)
      end,

      height = function(_, _, max_lines)
        return math.min(max_lines - 4, 15)
      end,
    },
    borderchars = {
      { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    -- ["ui-select"] = {}
  },
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

--Add leader shortcuts
-- vim.keymap.set("n", "<leader>p", require("fuzzy_find.custom").project_files, { silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>p",
  [[<cmd>lua require('telescope.builtin').find_files()<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>P",
  [[<cmd>lua require('telescope.builtin').find_files({no_ignore = true})<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>f",
  [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>b",
  [[<cmd>lua require('telescope.builtin').buffers()<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>h",
  [[<cmd>lua require('telescope.builtin').help_tags()<cr>]],
  { noremap = true, silent = true }
)

-- Git
vim.api.nvim_set_keymap(
  "n",
  "<leader>gc",
  [[<cmd>lua require('telescope.builtin').git_commits()<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>gb",
  [[<cmd>lua require('telescope.builtin').git_branches()<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>gs",
  [[<cmd>lua require('telescope.builtin').git_status()<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>gp",
  [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]],
  { noremap = true, silent = true }
)
