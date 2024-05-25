-- This code runs with an LSP is attached to the buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    --- @param keys string
    --- @param func function
    --- @param desc string
    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = event.buffer, desc = desc })
    end

    nmap("grn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("gra", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("<C-s>", vim.lsp.buf.signature_help, "Signature Documentation")
    nmap("gh", vim.lsp.buf.hover, "Hover Documentation")
    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    nmap("gD", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    nmap("<leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle [I]nlay [H]ints")

    -- Lesser used LSP functionality
    nmap("<leader>D", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Disable semantic tokens, which use a lot of memory
    -- https://github.com/pmizio/typescript-tools.nvim/issues/228#issuecomment-1903604947
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    -- local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- if client and client.server_capabilities.documentHighlightProvider then
    --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    --     buffer = event.buf,
    --     callback = vim.lsp.buf.document_highlight,
    --   })

    --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    --     buffer = event.buf,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    -- end
  end,
})
