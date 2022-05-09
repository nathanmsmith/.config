local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
	require("stripe").initFormatters()
else
	require("formatting.setup")
end

local format_group = vim.api.nvim_create_augroup("Format", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "FormatWrite",
	group = format_group,
})
