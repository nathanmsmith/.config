scriptencoding utf-8

command! DumbQuotes %s/“\|”/"/g | %s/‘\|’/'/g
command! ReloadConfig source $MYVIMRC
" Not needed snice I'm not working with Java
" command! Intellij execute ":!idea %:p --line " . line('.')
command! VSCode execute ":!code -g %:p\:" . line('.') . ":" . col('.')
command! FileName !echo % | pbcopy
command! Finder !open "%:p:h"

" Edit a file in the same directory
cabbr <expr> %% expand('%:p:h')
