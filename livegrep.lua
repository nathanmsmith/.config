local F = require("plenary.functional")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local util = {}

util.url_encode = function(str)
  if type(str) ~= "number" then
    str = str:gsub("\r?\n", "\r\n")
    str = str:gsub("([^%w%-%.%_%~ ])", function(c)
      return string.format("%%%02X", c:byte())
    end)
    str = str:gsub(" ", "+")
    return str
  else
    return str
  end
end

util.kv_to_str = function(kv, sep, kvsep)
  return F.join(
    F.kv_map(function(kvp)
      return kvp[1] .. kvsep .. util.url_encode(kvp[2])
    end, kv),
    sep
  )
end

util.curl_query = function(t)
  if not t then
    return
  end
  return util.kv_to_str(t, "&", "=")
end

local query_string = util.curl_query({
  q = "hello",
  fold_case = "auto",
  regex = "false",
})
P(query_string)

---- our picker function: colors
--local colors = function(opts)
--  -- opts:
--  --   regex
--  --   fold_case
--  --

--  opts = opts or {}
--  pickers.new(opts, {
--    prompt_title = "LiveGrep",
--    finder = finders.new_table({
--      results = { "red", "green", "blue" },
--    }),
--    sorter = conf.generic_sorter(opts),
--  }):find()
--end

---- to execute the function
--colors()

---- local response = curl.get("https://livegrep.com/api/v1/search/linux", {
----   query = ,
---- })
---- local results = vim.fn.json_decode(response.body).results

---- P(results)
