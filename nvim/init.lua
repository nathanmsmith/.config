require("impatient")
-- Put plugin managment first, as it handles installing packer.nvim for later files
require("plugins")

require("vanilla")
require("statusline")
require("projectionist")
require("fuzzy_find")
require("lsp")
-- SourceIfExists('~/.config/nvim/config/stripe.vim')

require("diagnostic")
require("formatting")
require("treesitter")
require("git")

-- function! SourceIfExists(file)
--   if filereadable(expand(a:file))
--     exe 'source' a:file
--   endif
-- endfunction

-- " Mostly vanilla Vim style tweaks
-- " Faster file switching with alternates
-- " Also integrates with vim-test
-- source $HOME/.config/nvim/config/navigation.vim
-- source $HOME/.config/nvim/config/editing.vim
-- source $HOME/.config/nvim/config/statusline.vim

-- let g:netrw_localrmdir='rm -r'

-- " Custom commands
-- source $HOME/.config/nvim/config/custom-commands.vim

-- " Various feature extensions
-- set shell=/usr/bin/env\ bash
-- source $HOME/.config/nvim/config/testing.vim
-- source $HOME/.config/nvim/config/searching.vim
-- source $HOME/.config/nvim/config/completion.vim

-- lua require('globals')

-- if !exists('*SaveAndExec')
--   function! SaveAndExec() abort
--     if &filetype == 'vim'
--       :silent! write
--       :source %
--     elseif &filetype == 'lua'
--       :silent! write
--       :luafile %
--     endif
--     return
--   endfunction
-- end
-- " Execute this file
-- nnoremap <leader>x :call SaveAndExec()<CR>
-- call SourceIfExists('~/.config/nvim/config/stripe.vim')

-- augroup TrimTrailingWhiteSpace
--   au!
--   au BufWritePre * %s/\s\+$//e
--   au BufWritePre * %s/\n\+\%$//e
-- augroup END
