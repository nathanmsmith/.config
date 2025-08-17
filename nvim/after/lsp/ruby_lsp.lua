-- local function add_ruby_deps_command(client, bufnr)
--   vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
--     local params = vim.lsp.util.make_text_document_params()
--     local showAll = opts.args == "all"
--
--     client.request("rubyLsp/workspace/dependencies", params, function(error, result)
--       if error then
--         print("Error showing deps: " .. error)
--         return
--       end
--
--       local qf_list = {}
--       for _, item in ipairs(result) do
--         if showAll or item.dependency then
--           table.insert(qf_list, {
--             text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
--             filename = item.path,
--           })
--         end
--       end
--
--       vim.fn.setqflist(qf_list)
--       vim.cmd("copen")
--     end, bufnr)
--   end, {
--     nargs = "?",
--     complete = function()
--       return { "all" }
--     end,
--   })
-- end

return {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".git" },
  init_options = {
    formatter = "auto",
    -- Disable the "migrations are pending" popup
    -- https://github.com/Shopify/ruby-lsp-rails/issues/540#issuecomment-2656091287
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
}
