local helpers = require("custom-helpers")

-- nvim-surround
require("nvim-surround").setup()

-- nvim-highlight-colors
require("nvim-highlight-colors").setup({ render = "virtual", enable_tailwind = true })

-- faster.nvim
require("faster").setup()

-- oil.nvim
require("oil").setup({
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-s>"] = false,
    ["<C-t>"] = false,
    ["<C-p>"] = false,
    ["<C-c>"] = false,
    ["<C-r>"] = "actions.refresh",
  },
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, bufnr)
      return helpers.contains({ ".DS_Store", ".." }, name)
    end,
  },
  confirmation = {
    border = "single",
  },
})
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- vim-wordmotion
local before_words = function(s, w)
  local before = [[\%(]] .. w .. s .. [[*\)\@<=]]
  return before .. s
end

local after_words = function(s, w)
  local after = [[\%(]] .. s .. "*" .. w .. [[\)\@=]]
  return s .. after
end

local between_words = function(s, w)
  local before = [[\%(]] .. w .. s .. [[*\)\@<=]]
  local after = [[\%(]] .. s .. "*" .. w .. [[\)\@=]]
  return before .. s .. after
end

local alpha = "[[:lower:][:upper:]]"
local alnum = "[[:lower:][:upper:][:digit:]]"
local alnum_with_graph = "[[:lower:][:upper:][:digit:][:graph:]]"

vim.g.wordmotion_spaces = {
  between_words("_", alnum),
  between_words("-", alpha),
  between_words([[\.]], alnum),
  before_words(",", alnum_with_graph),
  after_words(",", alnum_with_graph),
  before_words(":", alnum_with_graph),
  after_words(":", alnum_with_graph),
  before_words('"', alnum_with_graph),
  after_words('"', alnum_with_graph),
  before_words("'", alnum_with_graph),
  after_words("'", alnum_with_graph),
  before_words("(", alnum),
  after_words("(", alnum),
  before_words(")", alnum),
  after_words(")", alnum),
  before_words("`", alnum_with_graph),
  after_words("`", alnum_with_graph),
  before_words("%", alnum_with_graph),
  after_words("%", alnum_with_graph),
  before_words("\\[", alnum),
  after_words("\\[", alnum),
  before_words("\\]", alnum),
  after_words("\\]", alnum),
  before_words("{", alnum),
  after_words("{", alnum),
  before_words("}", alnum),
  after_words("}", alnum),
  before_words(";", alnum),
  after_words(";", alnum_with_graph),
  before_words("?", alnum_with_graph),
  after_words("?", alnum_with_graph),
  before_words("=", alnum),
  after_words("=", alnum),
  before_words("<", alnum),
  after_words("<", alnum),
  before_words(">", alnum),
  after_words(">", alnum),
  before_words("/", alnum_with_graph),
  after_words("/", alnum_with_graph),
}

-- mini.ai
local ai = require("mini.ai")
require("mini.ai").setup({
  n_lines = 1000,
  search_method = "cover",
  custom_textobjects = {
    -- Disable brackets alias in favor of builtin block textobject
    ["b"] = false,

    -- Replicate the "entire" object from https://github.com/kana/vim-textobj-entire
    ["e"] = function()
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line("$"),
        col = math.max(vim.fn.getline("$"):len(), 1),
      }
      return { from = from, to = to }
    end,

    ["r"] = ai.gen_spec.treesitter({ -- code block
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),

    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),

    ["t"] = ai.gen_spec.treesitter({ a = "@tag.outer", i = "@tag.inner" }),
  },
})

-- mini.splitjoin
require("mini.splitjoin").setup()

-- undotree keymap
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undotree" })

-- vim-rails: eruby.yaml filetype fix
if not helpers.isModuleAvailable("stripe") then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "eruby.yaml",
    command = "set filetype=yaml",
  })
end
