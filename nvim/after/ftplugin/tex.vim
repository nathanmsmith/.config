setlocal spell

" textobj-latex - Text objects for LaTeX code
" Author: Roberto Bonvallet <rbonvall@gmail.com>
" GetLatestVimScripts: 2100 1 textobj-user
" GetLatestVimScripts: 4506 1 :AutoInstall: textobj-latex"

if exists('g:loaded_textobj_latex')
  finish
endif

call textobj#user#plugin('latex', {
\   'environment': {
\     '*pattern*': ['\\begin{[^}]\+}.*\n\s*', '\n^\s*\\end{[^}]\+}.*$'],
\     'select-a': 'an',
\     'select-i': 'in',
\   },
\  'bracket-math': {
\     '*pattern*': ['\\\[', '\\\]'],
\     'select-a': 'ab',
\     'select-i': 'ib',
\   },
\  'paren-math': {
\     '*pattern*': ['\\(', '\\)'],
\     'select-a': 'a\',
\     'select-i': 'i\',
\   },
\  'dollar-math-a': {
\     '*pattern*': '[$][^$]*[$]',
\     'select': 'a$',
\   },
\  'dollar-math-i': {
\     '*pattern*': '[$]\zs[^$]*\ze[$]',
\     'select': 'i$',
\   },
\  'quote': {
\     '*pattern*': ['`', "'"],
\     'select-a': 'aq',
\     'select-i': 'iq',
\   },
\  'double-quote': {
\     '*pattern*': ['``', "''"],
\     'select-a': 'aQ',
\     'select-i': 'iQ',
\   },
\ })

let g:loaded_textobj_latex = 1

" Make
let b:tex_flavor = 'pdflatex'
:compiler tex
:set makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode
:set errorformat=%f:%l:\ %m
