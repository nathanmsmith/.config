" Define keywords
syn match markdocTagDelimiter "{%" contained
syn match markdocTagDelimiter "%}" contained
syn match markdocTagDelimiter "/%}" contained

" Define tag pattern
syn region markdocTag matchgroup=markdocTagDelimiter start="{%\s*" end="\s*%}" contains=markdocTagName,markdocAttribute,markdocShortcut,@markdocJson keepend

" Tag name
syn match markdocTagName "[-_a-zA-Z0-9]\+" contained

" Attribute
syn match markdocAttribute "[-_a-zA-Z0-9]\+\ze=" contained

" Shortcut
syn match markdocShortcut "[$\.#][-_:a-zA-Z0-9]\+" contained

" Include JSON syntax for attribute values
syn include @markdocJson syntax/json.vim
syn region markdocJsonRegion start="{" end="}" contains=@markdocJson contained

" Define highlighting
hi def link markdocTagDelimiter Tag
hi def link markdocTagName Tag
hi def link markdocAttribute Type
hi def link markdocShortcut String

" autocmd BufNewFile,BufRead *.md call s:CheckMarkdoc()
"
" function! s:CheckMarkdoc()
"   let n = 1
"   while n < 10 && n < line("$")
"     if getline(n) =~ '{%.*%}'
"       set filetype=markdoc
"       return
"     endif
"     let n = n + 1
"   endwhile
" endfunction
