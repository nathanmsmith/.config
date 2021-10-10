command! LspHover lua vim.lsp.buf.hover()<CR>
command! LspDisable lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>
command! LspInstalled lua print(vim.inspect(require('lspinstall').installed_servers()))<CR>

" LSP config, in lua
lua require("lsp")

nmap <silent> [w :lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> ]w :lua vim.lsp.diagnostic.goto_next()<CR>

" Show errors after 1 second
set updatetime=1000
