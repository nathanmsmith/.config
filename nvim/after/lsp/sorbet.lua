return {
  cmd = { "srb", "tc", "--lsp" },
  filetypes = { "ruby" },
  -- Unlike root_markers = { "sorbet/" },
  -- root_dir makes sure that sorbet is only activated for
  -- projects with a sorbet/ directory
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, "sorbet/")
    if root then
      on_dir(root)
    end
  end,
}
