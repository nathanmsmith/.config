M = {}

function M.isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == "function" then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

function M.inDir(name)
  return vim.fn.getcwd():find(name, 1, true)
end

function M.contains(table, val)
  for index, value in ipairs(table) do
    if value == val then
      return true
    end
  end

  return false
end

return M
