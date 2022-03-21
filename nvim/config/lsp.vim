command! LspHover lua vim.lsp.buf.hover()<CR>
command! LspDisable lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>
command! LspInstalled lua print(vim.inspect(require('lspinstall').installed_servers()))<CR>

" LSP config, in lua
lua require("lsp")

nmap <silent> [w :lua vim.diagnostic.goto_prev()<CR>
nmap <silent> ]w :lua vim.diagnostic.goto_next()<CR>
" autocmd CursorHold * lua vim.diagnostic.open_float({source = "if_many"})

" Show errors after 1 second
set updatetime=1000
