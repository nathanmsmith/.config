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
