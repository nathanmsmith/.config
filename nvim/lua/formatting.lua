local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  require("stripe").initFormatters()
else
  require("formatter").setup({
    filetype = {
      typescript = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
            stdin = true
          }
        end
      },
      ruby = {
        -- rubocop
        function()
          return {
            exe = "rubocop", -- might prepend `bundle exec `
            args = { "--auto-correct", "--stdin", "%:p", "2>/dev/null", "|", "awk 'f; /^====================$/{f=1}'" },
            stdin = true,
          }
        end,
      },
    },
  })
end

local format_group = vim.api.nvim_create_augroup("Format", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "FormatWrite",
  group = format_group,
})
