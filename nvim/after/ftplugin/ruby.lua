require("formatting").set("ruby", {
  work = { lsp_format = "prefer" },
  personal = { "rubocop" },
})

-- Custom rubocop args for personal use
if not require("custom-helpers").isModuleAvailable("stripe") then
  require("conform").formatters.rubocop = {
    args = {
      "--server",
      "-A", -- Unsafe autocorrect
      "-f",
      "quiet",
      "--stderr",
      "--stdin",
      "$FILENAME",
    },
  }
end
