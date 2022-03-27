vim.api.nvim_set_var("projectionist_heuristics", {
  -- ["*.rb"] = {
  --   ["lib/*.rb"] = {
  --     ["alternate"] = "spec/{}_spec.rb",
  --     ["type"] = "source",
  --   },
  --   ["spec/*_spec.rb"] = {
  --     ["alternate"] = "lib/{}.rb",
  --     ["type"] = "test",
  --   },
  -- },
  ["*.go"] = {
    ["*.go"] = {
      ["alternate"] = "{}_test.go",
      ["type"] = "source",
    },
    ["*_test.go"] = {
      ["alternate"] = "{}.go",
      ["type"] = "test",
    },
  },
  ["*.py"] = {
    ["*.py"] = {
      ["alternate"] = "{}_test.py",
      ["type"] = "source",
    },
    ["*_test.py"] = {
      ["alternate"] = "{}.py",
      ["type"] = "test",
    },
  },
  ["*.js|*.jsx"] = {
    ["*.test.js|*.test.jsx"] = {
      ["alternate"] = { "{}.jsx", "{}.js" },
      ["type"] = "test",
    },
    ["*.js|*.jsx"] = {
      ["alternate"] = { "{}.test.jsx", "{}.test.js" },
      ["type"] = "source",
    },
  },
  ["*.ts|*.tsx"] = {
    ["*.test.ts|*.test.tsx"] = {
      ["alternate"] = { "{}.tsx", "{}.ts" },
      ["type"] = "test",
    },
    ["*.ts|*.tsx"] = {
      ["alternate"] = { "{}.test.tsx", "{}.test.ts" },
      ["type"] = "source",
    },
  },
  ["*.css"] = {
    ["type"] = "css",
  },
  ["*.c|*.h|*.cpp|*.hpp"] = {
    ["*.c"] = { ["alternate"] = { "{}.h" } },
    ["*.cpp"] = { ["alternate"] = { "{}.h", "{}.hpp" } },
    ["*.h"] = { ["alternate"] = { "{}.cpp", "{}.c" } },
    ["*.hpp"] = { ["alternate"] = "{}.cpp" },
  },
  ["*.java"] = {
    ["src/main/java/*.java"] = {
      ["type"] = "source",
      ["alternate"] = "src/test/java/{}.java",
    },
    ["src/test/java/*.java"] = {
      ["type"] = "test",
      ["alternate"] = "src/test/java/{}.java",
    },
  },
})
