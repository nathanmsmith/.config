return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      local actions = require("fzf-lua").actions
      require("fzf-lua").setup({
        winopts = {
          preview = {
            layout = 'vertical',
            vertical = 'up:40%',
          },
        },
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
