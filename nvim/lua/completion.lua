local cmp = require("cmp")

-- Pretty labels for displaying sources in completion menu
local source_labels = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  luasnip = "[Snippet]",
  path = "[Path]",
}

local formatting = {
  expandable_indicator = true,
  fields = { "abbr", "kind", "menu" },
  format = function(entry, item)
    item.menu = source_labels[entry.source.name]
    return item
  end,
}

local mappings = {
  -- Start completion (ctrl-n)
  ["<C-n>"] = cmp.mapping({
    i = function()
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      else
        cmp.complete()
      end
    end,
    c = function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end,
  }),
  -- Previous item (ctrl-p)
  ["<C-p>"] = cmp.mapping({
    i = function()
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      else
        cmp.complete()
      end
    end,
    c = function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end,
  }),
  -- Accept completion
  ["<CR>"] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  }),
  -- Cancel completion (ctrl-e)
  ["<C-e>"] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  -- Scroll docs down (ctrl-f)
  ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  -- Scroll docs up (ctrl-b)
  ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
}

cmp.setup({
  completion = {
    autocomplete = false,
    -- Weirdly, I don't get noinsert behavior when setting vim.opt.completeopt.
    -- Not sure what's up with that!
    -- vim.opt.completeopt = { "menu", "menuone", "noinsert", "preview" }
    completeopt = "menu,menuone,noinsert",
  },
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = {
      border = "single",
      winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None",
      scrollbar = true,
    },
    documentation = {
      border = "single",
      winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder",
      scrollbar = true,
    },
  },
  formatting = formatting,
  sources = cmp.config.sources({
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "lazydev" },
    {
      name = "buffer",
      -- Get words from all visible buffers
      -- https://github.com/hrsh7th/cmp-buffer?tab=readme-ov-file#visible-buffers
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = mappings,
})

-- Command mode completions
cmp.setup.cmdline({ "/", "?" }, {
  mapping = mappings,
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  mapping = mappings,
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
