require("formatting").set("c", { personal = { "uncrustify" } })

-- Custom uncrustify args for Neovim dev
if not require("custom-helpers").isModuleAvailable("stripe") then
  require("conform").formatters.uncrustify = {
    args = function(_, ctx)
      return { "-q", "-l", "C", "-c", "src/uncrustify.cfg", "--no-backup" }
    end,
  }
end
