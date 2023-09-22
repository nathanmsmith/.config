local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  return {}
else
  return {
    "tpope/vim-rails",
    "tpope/vim-rake",
    "tpope/vim-bundler",
  }
end
