local helpers = require("custom-helpers")

-- if helpers.isModuleAvailable("stripe") then
--   -- require("stripe").initFormatters()
-- else
--   require("formatting.setup")

--   local format_group = vim.api.nvim_create_augroup("Format", { clear = true })
--   vim.api.nvim_create_autocmd("BufWritePost", {
--     callback = function()
--       vim.api.nvim_command("FormatWrite")
--     end,
--     group = format_group,
--     pattern = "*",
--   })
-- end

-- New format on save config
local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
  exclude_path_patterns = {
    "/node_modules/",
    ".local/share/nvim/lazy",
  },
  formatter_by_ft = {
    typescript = formatters.prettierd,
    typescriptreact = formatters.prettierd,
    lua = formatters.stylua,
    ruby = {
      formatters.shell({
        cmd = { "scripts/bin/rubocop-daemon/rubocop", "--autocorrect-all", "-f", "quiet", "--stderr", "--stdin", "%" },
      }),
      formatters.lsp,
    },
  },
})
