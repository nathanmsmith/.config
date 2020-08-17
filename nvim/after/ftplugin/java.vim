let b:ale_fixers = ['google_java_format']
let b:ale_linters = []
let java_highlight_functions = 1
let java_highlight_java_lang_ids = 1
let java_highlight_debug = 1
highlight link javaScopeDecl Statement
highlight link javaType Type
highlight link javaDocTags PreProc
" Disable the comment title color
hi def link javaCommentTitle Comment
