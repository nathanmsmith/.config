vim.api.nvim_set_var('projectionist_heuristics', {
  ['*.go'] = {
    ['*.go'] = {
      ['alternate'] = '{}_test.go',
      ['type'] = 'source',
    },
    ['*_test.go'] = {
      ['alternate'] = '{}.go',
      ['type'] = 'test'
    },
  },
  ['*.py'] = {
    ['*.py'] = {
      ['alternate'] = '{}_test.py',
      ['type'] = 'source',
    },
    ['*_test.py'] = {
      ['alternate'] = '{}.py',
      ['type'] = 'test'
    },
  },
  ['*.js'] = {
    ['*.js'] = {
      ['alternate'] = '{}.js',
      ['type'] = 'source',
    },
    ['*.test.js'] = {
      ['alternate'] = '{}.js',
      ['type'] = 'test'
    },
  },
  ['/*.c|src/*.c'] = {
    ['*.c'] = {['alternate'] = {'../include/{}.h', '{}.h'}},
    ['*.h'] = {['alternate'] = '{}.c'},
  },
  ['Makefile'] = {
    ['*Makefile'] = {['alternate'] = '{dirname}CMakeLists.txt'},
    ['*CMakeLists.txt'] = {['alternate'] = '{dirname}Makefile'},
  },
})
