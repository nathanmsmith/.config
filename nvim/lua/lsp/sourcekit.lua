local capabilities = require("lsp.capabilities")
local on_attach = require("lsp.on_attach")

require("lspconfig").sourcekit.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
  },
  root_dir = function(filename, _)
    local util = require("lspconfig.util")
    return util.root_pattern("buildServer.json")(filename)
      or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
      or util.find_git_ancestor(filename)
      or util.root_pattern("Package.swift")(filename)
  end,
})
