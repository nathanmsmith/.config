call minpac#add('nvim-treesitter/nvim-treesitter', {'type': 'opt'})

function InitializeTreesitter()
  let g:is_treesitter_initialized = 1
  packadd nvim-treesitter
  lua require("treesitter")
  edit!
  echo "Treesitter Initialized"
endfunction
