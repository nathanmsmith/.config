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

---Removes a prefix from the start of a string if it exists
---@param str string The input string to process
---@param prefix string The prefix to remove
---@return string The string with the prefix removed if found, otherwise the original string
function M.removePrefix(str, prefix)
  if str:sub(1, #prefix) == prefix then
    return str:sub(#prefix + 1)
  end
  return str
end

return M
