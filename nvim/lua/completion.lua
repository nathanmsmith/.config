local cmp = require("cmp")
local lspkind = require("lspkind")

vim.o.complete = ".,w,b,u"
vim.o.completeopt = "menu"

vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
vim.g.UltiSnipsRemoveSelectModeMappings = 0

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  completion = {
    autocomplete = false,
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      maxwidth = 50,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        ultisnips = "[Snippet]",
        path = "[Path]",
      },
    }),
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping({
      -- c = function()
      --   if cmp.visible() then
      --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      --   else
      --     cmp.complete()
      --   end
      -- end,
      i = function(fallback)
        if cmp.get_selected_entry() == nil and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
          vim.api.nvim_feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"), "n", true)
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
        elseif cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end,
    }),
    ["<S-Tab>"] = cmp.mapping({
      -- c = function()
      --   if cmp.visible() then
      --     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      --   else
      --     cmp.complete()
      --   end
      -- end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
        else
          fallback()
        end
      end,
    }),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
    ["<C-n>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Down>"), "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ["<C-p>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Up>"), "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      -- c = function(fallback)
      --   if cmp.visible() then
      --     cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      --   else
      --     fallback()
      --   end
      -- end,
    }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "ultisnips" },
    -- { name = "path" },
  }, {
    { name = "buffer" },
  }),
})

-- -- Use buffer source for `/`.
-- cmp.setup.cmdline("/", {
--   completion = { autocomplete = false },
--   sources = {
--     -- { name = 'buffer' }
--     { name = "buffer", opts = { keyword_pattern = [=[[^[:blank:]].*]=] } },
--   },
-- })

-- -- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(":", {
--   completion = { autocomplete = false },
--   sources = cmp.config.sources({
--     { name = "path" },
--   }, {
--     { name = "cmdline" },
--   }),
-- })
