" https://www.reddit.com/r/neovim/comments/j3xmf3/how_can_i_highlight_lua_code_in_a_usual_vim_file/g7fnh0u/
" unlet b:current_syntax
" syn include u/Lua syntax/lua.vim
" syn region embedlua matchgroup=vimEmbedError start="^lua << EOF$" end="^EOF$" keepend contains=@Lua
" let b:current_syntax = 'vim'
