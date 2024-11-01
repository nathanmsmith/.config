vim.opt.laststatus = 2

function _G.git_status()
  -- return vim.b.gitsigns_status or ""
  local branch = vim.b.gitsigns_head

  if branch then
    return " [" .. branch .. "] "
  else
    return ""
  end
end

function _G.snippet_status()
  local luasnip = require("luasnip")
  -- - `jumpable(direction)`: returns true if the current node has a next(`direction`
  --   = 1) or previous(`direction` = -1), e.g. whether it’s possible to jump
  --   forward or backward to another node.
  --   --   - `expand_or_jumpable()`: returns `expandable() or jumpable(1)` (exists only
  --     because commonly, one key is used to both jump forward and expand).
  -- - `expandable()`: true if a snippet can be expanded at the current cursor
  -- - `in_snippet()`: returns true if the cursor is inside the current snippet.
  -- - `get_active_snip()`: returns the currently active snippet (not node!).
  -- - `choice_active()`: true if inside a choiceNode.
  if luasnip.expandable() then
    return "snip expand"
  -- elseif luasnip.jumpable(1) or luasnip.jumpable(-1) then
  --   return "snip k"
  else
    print(vim.inspect(luasnip.get_active_snip()))
    local active_snip = luasnip.get_active_snip()
    return active_snip and active_snip.name or ""
  end
end

vim.opt.statusline = "%f%m%{v:lua.git_status()} %= %{v:lua.snippet_status()} %y"
