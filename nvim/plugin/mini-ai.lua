vim.pack.add({
  "https://github.com/echasnovski/mini.ai",
})

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
