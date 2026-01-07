-- Register custom make-range! directive for treesitter queries
-- This creates a range from two separate captures (used in JSX/TSX textobjects)
vim.treesitter.query.add_directive("make-range!", function(match, _, _, pred, metadata)
  local capture_id = pred[2]
  if type(capture_id) == "string" then
    capture_id = capture_id:gsub("^@", "")
    local start_capture = pred[3]:gsub("^@", "")
    local end_capture = pred[4]:gsub("^@", "")

    local start_node = match[start_capture]
    local end_node = match[end_capture]

    if start_node and end_node then
      local start_row, start_col = start_node:range()
      local _, _, end_row, end_col = end_node:range()

      metadata[capture_id] = metadata[capture_id] or {}
      metadata[capture_id].range = { start_row, start_col, end_row, end_col }
    end
  end
end, { force = true })

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
local filetypes = vim.list_extend(vim.list_slice(ensure_installed), {
  "typescriptreact", -- TSX files
  "javascriptreact", -- JSX files
})

local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = filetypes,
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
