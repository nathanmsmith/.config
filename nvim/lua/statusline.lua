vim.opt.laststatus = 2

local lsp_status = require("lsp-status")
lsp_status.config({
  current_function = false,
  show_filename = false,
  indicator_errors = "E",
  indicator_warnings = "W",
  indicator_info = "I",
  indicator_hint = "H",
  indicator_ok = "LSP",
  status_symbol = "",
  indicator_separator = "",
})
lsp_status.register_progress()

function _G.git_status()
  -- return vim.b.gitsigns_status or ""
  local branch = vim.b.gitsigns_head

  if branch then
    return " [" .. branch .. "] "
  else
    return ""
  end
end

function _G.lsp_status()
  if #vim.lsp.buf_get_clients() > 0 then
    return require("lsp-status").status()
  end
  return ""
end

vim.opt.statusline = "%f%m%{v:lua.git_status()}%{v:lua.lsp_status()} %= %y"
