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

  -- Rails project
  ["config.ru"] = {
    -- Misc files
    ["config/routes.rb"] = {
      ["type"] = "routes",
    },
    ["config/deploy.yml"] = {
      ["type"] = "deploy",
    },

    -- Models
    ["app/models/*.rb"] = {
      ["type"] = "model",
      ["alternate"] = "test/models/{}_test.rb",
    },
    ["test/models/*_test.rb"] = {
      ["type"] = "test",
      ["alternate"] = "app/models/{}.rb",
    },

    ["app/views/*.json.jbuilder"] = {
      ["type"] = "builder",
      ["alternate"] = "app/controllers/{dirname}_controller.rb",
    },
    ["app/views/*.html.erb"] = {
      ["type"] = "view",
      ["alternate"] = "app/controllers/{dirname}_controller.rb",
    },

    -- Controllers
    ["app/controllers/*_controller.rb"] = {
      ["type"] = "controller",
      ["alternate"] = "test/controllers/{}_controller_test.rb",
      ["related"] = {
        "app/models/{singular}.rb",
        "app/views/{}/index.html.erb",
        "app/views/{}/new.html.erb",
        "app/views/{}/show.html.erb",
        "app/views/{}/edit.html.erb",
      },
    },
    ["test/controllers/*_controller_test.rb"] = {
      ["type"] = "test",
      ["alternate"] = "app/controllers/{}_controller.rb",
    },

    ["app/javascript/*.js"] = {
      ["type"] = "javascript",
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
