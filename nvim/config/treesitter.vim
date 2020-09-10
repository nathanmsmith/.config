call minpac#add('nvim-treesitter/nvim-treesitter', {'type': 'opt'})

function InitializeTreesitter()
  packadd nvim-treesitter
  lua require("treesitter")
endfunction
