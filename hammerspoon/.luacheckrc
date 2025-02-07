stds.hammerspoon = {
  read_globals = {
    "hs",
    spoon = {
      fields = {
        "spoonPath",
        "use",
      },
    },
    "spoons",
    os = {
      fields = {
        "exit",
        "clock",
      },
    },
  },
}

std = "min+hammerspoon"

-- Globals that you use
globals = { "hs", "spoon" }

-- Ignore unused self parameters of methods
self = false

-- Don't report issues for files we don't maintain
exclude_files = {
  "Spoons/**.lua",
}

-- Warnings to ignore
ignore = {
  "212/self", -- Unused argument 'self'
  "431", -- Shadow variable
  "542", -- Empty if branch
}

-- Maximum line length
max_line_length = 120

-- Maximum cyclomatic complexity of functions
max_cyclomatic_complexity = 20

-- Patterns for files to analyze (customize as needed)
files = {
  "init.lua",
  "*.lua",
}

-- Allow color output
color = true

-- Don't check code inside comments
codes = true
