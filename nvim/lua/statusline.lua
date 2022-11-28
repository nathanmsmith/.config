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

vim.opt.statusline = "%f%m%{v:lua.git_status()} %= %y"
