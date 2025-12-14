local ensure_installed = {
  "c",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "query",
  "vim",
  "vimdoc",
  -- NOTE: the above are natively installed since neovim 0.12
  "bash",
  "diff",
  "dockerfile",
  "gitignore",
  "git_config",
  "luadoc",
  "regex",
  "toml",
  "yaml",
  "csv",
  "python",
  "html",
  "css",
  "javascript",
  "typescript",
  "tsx",
  "json",
  "elixir",
  "heex",
  "eex",
  "starlark",
  "fish",
  "go",
  "ruby",
}

-- Check if tree-sitter CLI is installed
if vim.fn.executable("tree-sitter") == 0 then
  vim.notify(
    "tree-sitter CLI not found. Some parsers may fail to install.\nInstall with: brew install tree-sitter",
    vim.log.levels.WARN
  )
end

require("nvim-treesitter").install(ensure_installed):wait(300000)

-- Enable treesitter highlighting and indentation for all filetypes
local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = ensure_installed,
  callback = function(_args)
    -- Enable highlighting
    vim.treesitter.start()

    -- Indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    -- Folding via Treesitter
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.o.foldlevel = 99
  end,
})

-- Treesitter textobjects configuration
require("nvim-treesitter-textobjects").setup({
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      ["]m"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  },
})

vim.filetype.add({
  extension = {
    cconf = "python",
    rbi = "ruby",
    sky = "starlark",
  },
  pattern = {
    [".*/%.vscode/.*%.json"] = "json5", -- These json files frequently have comments
  },
})
