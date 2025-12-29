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
  ["config/application.rb|config.ru"] = {
    -- Config files
    ["config/routes.rb"] = {
      ["type"] = "routes",
    },
    ["config/database.yml"] = {
      ["type"] = "database",
    },
    ["config/environments/*.rb"] = {
      ["type"] = "environment",
    },

    -- Models
    ["app/models/*.rb"] = {
      ["type"] = "model",
      ["alternate"] = {
        "spec/models/{}_spec.rb",
        "test/models/{}_test.rb",
      },
    },
    ["spec/models/*_spec.rb"] = {
      ["type"] = "spec",
      ["alternate"] = "app/models/{}.rb",
    },
    ["test/models/*_test.rb"] = {
      ["type"] = "test",
      ["alternate"] = "app/models/{}.rb",
    },

    -- Controllers
    ["app/controllers/*_controller.rb"] = {
      ["type"] = "controller",
      ["alternate"] = {
        "spec/controllers/{}_controller_spec.rb",
        "spec/requests/{}_spec.rb",
        "test/controllers/{}_controller_test.rb",
      },
    },
    ["spec/controllers/*_controller_spec.rb"] = {
      ["type"] = "spec",
      ["alternate"] = "app/controllers/{}_controller.rb",
    },
    ["spec/requests/*_spec.rb"] = {
      ["type"] = "spec",
      ["alternate"] = "app/controllers/{}_controller.rb",
    },
    ["test/controllers/*_controller_test.rb"] = {
      ["type"] = "test",
      ["alternate"] = "app/controllers/{}_controller.rb",
    },

    -- Views
    ["app/views/*/*.html.erb"] = {
      ["type"] = "view",
      ["alternate"] = "app/controllers/{dirname}_controller.rb",
    },
    ["app/views/*/*.json.jbuilder"] = {
      ["type"] = "jbuilder",
      ["alternate"] = "app/controllers/{dirname}_controller.rb",
    },

    -- Helpers
    ["app/helpers/*_helper.rb"] = {
      ["type"] = "helper",
      ["alternate"] = {
        "spec/helpers/{}_helper_spec.rb",
        "test/helpers/{}_helper_test.rb",
      },
    },
    ["spec/helpers/*_helper_spec.rb"] = {
      ["type"] = "spec",
      ["alternate"] = "app/helpers/{}_helper.rb",
    },
    ["test/helpers/*_helper_test.rb"] = {
      ["type"] = "test",
      ["alternate"] = "app/helpers/{}_helper.rb",
    },

    -- Mailers
    ["app/mailers/*_mailer.rb"] = {
      ["type"] = "mailer",
      ["alternate"] = {
        "spec/mailers/{}_mailer_spec.rb",
        "test/mailers/{}_mailer_test.rb",
      },
    },
    ["spec/mailers/*_mailer_spec.rb"] = {
      ["type"] = "spec",
      ["alternate"] = "app/mailers/{}_mailer.rb",
    },
    ["test/mailers/*_mailer_test.rb"] = {
      ["type"] = "test",
      ["alternate"] = "app/mailers/{}_mailer.rb",
    },

    -- Jobs
    ["app/jobs/*_job.rb"] = {
      ["type"] = "job",
      ["alternate"] = {
        "spec/jobs/{}_job_spec.rb",
        "test/jobs/{}_job_test.rb",
      },
    },
    ["spec/jobs/*_job_spec.rb"] = {
      ["type"] = "spec",
      ["alternate"] = "app/jobs/{}_job.rb",
    },
    ["test/jobs/*_job_test.rb"] = {
      ["type"] = "test",
      ["alternate"] = "app/jobs/{}_job.rb",
    },

    -- Services
    ["app/services/*.rb"] = {
      ["type"] = "service",
      ["alternate"] = {
        "spec/services/{}_spec.rb",
        "test/services/{}_test.rb",
      },
    },
    ["spec/services/*_spec.rb"] = {
      ["type"] = "spec",
      ["alternate"] = "app/services/{}.rb",
    },
    ["test/services/*_test.rb"] = {
      ["type"] = "test",
      ["alternate"] = "app/services/{}.rb",
    },

    -- Lib
    ["lib/*.rb"] = {
      ["type"] = "lib",
      ["alternate"] = {
        "spec/lib/{}_spec.rb",
        "test/lib/{}_test.rb",
      },
    },
    ["spec/lib/*_spec.rb"] = {
      ["type"] = "spec",
      ["alternate"] = "lib/{}.rb",
    },
    ["test/lib/*_test.rb"] = {
      ["type"] = "test",
      ["alternate"] = "lib/{}.rb",
    },

    -- Migrations
    ["db/migrate/*.rb"] = {
      ["type"] = "migration",
    },

    -- JavaScript/Stimulus
    ["app/javascript/controllers/*_controller.js"] = {
      ["type"] = "jscontroller",
    },
    ["app/javascript/*.js"] = {
      ["type"] = "javascript",
    },

    -- Stylesheets
    ["app/assets/stylesheets/*.css"] = {
      ["type"] = "stylesheet",
    },
    ["app/assets/stylesheets/*.scss"] = {
      ["type"] = "stylesheet",
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

  -- Elixir
  ["mix.exs"] = {
    ["lib/*.ex"] = {
      ["type"] = "source",
      ["alternate"] = "test/{}_test.exs",
    },
    ["test/*_test.exs"] = {
      ["type"] = "test",
      ["alternate"] = "lib/{}.ex",
    },
  },
})
