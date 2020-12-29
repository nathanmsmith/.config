" JSDoc highlighting
let g:javascript_plugin_jsdoc = 1

let g:ale_javascript_prettier_options = "--single-quote --no-semi --trailing-comma es5"
let b:ale_fixers = ['eslint', 'prettier']
let b:ale_linters = ['eslint']

if has('nvim-0.5')
  setlocal omnifunc=v:lua.vim.lsp.omnifunc
end
