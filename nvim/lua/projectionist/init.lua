vim.api.nvim_set_var('projectionist_heuristics', {
  ['*.rb'] = {
    ['lib/*.rb'] = {
      ['alternate'] = 'spec/{}_spec.rb',
      ['type'] = 'source'
    },
    ['spec/*_spec.rb'] = {
      ['alternate'] = 'lib/{}.rb',
      ['type'] = 'test',
    },
  },
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
    ['*.test.js'] = {
      ['alternate'] = '{}.js',
      ['type'] = 'test'
    },
    ['*.js'] = {
      ['alternate'] = '{}.test.js',
      ['type'] = 'source',
    },
  },
  ['*.c|*.h|*.cpp|*.hpp'] = {
    ['*.c'] = {['alternate'] = {'{}.h'}},
    ['*.cpp'] = {['alternate'] = {'{}.h', '{}.hpp'}},
    ['*.h'] = {['alternate'] = {'{}.cpp', '{}.c'}},
    ['*.hpp'] = {['alternate'] = '{}.cpp'},
  },
  ['*.java'] = {
    ['src/main/java/*.java'] = {
      ['type'] = 'source',
      ['alternate'] = 'src/test/java/{}.java'
    },
    ['src/test/java/*.java'] = {
      ['type'] = 'test',
      ['alternate'] = 'src/test/java/{}.java'
    }
  }
})
