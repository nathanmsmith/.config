local util = require("formatter.util")

local rubocop = function()
  return {
    exe = "bundle exec rubocop",
    args = {
      "--autocorrect-all",
      "-f",
      "quiet",
      "--stderr",
      "--stdin",
      util.escape_path(util.get_current_buffer_file_name()),
    },
    stdin = true,
    -- ignore_exitcode = true,
  }
end

return rubocop
