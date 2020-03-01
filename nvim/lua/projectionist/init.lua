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
  ['*.c|*.h|*.cpp|*.hpp'] = {
    ['*.c'] = {['alternate'] = {'{}.h'}},
    ['*.cpp'] = {['alternate'] = {'{}.h', '{}.hpp'}},
    ['*.h'] = {['alternate'] = {'{}.cpp', '{}.c'}},
    ['*.hpp'] = {['alternate'] = '{}.cpp'},
  },
})
