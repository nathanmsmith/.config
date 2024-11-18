local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  require("stripe-fuzzy_find").initFuzzyFind()
else
  require("telescope").setup({
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-u>"] = false,
          ["<C-d>"] = false,
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
      live_grep = {
        additional_args = {
          "--smart-case",
          "--hidden",
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })
end

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

vim.keymap.set("n", "<leader>p", require("telescope.builtin").find_files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>h", require("telescope.builtin").help_tags, { desc = "Search [H]elp" })
vim.keymap.set("n", "<leader>k", require("telescope.builtin").help_tags, { desc = "Search [K]eymaps" })
vim.keymap.set("n", "<leader>w", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>f", require("telescope.builtin").live_grep, { desc = "[F]ind by Grep" })
vim.keymap.set("n", "<leader>d", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>m", require("telescope.builtin").marks, { desc = "[M]arks" })
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers, { desc = "Find existing [B]uffers" })
vim.keymap.set(
  "n",
  "<leader>/",
  require("telescope.builtin").current_buffer_fuzzy_find,
  { desc = "[/] Fuzzily search in current buffer]" }
)

if helpers.isModuleAvailable("stripe") then
  require("stripe-fuzzy_find").initKeybinds()
end
