local lspconfig = require("lspconfig")
local lspinstall = require("lspinstall")
local null_ls = require("null-ls")

require("trouble").setup({ icons = false })

-- null-ls setup
null_ls.config({
	sources = { null_ls.builtins.formatting.stylua },
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	underline = false,
-- 	virtual_text = false,
-- 	signs = true,
-- 	update_in_insert = false,
-- })

local on_attach = function(client, bufnr)
	-- Keybindings for LSPs
	vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap(
		"n",
		"<c-k>",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {
		noremap = true,
		silent = true,
	})
	vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {
		noremap = true,
		silent = true,
	})
end

local default_config = {
	on_attach = on_attach,
}

-- Source: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua
-- local sumneko_root_path = vim.fn.stdpath("data").."/lspinstall/lua/"
-- local sumneko_binary = sumneko_root_path.."/sumneko-lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local lua_config = {
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

local function setup_servers()
	lspinstall.setup()
	local servers = lspinstall.installed_servers()
	for _, server in pairs(servers) do
		if server == "lua" then
			lspconfig[server].setup(lua_config)
		else
			lspconfig[server].setup(default_config)
		end
	end

	-- Other servers
	lspconfig["null-ls"].setup({
		on_attach = function(client)
			if client.resolved_capabilities.document_formatting then
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
			end
		end,
	})
end
setup_servers()

lspinstall.post_install_hook = function()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
