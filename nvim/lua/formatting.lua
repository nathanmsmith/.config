require("formatter").setup({
  filetype = {
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
