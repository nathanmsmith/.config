-- TODO: marks

-- TODO: snippets

-- TODO: skeletons
local cmp = require("cmp")

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
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
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

  -- mapping = cmp.mapping.preset.insert({
  --   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --   ["<C-Space>"] = cmp.mapping.complete(),
  --   ["<C-e>"] = cmp.mapping.abort(),
  --   ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  -- }),
  mapping = {
    -- Start completion (ctrl-n)
    ["<C-n>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end,
    }),

    -- Previous item (ctrl-p)
    ["<C-p>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end,
    }),

    -- Accept completion (ctrl-y)
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
  },
})

-- Snippets
local ls = require("luasnip")

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
  filter = filter or {}
  filter.direction = filter.direction or 1

  if filter.direction == 1 then
    return ls.expand_or_jumpable()
  else
    return ls.jumpable(filter.direction)
  end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
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

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  print("c-j")
  return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
