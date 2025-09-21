return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      local actions = require("fzf-lua").actions
      require("fzf-lua").setup({
        actions = {
          true,
          files = {
            true,
            ["ctrl-q"] = { fn = actions.file_sel_to_qf, prefix = "select-all" },
          },
        },
      })
    end,
  },
}
