command! LspHover lua vim.lsp.buf.hover()<CR>
command! LspDisable lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

packadd nvim-lspconfig
" packadd lsp-status.nvim
packadd diagnostic-nvim
" LSP config, in lua
lua require("lsp")
setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Show errors after 1 second
set updatetime=1000

let g:diagnostic_insert_delay =1
let g:diagnostic_enable_ale = 1
