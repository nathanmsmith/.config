-- nvim-cmp supports additional completion capabilities
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  return cmp_nvim_lsp.default_capabilities()
else
  return {}
end
