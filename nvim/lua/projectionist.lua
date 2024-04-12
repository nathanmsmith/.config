vim.api.nvim_set_var("projectionist_heuristics", {
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
  -- JS/TS projects
  ["package.json"] = {
    ["*.test.js|*.test.jsx"] = {
      ["alternate"] = { "{}.jsx", "{}.js" },
      ["type"] = "test",
    },
    ["*.js|*.jsx"] = {
      ["alternate"] = { "{}.test.jsx", "{}.test.js" },
      ["type"] = "source",
    },
    ["*.test.tsx"] = {
      ["alternate"] = "{}.tsx",
      ["type"] = "test",
    },
    ["*.tsx"] = {
      ["alternate"] = "{}.test.tsx",
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
