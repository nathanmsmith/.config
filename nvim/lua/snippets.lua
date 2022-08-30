local helpers = require("custom-helpers")
require("luasnip").setup({
  history = true,
  -- update_events = "TextChanged,TextChangedI",
  -- enable_autosnippets = true,
})
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
if helpers.isModuleAvailable("stripe") then
  require("stripe").initSnippets()
end

local skeletons = require("skeletons")

-- Set choice toggle to <c-e>
vim.keymap.set(
  { "i", "s" },
  "<c-e>",
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-e>'",
  { silent = true, expr = true }
)

local function expandSkeletonSnippet(language, skeleton)
  local snippet = skeletons[language][skeleton]
  if snippet == nil then
    return
  end

  vim.o.eventignore = "all"
  require("luasnip").snip_expand(snippet)
  vim.o.eventignore = ""
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, true, true)
  vim.api.nvim_command("normal! " .. esc .. "gg")
end

local function insertSkeleton()
  local filename = vim.fn.expand("%")

  -- " Abort on non-empty buffer or extant file
  if not (vim.fn.line("$") == 1 and vim.fn.getline("$") == "") or vim.fn.filereadable(filename) == 1 then
    return
  end

  if vim.fn.empty("b:projectionist") == 0 then
    local results = vim.fn["projectionist#query"]("skeleton")
    for _, tuple in ipairs(results) do -- Table iteration.
      local skeleton = tuple[2]
      expandSkeletonSnippet(vim.bo.filetype, skeleton)
      break
    end
  end
end

local group = vim.api.nvim_create_augroup("Skeletons", { clear = true })
vim.api.nvim_create_autocmd("User ProjectionistActivate", {
  callback = insertSkeleton,
  group = group,
  pattern = "*",
})
