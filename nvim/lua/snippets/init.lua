local ls = require("luasnip")
local types = require("luasnip.util.types")
local helpers = require("custom-helpers")

require("luasnip").setup({
  -- Updates all placeholders if there are multiple (e.g., `plvi` snippet in Lua )
  update_events = { "TextChanged", "TextChangedI" },
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "Choice (<c-h>, <c-l>)", "LuasnipChoiceNode" } },
        hl_mode = "combine",
      },
    },
  },
})

local active = function(filter)
  filter = filter or {}
  filter.direction = filter.direction or 1

  if filter.direction == 1 then
    return ls.expand_or_jumpable()
  else
    return ls.jumpable(filter.direction)
  end
end

local jump = function(direction)
  if direction == 1 then
    if ls.expandable() then
      return ls.expand_or_jump()
    else
      return ls.jumpable(1) and ls.jump(1)
    end
  else
    return ls.jumpable(-1) and ls.jump(-1)
  end
end

-- Stole these from TJ
-- https://github.com/tjdevries/config.nvim/blob/e47e28da1da65f5aafbf8bd6431f628ad51d1f8f/lua/custom/snippets.lua#L6
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  return active({ direction = 1 }) and jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  return active({ direction = -1 }) and jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end, { silent = true })

-- TODO: LSP-aware version
-- Helper to check if LSP snippet can be expanded
-- local function lsp_expandable()
--   local lsp_snippet = vim.lsp.util.get_current_line():match("^%s*(%S+)")
--   if not lsp_snippet then return false end
--
--   -- Check if there's an LSP snippet for the word under cursor
--   for _, client in ipairs(vim.lsp.get_active_clients()) do
--     if client.server_capabilities.completionProvider and
--        client.server_capabilities.completionProvider.resolveProvider then
--       return true
--     end
--   end
--   return false
-- end
--
-- local active = function(filter)
--   filter = filter or {}
--   filter.direction = filter.direction or 1
--
--   if filter.direction == 1 then
--     return ls.expand_or_jumpable() or lsp_expandable()
--   else
--     return ls.jumpable(filter.direction)
--   end
-- end
--
-- local jump = function(direction)
--   if direction == 1 then
--     if ls.expandable() then
--       return ls.expand()
--     elseif lsp_expandable() then
--       -- This expands LSP snippets through LuaSnip's interface
--       local bufnr = vim.api.nvim_get_current_buf()
--       local pos = vim.api.nvim_win_get_cursor(0)
--       local col = pos[2]
--       local line = vim.api.nvim_get_current_line()
--       local word = line:match("^%s*(%S+)")
--
--       if word then
--         -- Tell LuaSnip to expand LSP snippet
--         return ls.lsp_expand(word)
--       end
--     elseif ls.jumpable(1) then
--       return ls.jump(1)
--     end
--   else
--     return ls.jumpable(-1) and ls.jump(-1)
--   end
-- end

require("luasnip.loaders.from_vscode").lazy_load({
  paths = { vim.fn.stdpath("config") .. "/snippets", "~/stripe/stripe-config/nvim/snippets" },
})

-- -- Skeletons
-- -- local function expandSkeletonSnippet(language, skeleton)
-- --   local snippet = skeletons[language][skeleton]
-- --   if snippet == nil then
-- --     return
-- --   end
--
-- --   vim.o.eventignore = "all"
-- --   require("luasnip").snip_expand(snippet)
-- --   vim.o.eventignore = ""
-- --   local esc = vim.api.nvim_replace_termcodes("<ESC>", true, true, true)
-- --   vim.api.nvim_command("normal! " .. esc .. "gg")
-- -- end
--
-- -- local function insertSkeleton()
-- --   local filename = vim.fn.expand("%")
--
-- --   -- " Abort on non-empty buffer or extant file
-- --   if not (vim.fn.line("$") == 1 and vim.fn.getline("$") == "") or vim.fn.filereadable(filename) == 1 then
-- --     return
-- --   end
--
-- --   if vim.fn.empty("b:projectionist") == 0 then
-- --     local results = vim.fn["projectionist#query"]("skeleton")
-- --     for _, tuple in ipairs(results) do -- Table iteration.
-- --       local skeleton = tuple[2]
-- --       expandSkeletonSnippet(vim.bo.filetype, skeleton)
-- --       break
-- --     end
-- --   end
-- -- end
--
-- -- local group = vim.api.nvim_create_augroup("Skeletons", { clear = true })
-- -- vim.api.nvim_create_autocmd("User ProjectionistActivate", {
-- --   callback = insertSkeleton,
-- --   group = group,
-- --   pattern = "*",
-- -- })
--
